indexing
	description	: "Main window for this WEL Application"
	author		: "Generated by the New WEL Application Wizard"
	date		: "${FL_DATE}"
	revision	: "1.0.0"

class
	MAIN_WINDOW

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window
		do
			make_by_id (Idd_${FL_PROJECT_NAME_LOWERCASE}_dialog)
		end

	setup_dialog is
			-- Initialize the dialog content.
		do
				-- Change the icon.
			set_icon (class_icon, class_icon)
		end

feature {NONE} -- Implementation

	class_background: WEL_BRUSH is
			-- White background
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Idi_wel_application)
		end

end -- class MAIN_WINDOW
