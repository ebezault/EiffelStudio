class SELECTION_LIST 
	
inherit

	SORTED_TWO_WAY_LIST [INHERIT_INFO];
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_SELECTED;
	SHARED_ORIGIN_TABLE;
	SHARED_INHERITED;

creation

	make
	
feature 

	selection (parents: PARENT_LIST; old_t, new_t: FEATURE_TABLE): FEATURE_I is
			-- Feautre selected in the list.
		require
			not empty;
		local
			a_feature, old_feature: FEATURE_I;
			rout_id_set: ROUT_ID_SET;
			new_rout_id: INTEGER;
			feat_table: SELECT_TABLE;
			first_feature: FEATURE_I;
			stop: BOOLEAN;
			id, first_body_id: INTEGER;
		do
--debug ("REPLICATION")
	--trace;
--end;
			if not System.code_replication_off and then count > 1 then
				detect_replication (parents);
--debug ("REPLICATION")
	--io.error.putstring ("after repl%N");
	--trace;
--end;
			end;
			first_feature := first.a_feature;
			if 	one_body_only
				and then
				(	first_feature.written_class.generics = Void
					or else
					same_parent_type
				)
			then
				Result := first_feature;
			else
					-- Look for a valid selection
				Result := parent_selection (parents);

				if Result /= Void then
						-- Keep track of the selection
					Selected.add_front (Result.feature_name);
					from
						start;
						feat_table := Origin_table.computed;
					until
						empty
					loop
						unselect (new_t, old_t, feat_table);
					end;
					Result.set_is_selected (True);
debug ("REPLICATION")
	io.error.putstring ("Selected feature is: ");
	io.error.putstring (Result.feature_name);
	io.error.putstring (Result.generator);
	io.error.new_line;
end;
				end;
			end;
		end;

	Routine_id_counter: COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter;
		end;

	parent_selection (parents: PARENT_LIST): FEATURE_I is
			-- Manual selected feature
		require
			not empty
		local
			feature_i: FEATURE_I;
			vmrc2: VMRC2;
		do
			from
				start
			until
				after or else Result /= Void
			loop
				feature_i := item.a_feature;
				if parents.is_selecting (feature_i.feature_name) then
					Result := feature_i;
				else
					forth;
				end;
			end;
			if Result /= Void then
					-- Check if there is no second selection
				from
						-- Remove result information
					remove;
				until
					after
				loop
					feature_i := item.a_feature;
					if parents.is_selecting (feature_i.feature_name) then
						!!vmrc2;
						vmrc2.set_class (System.current_class);
						vmrc2.init (Result, feature_i);
						Error_handler.insert_error (vmrc2);
					end;

					forth
				end;
			end;
		end;

	one_body_only: BOOLEAN is
			-- Is only one body id invloved in the selection list ?
		require
			not empty
		do
			Result := 	first.a_feature.code_id
						= 
						last.a_feature.code_id;
		end;

	same_parent_type: BOOLEAN is
			-- Are all the feature comming form the same written type ?
		require
			not empty;
			one_body_only;
			has_generics: first.a_feature.written_class.generics /= Void;
		local
			instantiator, written_actual_type, written_type, to_compair: TYPE_A;
			written_class: CLASS_C;
			written_id, pos: INTEGER;
			info: INHERIT_INFO;
		do
			pos := position;
			from
				info := first;
				Result := True;
				written_class := info.a_feature.written_class;
				written_id := written_class.id;
				written_actual_type := written_class.actual_type;
				to_compair := written_actual_type.duplicate;
				if info.parent = Void then
						-- Redeclaration
					instantiator := written_actual_type;
				else
					instantiator := info.parent.parent_type;
				end;
				to_compair := to_compair.instantiation_in
													(instantiator, written_id);
				go (2);
			until
				after or else not Result
			loop
				written_type := written_actual_type.duplicate;
				info := item;
				if info.parent = Void then
						-- Redeclaration
					instantiator := written_actual_type;
				else
					instantiator := info.parent.parent_type;
				end;
				written_type := written_type.instantiation_in
													(instantiator, written_id);
				Result := deep_equal (to_compair, written_type);
				forth;
			end;
			go (pos);
		end;
	
	unselect (new_t, old_t: FEATURE_TABLE; select_table: SELECT_TABLE) is
			-- Process first unselected feature
		require
			good_arguments: not (new_t = Void or old_t = Void);
			not_off: not off
		local
			info: INHERIT_INFO;
			a_feature, old_feature: FEATURE_I;
			info_parent: PARENT_C;
			rout_id_set: ROUT_ID_SET;
			cond, in_generic_class: BOOLEAN;
			first_body_id, new_rout_id, written_id, id: INTEGER;
			instantiator, to_compair, written_type, written_actual_type: TYPE_A;
			written_class: CLASS_C;
			feature_name: STRING;
			old_pos: INTEGER
		do		
			id := new_t.feat_tbl_id;
			info := first;
			a_feature := info.a_feature;
			first_body_id := a_feature.body_id;
				-- New unselected feature
			a_feature := a_feature.unselected (id);
				-- Process new routine id set
			!!rout_id_set.make (1);
			feature_name := a_feature.feature_name;	
