indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_OUTPUT_BOX_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	WIZARD_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local
			internal_font: EV_FONT
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create output_outter_box
			create wizard_output_upper_box
			create output_text
			create progress_bar_box
			create progress_label_box
			create progress_bar_label
			create inner_progress_label_box
			create percentage_label
			create percent_label
			create progress_bar_inner_box
			create progress_bar
			create stop_button
			create final_message_box
			create final_message_label
			create destination_path_label
			create l_ev_cell_1
			create l_ev_horizontal_separator_1
			create wizard_output_middle_box
			create output_buttons_box
			create save_button
			create left_output_padding_cell
			create open_eiffelstudio_button
			create right_output_padding_cell
			create exit_button
			
				-- Build_widget_structure.
			extend (output_outter_box)
			output_outter_box.extend (wizard_output_upper_box)
			wizard_output_upper_box.extend (output_text)
			output_outter_box.extend (progress_bar_box)
			progress_bar_box.extend (progress_label_box)
			progress_label_box.extend (progress_bar_label)
			progress_label_box.extend (inner_progress_label_box)
			inner_progress_label_box.extend (percentage_label)
			inner_progress_label_box.extend (percent_label)
			progress_bar_box.extend (progress_bar_inner_box)
			progress_bar_inner_box.extend (progress_bar)
			progress_bar_inner_box.extend (stop_button)
			output_outter_box.extend (final_message_box)
			final_message_box.extend (final_message_label)
			final_message_box.extend (destination_path_label)
			final_message_box.extend (l_ev_cell_1)
			extend (l_ev_horizontal_separator_1)
			extend (wizard_output_middle_box)
			wizard_output_middle_box.extend (output_buttons_box)
			output_buttons_box.extend (save_button)
			output_buttons_box.extend (left_output_padding_cell)
			output_buttons_box.extend (open_eiffelstudio_button)
			output_buttons_box.extend (right_output_padding_cell)
			output_buttons_box.extend (exit_button)
			
			output_outter_box.set_padding_width (10)
			output_outter_box.set_border_width (7)
			output_outter_box.disable_item_expand (progress_bar_box)
			output_outter_box.disable_item_expand (final_message_box)
			wizard_output_upper_box.set_padding_width (5)
			output_text.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (121, 252, 65))
			create internal_font
			internal_font.set_family (4)
			internal_font.set_weight (7)
			internal_font.set_shape (10)
			internal_font.set_height_in_points (8)
			internal_font.preferred_families.extend ("Lucida Console")
			output_text.set_font (internal_font)
			output_text.disable_edit
			progress_bar_box.hide
			progress_bar_box.set_padding_width (5)
			progress_bar_box.disable_item_expand (progress_bar_inner_box)
			progress_label_box.set_padding_width (7)
			progress_label_box.disable_item_expand (progress_bar_label)
			progress_bar_label.set_text ("Progress:")
			progress_bar_label.align_text_left
			inner_progress_label_box.disable_item_expand (percentage_label)
			percentage_label.align_text_left
			percent_label.set_text ("%%")
			percent_label.align_text_left
			progress_bar_inner_box.set_padding_width (7)
			progress_bar_inner_box.disable_item_expand (stop_button)
			stop_button.disable_sensitive
			stop_button.set_text ("Stop")
			stop_button.set_minimum_width (100)
			final_message_box.hide
			final_message_box.set_padding_width (5)
			final_message_box.disable_item_expand (final_message_label)
			final_message_box.disable_item_expand (destination_path_label)
			final_message_label.set_text ("Files generated in:")
			final_message_label.align_text_left
			destination_path_label.set_foreground_color (link_label)
			destination_path_label.align_text_left
			wizard_output_middle_box.set_padding_width (5)
			wizard_output_middle_box.set_border_width (7)
			wizard_output_middle_box.disable_item_expand (output_buttons_box)
			output_buttons_box.set_padding_width (7)
			output_buttons_box.disable_item_expand (save_button)
			output_buttons_box.disable_item_expand (open_eiffelstudio_button)
			output_buttons_box.disable_item_expand (exit_button)
			save_button.disable_sensitive
			save_button.set_text ("Save")
			save_button.set_minimum_width (100)
			open_eiffelstudio_button.disable_sensitive
			open_eiffelstudio_button.set_text ("Launch EiffelStudio")
			open_eiffelstudio_button.set_minimum_width (120)
			exit_button.set_text ("Exit")
			exit_button.set_minimum_width (100)
			set_padding_width (7)
			disable_item_expand (l_ev_horizontal_separator_1)
			disable_item_expand (wizard_output_middle_box)
			
				--Connect events.
			stop_button.select_actions.extend (agent on_stop)
			destination_path_label.pointer_button_press_actions.extend (agent on_link_click (?, ?, ?, ?, ?, ?, ?, ?))
			destination_path_label.pointer_enter_actions.extend (agent on_link_enter)
			destination_path_label.pointer_leave_actions.extend (agent on_link_leave)
			save_button.select_actions.extend (agent on_save)
			open_eiffelstudio_button.select_actions.extend (agent on_open_eiffelstudio)
			exit_button.select_actions.extend (agent on_exit)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	output_text: EV_RICH_TEXT
	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
	output_outter_box, wizard_output_upper_box, progress_bar_box,
	wizard_output_middle_box: EV_VERTICAL_BOX
	progress_label_box, inner_progress_label_box, progress_bar_inner_box,
	final_message_box, output_buttons_box: EV_HORIZONTAL_BOX
	progress_bar_label, percentage_label, percent_label,
	final_message_label, destination_path_label: EV_LABEL
	stop_button, save_button, open_eiffelstudio_button,
	exit_button: EV_BUTTON
	left_output_padding_cell, right_output_padding_cell: EV_CELL

feature {NONE} -- Implementation

	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_cell_1: EV_CELL

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
	
	on_stop is
			-- Called by `select_actions' of `stop_button'.
		deferred
		end
	
	on_link_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `destination_path_label'.
		deferred
		end
	
	on_link_enter is
			-- Called by `pointer_enter_actions' of `destination_path_label'.
		deferred
		end
	
	on_link_leave is
			-- Called by `pointer_leave_actions' of `destination_path_label'.
		deferred
		end
	
	on_save is
			-- Called by `select_actions' of `save_button'.
		deferred
		end
	
	on_open_eiffelstudio is
			-- Called by `select_actions' of `open_eiffelstudio_button'.
		deferred
		end
	
	on_exit is
			-- Called by `select_actions' of `exit_button'.
		deferred
		end
	

end -- class WIZARD_OUTPUT_BOX_IMP
