indexing
	description: "Eiffel Vision menu. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_IMP
	
inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			initialize,
			on_activate,
			destroy,
			show
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			initialize,
			list_widget,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			list_widget := {EV_GTK_EXTERNALS}.gtk_menu_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (list_widget)
			{EV_GTK_EXTERNALS}.gtk_menu_item_set_submenu (
				c_object, list_widget
			)
			Precursor {EV_MENU_ITEM_LIST_IMP}
			Precursor {EV_MENU_ITEM_IMP}
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		local
			pc: EV_COORDINATE
			bw: INTEGER
		do
			pc := (create {EV_SCREEN}).pointer_position
			bw := {EV_GTK_EXTERNALS}.gtk_container_struct_border_width (list_widget)
			if not interface.is_empty then
				c_gtk_menu_popup (list_widget, pc.x + bw, pc.y + bw)
			end
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
			if not interface.is_empty then
				c_gtk_menu_popup (list_widget,
					a_widget.screen_x + a_x,
					a_widget.screen_y + a_y)
			end
		end

feature {NONE} -- Externals

	frozen c_gtk_menu_popup (a_menu: POINTER; a_x, a_y: INTEGER) is
		external
			"C inline use %"ev_menu_imp.h%""
		alias
			"[
				{
				c_position pos;
				pos.x_position = $a_x;
				pos.y_position = $a_y;
				gtk_menu_popup ((GtkMenu*) $a_menu, NULL, NULL, (GtkMenuPositionFunc) c_gtk_menu_position_func, &pos, 0, gtk_get_current_event_time());
				}
			]"
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
			end
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	list_widget: POINTER

	interface: EV_MENU

feature {NONE} -- Implementation
	
	destroy is
			-- Destroy the menu
		do
			interface.wipe_out
			Precursor {EV_MENU_ITEM_IMP}
		end

end -- class EV_MENU_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

