-- Standard byte code

class STD_BYTE_CODE 

inherit

	BYTE_CODE
		redefine
			compound, analyze, generate, finish_compound
		end;

feature 

	compound: BYTE_LIST [BYTE_NODE];
			-- Compound byte code

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	analyze is
			-- Builds a proper context (for C code).
		local
			workbench_mode: BOOLEAN;
			type_i: TYPE_I;
			feat: FEATURE_I;
			have_assert: BOOLEAN;
			inh_assert: INHERITED_ASSERTION;
		do
			workbench_mode := context.workbench_mode;
			feat := Context.associated_class.feature_table.item (feature_name);
			inh_assert := Context.inherited_assertion;
			inh_assert.init;
			if 	Context.has_inherited_assertion and then
				not Context.associated_class.is_basic and then
				feat.assert_id_set /= Void then
				--! Do not get inherited pre & post for basic types
				formulate_inherited_assertions (feat.assert_id_set);
			end;
			context.set_assertion_type (0);

				-- Enlarge the tree to get some attribute where we
				-- can store information gathered by analyze.
			enlarge_tree;
				-- Analyze preconditions
			have_assert := (precondition /= Void or else
							inh_assert.has_precondition) and then
				(workbench_mode or else context.assertion_level.check_precond);
			if 	have_assert then
				if workbench_mode then
					context.add_dt_current;
				end;
				if precondition /= Void then
					precondition.analyze;
				end;
				if inh_assert.has_precondition then
					inh_assert.analyze_precondition;
				end	
			end;
			have_assert := (postcondition /= Void or else
							inh_assert.has_postcondition) and then
				(workbench_mode or else context.assertion_level.check_postcond);
				-- Analyze postconditions
			if 	have_assert then
				if workbench_mode then
					context.add_dt_current;
				end;
				if postcondition /= Void then
					postcondition.analyze;
				end;
				if inh_assert.has_postcondition then
					inh_assert.analyze_postcondition;
				end	
			end;
				-- If result is expanded or a bit, we need to create it anyway
			if not result_type.is_void then
				type_i := context.real_type (result_type);
				if type_i.is_expanded or else type_i.is_bit then
					context.mark_result_used;
				end;
			end;
				-- Look at the compound after postconditions have been
				-- analyzed, so that the registers used for "old" expressions
				-- are not clobbered in any way.
			if compound /= Void then
					-- Look for all instances of assignments in Result
					-- in last instructions and set `last_in_result' iff
					-- all were such assignments.
				if not result_type.is_void and not is_once then
					compound.finish;
					compound.item.find_assign_result;
					compound.item.mark_last_instruction;
				end;
				compound.analyze;
			end;
			if rescue_clause /= Void then
				rescue_clause.analyze;
			end;
			if exception_stack_managed then
					-- For RTEA call
				context.mark_current_used;
			end;
		end;

	generate is
			-- Generate C code.
		local
			assignment: ASSIGN_B;
			type_i: TYPE_I;
			internal_name: STRING;
		do
				-- Generate the header "int foo(Current, args)"
			type_i := real_type (result_type);
			type_i.c_type.generate (generated_file);

				-- Function's name
			internal_name := Encoder.feature_name
				(System.class_type_of_id (context.current_type.type_id).id,
				body_id);

				-- Generate function name
			generated_file.putstring (internal_name);
			generated_file.putchar ('(');
			generate_arguments;
			generated_file.putchar (')');
			generated_file.new_line;
				-- Now generate C declarations for arguments
			generate_arg_declarations;
				-- Starting body of C routine
			generated_file.putchar ('{');
			generated_file.new_line;
			generated_file.indent;
				-- Declaration of all the local entities, such as
				-- Eiffel local variables, Result, temporary registers...
			generate_execution_declarations;
			generate_locals;
				-- If necessary, generate the once stuff (i.e. checks for
				-- the internal done flag). That way we do not enter the body
				-- of the once it it has already been done. Pre-conditions,
				-- if any, are only tested on the very first call.
			generate_once;
				-- Before entering in the code generate GC hooks, i.e. pass
				-- the addresses of all the reference variables.
			context.generate_gc_hooks (False);
				-- Clone expanded parameters, raise exception in caller if
				-- needed (void assigned to expanded).
			generate_expanded_cloning;
				-- Generate execution trace information
			generate_execution_trace;
				-- Generate the saving of the workbench mode assertion level
			if context.workbench_mode then
				generate_save_assertion_level;
			end;
				-- Precondition check generation
			generate_precondition;
			if 
				Context.has_chained_prec
			then
				-- For chained precondition (to implement or else...)
				Context.generate_body_label
			end;
				-- Generate old variables
			generate_old_variables;
			if rescue_clause /= Void then
					-- Generate a `setjmp' C instruction in case of a
					-- rescue clause
				generated_file.putstring ("RTEJ;");
				generated_file.new_line;
			end;
				-- Generate local expanded variable creations
			generate_expanded_variables;
				-- Now we want the body
			generate_compound;
				-- Now the postcondition
			generate_postcondition;
			if not result_type.is_void then
					-- Function returns something. So generate the return
					-- expression, if necessary. Otherwise, have some mercy
					-- for lint and highlight the NOTREACHED status...
				generate_return;
			else
					-- No return, this is a procedure. However, remove the
					-- GC hooks we've been generated.
				finish_compound;
				if rescue_clause /= Void then
					generated_file.putstring ("return;");
					generated_file.new_line;
				end;
			end;
				-- If there is a rescue clause, generate it now...
			generate_rescue;
				-- End of C function
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
				-- Leave a blank line after function definition
			generated_file.new_line;
			Context.inherited_assertion.wipe_out;
		end;

	generate_compound is
			-- Generate the function compound
		do
			if compound /= Void then
				compound.generate;
			end;
		end;

	generate_return is
			-- Generate return Result or hard-coded null
		local
			assignment: ASSIGN_B;
			a_creation: CREATION_B;
		do
			if compound /= Void then
				compound.finish;
					-- If ALL the last statements were assignments in result,
					-- generate a NOTREACHED for lint when last statement was
					-- not of type assignment. Otherwise, the return statements
					-- have already been generated.
				if compound.item.last_all_in_result then
					assignment ?= compound.item;
					a_creation ?= compound.item;
					if
						assignment = Void and a_creation = Void and
						not context.has_rescue
					then
						generated_file.putstring ("/* NOTREACHED */");
						generated_file.new_line;
					end;
				else
					generate_return_exp;
				end;
			else
				generate_return_exp;
			end;
		end;

	generate_return_exp is
			-- Generate the return expression
		local
			type_i: TYPE_I;
		do
				-- Do not forget to remove the GC hooks before returning
				-- if they have already been generated. For instance, when
				-- generating return for a once function, hooks have not
				-- been generated.
			finish_compound;
			if not result_type.is_void then
					-- Routine is a function. Emit a blank line before
					-- return expression unless we are in a once and hooks
					-- have not been generated (which means we are in the
					-- "if done" construct).
				if (not is_once or context.ref_var_used > 0) and
					(is_once or (not (compound = Void) and then compound.count > 1))
				then
					generated_file.new_line;
				end;
				generated_file.putstring ("return ");
					-- If Result was used, generate it. Otherwise, its value
					-- is simply the initial one (i.e. generic 0).
				if context.result_used then
					if real_type (result_type).c_type.is_pointer then
						context.Result_register.print_register_by_name;
					else
						generated_file.putstring ("Result");
					end;
					generated_file.putchar (';');
				else
					type_i := real_type (result_type);
					type_i.c_type.generate_cast (generated_file);
					generated_file.putstring ("0;");
				end;
				generated_file.new_line;
			end;
		end; -- generate_return_exp

	generate_once is
			-- Generate test at the head of once routines
		do
			-- Do nothing
		end; -- generate_once

	generate_expanded_variables is
			-- Create local expanded variables and Result
		local
			i, count, exp_type_id: INTEGER;
			type_i: TYPE_I;
			cl_type_i: CL_TYPE_I;
			bit_i: BIT_I;
			creation_feature: FEATURE_I;
			class_type: CLASS_TYPE;
			c_name: STRING;
		do
			if locals /= Void then
				count := locals.count;
				from
					i := locals.lower;
				until
					i > count
				loop
					type_i := locals.item (i);
					type_i := real_type (type_i);
							-- Generate only if variable used
					if context.local_vars.item(i) then
						if type_i.is_expanded then
							cl_type_i ?= type_i;
							context.local_var.set_position (i);
							context.local_var.print_register_by_name;
							exp_type_id := cl_type_i.expanded_type_id - 1;
							if context.workbench_mode then
									-- RTLX is a macro used to create
									-- expanded types
								generated_file.putstring (" = RTLX(");
								generated_file.putint (exp_type_id);
							else
								generated_file.putstring (" = RTLN(");
								generated_file.putint (exp_type_id);
								generated_file.putstring (");%N%T");
								class_type := cl_type_i.associated_class_type;
								creation_feature := class_type.associated_class.creation_feature;
								c_name := Encoder.feature_name
									(class_type.id, creation_feature.body_id);
								generated_file.putstring (c_name.duplicate);
								generated_file.putchar ('(');
								context.local_var.print_register_by_name;
							end;
							generated_file.putstring (");");
							generated_file.new_line;
						elseif type_i.is_bit then
							bit_i ?= type_i; -- Cannot fail
							context.local_var.set_position (i);
							context.local_var.print_register_by_name;
							generated_file.putstring (" = RTLB(");
							generated_file.putint (bit_i.size);
							generated_file.putstring (");");
							generated_file.new_line;
						end;
					end;
					i := i + 1;
				end;
			end;
			type_i := real_type (result_type);
			if context.result_used then
				if type_i.is_expanded then
					cl_type_i ?= type_i;
					exp_type_id := cl_type_i.expanded_type_id - 1;
					context.result_var.print_register_by_name;
					if context.workbench_mode then
							-- RTLX is a macro used to create
							-- expanded types
						generated_file.putstring (" = RTLX(");
						generated_file.putint (exp_type_id);
					else
						generated_file.putstring (" = RTLN(");
						generated_file.putint (exp_type_id);
						generated_file.putstring (");%N%T");
						class_type := cl_type_i.associated_class_type;
						creation_feature := class_type.associated_class.creation_feature;
						c_name := Encoder.feature_name
							(class_type.id, creation_feature.body_id);
						generated_file.putstring (c_name.duplicate);
						generated_file.putchar ('(');
						context.local_var.print_register_by_name;
					end;
					generated_file.putstring (");");
					generated_file.new_line;
				elseif type_i.is_bit then
					bit_i ?= type_i; -- Cannot fail
					context.result_var.print_register_by_name;
					generated_file.putstring (" = RTLB(");
					generated_file.putint (bit_i.size);
					generated_file.putstring (");");
					generated_file.new_line;
				end
			end;
		end;

	generate_expanded_cloning is
			-- Clone expanded parameters
		local
			arg: TYPE_I;
			i, count, nb_exp: INTEGER;
		do
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					arg := real_type (arguments.item (i));
					if arg.is_expanded then
						context.arg_var.set_position (i);
						generated_file.putstring ("if ((char *) 0 == ");
						context.arg_var.print_register_by_name;
						generated_file.putchar (')');
						generated_file.new_line;
						generated_file.indent;
						generated_file.putstring ("RTET(%"");
						generated_file.putstring (feature_name);
						generated_file.putstring ("%", EN_VEXP);");
						generated_file.new_line;
						generated_file.exdent;
							-- Expanded cloning protocol
						if context.exp_args > 1 then
							generated_file.putstring ("if (idx[");
							generated_file.putint (nb_exp);
							generated_file.putstring ("] == -1L)");
							generated_file.new_line;
							generated_file.indent;
							generate_arg_var_cloning (-1);
							generated_file.exdent;
							generated_file.putstring ("else");
							generated_file.new_line;
							generated_file.indent;
							generate_arg_var_cloning (nb_exp);
							generated_file.exdent;
							nb_exp := nb_exp + 1;
						else
							generate_arg_var_cloning (-1);
						end;
					end;
					i := i + 1;
				end;
			end;
		end;

	generate_arg_var_cloning (idx: INTEGER) is
			-- Generate cloning operation on Arg_var parameter from context
		do
			context.arg_var.print_register_by_name;
			generated_file.putstring (" = RTCL(");
			context.arg_var.print_register_by_name;
				-- If `idx' is not -1, then the reference was the one for the
				-- enclosing object and it needs adjusting by the expanded
				-- object's offset whithin that bigger object.
			if idx /= -1 then
				generated_file.putstring (" + idx[");
				generated_file.putint (idx);
				generated_file.putchar (']');
			end;
			generated_file.putchar (')');
			generated_file.putchar (';');
			generated_file.new_line;
		end;

	generate_locals is
			-- Declare C local variables
		local
			i, count: INTEGER;
			type_i: TYPE_I;
		do
				-- Eiffel local variables.
			if locals /= Void then
				count := locals.count;
				from
					i := locals.lower;
				until
					i > count
				loop
					type_i := locals.item (i);
					type_i := real_type (type_i);
							-- Generate only if variable used
					if context.local_vars.item(i) then
							-- Local reference variable are declared via
							-- the local variable array "l[]".
						if not context.need_gc_hooks or else
							not type_i.c_type.is_pointer then
							type_i.c_type.generate (generated_file);
							generated_file.putstring ("loc");
							generated_file.putint (i);
							generated_file.putstring (" = ");
							type_i.c_type.generate_cast (generated_file);
							generated_file.putstring ("0;");
							generated_file.new_line;
						end;
					end;
					i := i + 1;
				end;
			end;

				-- Generate index table if we have more than one expanded
				-- argument (cloning protocol).
			if context.exp_args > 1 then
				generated_file.putstring ("long idx[");
				generated_file.putint (context.exp_args);
				generated_file.putstring ("];");
				generated_file.new_line;
			end;

				-- Generate temporary locals under the control of the GC
			context.generate_temporary_ref_variables;

				-- Result is declared only if needed. It is a static value
				-- in case the routine is a once function.
			if (not result_type.is_void) and then context.result_used then
				generate_result_declaration;
			end;
				-- Declare the 'dtype' variable which holds the pre-computed
				-- dynamic type of current. To avoid unnecssary computations,
				-- this is not done in case of a once, before we know we have
				-- to really enter the body of the routine.
			if context.dt_current > 1 then
					-- There has to be more than one usage of the dynamic type
					-- of current in order to have this variable generated.
				if is_once then
					generated_file.putstring ("int dtype;");
				else
					generated_file.putstring ("int dtype = Dtype(Current);");
				end;
				generated_file.new_line;
			end;
				-- Generate the int local variable saving the global `nstcall'.
			if context.workbench_mode
				or else
				context.assertion_level.check_invariant
			then
				generated_file.putstring ("RTSN;");
				generated_file.new_line;
			end;
			if context.workbench_mode then
					-- Generate local variable for saving the workbench
					-- mode assertion level of the current object.
				generated_file.putstring ("RTDA;");
				generated_file.new_line;
			end;
				-- The local variable array is then declared, based on the
				-- number of reference variable which need to be placed under
				-- GC control (given by `ref_var_used').
			i := context.ref_var_used;
			if i > 0 then
				if rescue_clause /= Void then
					generated_file.putstring ("RTXD;");
					generated_file.new_line;
				else
					generated_file.putstring ("RTLD;");
					generated_file.new_line;
				end;
			end;
				-- Onces have an internal flag 'done'. Note that even if Result
				-- is not used in once functions, we have to generate the flag:
				-- we cannot simply return 0 in case some treatment with side
				-- effect were done.
			if is_once then
				generated_file.putstring ("static int done = 0;");
				generated_file.new_line;
			end;

				-- Generate temporary non-reference locals declarations
			context.generate_temporary_nonref_variables;

				-- Separate declarations and body with a blank line
			generated_file.new_line;
		end;

	generate_result_declaration is
			-- Generate the declaration of the Result entity
		local
			ctype: TYPE_C;
		do
			ctype := real_type (result_type).c_type;
			if ctype.is_pointer then
					-- The generation is included in the declaration of local
					-- variable array, hehe.
			else
				ctype.generate (generated_file);
				generated_file.putstring ("Result");
				generated_file.putstring (" = ");
				ctype.generate_cast (generated_file);
				generated_file.putstring ("0;");
				generated_file.new_line;
			end;
		end;

	init_dtype is
			-- Initializes the value of 'dtype' in once routines. For regular
			-- ones, the variable is initialized directly in the declaration.
		do
			if context.dt_current > 1 then
				generated_file.putstring ("dtype = Dtype(Current);");
				generated_file.new_line;
			end;
		end;

	generate_precondition is
			-- Generate precondition check if needed
		local
			workbench_mode: BOOLEAN;
			feat: FEATURE_I;
			have_assert: BOOLEAN;
			inh_assert: INHERITED_ASSERTION;
			count, i: INTEGER;
		do
			context.set_assertion_type (In_precondition);
			workbench_mode := context.workbench_mode;
			inh_assert := Context.inherited_assertion;
			have_assert := (precondition /= Void or else
							inh_assert.has_precondition) and then
				(workbench_mode or else context.assertion_level.check_precond);
			if have_assert then
				if workbench_mode then
					generated_file.putstring ("if (RTAL & CK_REQUIRE) {");
					generated_file.new_line;
					generated_file.indent;
				end;
				generate_invariant_before;
				if precondition /= Void then
					context.set_is_prec_first_block (True);
					Context.inc_label;
					precondition.generate;
					generated_file.putstring ("RTJB;");
					generated_file.new_line;
					generated_file.exdent;
					context.print_current_label;
					generated_file.putchar (':');
					generated_file.new_line;
					generated_file.indent;
				end;
				
				if inh_assert.has_precondition then
					inh_assert.generate_precondition
				end;

				if have_assert then
					if workbench_mode then
						generated_file.putstring ("RTCF;");
						generated_file.new_line;
						generated_file.putchar ('}');
						generated_file.new_line;
						generated_file.exdent;
					end;
				end;
			end;
		end;

	generate_postcondition is
			-- Generate postcondition check if needed
		local
			workbench_mode: BOOLEAN;
			have_assert: BOOLEAN;
			inh_assert: INHERITED_ASSERTION
		do
			workbench_mode := context.workbench_mode;
			inh_assert := Context.inherited_assertion;
			have_assert := (postcondition /= Void or else
							inh_assert.has_postcondition) and then
				(workbench_mode or else context.assertion_level.check_postcond);
			if have_assert then
				context.set_assertion_type (In_postcondition);
				if workbench_mode then
					generated_file.putstring ("if (RTAL & CK_ENSURE) {");
					generated_file.new_line;
					generated_file.indent;
				end;
				if postcondition /= Void then
					postcondition.generate;
				end;
				if inh_assert.has_postcondition then
					inh_assert.generate_postcondition
				end;
				generate_invariant_after;
				if workbench_mode then
					generated_file.putchar ('}');
					generated_file.new_line;
					generated_file.exdent;
				end;
			end;
		end;

	generate_save_assertion_level is
			-- Generate the instruction for saving the workbench mode
			-- assertion level of the current object.
		require
			workbench_mode: context.workbench_mode
		do
			generated_file.putstring ("RTSA(");
			generate_current_dtype;
			generated_file.putstring (");");
			generated_file.new_line;
		end;

	generate_current_dtype is
			-- Generate dynamic type of Current.
		do
			if context.dt_current > 1 then
				generated_file.putstring ("dtype");
			else
				generated_file.putstring ("Dtype(");
				context.current_register.print_register_by_name;
				generated_file.putchar (')');
			end;
		end;

	generate_invariant_before is
			-- Generate invariant check at the entry of the routine.
		do
			generate_invariant ("RTIV");
		end;

	generate_invariant_after is
			-- Generate invariant check at the end of the routine.
		do
			generate_invariant ("RTVI");
		end;

	generate_invariant (tag: STRING) is
			-- Generate invariant check with tag `tag'.
		do
			if  context.workbench_mode then
				generated_file.putstring (tag);
				generated_file.putchar ('(');
				context.current_register.print_register_by_name;
				generated_file.putstring (", RTAL);");
				generated_file.new_line;
			elseif context.assertion_level.check_invariant then
				generated_file.putstring (tag);
				generated_file.putchar ('(');
				context.current_register.print_register_by_name;
				generated_file.putstring (");");
				generated_file.new_line;
			end;
		end;

	generate_rescue is
			-- Generate the rescue clause
		local
			nb_refs: INTEGER;
		do
			if rescue_clause /= Void then
				generated_file.new_line;
				generated_file.exdent;
				generated_file.putstring("rescue:");
				generated_file.new_line;
				generated_file.indent;
				generated_file.putstring("RTEU;");
				generated_file.new_line;
					-- Resynchronize local variables stack
				nb_refs := context.ref_var_used;
				if nb_refs > 0 then
					generated_file.putstring ("RTXS(");
					generated_file.putint (nb_refs);
					generated_file.putstring (");");
					generated_file.new_line;
				end;
				rescue_clause.generate;
				generated_file.putstring ("/* NOTREACHED */");
				generated_file.new_line;
				generated_file.putstring("RTEF;");
				generated_file.new_line;
			end;
		end;

	exception_stack_managed: BOOLEAN is
			-- Do we have to manage the exception stack
		do
			Result := context.workbench_mode;
--			Result := true;
		end;

	generate_execution_declarations is
			-- Generate the declarations needed for exception trace handling
		do
			if rescue_clause /= Void then
				generated_file.putstring ("RTED;");
				generated_file.new_line;
			end;
			if exception_stack_managed or rescue_clause /= Void then
				generated_file.putstring ("RTEX;");
				generated_file.new_line;
			end;
		end;

	generate_execution_trace is
			-- Generate the execution trace stack handling
		do
			if exception_stack_managed then
				generated_file.putstring ("RTEA(%"");
				generated_file.putstring (feature_name);
				generated_file.putstring ("%", ");
				generated_file.putint (feature_origin);
				generated_file.putstring (", ");
				context.Current_register.print_register_by_name;
				generated_file.putstring (");");
				generated_file.new_line;
			elseif rescue_clause /= Void then
				generated_file.putstring ("RTEV;");
				generated_file.new_line;
			end;
		end;

	generate_pop_execution_trace is
			-- Generate the execution trace stack handling at the end of the
			-- routine
		do
			if exception_stack_managed or else rescue_clause /= Void
			then
				generated_file.putstring ("RTEE;");
				generated_file.new_line;
			end;
		end;

	finish_compound is
			-- Generate the end of the compound routine
		do
				-- Generate the removela of the GC hooks
			context.remove_gc_hooks;
				-- Generate the update of the trace stack before quitting
				-- the routine
			generate_pop_execution_trace;
			if rescue_clause /= Void then
				generated_file.putstring ("RTOK;");
				generated_file.new_line;
			end;
		end;

feature -- Byte code generation

	formulate_inherited_assertions (assert_id_set: ASSERT_ID_SET) is
			-- Formulate inherited post and pre conditions
			-- from the precursor definition of feature `feat'
			-- and save the details in inherited_assertion.
		require
			valid_arg: assert_id_set /= Void;
			current_not_basic: not Context.associated_class.is_basic;
		local
			byte_code: BYTE_CODE;
			inh_f: INH_ASSERT_INFO;
			ct: CLASS_TYPE;
			inh_c: CLASS_C;
			bd_id, i: INTEGER;
		do
			from
				i := 1;
			until
				i > assert_id_set.count
			loop
				inh_f := assert_id_set.item (i);
				if inh_f.has_assertion then
					--! Has assertion
					inh_c := System.class_of_id (inh_f.written_in);
					if inh_c.generics = Void then
						ct := inh_c.types.first;
					else
						ct := inh_c.meta_type (Context.current_type).associated_class_type;
					end;
					bd_id := System.body_index_table.item (inh_f.body_index);
					byte_code := System.byte_server.item (bd_id);
					if inh_f.has_precondition then
						Context.inherited_assertion.add_precondition_type (ct, byte_code);
					end;
					if inh_f.has_postcondition then
						Context.inherited_assertion.add_postcondition_type (ct, byte_code);
					end;
				end;
				i := i + 1;
			end;
		end;

	make_body_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		local
			have_assert: BOOLEAN;
			feat: FEATURE_I;
			inh_assert: INHERITED_ASSERTION;
		do
			feat := Context.associated_class.feature_table.item (feature_name);
			inh_assert := Context.inherited_assertion;
			inh_assert.init;
debug ("ACTIVITY")
			io.putstring ("feature name: ");
			io.putstring (feature_name);
			io.new_line;
end;
			if 	Context.has_inherited_assertion and then 
				not Context.associated_class.is_basic and then
				feat.assert_id_set /= Void then
				--! Do not get inherited pre & post for basic types
				formulate_inherited_assertions (feat.assert_id_set);
			end;
			have_assert := precondition /= Void or else inh_assert.has_precondition;
			if have_assert then
				context.set_assertion_type (In_precondition);
				ba.append (Bc_precond);
				ba.mark_forward;
			end;
			if precondition /= Void then
				context.set_is_prec_first_block (True);
				precondition.make_byte_code (ba);
				ba.append (Bc_goto_body);
				ba.mark_forward;
			end;
			if inh_assert.has_precondition then
				inh_assert.make_precondition_byte_code (ba);
			end;
			if have_assert then
				ba.append (Bc_raise_prec);
				if precondition /= Void then
					ba.write_forward;
				end;
				if inh_assert.has_precondition then
					inh_assert.write_forward (ba)
				end;
				ba.write_forward;
			end;
			if 	postcondition /= Void and then 	
				old_expressions /= Void then
					-- Make byte code for old expression
					--! Order is important since interpretor pops expression
					--! bottom up.
				from
					old_expressions.finish
				until
					old_expressions.before
				loop
					old_expressions.item.make_initial_byte_code (ba);
					old_expressions.back
				end
			end;
				-- Make byte code for inherited old expressions
			have_assert := postcondition /= Void or else inh_assert.has_postcondition;
			if 	have_assert then
				if inh_assert.has_postcondition then
					inh_assert.make_old_exp_byte_code (ba);
				end;
			end;
			context.record_breakable (ba);	-- Breakpoint on body entrance
			if compound /= Void then
				compound.make_byte_code (ba);
			end;

				-- Make byte code for postcondition
			if have_assert then
				context.set_assertion_type (In_postcondition);
				ba.append (Bc_postcond);
				ba.mark_forward;
			end;
			if postcondition /= Void then
				postcondition.make_byte_code (ba);
			end;
			if inh_assert.has_postcondition then
				inh_assert.make_postcondition_byte_code (ba);
			end;
			if have_assert then
				ba.write_forward;
			end;
			inh_assert.wipe_out;
		end;

end
