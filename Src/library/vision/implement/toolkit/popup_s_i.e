indexing

	description: "General popup shell implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class POPUP_S_I 

inherit

	SHELL_I
	
feature 

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		deferred
		end;

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		deferred
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		deferred
		end;

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		deferred
		end; 

	popdown is
			-- Popdown popup shell.
		deferred
		ensure
			not is_popped_up
		end;

	popup is
			-- Popup a popup shell with no grab on it.
		deferred
		end;

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		deferred
		ensure
			is_cascade_grab
		end;

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		deferred
		ensure
			is_exclusive_grab
		end;

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		deferred
		ensure
			is_no_grab
		end

end -- class POPUP_S_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
