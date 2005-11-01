indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_ABOUT_DIALOG

inherit
	ECDM_ABOUT_DIALOG_IMP

	CODE_REGISTRY_KEYS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			version_label.set_text (Version)
		end

feature {NONE} -- Implementation

	on_ok is
			-- Called by `select_actions' of `ok_button'.
			-- Close dialog
		do
			destroy
		end

	on_web_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `web_address_label'.
			-- Open web browser on `http://www.eiffel.com'.
		local
			l_browser_path: STRING
			l_res: SYSTEM_DLL_PROCESS
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_browser_path := (create {EXECUTION_ENVIRONMENT}).get ("SystemDrive")
				if l_browser_path /= Void then
					l_browser_path.append ("\Program Files\Internet Explorer\iexplore.exe")
					if {SYSTEM_FILE}.exists (l_browser_path) then
						l_res := {SYSTEM_DLL_PROCESS}.start (l_browser_path, "http://www.eiffel.com")
					end
				end
			end
		rescue
			l_retried := True
			retry
		end

	on_mouse_enter is
			-- Called by `pointer_enter_actions' of `web_address_label'.
			-- Change mouse cursor to "hyperlink hovering mouse cursor"
		local
			l_font: EV_FONT
		do
			default_font := web_address_label.font
			l_font := default_font.twin
			l_font.set_weight ((create {EV_FONT_CONSTANTS}).Weight_bold)
			web_address_label.set_font (l_font)
		end

	on_mouse_leave is
			-- Called by `pointer_leave_actions' of `web_address_label'.
			-- Restore mouse cursor.
		do
			web_address_label.set_font (default_font)
		end

	default_font: EV_FONT
			-- Default web label font

end -- class ECDM_ABOUT_DIALOG

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------