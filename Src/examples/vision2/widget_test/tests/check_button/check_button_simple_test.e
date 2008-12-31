note
	description: "Objects that demonstrate simple creation%
		%of EV_CHECK_BUTTON"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BUTTON_SIMPLE_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		do
			create check_button.make_with_text ("A Check button")
			widget := check_button
		end
				
feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON;
		-- Widget that test is to be performed on.
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CHECK_BUTTON_SIMPLE_TEST
