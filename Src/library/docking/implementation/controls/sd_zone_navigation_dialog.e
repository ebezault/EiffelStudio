﻿note
	description: "[
			Window allow user to navigate among all zones.
			The original version of this class was generated by EiffelBuild.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_ZONE_NAVIGATION_DIALOG

inherit
	SD_ZONE_NAVIGATION_DIALOG_IMP
		redefine
			show
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_is_shift_pressed: BOOLEAN; a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared
			is_shift_pressed := a_is_shift_pressed
			internal_docking_manager := a_docking_manager
			create_widgets
			create_functions

			make_with_shadow

			add_all_content_label

			key_release_actions.extend (agent on_key_release)
			key_press_actions.extend (agent on_key_press)

			disable_user_resize
			disable_border

			internal_vertical_box_top_top.set_border_width (1)
			internal_vertical_box_top_top.set_background_color (internal_shared.focused_color)

			focus_out_actions.extend (agent destroy)
		ensure
			set: is_shift_pressed = a_is_shift_pressed
			set: internal_docking_manager = a_docking_manager
		end

	create_widgets
			-- Create all widgets
		do
			create internal_vertical_box_top_top
			create internal_vertical_box_top
			create internal_label_box
			create internal_tools_box
			create internal_tools_label
			create tools_column.make
			create internal_files_box
			create internal_files_label
			create files_column.make
			create internal_info_box
			create full_title
			create description
			create detail
			create internal_info_box_border
			create scroll_area_tools
			create scroll_area_files
		end

	create_functions
			-- Create all functions
		do
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
		end

	user_initialization
			-- Called by `initialize'
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here
		local
			l_layout: EV_LAYOUT_CONSTANTS
			l_font: EV_FONT
		do
			create l_layout
			internal_vertical_box_top.set_border_width (l_layout.default_border_size)
			internal_vertical_box_top.set_padding (l_layout.default_padding_size)

			internal_info_box.set_border_width (l_layout.default_border_size)
			internal_info_box.set_padding_width (l_layout.default_padding_size)

			internal_info_box_border.set_border_width (1)
			internal_info_box_border.set_background_color (internal_shared.focused_color)

			internal_tools_box.set_border_width (l_layout.default_border_size)
			internal_tools_box.set_padding (l_layout.default_padding_size)

			internal_files_box.set_border_width (l_layout.default_border_size)
			internal_files_box.set_padding (l_layout.default_padding_size)

			scroll_area_files.hide_vertical_scroll_bar
			scroll_area_tools.hide_vertical_scroll_bar

			l_font := full_title.font
			l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			full_title.set_font (l_font)

				-- We have to do it like this, otherwise when press tab key (executing next_tabstop_widget in EV_WIDGET_IMP on Windows), there will be stack overflow
				-- The reason of the stack overflow maybe is: the `parent' of `wel_window' is not correct
			internal_files_label.enable_tabable_to
			internal_tools_label.enable_tabable_to
		end

	init_background (a_color: EV_COLOR)
			-- Set all widget's background color
		do
			internal_vertical_box_top.set_background_color (a_color)
			internal_label_box.set_background_color (a_color)
			internal_tools_box.set_background_color (a_color)
			internal_tools_label.set_background_color (a_color)
			tools_column.set_background_color (a_color)
			internal_files_box.set_background_color (a_color)
			internal_files_label.set_background_color (a_color)
			files_column.set_background_color (a_color)
			internal_info_box.set_background_color (a_color)
			full_title.set_background_color (a_color)
			description.set_background_color (a_color)
			detail.set_background_color (a_color)
		end

	add_all_content_label
			-- Add all content label to Current
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_content: SD_CONTENT
			l_label: SD_TOOL_BAR_WIDTH_BUTTON
			l_pass_first_editor, l_pass_second_editor: BOOLEAN
			l_first_label, l_last_label: detachable SD_TOOL_BAR_RADIO_BUTTON
			l_first_tool_label, l_last_tool_label: detachable SD_TOOL_BAR_RADIO_BUTTON
			l_tools_count, l_files_count: INTEGER
			l_pixel_buffer: detachable EV_PIXEL_BUFFER
		do
			l_contents := internal_docking_manager.property.contents_by_click_order
			from
				l_contents.start
				l_tools_count := 1
				l_files_count := 1
			until
				l_contents.after
			loop
				l_content := l_contents.item
				create l_label.make
				l_label.set_wrap (True)
				l_label.set_maximum_width (internal_max_item_width)
				l_label.set_data (l_content)

				l_label.select_actions.extend (agent select_label_and_destroy (l_label))
				l_pixel_buffer := l_content.pixel_buffer
				if l_pixel_buffer /= Void then
					l_label.set_pixel_buffer (l_pixel_buffer)
				end
				l_label.set_pixmap (l_content.pixmap)
				l_label.set_text (l_content.short_title)
				if l_content.type = {SD_ENUMERATION}.tool and l_content.is_visible then
					if l_tools_count > {SD_SHARED}.zone_navigation_column_count then
						l_tools_count := 1
						add_new_column (False)
					end
					tools_column.extend (l_label)
					l_tools_count := l_tools_count + 1
					if l_first_tool_label = Void then
						l_first_tool_label := l_label
					end
					l_last_tool_label := l_label
				elseif l_content.type = {SD_ENUMERATION}.editor and l_content.is_visible then
					if l_files_count > {SD_SHARED}.zone_navigation_column_count then
						l_files_count := 1
						add_new_column (True)
					end
					l_files_count := l_files_count + 1
					files_column.extend (l_label)
					if l_pass_first_editor and then not l_pass_second_editor then
						focus_label (l_label)
						l_pass_second_editor := True
					end
					if not l_pass_first_editor then
						l_first_label := l_label
						l_pass_first_editor := True
					end
					l_last_label := l_label
				else
					check only_three_type: l_content.is_visible implies l_content.type = {SD_ENUMERATION}.place_holder end
				end

				l_contents.forth
			end

			if l_first_label = Void then
					-- There is no editor label
				if l_last_tool_label /= Void and then is_shift_pressed then
					focus_label (l_last_tool_label)
				elseif l_first_tool_label /= Void then
					focus_label (l_first_tool_label)
				end
				if l_first_tool_label = Void then
						-- There is no label at all
					disable_sensitive
				end
			else
				if l_pass_first_editor and then not l_pass_second_editor then
					focus_label (l_first_label)
				elseif is_shift_pressed then
					if l_last_label /= Void then
						focus_label (l_last_label)
					end
				end
			end

			init_focued_lable := selected_label

			set_all_items_wrap

			compute_all_sizes
		end

	compute_all_sizes
			-- Let all tool bars compute them minimun sizes
		local
			l_maximum, l_temp: INTEGER
		do
			if is_sensitive then
				l_maximum := compute_all_sizes_imp (all_files_column)
				l_temp := compute_all_sizes_imp (all_tools_column)
				if l_maximum < l_temp then
					l_maximum := l_temp
				end
				set_columns_minimum_width (all_files_column, l_maximum)
				set_columns_minimum_width (all_tools_column, l_maximum)

				set_scroll_area_item_size (internal_files_box, scroll_area_files)
				set_scroll_area_item_size (internal_tools_box, scroll_area_tools)
			else
					-- There is no label to show at all

			end
		end

	set_scroll_area_item_size (a_box: EV_BOX; a_scroll_area: EV_SCROLLABLE_AREA)
			-- Set scroll area item minimum size
		require
			not_void: a_box /= Void
			not_void: a_scroll_area /= Void
		do
			if a_box.minimum_height + 15 > internal_max_height then

				a_scroll_area.set_minimum_height (internal_max_height + 15)
			else
				a_scroll_area.set_minimum_height (a_box.minimum_height + 15)
			end

			if a_box.minimum_width > internal_max_width then
				a_scroll_area.set_minimum_width (internal_max_width)
			else
				a_scroll_area.set_minimum_width (a_box.minimum_width)
			end
		end

	set_columns_minimum_width (a_columns: ARRAYED_LIST [SD_TOOL_BAR]; a_minimum_width: INTEGER_32)
			-- Set minimum width of `a_column' to `a_minimum_width'
		require
			not_void: a_columns /= Void
			valid: a_minimum_width > 0
		do
			from
				a_columns.start
			until
				a_columns.after
			loop
				a_columns.item.set_minimum_width (a_minimum_width)
				a_columns.forth
			end
		end

	compute_all_sizes_imp (a_columns: ARRAYED_LIST [SD_TOOL_BAR]): INTEGER
			-- Compute all column sizes
			-- Result is maximum size
		require
			not_void: a_columns /= Void
		local
			l_tool_bar: SD_TOOL_BAR
		do
			from
				a_columns.start
			until
				a_columns.after
			loop
				l_tool_bar := a_columns.item
				l_tool_bar.compute_minimum_size
				if Result < l_tool_bar.minimum_width then
					Result := l_tool_bar.minimum_width
				end
				a_columns.forth
			end
		end

	all_tools_column: ARRAYED_LIST [SD_TOOL_BAR]
			-- All tools columns
		do
			create Result.make (1)
			from
				internal_tools_box.start
			until
				internal_tools_box.after
			loop
				if attached {SD_TOOL_BAR} internal_tools_box.item as l_tool_bar then
					Result.extend (l_tool_bar)
				else
					check is_tool_bar: False end
				end
				internal_tools_box.forth
			end
		ensure
			not_void: Result /= Void
		end

	all_files_column: ARRAYED_LIST [SD_TOOL_BAR]
			-- All file columns
		do
			create Result.make (1)
			from
				internal_files_box.start
			until
				internal_files_box.after
			loop
				if attached {SD_TOOL_BAR} internal_files_box.item as l_tool_bar then
					Result.extend (l_tool_bar)
				else
					check is_tool_bar: False end
				end
				internal_files_box.forth
			end
		ensure
			not_void: Result /= Void
		end

	add_new_column (a_is_file: BOOLEAN)
			-- Add a new column
		do
			if a_is_file then
				create files_column.make
				internal_files_box.extend (files_column)
				internal_files_box.disable_item_expand (files_column)
			else
				create tools_column.make
				internal_tools_box.extend (tools_column)
				internal_tools_box.disable_item_expand (tools_column)
			end
		ensure
			created: a_is_file implies old files_column /= files_column
			created: (not a_is_file) implies old tools_column /= tools_column
		end

	set_all_items_wrap
			-- Set all items wrap
			-- And set items width to maximum width of all items
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_count: INTEGER
		do
				-- Tool items
			l_items := tools_column.items
			from
				l_items.start
				l_count := 1
			until
				l_items.after
			loop
				if l_count >= {SD_SHARED}.Zone_navigation_column_count then
					l_items.item.set_wrap (True)
					l_count := 1
				end
				l_count := l_count + 1
				l_items.forth
			end
		end

	maximum_item_width: INTEGER
			-- Maximum item width
		do
			internal_files_box.start
			if attached {SD_TOOL_BAR} internal_files_box.item as l_a_column then
				Result := l_a_column.width
			else
				check is_tool_bar: False end
			end
		end

