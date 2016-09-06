note
	description	: "Main window for this application"
	author		: "Generated by the New Vision2 Application Wizard."
	revision	: "1.0.0"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state,
			create_interface_objects
		end

	INTERFACE_NAMES
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

	DOCUMENT_TYPE_MANAGER
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

			setup_editor
		end

	create_interface_objects
			-- Create interface objects
		do
			create standard_menu_bar
			create file_menu.make_with_text (Menu_file_item)
			create help_menu.make_with_text (Menu_help_item)
			create main_container
			editor := create_editor
		end

	is_in_default_state: BOOLEAN
			-- the window in its default state
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
			menu_bar_not_yet_created: standard_menu_bar /= Void
		do
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
			file_menu_not_yet_created: file_menu /= Void
		local
			menu_item: EV_MENU_ITEM
		do
			create menu_item.make_with_text (Menu_file_open_item)
			menu_item.select_actions.extend (agent on_file_open)
			file_menu.extend (menu_item)

			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Create the File/Exit menu item and make it call
				-- `request_close_window' when it selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_close_window)
			file_menu.extend (menu_item)
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

	build_help_menu
			-- Create and populate `help_menu'.
		require
			help_menu_not_yet_created: help_menu /= Void
		local
			menu_item: EV_MENU_ITEM
		do
			create menu_item.make_with_text (Menu_help_contents_item)
			help_menu.extend (menu_item)
		ensure
			help_menu_created: help_menu /= Void and then not help_menu.is_empty
		end

feature {NONE} -- Events

	on_file_open
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog.make_with_title ("Choose a file")
			l_open_dialog.open_actions.extend (agent on_open (l_open_dialog))
			l_open_dialog.show_modal_to_window (Current)
		end

	on_open (a_dialog: EV_FILE_OPEN_DIALOG)
		require
			a_dialog_not_void: a_dialog /= Void
		do
			editor.load_file_path (a_dialog.full_file_path)
		end

feature -- Text Observer

	on_text_fully_loaded
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if attached question_dialog.selected_button as l_button and then l_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
					--| TODO: Remove this line if you don't want the application
					--|       to end when the first window closed..
				if attached (create {EV_ENVIRONMENT}).application as l_app then
					l_app.destroy
				end
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	build_main_container
			-- Create and populate `main_container'.
		require
			main_container_not_yet_created: main_container /= Void
		do
			main_container.extend (editor.widget)
		ensure
			main_container_created: main_container /= Void
		end

	create_editor: like editor
			-- Create editor
		do
			editor_preferences_cell.put (editor_data)
			create Result
		end

	setup_editor
			-- Setup the editor
		local
			l_doc: DOCUMENT_CLASS
		do
			editor_data.show_line_numbers_preference.set_value (True)
			editor.add_edition_observer (Current)
			editor.load_text ("Open a *.e or *.java file.")

				-- Init document classes
			l_doc := eiffel_class
			l_doc := java_class
		end

feature {NONE} -- Implementation / Constants

	editor: EDITABLE_TEXT_PANEL

	editor_data: EDITOR_DATA
			-- Default editor data
		local
			l_preferences: PREFERENCES
		once
			create l_preferences.make
			create Result.make (l_preferences)
		end

	eiffel_class: DOCUMENT_CLASS
			-- Create the document class.
		once
			create Result.make ("Eiffel Class", "e", "eiffel.syn")
			register_document ("e", Result)
		end

	java_class: DOCUMENT_CLASS
			-- Create the document class.
		local
			l_syntax: JAVA_SYNTAX_SCANNER
		once
			create Result.make ("Java Class", "java", "")
			register_document ("java", Result)

			create l_syntax.make ("java.syn")
			Result.set_scanner (l_syntax)
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING = "simple_editor"
			-- Title of the window.

	Window_width: INTEGER = 500
			-- Initial width for this window.

	Window_height: INTEGER = 700
			-- Initial height for this window.

end -- class MAIN_WINDOW
