-- List used in abstract syntax trees.

class CONSTRUCT_LIST [T]

inherit

	AST_YACC
		undefine
			copy, setup, consistent, is_equal
		redefine
			pass_address
		end;
	FIXED_LIST [T]
		export
			{NONE} make
		redefine
			sequential_index_of
		end;

creation
	make_filled

feature

	pass_address (n: INTEGER) is
			-- Eiffel-yacc interface
		do
			c_get_address (n, $Current, $make_filled);
			c_get_list_area ($to_c);
		end;

	set is
		do
			-- Do nothing
		end;

	sequential_index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- (According to the discrimination rule used by `search')
			-- 0 if none.
		local
			a_occurrences, pos: INTEGER
		do
			from
				start;
				pos := 1;
			until
				off or else (a_occurrences = i)
			loop
				if equal (item, v) then
					a_occurrences := a_occurrences + 1;
				end;
				forth;
				pos := pos + 1
			end;
			if a_occurrences = i then
				Result := pos - 1
			end
		end;

feature {NONE} -- Externals

	c_get_list_area (ptr: POINTER) is
			-- Send `ptr' to Yacc
		external	
			"C"
		end;

end
