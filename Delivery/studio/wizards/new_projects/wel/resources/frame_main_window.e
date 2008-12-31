note
	description	: "Main window for this WEL Application"
	author		: "Generated by the New WEL Application Wizard"
	date		: "${FL_DATE}"
	revision	: "1.0.0"

class
	MAIN_WINDOW

inherit
	${FL_APPLICATION_TYPE}
		redefine
			class_icon,
			class_background
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

	make
			-- Make the main window
		do
			make_top ("${FL_PROJECT_NAME}")
		end

feature {NONE} -- Implementation

	class_background: WEL_BRUSH
			-- White background
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Idr_mainframe)
		end

end
