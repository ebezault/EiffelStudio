indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANTS_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
			create l_vertical_box_1
			create l_horizontal_box_1
			create l_frame_1
			create l_vertical_box_2
			create constants_list
			create l_horizontal_box_2
			create display_all_types
			create l_horizontal_separator_1
			create l_horizontal_box_3
			create l_vertical_box_3
			create l_horizontal_box_4
			create l_cell_1
			create l_label_1
			create type_combo_box
			create string_item
			create integer_item
			create directory_item
			create pixmap_item
			create l_vertical_box_4
			create l_horizontal_box_5
			create l_cell_2
			create l_label_2
			create name_field
			create l_vertical_box_5
			create l_horizontal_box_6
			create l_cell_3
			create l_label_3
			create entry_selection_parent
			create l_cell_4
			create l_horizontal_box_7
			create l_cell_5
			create new_button
			create modify_button
			create remove_button
			create l_vertical_box_6
			create ok_button
			create l_cell_6
			
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_frame_1)
			l_frame_1.extend (l_vertical_box_2)
			l_vertical_box_2.extend (constants_list)
			l_vertical_box_2.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (display_all_types)
			l_vertical_box_2.extend (l_horizontal_separator_1)
			l_vertical_box_2.extend (l_horizontal_box_3)
			l_horizontal_box_3.extend (l_vertical_box_3)
			l_vertical_box_3.extend (l_horizontal_box_4)
			l_horizontal_box_4.extend (l_cell_1)
			l_horizontal_box_4.extend (l_label_1)
			l_vertical_box_3.extend (type_combo_box)
			type_combo_box.extend (string_item)
			type_combo_box.extend (integer_item)
			type_combo_box.extend (directory_item)
			type_combo_box.extend (pixmap_item)
			l_horizontal_box_3.extend (l_vertical_box_4)
			l_vertical_box_4.extend (l_horizontal_box_5)
			l_horizontal_box_5.extend (l_cell_2)
			l_horizontal_box_5.extend (l_label_2)
			l_vertical_box_4.extend (name_field)
			l_horizontal_box_3.extend (l_vertical_box_5)
			l_vertical_box_5.extend (l_horizontal_box_6)
			l_horizontal_box_6.extend (l_cell_3)
			l_horizontal_box_6.extend (l_label_3)
			l_vertical_box_5.extend (entry_selection_parent)
			l_vertical_box_2.extend (l_cell_4)
			l_vertical_box_2.extend (l_horizontal_box_7)
			l_horizontal_box_7.extend (l_cell_5)
			l_horizontal_box_7.extend (new_button)
			l_horizontal_box_7.extend (modify_button)
			l_horizontal_box_7.extend (remove_button)
			l_horizontal_box_1.extend (l_vertical_box_6)
			l_vertical_box_6.extend (ok_button)
			l_vertical_box_6.extend (l_cell_6)
			
			set_minimum_width (640)
			set_minimum_height (480)
			set_title (constants_dialog_title)
			l_vertical_box_1.set_padding_width (10)
			l_vertical_box_1.set_border_width (5)
			l_horizontal_box_1.disable_item_expand (l_vertical_box_6)
			l_frame_1.set_text ("Constants Defined")
			l_vertical_box_2.set_padding_width (1)
			l_vertical_box_2.set_border_width (2)
			l_vertical_box_2.disable_item_expand (l_horizontal_box_2)
			l_vertical_box_2.disable_item_expand (l_horizontal_separator_1)
			l_vertical_box_2.disable_item_expand (l_horizontal_box_3)
			l_vertical_box_2.disable_item_expand (l_cell_4)
			l_vertical_box_2.disable_item_expand (l_horizontal_box_7)
			display_all_types.enable_select
			display_all_types.set_text ("Show all types")
			l_horizontal_box_3.enable_homogeneous
			l_horizontal_box_3.set_padding_width (5)
			l_vertical_box_3.set_padding_width (small_padding)
			l_vertical_box_3.disable_item_expand (l_horizontal_box_4)
			l_horizontal_box_4.disable_item_expand (l_cell_1)
			l_cell_1.set_minimum_width (small_padding)
			l_label_1.set_text ("Type")
			l_label_1.align_text_left
			type_combo_box.set_text ("DIRECTORY")
			type_combo_box.set_minimum_width (80)
			type_combo_box.disable_edit
			string_item.set_text ("STRING")
			integer_item.set_text ("INTEGER")
			directory_item.enable_select
			directory_item.set_text ("DIRECTORY")
			pixmap_item.set_text ("PIXMAP")
			l_vertical_box_4.set_padding_width (small_padding)
			l_vertical_box_4.disable_item_expand (l_horizontal_box_5)
			l_horizontal_box_5.disable_item_expand (l_cell_2)
			l_cell_2.set_minimum_width (small_padding)
			l_label_2.set_text ("Name")
			l_label_2.align_text_left
			l_vertical_box_5.set_padding_width (small_padding)
			l_vertical_box_5.disable_item_expand (l_horizontal_box_6)
			l_horizontal_box_6.disable_item_expand (l_cell_3)
			l_cell_3.set_minimum_width (small_padding)
			l_label_3.set_text ("Value")
			l_label_3.align_text_left
			l_cell_4.set_minimum_height (5)
			l_horizontal_box_7.set_padding_width (5)
			l_horizontal_box_7.disable_item_expand (new_button)
			l_horizontal_box_7.disable_item_expand (modify_button)
			l_horizontal_box_7.disable_item_expand (remove_button)
			new_button.set_text (new_button_text)
			new_button.set_minimum_width (default_button_width)
			modify_button.set_text (modify_button_text)
			modify_button.set_minimum_width (default_button_width)
			remove_button.disable_sensitive
			remove_button.set_text (remove_button_text)
			remove_button.set_minimum_width (default_button_width)
			l_vertical_box_6.set_border_width (10)
			l_vertical_box_6.disable_item_expand (ok_button)
			ok_button.set_text (ok_button_text)
			ok_button.set_minimum_width (default_button_width)
			
			constants_list.select_actions.extend (agent item_selected_in_list (?))
			constants_list.deselect_actions.extend (agent item_deselected_in_list (?))
			constants_list.column_title_click_actions.extend (agent column_clicked (?))
			display_all_types.select_actions.extend (agent display_all_types_changed)
			string_item.select_actions.extend (agent string_item_selected)
			integer_item.select_actions.extend (agent integer_item_selected)
			directory_item.select_actions.extend (agent directory_item_selected)
			pixmap_item.select_actions.extend (agent pixmap_item_selected)
			name_field.change_actions.extend (agent validate_constant_name)
			new_button.select_actions.extend (agent new_button_selected)
			modify_button.select_actions.extend (agent modify_button_selected)
			remove_button.select_actions.extend (agent remove_selected_constant)
			ok_button.select_actions.extend (agent ok_pressed)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end
feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	l_vertical_box_1, l_vertical_box_2, l_vertical_box_3, l_vertical_box_4, l_vertical_box_5, 
	l_vertical_box_6: EV_VERTICAL_BOX
	l_horizontal_box_1, l_horizontal_box_2, l_horizontal_box_3, l_horizontal_box_4, 
	l_horizontal_box_5, l_horizontal_box_6, l_horizontal_box_7: EV_HORIZONTAL_BOX
	l_frame_1: EV_FRAME
	constants_list: EV_MULTI_COLUMN_LIST
	display_all_types: EV_CHECK_BUTTON
	l_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_cell_1, l_cell_2, l_cell_3, entry_selection_parent, l_cell_4, l_cell_5, l_cell_6: EV_CELL
	l_label_1, l_label_2, l_label_3: EV_LABEL
	type_combo_box: EV_COMBO_BOX
	string_item, integer_item, directory_item, pixmap_item: EV_LIST_ITEM
	name_field: EV_TEXT_FIELD
	new_button, modify_button, remove_button, ok_button: EV_BUTTON
	
	item_selected_in_list (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `select_actions' of `constants_list'.
		deferred
		end
	
	item_deselected_in_list (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Called by `deselect_actions' of `constants_list'.
		deferred
		end
	
	column_clicked (a_column: INTEGER) is
			-- Called by `column_title_click_actions' of `constants_list'.
		deferred
		end
	
	display_all_types_changed is
			-- Called by `select_actions' of `display_all_types'.
		deferred
		end
	
	string_item_selected is
			-- Called by `select_actions' of `string_item'.
		deferred
		end
	
	integer_item_selected is
			-- Called by `select_actions' of `integer_item'.
		deferred
		end
	
	directory_item_selected is
			-- Called by `select_actions' of `directory_item'.
		deferred
		end
	
	pixmap_item_selected is
			-- Called by `select_actions' of `pixmap_item'.
		deferred
		end
	
	validate_constant_name is
			-- Called by `change_actions' of `name_field'.
		deferred
		end
	
	new_button_selected is
			-- Called by `select_actions' of `new_button'.
		deferred
		end
	
	modify_button_selected is
			-- Called by `select_actions' of `modify_button'.
		deferred
		end
	
	remove_selected_constant is
			-- Called by `select_actions' of `remove_button'.
		deferred
		end
	
	ok_pressed is
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	

end -- class GB_CONSTANTS_DIALOG_IMP
