indexing
	description: "Abstract description of an Eiffel creation expression call."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_AS

inherit
	CALL_AS
		redefine
			type_check, is_equivalent, location
		end

	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

	SHARED_EVALUATOR
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like type; c: like call; l: like location) is
			-- Create a new CREATION_EXPR AST node.
		require
			t_not_void: t /= Void
			l_not_void: l /= Void
		local
			dcr_id : ID_AS
		do
			type := t
			call := c
			location := l.twin

				-- If there's no call create 'default_call'
			if call = Void then
					-- Create id. True name set later.
				create dcr_id.make (0)
				create default_call
				default_call.set_feature_name (dcr_id)
			end
		ensure
			type_set: type = t
			call_set: call = c
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_expr_as (Current)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			dummy_call: ACCESS_INV_AS
			dummy_name: ID_AS
		do
			ctxt.put_text_item (ti_Create_keyword)
			ctxt.put_space
			ctxt.put_text_item (ti_L_curly)
			ctxt.format_ast (type)

			if call /= Void then
					--| We have to create a dummy call because the current formating
					--| algorithm which makes the assumption that a feature call is
					--| either on Current or on something else.
					--| In the case of creation expression there is no current or no
					--| something else, so we create a dummy call which only goal is
					--| to set some properties of FORMAT_CONTEXT and LOCAL_FEAT_ADAPTATION
					--| to their correct value and then pass them to the real call, that
					--| way `call' is correctly formatted thanks to the information provided
					--| by the call to `dummy_call.format'.
					--| GB 12/13/2000: Changed dummy_name from " " to "}" to avoid
					--| useless space.
				create dummy_call
				create dummy_name.initialize (ti_R_curly.image)
				dummy_call.set_feature_name (dummy_name)
				ctxt.format_ast (dummy_call)
				ctxt.set_type_creation (type)
				ctxt.need_dot
				ctxt.format_ast (call)
			else
					--| Simply calling put_text_item doesn't work:
					--| the context local_adapt must change.
					--| Yeah yeah I know it's not really clean,
					--| but if you want to redo completely the text generation, go on.
				create dummy_call
				create dummy_name.initialize (ti_R_curly.image)
				dummy_call.set_feature_name (dummy_name)
				ctxt.format_ast (dummy_call)
			end

				--| If a dot call follows, it has to be relative to `type'.
			ctxt.set_type_creation (type)
		end

feature -- Access

	location: TOKEN_LOCATION
			-- Location of current.

	type: TYPE
			-- Creation Type.

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

	default_call : ACCESS_INV_AS
			-- Call to default create.

feature -- Type check

	type_check is
			-- Type check an access to a creation feature.
		local
			new_creation_type, creation_type: TYPE_A
			gen_type: GEN_TYPE_A
			creation_class: CLASS_C
			a_feature: FEATURE_I
			export_status, context_export: EXPORT_I
			create_type: CREATE_INFO
			creators: HASH_TABLE [EXPORT_I, STRING]
			depend_unit: DEPEND_UNIT
			feature_name: STRING
			vgcc1: VGCC1
			vgcc11: VGCC11
			vgcc2: VGCC2
			vgcc3: VGCC3
			vgcc4: VGCC4
			vgcc5: VGCC5
			vtcg3: VTCG3
			vtec1: VTEC1
			vtec2: VTEC2
			vtug: VTUG
			vape: VAPE
			formal_type: FORMAL_A
			formal_dec: FORMAL_DEC_AS
			is_formal_creation, is_default_creation: BOOLEAN
			dcr_feat: FEATURE_I
			the_call: like call
		do
				-- We need to remove from the stack the first element, since it
				-- has been added by EXPR_CALL_AS and it does not correspond to
				-- what we want to put, cad the type of the source.
				--| Type information will be added at the very end
			context.pop (1)

				-- Initialize the type stack, this information will be updated later
				-- just after `call.type_check'
			context.begin_expression

				-- We need to evaluate `type' in context of current class
				-- and current feature.
			creation_type := creation_evaluator.evaluated_type (
				type, Context.feature_table, Context.current_feature)
				
				-- Fully evaluated type for `creation_type'.
			new_creation_type := creation_type.actual_type

			if new_creation_type.has_expanded then
				if new_creation_type.expanded_deferred then
					create vtec1
					context.init_error (vtec1)
					Error_handler.insert_error (vtec1)
				elseif not new_creation_type.valid_expanded_creation (context.current_class) then
					create vtec2
					context.init_error (vtec2)
					Error_handler.insert_error (vtec2)
				end
			end

			if new_creation_type.is_formal then
					-- Cannot be Void
				formal_type ?= new_creation_type
				check
					formal_type_not_void: formal_type /= Void
				end
					-- Get the corresponding constraint type of the current class
				formal_dec := context.current_class.generics.i_th (formal_type.position)
				if formal_dec.has_constraint and then formal_dec.has_creation_constraint then
					new_creation_type := formal_dec.constraint_type
					is_formal_creation := True
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because there is no creation routine constraints
					create vgcc1
					context.init_error (vgcc1)
					vgcc1.set_target_name ("")
					Error_handler.insert_error (vgcc1);					
				end
			end

			if not new_creation_type.good_generics then
				vtug := new_creation_type.error_generics
				vtug.set_class (context.current_class)
				vtug.set_feature (context.current_feature)
				Error_handler.insert_error (vtug)
				Error_handler.raise_error
			elseif
				new_creation_type.is_none
			then
					-- Cannot create instance of NONE
				create vgcc3
				context.init_error (vgcc3)
				vgcc3.set_target_name ("")
				vgcc3.set_type (new_creation_type)
				Error_handler.insert_error (vgcc3)
			else
				new_creation_type.reset_constraint_error_list
				new_creation_type.check_constraints (context.current_class)
				if not new_creation_type.constraint_error_list.is_empty then
					create vtcg3
					vtcg3.set_class (context.current_class)
					vtcg3.set_feature (context.current_feature)
					vtcg3.set_error_list (new_creation_type.constraint_error_list)
					Error_handler.insert_error (vtcg3)
				else
					gen_type ?= new_creation_type
					if gen_type /= Void then
						Instantiator.dispatch (gen_type, context.current_class)
					end
						-- We do not update type stack now, since the call to
						-- `call.type_check' will change the information, we will
						-- do it when `call.type_check' will be done.
				end
			end

				-- Check for errors
			Error_handler.checksum

			creation_class := new_creation_type.associated_class
			if creation_class.is_deferred and then not is_formal_creation then
					-- Associated class cannot be deferred
				create vgcc2
				context.init_error (vgcc2)
				vgcc2.set_target_name ("")
				vgcc2.set_type (new_creation_type)
				Error_handler.insert_error (vgcc2)
				Error_handler.raise_error
			end

			if
				call = Void and then
				(creation_class.allows_default_creation or
				(is_formal_creation and then formal_dec.has_default_create))
			then
					-- Use default create
				if not is_formal_creation then
					dcr_feat := creation_class.default_create_feature
				else
					dcr_feat := creation_class.feature_table.feature_of_rout_id (
						System.default_create_id)
				end
				is_default_creation := True
				if is_formal_creation or else not dcr_feat.is_empty then
					default_call.feature_name.load (dcr_feat.feature_name)
					the_call := default_call
				else
						-- We insert creation without call to creation procedure
						-- in list of dependences of current feature.
					create depend_unit.make_emtpy_creation_unit (creation_class.class_id, dcr_feat)
					context.supplier_ids.extend (depend_unit)
				end
			else
				the_call := call
			end

			creators := creation_class.creators

			if the_call /= Void then
				context.replace (new_creation_type)

					-- Inform the next type checking that we are handling
					-- a creation expression and that this is not needed
					-- to check the VAPE validity of `the_call' if Current
					-- is used in a precondition clause statement.
				context.set_is_in_creation_expression (True)

					-- Type check the call: note that the creation type is on
					-- the type stack.
				the_call.type_check	
				feature_name := the_call.feature_name

					-- But since a creation routine is a feature its TYPE_A is of type
					-- VOID_A which is not what we want here, that's why we need to update
					-- the type now.
				context.replace (new_creation_type)

				if not is_formal_creation then
						-- Check if creation routine is non-once procedure
					if not creation_class.valid_creation_procedure (feature_name) then
						create vgcc5
						context.init_error (vgcc5)
						vgcc5.set_target_name ("")
						vgcc5.set_type (new_creation_type)
						a_feature := creation_class.feature_table.item (feature_name)
						vgcc5.set_creation_feature (a_feature)
						Error_handler.insert_error (vgcc5)
					elseif creators /= Void then
						export_status := creators.item (feature_name)
						if not export_status.valid_for (context.current_class) then
								-- Creation procedure is not exported
							create vgcc5
							context.init_error (vgcc5)
							vgcc5.set_target_name ("")
							vgcc5.set_type (new_creation_type)
							a_feature := creation_class.feature_table.item (feature_name)
							vgcc5.set_creation_feature (a_feature)
							Error_handler.insert_error (vgcc5)
						else
							if context.level4 then
								context_export := context.current_feature.export_status
								if not context_export.is_subset (export_status) then
									create vape
									context.init_error (vape)
									vape.set_exported_feature (a_feature)
									Error_handler.insert_error (vape)
									Error_handler.raise_error
								end
							end
						end
					end
				else
						-- Check that the creation feature used for creating the generic
						-- parameter has been listed in the constraint for the generic
						-- parameter.
					if not formal_dec.has_creation_feature_name (feature_name) then
						create vgcc11
						context.init_error (vgcc11)
						vgcc11.set_target_name ("")
						a_feature := creation_class.feature_table.item (feature_name)
						vgcc11.set_creation_feature (a_feature)
						Error_handler.insert_error (vgcc11)
					end
				end
			else
				if not is_formal_creation then
					context.replace (new_creation_type)
					if (creators = Void) or is_default_creation then
					elseif creators.is_empty then
						create vgcc5
						context.init_error (vgcc5)
						vgcc5.set_target_name ("")
						vgcc5.set_type (new_creation_type)
						vgcc5.set_creation_feature (Void)
						Error_handler.insert_error (vgcc5)
					else
						create vgcc4
						context.init_error (vgcc4)
						vgcc4.set_target_name ("")
						vgcc4.set_type (new_creation_type)
						Error_handler.insert_error (vgcc4)
					end
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because we need a creation routine call
					create vgcc1
					context.init_error (vgcc1)
					vgcc1.set_target_name ("")
					Error_handler.insert_error (vgcc1);				
				end
			end

				-- Check for errors
			Error_handler.checksum

				-- Compute creation information
			create_type := creation_type.create_info

			context.creation_infos.insert (create_type)
			context.creation_types.insert (new_creation_type.type_i)
		end

feature

	byte_node: CREATION_EXPR_B is
			-- Associated byte code.
		local
			create_type: CREATE_INFO
			call_access: CALL_ACCESS_B
			the_call: like call
			l_type: TYPE_I
		do
			create Result

			if default_call = Void or else default_call.feature_name.is_empty then
				the_call := call
			else
				the_call := default_call
			end

			if the_call /= Void then
				call_access ?= the_call.byte_node
				check
					has_valid_call: call_access /= Void
				end
				Result.set_call (call_access)
			end

				-- Cannot be Void since the only thing that we put is of type CREATION_TYPE
				-- for a CREATION_EXPR_B
			create_type ?= context.creation_infos.item
			context.creation_infos.forth
			check
				create_type_not_void: create_type /= Void
			end
			
			l_type := context.creation_types.item
			context.creation_types.forth
			check
				l_type_not_void: l_type /= Void
			end
			
			Result.set_info (create_type)
			Result.set_type (l_type)
			Result.set_line_number (line_number)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (type, other.type)
		end

invariant
		-- A creation expression contains its type
	type_exists: type /= Void

end -- class CREATION_EXPR_AS
