-- Eiffel class generated by the 2.3 to 3 translator.


-- pulldown for option button implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class OPT_PULL_I 

inherit

	PULLDOWN_I



	
feature 

	option_button: OPTION_B;
			-- option button which contains the pulldown

	selected_button: BUTTON is
            		-- Current Push Button selected in the option menu
		deferred
		end;

   	set_selected_button (button: BUTTON) is
            		-- Set `selected_button' to `button'
		deferred
	        ensure
		        button.same (selected_button)
	        end; -- set_selected_button

feature
	caption: STRING is
		deferred
		end;

	set_caption (a_caption: STRING) is
		deferred
		end;

	add_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
		do
		end;


end -- class OPT_PULL_I


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