feature -- Command

	show
			-- <Precursor>
		do
			Precursor {SD_ZONE_NAVIGATION_DIALOG_IMP}
			if attached init_focued_lable as l_label then
				focus_label (l_label)
			end
		end

feature {NONE} -- Agents

	on_key_release (a_key: EV_KEY)
			-- Handle key release
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_ctrl then
				if is_sensitive then
					select_label_and_destroy (selected_label)
				else
					destroy
					ev_application.do_once_on_idle (agent (internal_docking_manager.main_window).set_focus)
				end
			when {EV_KEY_CONSTANTS}.key_shift then
				is_shift_pressed := False
			else

			end
		end

	on_key_press (a_key: EV_KEY)
			-- Handle key press
		local
			l_selected_label: detachable SD_TOOL_BAR_RADIO_BUTTON
			l_next_label: detachable SD_TOOL_BAR_RADIO_BUTTON
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_tab then
				l_selected_label := selected_label
				if is_shift_pressed then
					l_next_label := find_previous_label_same_type
				else
					l_next_label := find_next_label_same_type
				end
			when {EV_KEY_CONSTANTS}.key_up then
				l_selected_label := selected_label
				l_next_label := find_previous_label
			when {EV_KEY_CONSTANTS}.key_down then
				l_selected_label := selected_label
				l_next_label := find_next_label
			when {EV_KEY_CONSTANTS}.key_left then
				l_selected_label := selected_label
				l_next_label := find_label_at_left_side
			when {EV_KEY_CONSTANTS}.key_right then
				l_selected_label := selected_label
				l_next_label := find_label_at_right_side
			when {EV_KEY_CONSTANTS}.key_shift then
				is_shift_pressed := True
			else

			end

			if l_next_label /= Void then
				focus_label (l_next_label)
				if l_selected_label /= Void and l_selected_label /= l_next_label then
					l_selected_label.disable_select
				end
			end
		end

