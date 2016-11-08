note
	description:
		"[
			Popup dialog to import settings from previous installations.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SETTINGS_IMPORT_DIALOG

inherit
	EB_DIALOG
	
	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW)
			-- Initialize Current with `a_window' as parent.
		require
			a_window_not_void: a_window /= Void
		do
			create on_finish_actions

			make_with_title (interface_names.l_settings_management)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			set_size (600, 400)

			build_interface

			key_press_actions.extend (agent escape_check (?))
			focus_in_actions.extend (agent on_window_focused)
			close_request_actions.extend (agent on_close)
		end

	build_interface
		local
			cell: EV_CELL
			vbox,vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			cb: EV_COMBO_BOX
			fr: EV_FRAME
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			but_check: EV_CHECK_BUTTON
			but: EV_BUTTON
			tg_but: EV_TOGGLE_BUTTON
		do
			create vbox
			vbox.set_border_width (layout_constants.default_border_size)
			vbox.set_padding_width (layout_constants.default_padding_size)
			extend (vbox)

			create cell
			main_cell := cell
			vbox.extend (cell) --; vbox.disable_item_expand (cell)

			create fr.make_with_text (interface_names.l_installed_versions)
			cell.extend (fr)

			versions_frame := fr

			create vb
			fr.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
			vb.set_padding_width (layout_constants.default_padding_size)

				-- Installed Versions
			create cb
			versions_combo := cb
			vb.extend (cb)
			vb.disable_item_expand (cb)

				-- Preferences
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			vb.extend (hb); vb.disable_item_expand (hb)
			create but_check.make_with_text ("Preferences")
			but_check.set_minimum_width (100)
			but_check.enable_select
			hb.extend (but_check); hb.disable_item_expand (but_check)
			preferences_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			preferences_tf := tf


				-- user_files_path ("studio")
				--		studio\eifinit\
				--		studio\bitmaps\png\
				--		studio\tools\testing\icons
				--		studio\metrics\predefined_metrics.xml
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			vb.extend (hb); vb.disable_item_expand (hb)
			create but_check.make_with_text ("Configuration Files")
			but_check.set_minimum_width (100)
			but_check.enable_select
			hb.extend (but_check); hb.disable_item_expand (but_check)
			studio_config_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			studio_config_tf := tf


				-- user_templates_path
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			vb.extend (hb); vb.disable_item_expand (hb)
			create but_check.make_with_text ("Templates")
			but_check.set_minimum_width (100)
			but_check.enable_select
			hb.extend (but_check); hb.disable_item_expand (but_check)
			templates_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			templates_tf := tf

				-- *.ini files under user_files_path
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			vb.extend (hb); vb.disable_item_expand (hb)
			create but_check.make_with_text ("*.ini files")
			but_check.set_minimum_width (100)
			but_check.enable_select
			hb.extend (but_check); hb.disable_item_expand (but_check)
			ini_files_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			ini_files_tf := tf

				-- Custom Edit
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			vb.extend (hb); vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create lab.make_with_text (interface_names.l_edit_custom_settings)
			hb.extend (lab); hb.disable_item_expand (lab)
			create tg_but.make_with_text (interface_names.b_edit_settings)
			tg_but.set_minimum_width (100)
			hb.extend (tg_but); hb.disable_item_expand (tg_but)
			tg_but.select_actions.extend (agent on_custom_edit (tg_but))

			vb.extend (create {EV_CELL})

			create hb
			hb.extend (create {EV_CELL})

			create but.make_with_text (interface_names.b_import_settings)
			but.select_actions.extend (agent on_import)
			import_button := but
			but.disable_sensitive
			hb.extend (but)
			hb.disable_item_expand (but)
			layout_constants.set_default_size_for_button (but)

			create but.make_with_text (interface_names.b_close)
			but.select_actions.extend (agent on_close)
			hb.extend (but)
			hb.disable_item_expand (but)
			layout_constants.set_default_size_for_button (but)

			create but.make_with_text (interface_names.b_arrow_back)
			but.select_actions.extend (agent update)
			back_button := but
			hb.extend (but)
			hb.disable_item_expand (but)
			layout_constants.set_default_size_for_button (but)

--			hb.extend (create {EV_CELL})

			vbox.extend (hb)
			vbox.disable_item_expand (hb)

			create text_widget

			show_actions.extend (agent update)
		end

feature -- Access

	main_cell: EV_CELL

	versions_frame: EV_FRAME

	text_widget: EV_TEXT

	versions_combo: EV_COMBO_BOX

	preferences_tf,
	templates_tf,
	studio_config_tf,
	ini_files_tf: EV_TEXT_FIELD


	preferences_cb,
	studio_config_cb,
	templates_cb,
	ini_files_cb: EV_CHECK_BUTTON

	import_button: EV_BUTTON
	back_button: EV_BUTTON

feature -- Actions

	on_finish_actions: ACTION_SEQUENCE
			-- Actions triggered when import is done or cancelled.

feature -- Event

	on_custom_edit (but: EV_TOGGLE_BUTTON)
		do
			if but.is_selected then
				but.set_text (interface_names.b_apply)
				preferences_cb.enable_sensitive
				preferences_tf.enable_edit

				studio_config_cb.enable_sensitive
				studio_config_tf.enable_edit

				templates_cb.enable_sensitive
				templates_tf.enable_edit

				ini_files_cb.enable_sensitive
				ini_files_tf.enable_edit

				import_button.hide
			else
				but.set_text (interface_names.b_edit_settings)
				preferences_tf.disable_edit

				studio_config_tf.disable_edit

				templates_tf.disable_edit

				ini_files_tf.disable_edit

				update_choices_status
				import_button.show
			end
		end

	on_import
		local
			l_prefs_versions: PREFERENCES_VERSIONS
			l_prefs: PREFERENCES_STORAGE_DEFAULT
			is_verbose: BOOLEAN
			d: DIRECTORY
			l_prefs_import_callback: detachable PROCEDURE [TUPLE [ith: INTEGER; total: INTEGER; name, value: READABLE_STRING_GENERAL]]
		do
			import_button.hide
			back_button.show
			main_cell.wipe_out
			main_cell.replace (text_widget)

			text_widget.set_text ("Importing ...%N")
			is_verbose := True

			if preferences_cb.is_sensitive and then preferences_cb.is_selected then

				text_widget.append_text ("- Preferences from %"")
				text_widget.append_text (preferences_tf.text)
				text_widget.append_text ("%"%N")

				create l_prefs_versions
				create l_prefs.make_with_location_and_version (preferences_tf.text, l_prefs_versions.version_2_0)

--"projects.last_opened_projects"
-- "path"
-- "opened_metric_browse_archive_directory"
-- "opened_project_directory"


				if is_verbose then
					l_prefs_import_callback := agent (ith: INTEGER_32; total: INTEGER_32; name, value: READABLE_STRING_GENERAL)
								do
									text_widget.append_text (" [" + ith.out + "/" + total.out + "] ")
									text_widget.append_text (name)
									text_widget.append_text (": ")
									text_widget.append_text (value)
									text_widget.append_text ("%N")
								end
				end
				preferences.preferences.import_from_storage_with_callback_and_exclusion (l_prefs,
						True, -- Ignore hidden preferences
						l_prefs_import_callback,
						agent (ith: INTEGER; total: INTEGER; k, v: READABLE_STRING_GENERAL): BOOLEAN
							do
								Result := is_excluded_preference (k, v)

								if Result then
									text_widget.append_text (" [" + ith.out + "/" + total.out + "] ")
									text_widget.append_text (k)
									text_widget.append_text (": Excluded!%N")
								end
							end
					)
			end
			if studio_config_cb.is_sensitive and then studio_config_cb.is_selected then
				text_widget.append_text ("- Configuration file.%N")
				safe_copy_directory_content_into (create {PATH}.make_from_string (studio_config_tf.text), eiffel_layout.user_files_path.extended ("studio"), is_verbose)
			end
			if templates_cb.is_sensitive and then templates_cb.is_selected then
				text_widget.append_text ("- Templates.%N")
				safe_copy_directory_content_into (create {PATH}.make_from_string (templates_tf.text), eiffel_layout.user_templates_path, is_verbose)
			end
			if ini_files_cb.is_sensitive and then ini_files_cb.is_selected then
				text_widget.append_text ("- *.ini files.%N")
				create d.make_with_name (ini_files_tf.text)
				across
					d.entries as ic
				loop
					if ic.item.is_current_symbol or ic.item.is_parent_symbol then
					elseif attached ic.item.extension as ext and then ext.same_string ("ini") then
						safe_copy_file_to (create {RAW_FILE}.make_with_path (d.path.extended_path (ic.item)),
								create {RAW_FILE}.make_with_path (eiffel_layout.user_templates_path.extended_path (ic.item)), is_verbose)
					end
				end
			end
		end

	is_excluded_preference (a_name, a_value: READABLE_STRING_GENERAL): BOOLEAN
			-- Is excluding preference named `a_name` with value `a_value`?
		do
			if attached selected_version_name as vn and then a_value.has_substring (vn) then
					-- Be prudent, and do not import preference whose value may have version specific values.
				Result := True
			end
		end

	update
		local
			li: EV_LIST_ITEM
			l_curr_version: READABLE_STRING_GENERAL
			l_prev_version: detachable READABLE_STRING_GENERAL
			l_prev_version_list_item: detachable EV_LIST_ITEM
		do
			import_button.show
			back_button.hide
			main_cell.wipe_out
			main_cell.put (versions_frame)

			selected_version_name := Void
			if is_eiffel_layout_defined then
				l_curr_version := eiffel_layout.version_name
				across
					eiffel_layout.installed_version_names as ic
				loop
					create li.make_with_text (eiffel_layout.product_name_for_version (ic.item))
					li.set_data (ic.item)
					versions_combo.extend (li)
					li.select_actions.extend (agent on_version_selected (ic.item))
					if not l_curr_version.same_string (ic.item) then
						l_prev_version := ic.item
						l_prev_version_list_item := li
					end
				end
				if l_prev_version_list_item /= Void then
					l_prev_version_list_item.enable_select
				end
			end
		end

	selected_version_name: detachable READABLE_STRING_GENERAL

	on_version_selected (v: READABLE_STRING_GENERAL)
		local
			p, ufp: PATH
			s: READABLE_STRING_32
			cb: EV_CHECK_BUTTON
			tf: EV_TEXT_FIELD
		do
			selected_version_name := v
			ufp := eiffel_layout.user_files_path_for_version (v, False)

				-- Preferences
			preferences_cb.enable_sensitive
			s := eiffel_layout.eiffel_preferences_for_version (v, False)
			preferences_cb.set_tooltip ({STRING_32} "Preferences at " + s)
			preferences_tf.set_text (s)

				-- Studio
			p := ufp.extended ("studio")
			cb := studio_config_cb
			tf := studio_config_tf
			tf.set_text (p.name)
			cb.set_tooltip ({STRING_32} "Import directory %"" + p.name + "%"")

				-- Templates
			p := ufp.extended ("templates")
			tf := templates_tf
			cb := templates_cb
			tf.set_text (p.name)
			cb.set_tooltip ({STRING_32} "Import directory %"" + p.name + "%"")

				-- *.ini files
			cb := ini_files_cb
			tf := ini_files_tf
			p := ufp
			cb.set_tooltip (ufp.name + "  *.ini files")
			tf.set_text (ufp.name)

				-- Update choices

			update_choices_status

				-- Button Import
			if eiffel_layout.version_name.same_string_general (v) then
				import_button.disable_sensitive
			else
				import_button.enable_sensitive
			end
		end

	update_choices_status
		local
			p: READABLE_STRING_32
			ut: FILE_UTILITIES
			cb: EV_CHECK_BUTTON
			d: DIRECTORY
		do
				-- Preferences
			preferences_cb.enable_sensitive

				-- Studio
			p := studio_config_tf.text
			cb := studio_config_cb
			if ut.directory_exists (p) then
				cb.enable_sensitive
			else
				cb.disable_sensitive
			end

				-- Templates
			p := templates_tf.text
			cb := templates_cb
			if ut.directory_exists (p) then
				cb.enable_sensitive
			else
				cb.disable_sensitive
			end

				-- *.ini files
			cb := ini_files_cb
			p := ini_files_tf.text
			if ut.directory_exists (p) then
				create d.make_with_name (p)
				if across d.entries as ic some attached ic.item.extension as ext and then ext.is_case_insensitive_equal_general ("ini") end then
					cb.enable_sensitive
				else
					cb.disable_sensitive
				end
			else
				cb.disable_sensitive
			end
		end

feature {NONE} -- Implementation

	safe_copy_directory_content_into (a_dirname: PATH; a_target_dirname: PATH; is_verbose: BOOLEAN)
		local
			p,tgt: PATH
			d_src, d_tgt: DIRECTORY
			f_src: RAW_FILE
		do
			create d_src.make_with_path (a_dirname)
			if d_src.exists then
				create d_tgt.make_with_path (a_target_dirname)
				if not d_tgt.exists then
					d_tgt.create_dir
					text_widget.append_text ("Create directory ")
					text_widget.append_text (a_target_dirname.name)
					text_widget.append_text ("%N")
				end
				if d_tgt.exists then
					across
						d_src.entries as ic
					loop
						p := ic.item
						if p.is_current_symbol or p.is_parent_symbol then
								-- Skip
						else
							create f_src.make_with_path (d_src.path.extended_path (p))
							tgt := a_target_dirname.extended_path (p)
							if f_src.is_directory then
								safe_copy_directory_content_into (f_src.path, tgt, is_verbose)
							else
								safe_copy_file_to (f_src, create {RAW_FILE}.make_with_path (tgt), is_verbose)
							end
						end
					end
				end
			end
		end

	safe_copy_file_to (f_src, f_tgt: FILE; is_verbose: BOOLEAN)
		local
			retried: BOOLEAN
			l_tgt_existed: BOOLEAN
		do
			if retried then
				if not f_src.is_closed then
					f_src.close
				end
				if not f_tgt.is_closed then
					f_tgt.close
				end

				if is_verbose then
					text_widget.append_text ("Error while copying file to ")
					text_widget.append_text (f_tgt.path.name)
					text_widget.append_text ("%N")
				end
			elseif f_tgt.exists and then not f_tgt.is_access_writable then
				if is_verbose then
					text_widget.append_text ("Could not replace file ")
					text_widget.append_text (f_tgt.path.name)
					text_widget.append_text ("%N")
				end
			elseif f_tgt.exists and then f_src.date < f_tgt.date then
				if is_verbose then
					text_widget.append_text ("Keep more recent file ")
					text_widget.append_text (f_tgt.path.name)
					text_widget.append_text ("%N")
				end
			else
				if f_tgt.exists then
					f_tgt.open_write
					l_tgt_existed := True
				else
					f_tgt.create_read_write
				end
				f_src.open_read
				f_src.copy_to (f_tgt)
				f_src.close
				f_tgt.close
				if is_verbose then
					if l_tgt_existed then
						text_widget.append_text ("Replace file ")
					else
						text_widget.append_text ("Copy to file ")
					end
					text_widget.append_text (f_tgt.path.name)
					text_widget.append_text ("%N")
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Actions

	on_close
	 		-- Action to take when user presses 'Cancel' button.
		do
			import_button.show
			back_button.hide
			main_cell.wipe_out
			main_cell.put (versions_frame)
			hide
			on_finish_actions.call (Void)
		end

feature {NONE} -- Implementation

	on_window_focused
			-- Acion to be taken when window gains focused.
		do
			versions_combo.set_focus
		end

	escape_check (key: EV_KEY)
			-- Check for keyboard escape character.
		require
			key_not_void: key /= Void
     	do
        	if key.code = {EV_KEY_CONSTANTS}.key_escape then
            	on_close
            end
      	end

	execute
		do
		end

	execute_and_close
		do
			execute
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_ARGUMENT_DIALOG
