indexing
	description: "Up-down control (UD) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UD_CONSTANTS

feature -- Access

	Ud_maxval: INTEGER is
			-- Maximum value allowed in an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UD_MAXVAL"
		end

	Ud_minval: INTEGER is
			-- Minimum value allowed in an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UD_MINVAL"
		end

end -- class WEL_UD_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
