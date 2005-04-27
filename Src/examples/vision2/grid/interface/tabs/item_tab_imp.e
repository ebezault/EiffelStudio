indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ITEM_TAB_IMP

inherit
	EV_VERTICAL_BOX
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

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create item_finder
			create item_frame
			create main_box
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create item_x_index
			create l_ev_label_2
			create item_y_index
			create l_ev_table_1
			create textable_container
			create l_ev_label_3
			create textable_entry
			create is_selected
			create pixmapable_container
			create l_ev_label_4
			create pixmap_holder
			create left_border_container
			create l_ev_label_5
			create left_border_spin_button
			create spacing_container
			create l_ev_label_6
			create spacing_spin_button
			create alignment_container
			create l_ev_label_7
			create alignment_combo
			create left_alignment_item
			create center_alignment_item
			create right_alignment_item
			create apply_pixmap_row_button
			create apply_pixmap_column_button
			create apply_alignment_row_button
			create apply_alignment_column_button
			create apply_left_border_row_button
			create apply_left_border_column_button
			create apply_spacing_row_button
			create apply_spacing_column_button
			create item_operations_frame
			create l_ev_vertical_box_1
			create remove_item_button
			
				-- Build_widget_structure.
			extend (item_finder)
			extend (item_frame)
			item_frame.extend (main_box)
			main_box.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (item_x_index)
			l_ev_horizontal_box_1.extend (l_ev_label_2)
			l_ev_horizontal_box_1.extend (item_y_index)
			main_box.extend (l_ev_table_1)
			textable_container.extend (l_ev_label_3)
			textable_container.extend (textable_entry)
			pixmapable_container.extend (l_ev_label_4)
			pixmapable_container.extend (pixmap_holder)
			left_border_container.extend (l_ev_label_5)
			left_border_container.extend (left_border_spin_button)
			spacing_container.extend (l_ev_label_6)
			spacing_container.extend (spacing_spin_button)
			alignment_container.extend (l_ev_label_7)
			alignment_container.extend (alignment_combo)
			alignment_combo.extend (left_alignment_item)
			alignment_combo.extend (center_alignment_item)
			alignment_combo.extend (right_alignment_item)
			extend (item_operations_frame)
			item_operations_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (remove_item_button)
			
			item_frame.disable_sensitive
			item_frame.set_text ("Item Properties")
			main_box.set_padding_width (box_padding)
			main_box.set_border_width (box_padding)
			main_box.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.set_padding_width (box_padding)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_2)
			l_ev_label_1.set_text ("X Index")
			l_ev_label_1.align_text_left
			item_x_index.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			l_ev_label_2.set_text ("Y Index")
			item_y_index.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			l_ev_table_1.resize (3, 7)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
			l_ev_table_1.set_border_width (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (textable_container, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (is_selected, 1, 6, 1, 1)
			l_ev_table_1.put_at_position (pixmapable_container, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (left_border_container, 1, 4, 1, 1)
			l_ev_table_1.put_at_position (spacing_container, 1, 5, 1, 1)
			l_ev_table_1.put_at_position (alignment_container, 1, 3, 1, 1)
			l_ev_table_1.put_at_position (apply_pixmap_row_button, 2, 2, 1, 1)
			l_ev_table_1.put_at_position (apply_pixmap_column_button, 3, 2, 1, 1)
			l_ev_table_1.put_at_position (apply_alignment_row_button, 2, 3, 1, 1)
			l_ev_table_1.put_at_position (apply_alignment_column_button, 3, 3, 1, 1)
			l_ev_table_1.put_at_position (apply_left_border_row_button, 2, 4, 1, 1)
			l_ev_table_1.put_at_position (apply_left_border_column_button, 3, 4, 1, 1)
			l_ev_table_1.put_at_position (apply_spacing_row_button, 2, 5, 1, 1)
			l_ev_table_1.put_at_position (apply_spacing_column_button, 3, 5, 1, 1)
			textable_container.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Text : ")
			textable_entry.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			is_selected.set_text ("is_selected")
			pixmapable_container.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Pixmap : ")
			left_border_container.disable_item_expand (l_ev_label_5)
			l_ev_label_5.set_text ("Left Border : ")
			spacing_container.disable_item_expand (l_ev_label_6)
			l_ev_label_6.set_text ("Spacing : ")
			alignment_container.disable_item_expand (l_ev_label_7)
			l_ev_label_7.set_text ("Alignment : ")
			l_ev_label_7.align_text_left
			alignment_combo.set_text ("Left")
			left_alignment_item.set_text ("Left")
			center_alignment_item.set_text ("Center")
			right_alignment_item.set_text ("Right")
			apply_pixmap_row_button.set_text ("Apply Row")
			apply_pixmap_column_button.set_text ("Apply Column")
			apply_alignment_row_button.set_text ("Apply Row")
			apply_alignment_column_button.set_text ("Apply Column")
			apply_left_border_row_button.set_text ("Apply Row")
			apply_left_border_column_button.set_text ("Apply Column")
			apply_spacing_row_button.set_text ("Apply Row")
			apply_spacing_column_button.set_text ("Apply Column")
			item_operations_frame.disable_sensitive
			item_operations_frame.set_text ("Item Operations")
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (remove_item_button)
			remove_item_button.set_text ("Remove Item")
			set_border_width (box_padding)
			disable_item_expand (item_finder)
			disable_item_expand (item_frame)
			disable_item_expand (item_operations_frame)
			
				--Connect events.
			item_x_index.change_actions.extend (agent item_x_index_changed (?))
			item_y_index.change_actions.extend (agent item_y_index_changed (?))
			textable_entry.change_actions.extend (agent textable_entry_changed)
			is_selected.select_actions.extend (agent is_selected_selected)
			pixmap_holder.select_actions.extend (agent pixmap_holder_item_selected)
			left_border_spin_button.change_actions.extend (agent left_border_spin_button_changed (?))
			spacing_spin_button.change_actions.extend (agent spacing_spin_button_changed (?))
			left_alignment_item.select_actions.extend (agent left_alignment_item_selected)
			center_alignment_item.select_actions.extend (agent center_alignment_item_selected)
			right_alignment_item.select_actions.extend (agent right_alignment_item_selected)
			apply_pixmap_row_button.select_actions.extend (agent apply_pixmap_row_button_selected)
			apply_pixmap_column_button.select_actions.extend (agent apply_pixmap_column_selected)
			apply_alignment_row_button.select_actions.extend (agent apply_alignment_row_button_selected)
			apply_alignment_column_button.select_actions.extend (agent apply_alignment_column_button_selected)
			apply_left_border_row_button.select_actions.extend (agent apply_left_border_row_button_selected)
			apply_left_border_column_button.select_actions.extend (agent apply_left_border_column_button_selected)
			apply_spacing_row_button.select_actions.extend (agent apply_spacing_row_button_selected)
			apply_spacing_column_button.select_actions.extend (agent apply_spacing_column_button_selected)
			remove_item_button.select_actions.extend (agent remove_item_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	main_box: EV_VERTICAL_BOX
	is_selected: EV_CHECK_BUTTON
	item_x_index, item_y_index, left_border_spin_button, spacing_spin_button: EV_SPIN_BUTTON
	item_finder: GRID_ITEM_FINDER
	textable_container,
	pixmapable_container, left_border_container, spacing_container, alignment_container: EV_HORIZONTAL_BOX
	apply_pixmap_row_button,
	apply_pixmap_column_button, apply_alignment_row_button, apply_alignment_column_button,
	apply_left_border_row_button, apply_left_border_column_button, apply_spacing_row_button,
	apply_spacing_column_button, remove_item_button: EV_BUTTON
	item_frame, item_operations_frame: EV_FRAME
	pixmap_holder,
	alignment_combo: EV_COMBO_BOX
	textable_entry: EV_TEXT_FIELD
	left_alignment_item, center_alignment_item, right_alignment_item: EV_LIST_ITEM

feature {NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3,
	l_ev_label_4, l_ev_label_5, l_ev_label_6, l_ev_label_7: EV_LABEL
	l_ev_table_1: EV_TABLE

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
	
	item_x_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_x_index'.
		deferred
		end
	
	item_y_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_y_index'.
		deferred
		end
	
	textable_entry_changed is
			-- Called by `change_actions' of `textable_entry'.
		deferred
		end
	
	is_selected_selected is
			-- Called by `select_actions' of `is_selected'.
		deferred
		end
	
	pixmap_holder_item_selected is
			-- Called by `select_actions' of `pixmap_holder'.
		deferred
		end
	
	left_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `left_border_spin_button'.
		deferred
		end
	
	spacing_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `spacing_spin_button'.
		deferred
		end
	
	left_alignment_item_selected is
			-- Called by `select_actions' of `left_alignment_item'.
		deferred
		end
	
	center_alignment_item_selected is
			-- Called by `select_actions' of `center_alignment_item'.
		deferred
		end
	
	right_alignment_item_selected is
			-- Called by `select_actions' of `right_alignment_item'.
		deferred
		end
	
	apply_pixmap_row_button_selected is
			-- Called by `select_actions' of `apply_pixmap_row_button'.
		deferred
		end
	
	apply_pixmap_column_selected is
			-- Called by `select_actions' of `apply_pixmap_column_button'.
		deferred
		end
	
	apply_alignment_row_button_selected is
			-- Called by `select_actions' of `apply_alignment_row_button'.
		deferred
		end
	
	apply_alignment_column_button_selected is
			-- Called by `select_actions' of `apply_alignment_column_button'.
		deferred
		end
	
	apply_left_border_row_button_selected is
			-- Called by `select_actions' of `apply_left_border_row_button'.
		deferred
		end
	
	apply_left_border_column_button_selected is
			-- Called by `select_actions' of `apply_left_border_column_button'.
		deferred
		end
	
	apply_spacing_row_button_selected is
			-- Called by `select_actions' of `apply_spacing_row_button'.
		deferred
		end
	
	apply_spacing_column_button_selected is
			-- Called by `select_actions' of `apply_spacing_column_button'.
		deferred
		end
	
	remove_item_button_selected is
			-- Called by `select_actions' of `remove_item_button'.
		deferred
		end
	

end -- class ITEM_TAB_IMP
