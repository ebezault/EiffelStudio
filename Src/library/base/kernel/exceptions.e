--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- facilities for controlling exception handling

indexing

	date: "$Date$";
	revision: "$Revision$"

class EXCEPTIONS



feature -- Ouput

	raise (tag: STRING) is
			-- Raise a user exception of tag `tag'.
		local
			str: ANY;
		do
			if tag /= Void then
				str := tag.to_c
			end;
			eraise ($str, Programmer_exception);
		end;

feature -- Status report

	is_programmer_exception (tag: STRING): BOOLEAN is
			-- Is the last exception a programmer exception of tag `tag' ?
		do
			Result := 	exception = Programmer_exception
						and then
						equal (tag, programmer_exception_name)
		end;

feature  {NONE} -- Access
				--| Those values cannot be changed and match with run-time
				--| C constants

	Programmer_exception: INTEGER is 24;


feature  {NONE} -- External, Ouput

	eraise (str: ANY; code: INTEGER) is
			-- Raise an exception
		external
			"C"
		end;


feature -- External, Status report

	exception: INTEGER is
			-- Last exception code
		external
			"C"
		alias
			"eecode"
		end;


	programmer_exception_name: STRING is
			-- Last programmer exception tag
		external
			"C"
		alias
			"eetag"
		end;

end -- class EXCEPTIONS
