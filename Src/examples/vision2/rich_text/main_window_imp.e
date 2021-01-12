note
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects, initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	frozen initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants

			
				-- Build widget structure.
			set_menu_bar (l_ev_menu_bar_1)
			l_ev_menu_bar_1.extend (file_menu)
			file_menu.extend (open_menu_item)
			file_menu.extend (save_menu_item)
			file_menu.extend (save_as_menu_item)
			file_menu.extend (l_ev_menu_separator_1)
			file_menu.extend (print_menu_item)
			file_menu.extend (l_ev_menu_separator_2)
			file_menu.extend (exit_menu_item)
			l_ev_menu_bar_1.extend (options_menu)
			options_menu.extend (word_wrapping_menu_item)
			options_menu.extend (show_paragraph_toolbar)
			options_menu.extend (show_tab_control_menu_item)
			extend (main_vertical_box)
			main_vertical_box.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (font_selection)
			l_ev_horizontal_box_1.extend (size_selection)
			l_ev_horizontal_box_1.extend (color_toolbar)
			color_toolbar.extend (color_button)
			l_ev_horizontal_box_1.extend (background_color_toolbar)
			background_color_toolbar.extend (background_color_button)
			l_ev_horizontal_box_1.extend (format_toolbar)
			format_toolbar.extend (l_ev_tool_bar_separator_1)
			format_toolbar.extend (bold_button)
			format_toolbar.extend (italic_button)
			format_toolbar.extend (underlined_button)
			format_toolbar.extend (striked_through_button)
			format_toolbar.extend (l_ev_tool_bar_separator_2)
			format_toolbar.extend (save_button)
			format_toolbar.extend (l_ev_tool_bar_separator_3)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_2)
			l_ev_cell_2.extend (vertical_offset)
			main_vertical_box.extend (paragraph_toolbar_holder)
			paragraph_toolbar_holder.extend (l_ev_horizontal_separator_1)
			paragraph_toolbar_holder.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (paragraph_toolbar)
			paragraph_toolbar.extend (left_alignment_button)
			paragraph_toolbar.extend (center_alignment_button)
			paragraph_toolbar.extend (right_alignment_button)
			paragraph_toolbar.extend (justified_button)
			paragraph_toolbar.extend (l_ev_tool_bar_separator_4)
			l_ev_horizontal_box_2.extend (l_ev_cell_3)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (l_ev_cell_4)
			l_ev_cell_4.extend (left_margin)
			l_ev_horizontal_box_2.extend (l_ev_label_3)
			l_ev_horizontal_box_2.extend (l_ev_cell_5)
			l_ev_cell_5.extend (right_margin)
			l_ev_horizontal_box_2.extend (l_ev_label_4)
			l_ev_horizontal_box_2.extend (l_ev_cell_6)
			l_ev_cell_6.extend (top_spacing)
			l_ev_horizontal_box_2.extend (l_ev_label_5)
			l_ev_horizontal_box_2.extend (l_ev_cell_7)
			l_ev_cell_7.extend (bottom_spacing)
			l_ev_horizontal_box_2.extend (l_ev_cell_8)
			main_vertical_box.extend (tab_control_holder)
			tab_control_holder.extend (l_ev_horizontal_separator_2)
			main_vertical_box.extend (rich_text)
			main_vertical_box.extend (l_ev_cell_9)
			main_vertical_box.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (general_label)
			l_ev_horizontal_box_4.extend (save_progress)
			l_ev_horizontal_box_3.extend (l_ev_frame_2)
			l_ev_frame_2.extend (caret_position_label)

			file_menu.set_text ("File")
			open_menu_item.set_text ("Open")
			save_menu_item.set_text ("Save")
			save_as_menu_item.set_text ("Save As")
			print_menu_item.set_text ("Print")
			exit_menu_item.set_text ("Exit")
			options_menu.set_text ("Options")
			word_wrapping_menu_item.enable_select
			word_wrapping_menu_item.set_text ("Word Wrapping")
			show_paragraph_toolbar.enable_select
			show_paragraph_toolbar.set_text ("Paragraph Toolbar")
			show_tab_control_menu_item.set_text ("Tab Control Bar")
			integer_constant_set_procedures.extend (agent main_vertical_box.set_padding (?))
			integer_constant_retrieval_functions.extend (agent tiny_padding)
			main_vertical_box.disable_item_expand (l_ev_horizontal_box_1)
			main_vertical_box.disable_item_expand (paragraph_toolbar_holder)
			main_vertical_box.disable_item_expand (tab_control_holder)
			main_vertical_box.disable_item_expand (l_ev_cell_9)
			main_vertical_box.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_horizontal_box_1.disable_item_expand (font_selection)
			l_ev_horizontal_box_1.disable_item_expand (size_selection)
			l_ev_horizontal_box_1.disable_item_expand (color_toolbar)
			l_ev_horizontal_box_1.disable_item_expand (background_color_toolbar)
			l_ev_horizontal_box_1.disable_item_expand (format_toolbar)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_cell_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_cell_2)
			font_selection.set_tooltip ("Font Family Selection")
			integer_constant_set_procedures.extend (agent font_selection.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent font_selection_combo_box_width)
			size_selection.set_tooltip ("Font Size Selection in Pixels")
			integer_constant_set_procedures.extend (agent size_selection.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent font_size_combo_box_width)
			color_button.set_tooltip ("Font Color Selection")
			background_color_button.set_tooltip ("Font Background Color Selection")
			bold_button.enable_select
			bold_button.set_tooltip ("Bold")
			pixmap_constant_set_procedures.extend (agent bold_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent bold_png)
			italic_button.set_tooltip ("Italic")
			pixmap_constant_set_procedures.extend (agent italic_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent italic_png)
			underlined_button.set_tooltip ("Underlined")
			pixmap_constant_set_procedures.extend (agent underlined_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent underline_png)
			striked_through_button.set_tooltip ("Striken Through")
			pixmap_constant_set_procedures.extend (agent striked_through_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent strike_png)
			pixmap_constant_set_procedures.extend (agent save_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent icon_save_color_png)
			l_ev_label_1.set_text ("Offset")
			l_ev_label_1.set_tooltip ("Vertical Offset of Character from Baseline")
			integer_constant_set_procedures.extend (agent l_ev_cell_1.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			vertical_offset.set_tooltip ("Vertical Character Offset")
			vertical_offset.value_range.adapt (create {INTEGER_INTERVAL}.make (-25, 25))
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_2.set_padding (?))
			integer_constant_retrieval_functions.extend (agent small_padding)
			l_ev_horizontal_box_2.disable_item_expand (paragraph_toolbar)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cell_3)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cell_4)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_3)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cell_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_4)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cell_6)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_cell_7)
			left_alignment_button.set_tooltip ("Align Text Left")
			pixmap_constant_set_procedures.extend (agent left_alignment_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent left_alignment_png)
			center_alignment_button.set_tooltip ("Center Text")
			pixmap_constant_set_procedures.extend (agent center_alignment_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent center_alignment_png)
			right_alignment_button.set_tooltip ("Align Text Right")
			pixmap_constant_set_procedures.extend (agent right_alignment_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent right_alignment_png)
			justified_button.set_tooltip ("Justify Text")
			pixmap_constant_set_procedures.extend (agent justified_button.set_pixmap (?))
			pixmap_constant_retrieval_functions.extend (agent justified_png)
			l_ev_cell_3.set_minimum_width (0)
			l_ev_label_2.set_text ("Left Margin")
			left_margin.set_tooltip ("Paragraph Left Margin")
			integer_constant_set_procedures.extend (agent left_margin.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent font_size_combo_box_width)
			left_margin.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 200))
			l_ev_label_3.set_text ("Right Margin")
			right_margin.set_tooltip ("Paragraph Right Margin")
			integer_constant_set_procedures.extend (agent right_margin.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent font_size_combo_box_width)
			right_margin.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 200))
			l_ev_label_4.set_text ("Top Spacing")
			top_spacing.set_tooltip ("Paragraph Top Spacing")
			integer_constant_set_procedures.extend (agent top_spacing.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent font_size_combo_box_width)
			top_spacing.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 200))
			l_ev_label_5.set_text ("Bottom Spacing")
			bottom_spacing.set_tooltip ("Paragraph Bottom Spacing")
			integer_constant_set_procedures.extend (agent bottom_spacing.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent font_size_combo_box_width)
			bottom_spacing.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 200))
			tab_control_holder.hide
			integer_constant_set_procedures.extend (agent l_ev_cell_9.set_minimum_height (?))
			integer_constant_retrieval_functions.extend (agent tiny_padding)
			integer_constant_set_procedures.extend (agent l_ev_horizontal_box_3.set_padding (?))
			integer_constant_retrieval_functions.extend (agent tiny_padding)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_frame_2)
			l_ev_frame_1.set_style (1)
			save_progress.hide
			integer_constant_set_procedures.extend (agent l_ev_frame_2.set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent caret_position_status_bar_width)
			l_ev_frame_2.set_style (1)
			integer_constant_set_procedures.extend (agent set_minimum_width (?))
			integer_constant_retrieval_functions.extend (agent window_width)
			integer_constant_set_procedures.extend (agent set_minimum_height (?))
			integer_constant_retrieval_functions.extend (agent window_height)
			set_title ("Rich Text Example")

			set_all_attributes_using_constants
			
				-- Connect events.
			open_menu_item.select_actions.extend (agent open_file)
			save_menu_item.select_actions.extend (agent save_file)
			save_as_menu_item.select_actions.extend (agent save_file_as)
			print_menu_item.select_actions.extend (agent print_text)
			exit_menu_item.select_actions.extend (agent exit)
			word_wrapping_menu_item.select_actions.extend (agent word_wrapping_toggled)
			show_paragraph_toolbar.select_actions.extend (agent show_paragraph_toolbar_selected)
			show_tab_control_menu_item.select_actions.extend (agent show_tab_control_toggled)
			font_selection.select_actions.extend (agent font_selected)
			size_selection.select_actions.extend (agent font_size_selected)
			size_selection.return_actions.extend (agent font_size_selected)
			color_button.select_actions.extend (agent color_selected)
			background_color_button.select_actions.extend (agent background_color_selected)
			bold_button.select_actions.extend (agent bold_selected)
			italic_button.select_actions.extend (agent italic_selected)
			underlined_button.select_actions.extend (agent underline_selected)
			striked_through_button.select_actions.extend (agent strike_through_selected)
			save_button.select_actions.extend (agent save_file)
			vertical_offset.change_actions.extend (agent offset_changed (?))
			left_alignment_button.select_actions.extend (agent left_alignment_selected)
			center_alignment_button.select_actions.extend (agent center_alignment_selected)
			right_alignment_button.select_actions.extend (agent right_alignment_selected)
			justified_button.select_actions.extend (agent justified_selected)
			left_margin.change_actions.extend (agent left_margin_changed (?))
			right_margin.change_actions.extend (agent right_margin_changed (?))
			top_spacing.change_actions.extend (agent top_spacing_changed (?))
			bottom_spacing.change_actions.extend (agent bottom_spacing_changed (?))
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent destroy_and_exit_if_last)

				-- Call `user_initialization'.
			user_initialization
		end
		
	frozen create_interface_objects
			-- Create objects
		do
			
				-- Create all widgets.
			create l_ev_menu_bar_1
			create file_menu
			create open_menu_item
			create save_menu_item
			create save_as_menu_item
			create l_ev_menu_separator_1
			create print_menu_item
			create l_ev_menu_separator_2
			create exit_menu_item
			create options_menu
			create word_wrapping_menu_item
			create show_paragraph_toolbar
			create show_tab_control_menu_item
			create main_vertical_box
			create l_ev_horizontal_box_1
			create font_selection
			create size_selection
			create color_toolbar
			create color_button
			create background_color_toolbar
			create background_color_button
			create format_toolbar
			create l_ev_tool_bar_separator_1
			create bold_button
			create italic_button
			create underlined_button
			create striked_through_button
			create l_ev_tool_bar_separator_2
			create save_button
			create l_ev_tool_bar_separator_3
			create l_ev_label_1
			create l_ev_cell_1
			create l_ev_cell_2
			create vertical_offset
			create paragraph_toolbar_holder
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_2
			create paragraph_toolbar
			create left_alignment_button
			create center_alignment_button
			create right_alignment_button
			create justified_button
			create l_ev_tool_bar_separator_4
			create l_ev_cell_3
			create l_ev_label_2
			create l_ev_cell_4
			create left_margin
			create l_ev_label_3
			create l_ev_cell_5
			create right_margin
			create l_ev_label_4
			create l_ev_cell_6
			create top_spacing
			create l_ev_label_5
			create l_ev_cell_7
			create bottom_spacing
			create l_ev_cell_8
			create tab_control_holder
			create l_ev_horizontal_separator_2
			create rich_text
			create l_ev_cell_9
			create l_ev_horizontal_box_3
			create l_ev_frame_1
			create l_ev_horizontal_box_4
			create general_label
			create save_progress
			create l_ev_frame_2
			create caret_position_label

			create string_constant_set_procedures.make (10)
			create string_constant_retrieval_functions.make (10)
			create integer_constant_set_procedures.make (10)
			create integer_constant_retrieval_functions.make (10)
			create pixmap_constant_set_procedures.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create integer_interval_constant_retrieval_functions.make (10)
			create integer_interval_constant_set_procedures.make (10)
			create font_constant_set_procedures.make (10)
			create font_constant_retrieval_functions.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create color_constant_set_procedures.make (10)
			create color_constant_retrieval_functions.make (10)
			user_create_interface_objects
		end


feature -- Access

	file_menu, options_menu: EV_MENU
	open_menu_item, save_menu_item, save_as_menu_item, print_menu_item,
	exit_menu_item: EV_MENU_ITEM
	word_wrapping_menu_item, show_paragraph_toolbar, show_tab_control_menu_item: EV_CHECK_MENU_ITEM
	main_vertical_box,
	paragraph_toolbar_holder, tab_control_holder: EV_VERTICAL_BOX
	font_selection, size_selection: EV_COMBO_BOX
	color_toolbar,
	background_color_toolbar, format_toolbar, paragraph_toolbar: EV_TOOL_BAR
	color_button, background_color_button,
	save_button: EV_TOOL_BAR_BUTTON
	bold_button, italic_button, underlined_button, striked_through_button,
	left_alignment_button, center_alignment_button, right_alignment_button, justified_button: EV_TOOL_BAR_TOGGLE_BUTTON
	vertical_offset,
	left_margin, right_margin, top_spacing, bottom_spacing: EV_SPIN_BUTTON
	rich_text: EV_RICH_TEXT
	general_label,
	caret_position_label: EV_LABEL
	save_progress: EV_HORIZONTAL_PROGRESS_BAR

feature {NONE} -- Implementation

	l_ev_menu_bar_1: EV_MENU_BAR
	l_ev_menu_separator_1, l_ev_menu_separator_2: EV_MENU_SEPARATOR
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
	l_ev_tool_bar_separator_1,
	l_ev_tool_bar_separator_2, l_ev_tool_bar_separator_3, l_ev_tool_bar_separator_4: EV_TOOL_BAR_SEPARATOR
	l_ev_label_1,
	l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5: EV_LABEL
	l_ev_cell_1, l_ev_cell_2,
	l_ev_cell_3, l_ev_cell_4, l_ev_cell_5, l_ev_cell_6, l_ev_cell_7, l_ev_cell_8, l_ev_cell_9: EV_CELL
	l_ev_horizontal_separator_1,
	l_ev_horizontal_separator_2: EV_HORIZONTAL_SEPARATOR
	l_ev_frame_1, l_ev_frame_2: EV_FRAME

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

	user_create_interface_objects
			-- Feature for custom user interface object creation, called at end of `create_interface_objects'.
		deferred
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	open_file
			-- Called by `select_actions' of `open_menu_item'.
		deferred
		end
	
	save_file
			-- Called by `select_actions' of `save_menu_item'.
		deferred
		end
	
	save_file_as
			-- Called by `select_actions' of `save_as_menu_item'.
		deferred
		end
	
	print_text
			-- Called by `select_actions' of `print_menu_item'.
		deferred
		end
	
	exit
			-- Called by `select_actions' of `exit_menu_item'.
		deferred
		end
	
	word_wrapping_toggled
			-- Called by `select_actions' of `word_wrapping_menu_item'.
		deferred
		end
	
	show_paragraph_toolbar_selected
			-- Called by `select_actions' of `show_paragraph_toolbar'.
		deferred
		end
	
	show_tab_control_toggled
			-- Called by `select_actions' of `show_tab_control_menu_item'.
		deferred
		end
	
	font_selected
			-- Called by `select_actions' of `font_selection'.
		deferred
		end
	
	font_size_selected
			-- Called by `select_actions' of `size_selection'.
		deferred
		end
	
	color_selected
			-- Called by `select_actions' of `color_button'.
		deferred
		end
	
	background_color_selected
			-- Called by `select_actions' of `background_color_button'.
		deferred
		end
	
	bold_selected
			-- Called by `select_actions' of `bold_button'.
		deferred
		end
	
	italic_selected
			-- Called by `select_actions' of `italic_button'.
		deferred
		end
	
	underline_selected
			-- Called by `select_actions' of `underlined_button'.
		deferred
		end
	
	strike_through_selected
			-- Called by `select_actions' of `striked_through_button'.
		deferred
		end
	
	offset_changed (a_value: INTEGER)
			-- Called by `change_actions' of `vertical_offset'.
		deferred
		end
	
	left_alignment_selected
			-- Called by `select_actions' of `left_alignment_button'.
		deferred
		end
	
	center_alignment_selected
			-- Called by `select_actions' of `center_alignment_button'.
		deferred
		end
	
	right_alignment_selected
			-- Called by `select_actions' of `right_alignment_button'.
		deferred
		end
	
	justified_selected
			-- Called by `select_actions' of `justified_button'.
		deferred
		end
	
	left_margin_changed (a_value: INTEGER)
			-- Called by `change_actions' of `left_margin'.
		deferred
		end
	
	right_margin_changed (a_value: INTEGER)
			-- Called by `change_actions' of `right_margin'.
		deferred
		end
	
	top_spacing_changed (a_value: INTEGER)
			-- Called by `change_actions' of `top_spacing'.
		deferred
		end
	
	bottom_spacing_changed (a_value: INTEGER)
			-- Called by `change_actions' of `bottom_spacing'.
		deferred
		end
	

feature {NONE} -- Constant setting

	frozen set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING_32
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).item (Void)
				string_constant_set_procedures.item.call ([s])
				string_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_integer_constants
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).item (Void)
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				arg1 := integer_interval_constant_retrieval_functions.item.item (Void)
				integer_interval_constant_retrieval_functions.forth
				arg2 := integer_interval_constant_retrieval_functions.item.item (Void)
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).item (Void)
				pixmap_constant_set_procedures.item.call ([p])
				pixmap_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).item (Void)
				font_constant_set_procedures.item.call ([f])
				font_constant_set_procedures.forth
			end	
		end

	frozen set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).item (Void)
				color_constant_set_procedures.item.call ([c])
				color_constant_set_procedures.forth
			end
		end

	frozen set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
	
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [READABLE_STRING_GENERAL]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [STRING_32]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_PIXMAP]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER_INTERVAL]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_FONT]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_COLOR]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_COLOR]]

	frozen integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

end
