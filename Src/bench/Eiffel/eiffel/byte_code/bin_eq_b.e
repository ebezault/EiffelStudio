class BIN_EQ_B 

inherit

	BIN_EQUAL_B
		redefine
			enlarged, generate_operator
		end
	
feature

	generate_operator is
			-- Generate the operator
		do
			generated_file.putstring (" == ");
		end;

	generate_boolean_constant is
			-- Generate false constant
		do
			generated_file.putstring ("'\0'");
		end;

	enlarged: BIN_EQ_BL is
			-- Enlarge node
		do
			!!Result;
			Result.fill_from (Current);
		end;

feature -- Byte code generation

	
	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			Result := Bc_eq
		end;

	expanded_operator_constant: CHARACTER is
			-- Byte code constant associated to current expanded
			-- equality
		do
			Result := Bc_standard_equal;
		end;

	obvious_operator_constant: CHARACTER is 
			-- Byte code operator associated to an obvious false
			-- comparison
		do
			Result := Bc_false_compar;
		end;

end