feature {NONE} -- Implementation query

	items_count: INTEGER
			-- How many items it current dialog
		do
			Result := tools_column.items.count + files_column.items.count
		end

feature {NONE} -- Implementation command

	init_focued_lable: detachable SD_TOOL_BAR_TOGGLE_BUTTON
			-- The first focused label setted by `add_all_content_label'

	focus_label (a_label: SD_TOOL_BAR_TOGGLE_BUTTON)
			-- Enable a_label's focus color
		require
			not_void: a_label /= Void
		local
			l_selected_index: INTEGER
			l_target_x: INTEGER
			l_scroll_area: EV_SCROLLABLE_AREA
			l_left_in, l_right_in: BOOLEAN
			l_is_selected_label_in_files: BOOLEAN
			l_maximum_scroll_position: REAL
			l_all_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			from
					-- Although toggle button will disable other buttons in the same tool bar,
					-- but it can't diable buttoons in other tool bars
				l_all_items := all_items
				l_all_items.start
			until
				l_all_items.after
			loop
				if attached {SD_TOOL_BAR_TOGGLE_BUTTON} l_all_items.item as l_toggle then
					l_toggle.disable_select
				end
				l_all_items.forth
			end

			a_label.enable_select
			set_text_info (a_label)

			l_selected_index := selected_item_index
			l_is_selected_label_in_files := is_seleted_label_in_files

			l_target_x := (l_selected_index // {SD_SHARED}.zone_navigation_column_count) * maximum_item_width
			if l_is_selected_label_in_files then
				l_scroll_area := scroll_area_files
			else
				l_scroll_area := scroll_area_tools
			end

			l_left_in := l_scroll_area.x_offset <= l_target_x
			l_right_in := l_target_x + maximum_item_width <= l_scroll_area.x_offset + l_scroll_area.width
			if not (l_left_in and l_right_in) then
				l_maximum_scroll_position := l_scroll_area.item.width * (1 - (l_scroll_area.width / l_scroll_area.item.width).truncated_to_real)
				l_scroll_area.set_x_offset (l_target_x.min (l_maximum_scroll_position.rounded))
			end
		end

	set_text_info (a_item: SD_TOOL_BAR_ITEM)
			-- Set bottom texts which are informations about a content
		require
			not_void: a_item /= Void
		do
			if attached {SD_CONTENT} a_item.data as l_content then
				full_title.set_text (l_content.long_title)
				if attached l_content.description as l_description then
					description.set_text (l_description)
				else
					description.set_text (internal_shared.interface_names.Zone_navigation_no_description_available)
				end
				if attached l_content.detail as l_detail then
						-- We have to do it in idle actions, otherwise dialog minimum height will not correct
					ev_application.do_once_on_idle (agent check_before_set_text (l_detail))
				else
					detail.set_text (internal_shared.interface_names.Zone_navigation_no_detail_available)
				end
			else
				check data_is_content: False end
			end
		end

	selected_item_index: INTEGER
			-- Selected item index
		local
			l_selected: like selected_label
		do
			l_selected := selected_label
			Result := all_items_in_part (is_seleted_label_in_files).index_of (l_selected, 1)
		ensure
			valid: Result /= 0
		end

	select_label_and_destroy (a_label: SD_TOOL_BAR_ITEM)
			-- Select `a_label' and destroy Current
		require
			not_void: a_label /= Void
		do
			if a_label /= Void and then attached {SD_CONTENT} a_label.data as l_content then
					-- If we call set_focus immediately, destroy will make Current get focus
				destroy
				l_content.set_focus
			else
				check a_label_not_attached: a_label = Void end
				destroy
			end
		end

	find_label_at_right_side: SD_TOOL_BAR_RADIO_BUTTON
			-- Find label at right
		require
			has_label: all_items.count > 0
		local
			l_selected_item: like selected_label
			l_current_list, l_side_list: ARRAYED_LIST [SD_TOOL_BAR_RADIO_BUTTON]
			l_selected_index, l_result_index, l_balance: INTEGER
			l_selected_item_in_files: BOOLEAN
		do
			l_selected_item := selected_label
			l_selected_item_in_files := is_seleted_label_in_files
			l_current_list := all_items_in_part (l_selected_item_in_files)

			l_selected_index := l_current_list.index_of (l_selected_item, 1)
			l_balance := l_current_list.count \\ {SD_SHARED}.zone_navigation_column_count

			if l_selected_index <= l_current_list.count - l_balance then
					-- Not in the last column
				l_result_index := l_selected_index + {SD_SHARED}.zone_navigation_column_count
				if l_result_index > l_current_list.count then
					l_result_index := l_current_list.count
				end

				Result := l_current_list.i_th (l_result_index)
			else
					-- In the last column, we should go to other part
				l_result_index := l_selected_index \\ {SD_SHARED}.zone_navigation_column_count
				l_side_list := all_items_in_part (not l_selected_item_in_files)
				if l_side_list.count > 0 then
					if l_result_index > l_side_list.count then
						l_result_index := l_side_list.count
					end
					Result := l_side_list.i_th (l_result_index)
				else
					Result := l_current_list.i_th (l_result_index)
				end
			end
		end

	find_label_at_left_side: SD_TOOL_BAR_RADIO_BUTTON
			-- Find label which is at left side
		require
			has_label: all_items.count > 0
		local
			l_selected_item: like selected_label
			l_current_list, l_side_list: ARRAYED_LIST [SD_TOOL_BAR_RADIO_BUTTON]
			l_selected_index, l_result_index, l_balance: INTEGER
			l_selected_item_in_files: BOOLEAN
		do
			l_selected_item := selected_label
			l_selected_item_in_files := is_seleted_label_in_files
			l_current_list := all_items_in_part (l_selected_item_in_files)

			l_selected_index := l_current_list.index_of (l_selected_item, 1)

			if l_selected_index > {SD_SHARED}.zone_navigation_column_count then
					-- Not in the first column
				l_result_index := l_selected_index - {SD_SHARED}.zone_navigation_column_count
				if l_result_index > l_current_list.count then
					l_result_index := l_current_list.count
				end
				Result := l_current_list.i_th (l_result_index)
			else
					-- In the first column, we should go to other part
				l_side_list := all_items_in_part (not l_selected_item_in_files)

				if l_side_list.count > 0 then
						-- Go to the right side of the other list
					l_balance := l_side_list.count \\ {SD_SHARED}.zone_navigation_column_count
					l_result_index := l_side_list.count - {SD_SHARED}.zone_navigation_column_count + ({SD_SHARED}.zone_navigation_column_count - l_balance) + l_selected_index
					if l_result_index > l_side_list.count then
						l_result_index := l_side_list.count
					end

					Result := l_side_list.i_th (l_result_index)
				else
					l_balance := l_current_list.count \\ {SD_SHARED}.zone_navigation_column_count
					l_result_index := l_current_list.count - {SD_SHARED}.zone_navigation_column_count + ({SD_SHARED}.zone_navigation_column_count - l_balance) + l_selected_index
					if l_result_index > l_current_list.count then
						l_result_index := l_current_list.count
					end

					Result := l_current_list.i_th (l_result_index)
				end

			end
		end

	find_next_label_same_type: SD_TOOL_BAR_RADIO_BUTTON
			-- Find next label which is same type
		require
			has_label: items_count > 0
		local
			l_items: like all_items_in_part
			i: INTEGER
		do
			l_items := all_items_in_part (is_seleted_label_in_files)
			i := l_items.index_of (selected_label, l_items.lower)
			check has_selected_label: i /= 0 end
			if i = l_items.upper then
					-- l_items is not empty , see precondition `has_label'
				Result := l_items.first
			else
				check valid_index: l_items.valid_index (i) end
				Result := l_items.i_th (i + 1)
			end
		ensure
			not_void: Result /= Void
		end

	find_previous_label_same_type: SD_TOOL_BAR_RADIO_BUTTON
			-- Find previous label which is same type
		require
			has_label: items_count > 0
		local
			l_items: like all_items_in_part
			i: INTEGER
		do
			l_items := all_items_in_part (is_seleted_label_in_files)
			i := l_items.index_of (selected_label, l_items.lower)
			check has_selected_label: i /= 0 end
			if i = l_items.lower then
					-- l_items is not empty , see precondition `has_label'
				Result := l_items.last
			else
				check valid_index: l_items.valid_index (i) end
				Result := l_items.i_th (i - 1)
			end
		ensure
			not_void: Result /= Void
		end

	find_previous_label: SD_TOOL_BAR_RADIO_BUTTON
			-- Find previous label
		require
			has_label: items_count > 0
		local
			l_items,
			l_list: like all_items_in_part
			i: INTEGER
		do
			l_items := all_items_in_part (is_seleted_label_in_files)
			i := l_items.index_of (selected_label, l_items.lower)
			check has_selected_label: i /= 0 end
			if i = l_items.lower then
				l_list := all_items_in_part (not is_seleted_label_in_files)
				if not l_list.is_empty then
					Result := l_list.last
				else
					Result := l_items.last
				end
			else
				check valid_index: l_items.valid_index (i) end
				Result := l_items.i_th (i - 1)
			end
		ensure
			not_void: Result /= Void
		end

	find_next_label: SD_TOOL_BAR_RADIO_BUTTON
			-- Find next label
		require
			has_label: items_count > 0
		local
			l_items,
			l_list: like all_items_in_part
			i: INTEGER
		do
			l_items := all_items_in_part (is_seleted_label_in_files)
			i := l_items.index_of (selected_label, l_items.lower)
			check has_selected_label: i /= 0 end
			if i = l_items.upper then
				l_list := all_items_in_part (not is_seleted_label_in_files)
				if not l_list.is_empty then
					Result := l_list.first
				else
					Result := l_items.first
				end
			else
				check valid_index: l_items.valid_index (i) end
				Result := l_items.i_th (i + 1)
			end
		ensure
			not_void: Result /= Void
		end

	all_items: ARRAYED_LIST [SD_TOOL_BAR_RADIO_BUTTON]
			-- All items
			-- Items order is from top -> bottom, left -> right
		do
			create Result.make (30)
			Result.append (all_items_in_part (False))
			Result.append (all_items_in_part (True))
		end

	all_items_in_part (a_is_file: BOOLEAN): ARRAYED_LIST [SD_TOOL_BAR_RADIO_BUTTON]
			-- All file items if `a_is_file'
			-- Item order is from top -> bottom, left -> right
		local
			l_columns: ARRAYED_LIST [SD_TOOL_BAR]
		do
			if a_is_file then
				l_columns := all_files_column
			else
				l_columns := all_tools_column
			end

			from
				l_columns.start
				create Result.make (30)
			until
				l_columns.after
			loop
				across
					l_columns.item.items as c
				loop
					if attached {SD_TOOL_BAR_RADIO_BUTTON} c as but then
						Result.extend (but)
					else
						check only_sd_tool_bar_radio_button: False end
					end
				end
				l_columns.forth
			end
		ensure
			not_void: Result /= Void
		end

	selected_label: SD_TOOL_BAR_RADIO_BUTTON
			-- Current selected label
		require
			has_label: is_sensitive
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_all_columns: ARRAYED_LIST [SD_TOOL_BAR]
			l_result: detachable like selected_label
		do
			from
				l_all_columns := all_files_column
				l_all_columns.start
			until
				l_all_columns.after or l_result /= Void
			loop
				from
					l_items := l_all_columns.item.items
					l_items.start
				until
					l_items.after or l_result /= Void
				loop
					if attached {like selected_label} l_items.item as l_item then
						if l_item.is_selected then
							l_result := l_item
							is_seleted_label_in_files := True
						end
					else
						check is_radio_button: False end
					end
					l_items.forth
				end
				l_all_columns.forth
			end

			if l_result = Void then
				from
					l_all_columns := all_tools_column
					l_all_columns.start
				until
					l_all_columns.after or l_result /= Void
				loop
					from
						l_items := l_all_columns.item.items
						l_items.start
					until
						l_items.after or l_result /= Void
					loop
						if attached {like selected_label} l_items.item as l_item then
							if l_item.is_selected then
								l_result := l_item
								is_seleted_label_in_files := False
							end
						else
							check is_radio_button: False end
						end
						l_items.forth
					end
					l_all_columns.forth
				end
			end

			check l_result /= Void then
					-- Implied by there must be a selected label in all lists
				Result := l_result
			end
		ensure
			not_void: Result /= Void
		end

	check_before_set_text (a_tip: READABLE_STRING_GENERAL)
			-- call `set_text' if possible
		do
			if not is_destroyed then
				set_text (a_tip)
			end
		end

	is_seleted_label_in_files: BOOLEAN
			-- If selected label in files group?
			-- Oterwise it's in tools group

	is_shift_pressed: BOOLEAN
			-- If shift key pressed?

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to

	internal_max_width: INTEGER = 400
			-- Max width

	internal_max_height: INTEGER = 300
			-- Max height

	internal_max_item_width: INTEGER = 161
			-- Max width of a tool bar item which represent a SD_CONTENT

