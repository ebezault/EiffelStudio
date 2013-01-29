note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_menu_bar_1
			create file_menu
			create file_exit_menu_item
			create view_menu
			create view_tools_menu_item
			create profile_menu
			create full_collect_menu_item
			create l_ev_menu_separator_1
			create profiling_on_menu_item
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create grid_cell
			create tools_notebook
			create grid_tab
			create column_tab
			create row_tab
			create item_tab
			create selection_tab
			create position_tab
			create events_tab
			create status_bar_frame
			
				-- Build_widget_structure.
			set_menu_bar (l_ev_menu_bar_1)
			l_ev_menu_bar_1.extend (file_menu)
			file_menu.extend (file_exit_menu_item)
			l_ev_menu_bar_1.extend (view_menu)
			view_menu.extend (view_tools_menu_item)
			l_ev_menu_bar_1.extend (profile_menu)
			profile_menu.extend (full_collect_menu_item)
			profile_menu.extend (l_ev_menu_separator_1)
			profile_menu.extend (profiling_on_menu_item)
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (grid_cell)
			l_ev_horizontal_box_1.extend (tools_notebook)
			tools_notebook.extend (grid_tab)
			tools_notebook.extend (column_tab)
			tools_notebook.extend (row_tab)
			tools_notebook.extend (item_tab)
			tools_notebook.extend (selection_tab)
			tools_notebook.extend (position_tab)
			tools_notebook.extend (events_tab)
			l_ev_vertical_box_1.extend (status_bar_frame)
			
			file_menu.set_text ("File")
			file_exit_menu_item.set_text ("Exit")
			view_menu.set_text ("View")
			view_tools_menu_item.enable_select
			view_tools_menu_item.set_text ("Tools Displayed")
			profile_menu.set_text ("Profile")
			full_collect_menu_item.set_text ("Full Memory Collect")
			profiling_on_menu_item.set_text ("Profiling on")
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (status_bar_frame)
			l_ev_horizontal_box_1.disable_item_expand (tools_notebook)
			grid_cell.set_minimum_width (500)
			grid_cell.set_minimum_height (400)
			tools_notebook.set_minimum_width (400)
			tools_notebook.set_item_text (grid_tab, "General")
			tools_notebook.set_item_text (column_tab, "Column")
			tools_notebook.set_item_text (row_tab, "Row")
			tools_notebook.set_item_text (item_tab, "Item")
			tools_notebook.set_item_text (selection_tab, "Selection")
			tools_notebook.set_item_text (position_tab, "Position")
			tools_notebook.set_item_text (events_tab, "Events")
			status_bar_frame.set_style (1)
			set_title ("Grid Tester")
			
				--Connect events.
			file_exit_menu_item.select_actions.extend (agent file_exit_menu_item_selected)
			view_tools_menu_item.select_actions.extend (agent view_tools_menu_item_selected)
			full_collect_menu_item.select_actions.extend (agent full_collect_menu_item_selected)
			profiling_on_menu_item.select_actions.extend (agent profiling_on_menu_item_selected)
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	view_tools_menu_item, profiling_on_menu_item: EV_CHECK_MENU_ITEM
	column_tab: COLUMN_TAB
	grid_tab: GRID_TAB
	file_menu, view_menu,
	profile_menu: EV_MENU
	grid_cell: EV_CELL
	position_tab: POSITION_TAB
	row_tab: ROW_TAB
	tools_notebook: EV_NOTEBOOK
	item_tab: ITEM_TAB
	events_tab: EVENTS_TAB
	file_exit_menu_item,
	full_collect_menu_item: EV_MENU_ITEM
	selection_tab: SELECTION_TAB
	status_bar_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_menu_separator_1: EV_MENU_SEPARATOR
	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_menu_bar_1: EV_MENU_BAR

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	file_exit_menu_item_selected
			-- Called by `select_actions' of `file_exit_menu_item'.
		deferred
		end
	
	view_tools_menu_item_selected
			-- Called by `select_actions' of `view_tools_menu_item'.
		deferred
		end
	
	full_collect_menu_item_selected
			-- Called by `select_actions' of `full_collect_menu_item'.
		deferred
		end
	
	profiling_on_menu_item_selected
			-- Called by `select_actions' of `profiling_on_menu_item'.
		deferred
		end
	

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


end -- class MAIN_WINDOW_IMP
