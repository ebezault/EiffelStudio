indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TOC_DIALOG_IMP

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
			
				-- Create all widgets.
			create button_frame
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create l_ev_vertical_box_2
			create l_ev_vertical_box_3
			create l_ev_label_1
			create l_ev_horizontal_box_2
			create l_ev_label_2
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_3
			create l_ev_label_3
			create description_text
			create l_ev_horizontal_box_4
			create l_ev_label_4
			create index_filename_text
			create l_ev_horizontal_box_5
			create l_ev_label_5
			create l_ev_horizontal_separator_2
			create l_ev_horizontal_box_6
			create index_root_check
			create l_ev_horizontal_box_7
			create include_empty_dirs_check
			create l_ev_horizontal_box_8
			create include_no_index_check
			create l_ev_horizontal_box_9
			create include_skipped_sub_dirs_check
			create l_ev_horizontal_box_10
			create order_alphabetical_check
			create l_ev_horizontal_box_11
			create l_ev_label_6
			create filter_combo
			create l_ev_horizontal_box_12
			create l_ev_cell_1
			create l_ev_horizontal_box_13
			create l_ev_cell_2
			create okay_button
			create cancel_button
			
				-- Build_widget_structure.
			extend (button_frame)
			button_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_label_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_3)
			l_ev_horizontal_box_3.extend (description_text)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_4)
			l_ev_horizontal_box_4.extend (index_filename_text)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_5)
			l_ev_horizontal_box_5.extend (l_ev_horizontal_separator_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (index_root_check)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (include_empty_dirs_check)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (include_no_index_check)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_9)
			l_ev_horizontal_box_9.extend (include_skipped_sub_dirs_check)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_10)
			l_ev_horizontal_box_10.extend (order_alphabetical_check)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_11)
			l_ev_horizontal_box_11.extend (l_ev_label_6)
			l_ev_horizontal_box_11.extend (filter_combo)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_12)
			l_ev_vertical_box_1.extend (l_ev_cell_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_13)
			l_ev_horizontal_box_13.extend (l_ev_cell_2)
			l_ev_horizontal_box_13.extend (okay_button)
			l_ev_horizontal_box_13.extend (cancel_button)
			
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_13)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_vertical_box_2)
			l_ev_vertical_box_2.set_padding_width (5)
			l_ev_vertical_box_2.set_border_width (2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_8)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_9)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_10)
			l_ev_vertical_box_3.set_padding_width (5)
			l_ev_vertical_box_3.set_border_width (inner_border_width)
			l_ev_vertical_box_3.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("To sort the currently loaded Table of Contents simply choose from the%Noptions listed below and click 'Sort'.  A new TOC will be generated%Nbased upon the options specified.")
			l_ev_label_1.align_text_left
			l_ev_horizontal_box_2.set_padding_width (5)
			l_ev_horizontal_box_2.set_border_width (2)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("General")
			l_ev_label_2.align_text_left
			l_ev_horizontal_box_3.set_padding_width (5)
			l_ev_horizontal_box_3.set_border_width (inner_border_width)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Textual Description")
			l_ev_label_3.align_text_left
			l_ev_horizontal_box_4.set_padding_width (5)
			l_ev_horizontal_box_4.set_border_width (5)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Index filename")
			l_ev_label_4.align_text_left
			index_filename_text.set_text ("index.xml")
			l_ev_horizontal_box_5.set_padding_width (5)
			l_ev_horizontal_box_5.set_border_width (2)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_5)
			l_ev_label_5.set_text ("Sorting")
			l_ev_label_5.align_text_left
			l_ev_horizontal_box_6.set_padding_width (5)
			l_ev_horizontal_box_6.set_border_width (inner_border_width)
			index_root_check.enable_select
			index_root_check.set_text ("Automatically make root nodes from index files")
			l_ev_horizontal_box_7.set_padding_width (5)
			l_ev_horizontal_box_7.set_border_width (inner_border_width)
			include_empty_dirs_check.set_text ("Include empty directories")
			l_ev_horizontal_box_8.set_padding_width (5)
			l_ev_horizontal_box_8.set_border_width (inner_border_width)
			include_no_index_check.set_text ("Include directories without index file")
			l_ev_horizontal_box_9.set_padding_width (5)
			l_ev_horizontal_box_9.set_border_width (inner_border_width)
			include_skipped_sub_dirs_check.enable_select
			include_skipped_sub_dirs_check.set_text ("Include sub directories of skipped directories")
			l_ev_horizontal_box_10.set_padding_width (5)
			l_ev_horizontal_box_10.set_border_width (inner_border_width)
			order_alphabetical_check.enable_select
			order_alphabetical_check.set_text ("Order alphabetically")
			l_ev_horizontal_box_11.set_padding_width (5)
			l_ev_horizontal_box_11.set_border_width (inner_border_width)
			l_ev_horizontal_box_11.disable_item_expand (l_ev_label_6)
			l_ev_label_6.set_text ("Sort for ")
			l_ev_label_6.align_text_left
			filter_combo.disable_edit
			l_ev_horizontal_box_13.set_padding_width (5)
			l_ev_horizontal_box_13.set_border_width (2)
			l_ev_horizontal_box_13.disable_item_expand (okay_button)
			l_ev_horizontal_box_13.disable_item_expand (cancel_button)
			okay_button.set_text ("Sort")
			okay_button.set_minimum_width (80)
			cancel_button.set_text ("Cancel")
			cancel_button.set_minimum_width (80)
			set_maximum_width (dialog_wide_width)
			set_maximum_height (dialog_tall_height)
			set_title ("Table of Contents Sorter")
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	index_root_check, include_empty_dirs_check, include_no_index_check, include_skipped_sub_dirs_check,
	order_alphabetical_check: EV_CHECK_BUTTON
	l_ev_horizontal_separator_1, l_ev_horizontal_separator_2: EV_HORIZONTAL_SEPARATOR
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2,
	l_ev_horizontal_box_3, l_ev_horizontal_box_4, l_ev_horizontal_box_5, l_ev_horizontal_box_6,
	l_ev_horizontal_box_7, l_ev_horizontal_box_8, l_ev_horizontal_box_9, l_ev_horizontal_box_10,
	l_ev_horizontal_box_11, l_ev_horizontal_box_12, l_ev_horizontal_box_13: EV_HORIZONTAL_BOX
	l_ev_label_1,
	l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5, l_ev_label_6: EV_LABEL
	okay_button,
	cancel_button: EV_BUTTON
	button_frame: EV_FRAME
	l_ev_cell_1, l_ev_cell_2: EV_CELL
	filter_combo: EV_COMBO_BOX
	description_text,
	index_filename_text: EV_TEXT_FIELD

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
	
end -- class TOC_DIALOG_IMP