debug ("REPLICATION")
	io.error.putstring ("unselecting :");
	io.error.putstring (feature_name);
	io.error.new_line;
end;
			old_feature := old_t.item (feature_name);
				-- Process a new routine id
			if 	old_feature /= Void and then
				old_feature.is_unselected and old_feature.access_in = id
			then
					-- Take an old one
				new_rout_id := old_feature.rout_id_set.first;
			else
					-- Take a new one
				new_rout_id := a_feature.new_rout_id;
			end;
			rout_id_set.put (new_rout_id);
			if new_rout_id < 0 then
					-- Attribute routine id
				new_rout_id := - new_rout_id;
			end;
				-- Insertion into thwe routine info table
			System.rout_info_table.put (new_rout_id, System.current_class);	
			a_feature.set_rout_id_set (rout_id_set);
			a_feature.set_is_selected (False);
			a_feature.set_is_origin (True);
			select_table.put (a_feature, new_rout_id);
			new_t.replace (a_feature, feature_name);

				-- Remove unselection
			remove;

			if not after then
				written_class := a_feature.written_class;
				in_generic_class := written_class.generics /= Void;
				if in_generic_class then
						-- Prepare an instantiated type
					written_id := written_class.id;
					written_actual_type := written_class.actual_type;
					info_parent := info.parent;
					to_compair := written_actual_type.duplicate;
					if info_parent = Void then
						instantiator := written_actual_type;
					else
						instantiator := info_parent.parent_type;
					end;
					to_compair := to_compair.instantiation_in
													(instantiator, written_id);
				end;
			end;
			
			from
				old_pos := position
			until
				after
			loop
				info := item;
				a_feature := info.a_feature;
					-- First condition for unselection: same body id
				cond := a_feature.body_id = first_body_id;
				if cond and then in_generic_class then
						-- Second condition if written in a generic class: same
						-- instantiated written actual type.
					info_parent := info.parent;
					if info_parent = Void then
						instantiator := written_actual_type;
					else
						instantiator := info_parent.parent_type;
					end;
					written_type := written_actual_type.duplicate;
					written_type := written_type.instantiation_in
													(instantiator, written_id);
					cond := to_compair.same_as (written_type);
				end;
				if cond then
					a_feature := a_feature.unselected (id);	
					a_feature.set_is_selected (False);
					a_feature.set_is_origin (True);
					a_feature.set_rout_id_set (rout_id_set.duplicate);
					new_t.replace (a_feature, a_feature.feature_name);
					remove
				else
					forth
				end
			end;
			go (old_pos)
		end;

	trace is
			-- Debug purpose
		do
			from
				start
			until
				after
			loop
if item.a_feature.written_class > System.any_class.compiled_class and
		item.a_feature /= Void then
				if item.parent = Void then
					io.error.putstring ("VOID");
				else
					io.error.putstring (item.parent.class_name);
				end;
				io.error.putstring (": ");
				io.error.putstring (item.a_feature.generator);
				io.error.putstring (item.a_feature.feature_name);
				--io.error.putchar (' ');
				item.a_feature.rout_id_set.trace;
				io.error.putstring (" {body_id = ");
				io.error.putint (item.a_feature.body_id);
				io.error.putstring ("} written class: ");
				io.error.putstring (item.a_feature.written_class.class_name);
				io.error.new_line;
				io.error.putstring ("Written in feature name: ");

	if System.Feat_tbl_server.has (item.a_feature.written_in) then
				io.error.putstring
