indexing
	description: "value dealing with year, month and day"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	access: date, time

class
	DATE_VALUE

inherit
	DATE_CONSTANTS

creation

feature -- Access

	day: INTEGER is
			-- Day of the current object
		do
			Result := c_day (compact_date);
		end

	month: INTEGER is
			-- Month of the current object
		do
			Result := c_month (compact_date);
		end

	year: INTEGER is
			-- Year of the current object 
		do
			Result := c_year (compact_date);
		end

	compact_date: INTEGER
			-- Day, month and year coded.

feature {NONE} -- External

	c_day (c_d: INTEGER): INTEGER is
		external
			"C"
		end

	c_month (c_d: INTEGER): INTEGER is
		external
			"C"
		end

	c_year (c_d: INTEGER): INTEGER is
		external
			"C"
		end

end -- class DATE_VALUE


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


