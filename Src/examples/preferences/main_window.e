indexing
	description	: "Main window for this application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date$"
	revision	: "1.0.0"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature -- Preference Testing

	initialize_basic_preferences is
			-- Initialize preferences using standard manager, factory and preference types.
		local
				-- Standard
			l_factory: GRAPHICAL_PREFERENCE_FACTORY
			l_manager: PREFERENCE_MANAGER
			br: BOOLEAN_PREFERENCE
			ir: INTEGER_PREFERENCE
			ar: ARRAY_PREFERENCE
			sr: STRING_PREFERENCE
			fr: FONT_PREFERENCE
			cr: COLOR_PREFERENCE
			df: EV_FONT
		do
			create l_factory
			create basic_preferences.make

			create df.make_with_values (1, 6, 10, 8)
			df.preferred_families.extend ("verdana")
			df.preferred_families.extend ("arial")
			df.preferred_families.extend ("helvetica")

			l_manager := basic_preferences.new_manager ("examples")
			ir := l_factory.new_integer_preference_value (l_manager, "examples.my_integer_preference", 10)
			ar := l_factory.new_array_preference_value (l_manager, "examples.my_list_preference", <<"1","2","3">>)
			fr := l_factory.new_font_preference_value (l_manager, "examples.my_font_preference", df)
			sr := l_factory.new_string_preference_value (l_manager, "examples.my_string_preference", "a string")
			sr := l_factory.new_string_preference_value (l_manager, "examples.driver_location", (create {DIRECTORY_NAME}.make_from_string ("C:\My Directory Location")).string)

			l_manager := basic_preferences.new_manager ("display")
			br := l_factory.new_boolean_preference_value (l_manager, "display.fullscreen_at_startup", True)
			cr := l_factory.new_color_preference_value (l_manager, "display.background_color", create {EV_COLOR}.make_with_8_bit_rgb (128, 2, 136))

			l_manager := basic_preferences.new_manager ("graphics")
			br := l_factory.new_boolean_preference_value (l_manager, "graphics.use_maximum_resolution", True)
		end

	initialize_custom_preferences is
			-- Initialize preferences using a custom manager (CUSTOM_MANAGER), which can create, in addition to the standard
			-- preference types the custom type DIRECTORY_RESOURCE.
		local
			l_manager: CUSTOM_MANAGER
			br: BOOLEAN_PREFERENCE
			dr: DIRECTORY_RESOURCE
			cr: COLOR_PREFERENCE
		do
			create custom_preferences.make

			create l_manager.make (custom_preferences, "display")
			br := l_manager.new_boolean_preference_value (l_manager, "display.fullscreen_at_startup", True)
			cr := l_manager.new_color_preference_value (l_manager, "display.background_color", create {EV_COLOR}.make_with_8_bit_rgb (128, 128, 0))
			dr := l_manager.new_directory_preference_value ("display.driver_location", create {DIRECTORY_NAME}.make_from_string ("C:\A Directory Location"))

			create l_manager.make (custom_preferences, "graphics")
			br := l_manager.new_boolean_preference_value (l_manager, "graphics.use_maximum_resolution", True)
		end

	preference_window: PREFERENCES_GRID
			-- The default preference interface widget

	custom_preference_window: CUSTOM_PREFERENCE_DIALOG
			-- A custom preference interface widget

feature {NONE} -- Initialization

	basic_preferences: PREFERENCES

	custom_preferences: PREFERENCES

	initialize is
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

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

	is_in_default_state: BOOLEAN is
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end

feature {NONE} -- Implementation, Close event

	request_close_window is
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

	build_main_container is
			-- Create and populate `main_container'.
		require
			main_container_not_yet_created: main_container = Void
		local
			basic_button,
			custom_button: EV_BUTTON
		do
			create main_container

			create basic_button.make_with_text ("Load preferences (normal view)")
			basic_button.select_actions.extend (agent show_standard_preference_window)
			main_container.extend (basic_button)

			create custom_button.make_with_text ("Load preferences (custom view)")
			custom_button.select_actions.extend (agent show_custom_preference_window)
			main_container.extend (custom_button)
		ensure
			main_container_created: main_container /= Void
		end

	show_standard_preference_window is
			-- Show preference window basic view
		do
			initialize_basic_preferences
			create preference_window.make (basic_preferences, Current)
			preference_window.show
		end

	show_custom_preference_window is
			-- Show preference window customized view
		do
			initialize_custom_preferences
			create custom_preference_window.make (custom_preferences, Current)
			custom_preference_window.show
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING is "EiffelPreference Example"
			-- Title of the window.

	Window_width: INTEGER is 100
			-- Initial width for this window.

	Window_height: INTEGER is 100;
			-- Initial height for this window.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_WINDOW
