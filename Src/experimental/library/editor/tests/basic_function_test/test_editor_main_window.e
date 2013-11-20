note
	description: "Main window for this application"
	author: "Generated by the New Vision2 Application Wizard."
	date: "$Date$"
	revision: "1.0.0"

class
	TEST_EDITOR_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

	TEST_EDITOR_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_EDITOR_DATA
		export
			{NONE} all
		undefine
			default_create, copy
		end

	TEXT_OBSERVER
		export
			{NONE} all
		undefine
			default_create, copy
		redefine
			on_text_fully_loaded
		end

	SYSTEM_ENCODINGS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	initialize
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

			build_main_container
			extend (main_container)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window
			set_title (Window_title)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)
		end

	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end


feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)

	build_standard_menu_bar
			-- Create and populate `standard_menu_bar'.
		require
			menu_bar_not_yet_created: standard_menu_bar = Void
		do
				-- Create the menu bar.
			create standard_menu_bar

				-- Add the "File" menu
			build_file_menu
			standard_menu_bar.extend (file_menu)

				-- Add the "Help" menu
			build_help_menu
			standard_menu_bar.extend (help_menu)
		ensure
			menu_bar_created:
				standard_menu_bar /= Void and then
				not standard_menu_bar.is_empty
		end

	build_file_menu
			-- Create and populate `file_menu'.
		require
			file_menu_not_yet_created: file_menu = Void
		local
			menu_item: EV_MENU_ITEM
		do
			create file_menu.make_with_text (Menu_file_item)

			create menu_item.make_with_text (Menu_file_open_item)
			menu_item.select_actions.extend (agent on_file_open)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_save_item)
			menu_item.select_actions.extend (agent on_file_save)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_saveas_item)
			menu_item.select_actions.extend (agent on_file_save_as)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_close_item)
			menu_item.select_actions.extend (agent on_file_close)
			file_menu.extend (menu_item)

			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Create the File/Exit menu item and make it call
				-- `request_close_window' when it is selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_close_window)
			file_menu.extend (menu_item)
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

	build_help_menu
			-- Create and populate `help_menu'.
		require
			help_menu_not_yet_created: help_menu = Void
		local
			menu_item: EV_MENU_ITEM
		do
			create help_menu.make_with_text (Menu_help_item)

			create menu_item.make_with_text (Menu_help_contents_item)
				--| TODO: Add the action associated with "Contents and Index" here.
			help_menu.extend (menu_item)
		ensure
			help_menu_created: help_menu /= Void and then not help_menu.is_empty
		end

feature {NONE} -- File operation

	on_file_open
		do

		end

	on_file_save
		do

		end

	on_file_save_as
		do

		end

	on_file_close
		do

		end

feature -- Text Observer

	on_text_fully_loaded
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
--			loaded_count := loaded_count + 1
--			if loaded_count < times_to_load then
--				load_text
--			end
			if text_loaded = 1 then
				test_complicated
				load_text2
			elseif text_loaded = 2 then
				test_item
			end
			if text_loaded = 2 then
				(create {EV_ENVIRONMENT}).application.destroy
			end
		end

	loaded_count: INTEGER

	times_to_load: INTEGER = 100
			-- The original number to reproduce a problem was `10000' which is better for stress testing.

feature {NONE} -- Implementation, Close event

	request_close_window
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
					--| TODO: Remove this line if you don't want the application
					--|       to end when the first window is closed..
				(create {EV_ENVIRONMENT}).application.destroy
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	build_main_container
			-- Create and populate `main_container'.
		require
			main_container_not_yet_created: main_container = Void
		do
			create main_container
			editor_preferences_cell.put (editor_data)
			create editor
			main_container.extend (editor.widget)
			editor_data.show_line_numbers_preference.set_value (True)
			editor.enable_line_numbers
			editor.add_edition_observer (Current)

			editor.set_encoding (utf8)

			load_text1
		ensure
			main_container_created: main_container /= Void
		end

	load_text1
		do
			text_loaded := 1
			editor.load_text (text1)
		end

	load_text2
		do
			text_loaded := 2
			editor.load_text (text2)
		end

	text_loaded: INTEGER
			-- Which text was loaded.

	text1: STRING =
	"[
　　刘翔排在第五道，在阿诺德和雷恩-威尔逊中间，大史为第一道，
阿兰-约翰逊则在第四道，而战胜过刘翔的摩尔在第二道。在大会介
绍到阿兰时，全场掌声雷动，阿兰看上去很享受这样的场景，不过相
比之下，刘翔得到的欢呼声更猛烈，刘翔对着观众挥手示意，脸上露
出浅浅笑意。

