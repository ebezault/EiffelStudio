note
	description: "Objects that display documentation for Vision2 classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_DISPLAY

inherit
	INTERNAL

	WIDGET_TEST_SHARED

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: EV_RICH_TEXT)
			-- Create `Current' and and assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			text := a_text
		end

feature -- Status setting

	update_for_type_change (widget: EV_WIDGET)
			-- Update documentation for type matching `widget'.
		do
			if real_update_for_type_change_agent = Void then
				real_update_for_type_change_agent := agent real_update_for_type_change
			end
			widget_to_update := widget
			application.do_once_on_idle (real_update_for_type_change_agent)
				-- We defer this so that it is executed on the idle actions of EV_APPLICATION.
				-- This speeds up the appearence of the type change to a user, as they are not
				-- waiting for the file to load before being able to interact with the interface.
		end

	widget_to_update: EV_WIDGET

	real_update_for_type_change_agent: PROCEDURE [DOCUMENTATION_DISPLAY, TUPLE ]

	real_update_for_type_change
			-- Actually perform the update of the text.
		local
			file_name: STRING
			directory_name: DIRECTORY_NAME
			full_filename: FILE_NAME
			file: PLAIN_TEXT_FILE
			widget: EV_WIDGET
		do
			widget := widget_to_update
			file_name := class_name (widget)
			file_name.to_lower
			file_name.append ("_flatshort.rtf")
			create directory_name.make_from_string (eiffel_layout.shared_application_path)
			directory_name.extend ("flatshort")
			create full_filename.make_from_string (directory_name.out)
			full_filename.extend (file_name)
			create file.make (full_filename)
			if file.exists then
				text.set_with_named_file (full_filename)
			else
				text.set_text ("Unable to locate the documentation for " + test_widget_type + ".%N%N" + location_error_message)
			end

			update_text_size
		end

	update_text_size
			-- adjust font size of `flat_short_display' by `value'.
		local
			font: EV_FONT
			format_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			format: EV_CHARACTER_FORMAT
		do
			if text.text_length /= 0 then
				format := text.character_format (1)
				font := format.font
					-- Now update font used within `text'. The RTF generated by EiffelStudio uses courier which does not scale
					-- very well, but is available on all platforms. We no create a font with "Courier New" and then "Courier" within
					-- the `preferred_families' and apply it to all of the test in `text'. This ensures that we use courier new on
					-- platforms that support it, enabling smooth font scaling.
				font.preferred_families.wipe_out
				font.preferred_families.extend ("Courier New")
				font.preferred_families.extend ("Courier")
				font.set_height_in_points (current_text_size)
				format.set_font (font)
				create format_info.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_height | {EV_CHARACTER_FORMAT_CONSTANTS}.font_family)
				text.modify_region (1, text.text_length, format, format_info)
			end
		end

feature {NONE} -- Implementation

	text: EV_RICH_TEXT
		-- All class output is displayed on this widget.

invariant
	text_not_void: text /= Void

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


end -- class DOCUMENTATION_DISPLAY
