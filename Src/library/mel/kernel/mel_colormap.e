indexing

	description: 
		"Implementation of Colormap.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COLORMAP

creation
	make_from_existing

creation {MEL_SCREEN} 

	make_default

feature {NONE} -- Initialization

	make_from_existing (an_id: like identifier) is
			-- Initialize `identifier' with C pointer `an_id'.
		require
			id_not_null: an_id /= default_pointer
		do
			identifier := an_id
		ensure
			set: identifier = an_id
		end;

	make_default (a_screen: MEL_SCREEN) is
			-- Initialize to default colormap of `screen'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		do
			identifier := DefaultColormapOfScreen (a_screen.handle);
		end;

feature -- Access

	identifier: POINTER;
			-- Associated C identifier

	is_valid: BOOLEAN is
			-- Is the resource valid?
		do
			Result := identifier /= default_pointer
		ensure
			valid_result: Result implies identifier /= default_pointer
		end;

feature {NONE} -- External features

	DefaultColormapOfScreen (a_screen: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Screen *): EIF_POINTER"
		alias
			"DefaultColormapOfScreen"
		end;

invariant

	identifier_not_null: identifier /= default_pointer

end -- class MEL_COLORMAP

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