　　枪响之后，八人如离弦之箭般冲出赛道，刘翔起跑状况不错，不
过阿兰-约翰逊看起来初始状态更猛，在杀到第一栏时，阿兰稍稍领
先，在前三栏，阿兰保持着这种微弱的优势，而刘翔和其他选手之间
的优势距离也不明显。

　　在杀过三栏后，刘翔后程威力开始爆发，他逐渐加速开始超越，
到第六栏时已经变成稍微领先了阿兰，随后的攻栏，刘翔依旧保持了
最强劲速度，逐渐拉开了和其他7人之间的距离！而此时阿兰越跑越
慢，先是曾经战胜过刘翔的摩尔，随后是梅里特、佩恩，悉数超过了
阿兰。

　　摩尔虽然风头强劲，但在今天的比赛中，他丝毫动摇不了刘翔
的领先地位。而阿诺德也显得后程乏力，在今天的比赛中，阿诺德
过最后一栏时也有磕绊，影响了自己的成绩，而在观众的呐喊声中，
无人匹敌的刘翔呼啸着杀过了终点！

　　三连冠的刘翔很是兴奋，他先把鲜花丢给狂热的观众，对着蜂拥
上来的记者，刘翔有节奏的用手指指胸口、自己在拼命鼓掌，再竖起
食指表示自己是冠军，最后他高兴地张开双臂，让记者们疯狂抢拍，
在这个夜晚，刘翔，是当之无愧的胜利者！
	]"

	text2: STRING =
	"[
EiffelStudio 5.7 provided Post 
fact that they provide no way 
directory containing the built
My specific need at the moment

	]"

feature {NONE} -- Implementation / Constants

	editor: EDITABLE_TEXT_PANEL

	editor_data: EDITOR_DATA
			--
		local
			l_preferences: PREFERENCES
		once
			create l_preferences.make
			create Result.make (l_preferences)
		end

	Window_title: STRING = "unicode_editor"
			-- Title of the window.

	Window_width: INTEGER = 500
			-- Initial width for this window.

	Window_height: INTEGER = 700
			-- Initial height for this window.

feature {NONE} -- Test item

	num_op: INTEGER = 100

	test_complicated
			--
		local
			i: INTEGER
			i_cnt: INTEGER
		do
			from
				i := 0
				i_cnt := num_op
			until
				i = num_op
			loop
				editor.text_displayed.cursor.go_to_position (100)
				editor.text_displayed.insert_string ("astr")
				editor.text_displayed.insert_eol
				editor.text_displayed.cursor.go_to_position (100)
				editor.text_displayed.delete_char
				editor.text_displayed.select_region (200, 204)
				editor.text_displayed.indent_selection
				editor.text_displayed.forget_selection
				editor.text_displayed.back_delete_char
				editor.text_displayed.select_region (300, 304)
				editor.text_displayed.move_selection_to_pos (30)
				editor.text_displayed.select_region (200, 204)
				editor.text_displayed.delete_selection
				editor.text_displayed.insert_char ('x')
				editor.text_displayed.select_region (100, 103)
				editor.text_displayed.replace_selection ("")
				if i \\ 3 = 0 then
					editor.undo
				end
				i := i + 1
			end
			from
				i := 0
				i_cnt := num_op * 8
			until
				i = i_cnt
			loop
				if editor.undo_is_possible then
					editor.undo
				end
				i := i + 1
			end
		end


	test_item
			-- This is a simplist reproducible code for the crash of editor. (DO NOT CHANGE IT ANY MORE)
		note
			reproducible_text:
				"[
EiffelStudio 5.7 provided Post 
fact that they provide no way 
directory containing the built
My specific need at the moment

				]"
		local
			i: INTEGER
			i_cnt, l_num_op: INTEGER
		do
			l_num_op := 2
			from
				i := 0
				i_cnt := l_num_op
			until
				i = l_num_op
			loop
				editor.text_displayed.cursor.go_to_position (5)
				editor.text_displayed.insert_string ("astr")
--				editor.text_displayed.insert_eol
--				editor.text_displayed.cursor.go_to_position (100)
--				editor.text_displayed.delete_char
				editor.text_displayed.select_region (100, 104)
				editor.text_displayed.indent_selection
--				editor.text_displayed.forget_selection
				editor.text_displayed.back_delete_char
--				editor.text_displayed.select_region (300, 304)
--				editor.text_displayed.move_selection_to_pos (30)
--				editor.text_displayed.select_region (200, 204)
--				editor.text_displayed.delete_selection
--				editor.text_displayed.insert_char ('x')
--				editor.text_displayed.select_region (100, 103)
--				editor.text_displayed.replace_selection ("")
				i := i + 1
			end
			from
				i := 0
				i_cnt := l_num_op * 8
			until
				i = i_cnt
			loop
				if editor.undo_is_possible then
					editor.undo
				end
				i := i + 1
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class MAIN_WINDOW
