indexing
	description: "Clipping precision (CLIP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIP_PRECISION_CONSTANTS

feature -- Access

	Clip_default_precis: INTEGER is 0

	Clip_character_precis: INTEGER is 1

	Clip_stroke_precis: INTEGER is 2

	Clip_mask: INTEGER is 15

	Clip_lh_angles: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CLIP_LH_ANGLES"
		end

	Clip_tt_always: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CLIP_TT_ALWAYS"
		end

	Clip_embedded: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CLIP_EMBEDDED"
		end

end -- class WEL_CLIP_PRECISION_CONSTANTS

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

