indexing

	description: 
		"EiffelVision menu. Menu contains several menu items and shows them when the menu is opened."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU

inherit
	EV_MENU_ITEM_HOLDER 
		redefine
			implementation
		end

creation
	make,
	make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_MENU_HOLDER) is
			-- Create an empty menu.
		do
			!EV_MENU_IMP!implementation.make
			implementation.set_interface (Current)
			implementation.set_parent (par)
		end

	make_with_text (par: EV_MENU_HOLDER; label: STRING) is         
			-- Create a menu widget with `par' as
			-- parent
		do
			!EV_MENU_IMP!implementation.make_with_text (label)
			implementation.set_interface (Current)
			implementation.set_parent (par)
		end	

feature -- Access

	count: INTEGER is
			-- Number of items in the menu.
		do
			Result := implementation.count
		end

	get_item (index: INTEGER): EV_MENU_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: (index <= count) and (index >= 0)	
		do
			Result := implementation.get_item (index)
		end

	text: STRING is
			-- Label of the current menu
		require
			exists: not destroyed
		do
			Result := implementation.text
		end

feature -- Element change

	set_parent (par: EV_MENU_HOLDER) is
			-- Make `par' the new parent of the item.
		require
			exists: not destroyed
		do
			implementation.set_parent (par)
		end

feature -- Implementation
	
	implementation: EV_MENU_I	

end -- class EV_MENU

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
