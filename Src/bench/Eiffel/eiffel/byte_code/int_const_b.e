class INT_CONST_B 

inherit

	EXPR_B
		redefine
			print_register, make_byte_code,
			is_simple_expr
		end;
	
feature 

	value: INTEGER;
			-- Character value

	set_value (v: INTEGER) is
			-- Assign `v' to `value'.
		do
			value := v;
		end;

	type: TYPE_I is
			-- Integer type
		once
			Result := Long_c_type;
		end;

	print_register is
			-- Print integer constant
		do
			generated_file.putint (value);
			generated_file.putchar ('L');
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end; -- used

	is_simple_expr: BOOLEAN is true;
			-- A constant is a simple expression

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant
		do
			ba.append (Bc_int);
			ba.append_integer (value);
		end; -- make_byte_code

end
