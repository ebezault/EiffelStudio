indexing
	description: 
		"EiffelVision menu, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_I
	
inherit
	EV_MENU_ITEM_CONTAINER_I

feature {NONE} -- Initialization

	make (par: EV_MENU_CONTAINER) is
			-- Create an empty menu.
		deferred
		end	

	make_with_text (par: EV_MENU_CONTAINER; txt: STRING) is
			-- Create an empty menu with `label' as label. 
		deferred
		end	

feature -- Access

	text: STRING is
			-- Label of the current menu
		require
			exists: not destroyed
		deferred
		end

	interface: EV_MENU
		-- Interface of the current object

feature -- Element change

	set_interface (an_interface: EV_MENU) is
			-- Make `an_interface' the interface of the current
			-- implementation
		do
			interface := an_interface
		end

end -- class EV_MENU_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
