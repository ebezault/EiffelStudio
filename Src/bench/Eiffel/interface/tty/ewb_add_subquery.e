class EWB_ADD_SUBQUERY

inherit
	EWB_QUERY
		redefine
			loop_action
		end;

feature {NONE} -- Execute

	loop_action is
		local
			command_arguments: EWB_ARGUMENTS;
			i: INTEGER;
			start, modval: INTEGER;
			argument: STRING;
		do
			command_arguments := command_line_io.command_arguments;
			if command_arguments.argument_count >= 4 then
				!! subquery.make (command_arguments.item (2), command_arguments.item (3), command_arguments.item (4));
			else
				extra_help;
				from
					io.putstring ("--> Subquery: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
				until
					command_arguments.argument_count = 3
				loop
					io.putstring ("--> Subquery: ");
					command_line_io.get_name;
					command_arguments := command_line_io.command_arguments;
				end;
				!! subquery.make (command_arguments.item (1), command_arguments.item (2), command_arguments.item (3));
			end;
			execute;
		end;

	execute is
		local
			sq_op: SUBQUERY_OPERATOR
		do
			subqueries.extend (subquery);
			if subqueries.count > 1 then
				!! sq_op.make ("and");
				subquery_operators.extend (sq_op);
				from
					subqueries.finish;
				until
					subqueries.before or not subqueries.item.is_active
				loop
					subqueries.back;
				end;
				if not subqueries.before then
					from
						subquery_operators.go_i_th (subqueries.index);
						subquery_operators.item.inactivate;
					until
						subqueries.before or subqueries.item.is_active
					loop
						subqueries.back;
					end;
					if not subqueries.before then
						subquery_operators.go_i_th (subqueries.index);
						subquery_operators.item.activate;
					end;
				end;
			end;
		end;

feature -- Properties

	name: STRING is
		once
			Result := add_subquery_cmd_name;
		end;

	help_message: STRING is
		once
			Result := add_subquery_help;
		end;

	abbreviation: CHARACTER is
		once
			Result := add_subquery_abb;
		end;

feature {NONE} -- Implementation

	extra_help is
			-- Prints some extra help on this command.
		do
			io.putstring ("A subquery has the following form: ");
			io.putstring ("attribute operator value%N%N");
			io.putstring ("attribute is one of: featurename, calls, total, self, descendents, percentage%N");
			io.putstring ("operator is one of: < > <= >= = /= in%N");
			io.putstring ("value is one of: integer (for calls), string_with_wildcards (for featurename)%N");
			io.putstring ("%T%T real (for other attributes) or a bounded_value%N");
			io.putstring ("%T%T%TA string_with_wildcards is a string containing%N%T%T%T'*' or '?'%N");
			io.putstring ("%T%T%TA bounded_value is a value followed by '-' followed by%N%T%T%Ta value%N");
			io.putstring ("%T%T%T%TNo strings are allowed here.%N");
		end;

feature {NONE} -- Attributes

	subquery: SUBQUERY

end -- class EWB_ADD_SUBQUERY