(item.a_feature.written_class.feature_table.feature_of_body_id
(item.a_feature.body_id).feature_name);
	else
				io.error.putstring ("Dunno");
	end;
				io.error.new_line;
end;
				forth;
			end;
		end;

feature -- Replication

	detect_replication (parent_list: PARENT_LIST) is
			-- Detect perform replication. 
		local
			cur: CURSOR;
			curr_feat, tmp_feat: FEATURE_I;
			found: BOOLEAN;
			rep_name: REP_NAME;
			replication: FEATURE_I;
			rep_name_list: REP_NAME_LIST;
			inh_info: INHERIT_INFO;
			parent: PARENT_C;
			parents: LINKED_LIST [PARENT_C];
		do
			from
				start
			until
				after
			loop
				inh_info := item;
				curr_feat := item.a_feature;
				cur := cursor;
				from
					start;
					found := False;
				until
					after or found
				loop
					tmp_feat := item.a_feature;
					if 
						--(curr_feat.written_class.conform_to
									--(tmp_feat.written_class) or else
						--tmp_feat.written_class.conform_to
									--(curr_feat.written_class)) and then
						not (curr_feat.feature_name.is_equal 
									(tmp_feat.feature_name)) and then
						(curr_feat /= tmp_feat) 
					then
debug ("ACTUAL_REPLICATION")
	io.error.putstring ("(selection) Detecting replication: ");
	io.error.putstring (curr_feat.feature_name);
	io.error.new_line;
end;
debug ("REPLICATION")
	io.error.putstring ("(selection) Detecting replication: ");
	io.error.putstring (curr_feat.feature_name);
	io.error.new_line;
end;
						found := True;
						replication := curr_feat.replicated;
						if inh_info.parent = Void then
							-- if feature was redefined or merged or joined
							-- then try to find parent clause to which
							-- it came from
							parents := find_parents (parent_list,
										 curr_feat.feature_name);
						else
							!!parents.make;
							parents.add_front (inh_info.parent);
						end;
						inh_info.set_a_feature (replication);
						from
							parents.start
						until
							parents.after
						loop
							parent := parents.item;
							!!rep_name;
							rep_name.set_rep_feature (replication);
							rep_name_list := rep_list_item (parent);
							rep_name_list.add_front (rep_name);
							parents.forth
						end;
					end;
					forth;
				end;
				go_to (cur);
				forth
			end;
		end;

	rep_list_item (p: PARENT_C): REP_NAME_LIST is
			-- Retrieve rep_name_list for parent `p'. If not
			-- exist, then create one (and adds it to the
			-- rep_parent_list of INHERIT_TABLE - side affect).
		local
			list: LINKED_LIST [REP_NAME_LIST];
			rep_list: REP_NAME_LIST;
		do
			list := Inherit_table.rep_parent_list;
			from
				list.start
			until
				list.after or else (Result /= Void)
			loop
				rep_list := list.item;
				if rep_list.has_parent_clause (p) then
					Result := rep_list
				end;
				list.forth;
			end;
			if (Result = Void) then
				!!Result.make (p);
				list.add_front (Result);
			end;
		end;

	find_parents (parent_list: PARENT_LIST; 
				name: STRING): LINKED_LIST [PARENT_C] is
		local
			f_table: FEATURE_TABLE;
			parent_c: PARENT_C;
		do
			from
				parent_list.start;
				!!Result.make;
			until
				parent_list.after or else Result.count > 0 
			loop
				parent_c := parent_list.item;
				if parent_c.has_renamed (name) then
					Result.add_front (parent_c);
				end;	
				parent_list.forth
			end;
			if Result.count = 0 then
				-- We didn't find the name in the rename clause
				-- of any of the parents.
				from
					parent_list.start
				until
					parent_list.after
				loop
					parent_c := parent_list.item;
					f_table := parent_c.parent.feature_table;
					if 
						not parent_c.is_renaming (name) and then 
						f_table.has (name) 
					then
						Result.add_front (parent_c);
					end;
					parent_list.forth
				end;
			end;
		end;

end
