indexing
	description: "IAxWinAmbientDispatch Interface Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IAX_WIN_AMBIENT_DISPATCH_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	set_allow_windowless_activation_user_precondition (pb_can_windowless_activate: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `set_allow_windowless_activation'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	allow_windowless_activation_user_precondition: BOOLEAN is
			-- User-defined preconditions for `allow_windowless_activation'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_back_color_user_precondition (pclr_background: INTEGER): BOOLEAN is
			-- User-defined preconditions for `set_back_color'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	back_color_user_precondition: BOOLEAN is
			-- User-defined preconditions for `back_color'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_fore_color_user_precondition (pclr_foreground: INTEGER): BOOLEAN is
			-- User-defined preconditions for `set_fore_color'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	fore_color_user_precondition: BOOLEAN is
			-- User-defined preconditions for `fore_color'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_locale_id_user_precondition (plcid_locale_id: INTEGER): BOOLEAN is
			-- User-defined preconditions for `set_locale_id'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	locale_id_user_precondition: BOOLEAN is
			-- User-defined preconditions for `locale_id'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_user_mode_user_precondition (pb_user_mode: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `set_user_mode'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	user_mode_user_precondition: BOOLEAN is
			-- User-defined preconditions for `user_mode'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_display_as_default_user_precondition (pb_display_as_default: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `set_display_as_default'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	display_as_default_user_precondition: BOOLEAN is
			-- User-defined preconditions for `display_as_default'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_font_user_precondition (p_font: FONT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `set_font'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	font_user_precondition: BOOLEAN is
			-- User-defined preconditions for `font'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_message_reflect_user_precondition (pb_msg_reflect: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `set_message_reflect'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	message_reflect_user_precondition: BOOLEAN is
			-- User-defined preconditions for `message_reflect'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	show_grab_handles_user_precondition (pb_show_grab_handles: BOOLEAN_REF): BOOLEAN is
			-- User-defined preconditions for `show_grab_handles'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	show_hatching_user_precondition (pb_show_hatching: BOOLEAN_REF): BOOLEAN is
			-- User-defined preconditions for `show_hatching'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_doc_host_flags_user_precondition (pdw_doc_host_flags: INTEGER): BOOLEAN is
			-- User-defined preconditions for `set_doc_host_flags'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	doc_host_flags_user_precondition: BOOLEAN is
			-- User-defined preconditions for `doc_host_flags'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_doc_host_double_click_flags_user_precondition (pdw_doc_host_double_click_flags: INTEGER): BOOLEAN is
			-- User-defined preconditions for `set_doc_host_double_click_flags'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	doc_host_double_click_flags_user_precondition: BOOLEAN is
			-- User-defined preconditions for `doc_host_double_click_flags'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_allow_context_menu_user_precondition (pb_allow_context_menu: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `set_allow_context_menu'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	allow_context_menu_user_precondition: BOOLEAN is
			-- User-defined preconditions for `allow_context_menu'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_allow_show_ui_user_precondition (pb_allow_show_ui: BOOLEAN): BOOLEAN is
			-- User-defined preconditions for `set_allow_show_ui'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	allow_show_ui_user_precondition: BOOLEAN is
			-- User-defined preconditions for `allow_show_ui'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_option_key_path_user_precondition (pbstr_option_key_path: STRING): BOOLEAN is
			-- User-defined preconditions for `set_option_key_path'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	option_key_path_user_precondition: BOOLEAN is
			-- User-defined preconditions for `option_key_path'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	set_allow_windowless_activation (pb_can_windowless_activate: BOOLEAN) is
			-- Enable or disable windowless activation
			-- `pb_can_windowless_activate' [in].  
		require
			set_allow_windowless_activation_user_precondition: set_allow_windowless_activation_user_precondition (pb_can_windowless_activate)
		deferred

		end

	allow_windowless_activation: BOOLEAN is
			-- Enable or disable windowless activation
		require
			allow_windowless_activation_user_precondition: allow_windowless_activation_user_precondition
		deferred

		end

	set_back_color (pclr_background: INTEGER) is
			-- Set the background color
			-- `pclr_background' [in].  
		require
			set_back_color_user_precondition: set_back_color_user_precondition (pclr_background)
		deferred

		end

	back_color: INTEGER is
			-- Set the background color
		require
			back_color_user_precondition: back_color_user_precondition
		deferred

		end

	set_fore_color (pclr_foreground: INTEGER) is
			-- Set the ambient foreground color
			-- `pclr_foreground' [in].  
		require
			set_fore_color_user_precondition: set_fore_color_user_precondition (pclr_foreground)
		deferred

		end

	fore_color: INTEGER is
			-- Set the ambient foreground color
		require
			fore_color_user_precondition: fore_color_user_precondition
		deferred

		end

	set_locale_id (plcid_locale_id: INTEGER) is
			-- Set the ambient locale
			-- `plcid_locale_id' [in].  
		require
			set_locale_id_user_precondition: set_locale_id_user_precondition (plcid_locale_id)
		deferred

		end

	locale_id: INTEGER is
			-- Set the ambient locale
		require
			locale_id_user_precondition: locale_id_user_precondition
		deferred

		end

	set_user_mode (pb_user_mode: BOOLEAN) is
			-- Set the ambient user mode
			-- `pb_user_mode' [in].  
		require
			set_user_mode_user_precondition: set_user_mode_user_precondition (pb_user_mode)
		deferred

		end

	user_mode: BOOLEAN is
			-- Set the ambient user mode
		require
			user_mode_user_precondition: user_mode_user_precondition
		deferred

		end

	set_display_as_default (pb_display_as_default: BOOLEAN) is
			-- Enable or disable the control as default
			-- `pb_display_as_default' [in].  
		require
			set_display_as_default_user_precondition: set_display_as_default_user_precondition (pb_display_as_default)
		deferred

		end

	display_as_default: BOOLEAN is
			-- Enable or disable the control as default
		require
			display_as_default_user_precondition: display_as_default_user_precondition
		deferred

		end

	set_font (p_font: FONT_INTERFACE) is
			-- Set the ambient font
			-- `p_font' [in].  
		require
			set_font_user_precondition: set_font_user_precondition (p_font)
		deferred

		end

	font: FONT_INTERFACE is
			-- Set the ambient font
		require
			font_user_precondition: font_user_precondition
		deferred

		ensure
			valid_font: Result.item /= default_pointer
		end

	set_message_reflect (pb_msg_reflect: BOOLEAN) is
			-- Enable or disable message reflection
			-- `pb_msg_reflect' [in].  
		require
			set_message_reflect_user_precondition: set_message_reflect_user_precondition (pb_msg_reflect)
		deferred

		end

	message_reflect: BOOLEAN is
			-- Enable or disable message reflection
		require
			message_reflect_user_precondition: message_reflect_user_precondition
		deferred

		end

	show_grab_handles (pb_show_grab_handles: BOOLEAN_REF) is
			-- Show or hide grab handles
			-- `pb_show_grab_handles' [out].  
		require
			show_grab_handles_user_precondition: show_grab_handles_user_precondition (pb_show_grab_handles)
		deferred

		end

	show_hatching (pb_show_hatching: BOOLEAN_REF) is
			-- Are grab handles enabled
			-- `pb_show_hatching' [out].  
		require
			show_hatching_user_precondition: show_hatching_user_precondition (pb_show_hatching)
		deferred

		end

	set_doc_host_flags (pdw_doc_host_flags: INTEGER) is
			-- Set the DOCHOSTUIFLAG flags
			-- `pdw_doc_host_flags' [in].  
		require
			set_doc_host_flags_user_precondition: set_doc_host_flags_user_precondition (pdw_doc_host_flags)
		deferred

		end

	doc_host_flags: INTEGER is
			-- Set the DOCHOSTUIFLAG flags
		require
			doc_host_flags_user_precondition: doc_host_flags_user_precondition
		deferred

		end

	set_doc_host_double_click_flags (pdw_doc_host_double_click_flags: INTEGER) is
			-- Set the DOCHOSTUIDBLCLK flags
			-- `pdw_doc_host_double_click_flags' [in].  
		require
			set_doc_host_double_click_flags_user_precondition: set_doc_host_double_click_flags_user_precondition (pdw_doc_host_double_click_flags)
		deferred

		end

	doc_host_double_click_flags: INTEGER is
			-- Set the DOCHOSTUIDBLCLK flags
		require
			doc_host_double_click_flags_user_precondition: doc_host_double_click_flags_user_precondition
		deferred

		end

	set_allow_context_menu (pb_allow_context_menu: BOOLEAN) is
			-- Enable or disable context menus
			-- `pb_allow_context_menu' [in].  
		require
			set_allow_context_menu_user_precondition: set_allow_context_menu_user_precondition (pb_allow_context_menu)
		deferred

		end

	allow_context_menu: BOOLEAN is
			-- Enable or disable context menus
		require
			allow_context_menu_user_precondition: allow_context_menu_user_precondition
		deferred

		end

	set_allow_show_ui (pb_allow_show_ui: BOOLEAN) is
			-- Enable or disable UI
			-- `pb_allow_show_ui' [in].  
		require
			set_allow_show_ui_user_precondition: set_allow_show_ui_user_precondition (pb_allow_show_ui)
		deferred

		end

	allow_show_ui: BOOLEAN is
			-- Enable or disable UI
		require
			allow_show_ui_user_precondition: allow_show_ui_user_precondition
		deferred

		end

	set_option_key_path (pbstr_option_key_path: STRING) is
			-- Set the option key path
			-- `pbstr_option_key_path' [in].  
		require
			set_option_key_path_user_precondition: set_option_key_path_user_precondition (pbstr_option_key_path)
		deferred

		end

	option_key_path: STRING is
			-- Set the option key path
		require
			option_key_path_user_precondition: option_key_path_user_precondition
		deferred

		end

end -- IAX_WIN_AMBIENT_DISPATCH_INTERFACE