feature {NONE} -- Copied from Eiffel Build project GB_TIP_OF_THE_DAY_DIALOG

	set_text (tip: READABLE_STRING_GENERAL)
			-- Display `tip' as a wrapped text within `detail'
			-- Replace all '%N' characters as spaces
		local
			l_counter: INTEGER
			l_font: EV_FONT
			l_current_width: INTEGER
			l_last_string: detachable STRING_32
			l_temp_string: detachable STRING_32
			l_modified_tip: STRING_32
			l_lines: ARRAYED_LIST [STRING_32]
			l_start_pos: INTEGER
			l_output: STRING_32
			l_maximum_string_width: INTEGER
			l_all_space_indexes: ARRAYED_LIST [INTEGER]
		do
			create l_all_space_indexes.make (20)
			create l_lines.make (4)
			l_font := detail.font
			create l_modified_tip.make_from_string_general (tip)
			l_modified_tip.replace_substring_all ("%N", " ")
			l_modified_tip.append_character (' ')
			l_maximum_string_width := width - 25

				-- Set up all space indexes which stores the index of each space in the
				-- text, as these are the wrapping criterion
				-- Note that if a word is contained that is longer than the width of the label,
				-- this will probable lead to problems. No attempt to prevent this is made in the code
			from
				l_counter := 1
			until
				l_counter > l_modified_tip.count
			loop
				if l_modified_tip.item (l_counter) = Operating_environment.directory_separator then
					l_all_space_indexes.extend (l_counter)
				end
				l_counter := l_counter + 1
			end

				-- Perform calculations to determine where wrapping must occur
			from
				l_start_pos := 1
				l_counter := 1
			until
				l_counter > l_all_space_indexes.count or l_counter < 1
			loop
				from
					l_current_width := 0
				until
					l_current_width > l_maximum_string_width or
					l_counter > l_all_space_indexes.count or l_counter < 1
				loop

					l_temp_string := l_modified_tip.substring (l_start_pos, l_all_space_indexes.i_th (l_counter) - 1)
					l_current_width := l_font.string_width (l_temp_string)
					if l_current_width <= l_maximum_string_width then
						l_last_string := l_temp_string
						l_counter := l_counter + 1
					else
						l_counter := l_counter - 1
					end
				end
				if l_all_space_indexes.valid_index (l_counter) then
					l_start_pos := l_all_space_indexes.i_th (l_counter) + 1
				end
				if l_lines.count = 0 and l_last_string = Void and l_counter = 0 then
						-- Only one line which can't be wrapped
					if l_temp_string /= Void then
						l_lines.extend (l_temp_string)
					end
				else
					if l_last_string /= Void then
						l_lines.extend (l_last_string)
					end
				end
			end

				-- Now create and set the text on the label
			l_output := ""
			from
				l_lines.start
			until
				l_lines.off
			loop
				l_output.append (l_lines.item)
				if l_lines.index < l_lines.count then
					l_output.append_character (Operating_environment.directory_separator)
					l_output.append_character ('%N')
				end
				l_lines.forth
			end

			detail.set_text (l_output)
		end

invariant
	internal_docking_manager_not_void: internal_docking_manager /= Void
	all_files_column_are_tool_bar_button: ∀ f: all_files_column ¦ ∀ i: f.items ¦ attached {SD_TOOL_BAR_BUTTON} i
	all_tools_column_are_tool_bar_button: ∀ t: all_tools_column ¦ ∀ i: t.items ¦ attached {SD_TOOL_BAR_BUTTON} i

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
