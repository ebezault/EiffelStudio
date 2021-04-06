note
	description: "Summary description for {SCM_SAVE_DIALOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_SAVE_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog
		redefine
			is_size_and_position_remembered
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	SHARED_SCM_NAMES

	EV_LAYOUT_CONSTANTS

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make (a_service: SOURCE_CONTROL_MANAGEMENT_S; a_commit: SCM_COMMIT_SET)
		do
			scm_service := a_service
			commit := a_commit
			create commit_log_box
			create commit_log_text

			create progress_log_box
			create progress_log_text

			create status_box
			create status_text
			make_dialog
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	commit: SCM_COMMIT_SET

feature -- Widgets

	status_text: EV_TEXT

	status_box: EV_VERTICAL_BOX

	progress_log_box: EV_VERTICAL_BOX

	progress_log_text: EV_TEXT

	commit_log_box: EV_VERTICAL_BOX

	commit_log_text: EV_TEXT


feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			fb, b: EV_VERTICAL_BOX
--			f: EV_FRAME
			sp: EV_VERTICAL_SPLIT_AREA
			txt: EV_TEXT
			lab: EV_LABEL
		do
			create sp
			a_container.extend (sp)

				-- Changes box
			create fb
			sp.extend (fb)
			fb.set_padding_width (default_padding_size)
			fb.set_border_width (default_border_size)

			b := status_box
			fb.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)

			create lab.make_with_text (scm_names.label_changes)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			txt := status_text
			txt.set_text (commit.changes_description)
			txt.disable_edit
			b.extend (txt)

			b := progress_log_box
			fb.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)

			create lab.make_with_text (scm_names.label_operation_logs)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			txt := progress_log_text
			txt.disable_edit
			b.extend (txt)
			b.hide

				-- Commit log box
			b := commit_log_box
			sp.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)

			create lab.make_with_text (scm_names.label_commit_message)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			txt := commit_log_text
			txt.set_minimum_height (3 * txt.font.line_height)
			if attached commit.message as msg then
				txt.set_text (msg)
			end
			b.extend (txt)

			show_actions.extend_kamikaze (agent (i_sp: EV_VERTICAL_SPLIT_AREA)
					do
						i_sp.set_proportion (0.75)
					end(sp)
				)

			if attached dialog_window_buttons [dialog_buttons.reset_button] as but then
				but.hide
			end

			set_button_text (dialog_buttons.ok_button, interface_names.b_save)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_cancel)
			set_button_text (dialog_buttons.reset_button, interface_names.b_close)

			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)
			set_button_action_before_close (dialog_buttons.reset_button, agent on_close)
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "FIXME..." -- FIXME
		end

feature {NONE} -- Helpers

	register_input_widget (aw: EV_WIDGET)
			-- Register `aw' as an input widget
		do
			suppress_confirmation_key_close  (aw)
		end

	extend_non_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, False)
		end

	extend_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, True)
		end

	extend_to (b: EV_BOX; w: EV_WIDGET; is_expandable: BOOLEAN)
			-- Extend `w' to `b', and keep expand enabled (default)
		do
			b.extend (w)
			if not is_expandable then
				b.disable_item_expand (w)
			end
		end

feature -- Action

	set_size (w,h: INTEGER)
		do
			dialog.set_size (w, h)
		end

	error_background_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 210, 210)
		end

	notify_error_on_text_field (a_tf: EV_TEXT_FIELD)
			--
		local
			col: EV_COLOR
		do
			col := a_tf.background_color
			a_tf.set_background_color (error_background_color)
			a_tf.key_press_actions.extend_kamikaze (agent (atf: EV_TEXT_FIELD; acol: EV_COLOR; akey: EV_KEY)
					do
						atf.set_background_color (acol)
					end(a_tf, col, ?)
				)
		end

	on_ok
		local
			err: BOOLEAN
			l_pointer_style: detachable EV_POINTER_STYLE
		do
			if attached dialog_window_buttons [dialog_buttons.ok_button] as but then
				but.hide
			end
			if attached dialog_window_buttons [dialog_buttons.reset_button] as but then
				but.show
			end

			l_pointer_style := dialog.pointer_style
			dialog.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
			
			commit.set_message (commit_log_text.text)
			scm_service.commit_and_push (commit)

			dialog.set_pointer_style (l_pointer_style)

			status_box.hide
			commit_log_box.hide
			progress_log_box.show

			if attached commit.execution_message as m then
				progress_log_text.set_text (m)
			else
				progress_log_text.set_text (scm_names.text_no_output)
			end

			err := commit.has_error

			if err then
				if attached dialog_window_buttons [dialog_buttons.ok_button] as but then
					but.show
				end
				if attached dialog_window_buttons [dialog_buttons.reset_button] as but then
					but.hide
				end
			else
				if attached dialog_window_buttons [dialog_buttons.cancel_button] as but then
					but.hide
				end
			end

			veto_close
		end

	on_close
		do
			-- Bye
		end

	on_cancel
		do
			commit.reset
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.source_version_control_icon_buffer
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := scm_names.title_scm_save
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.reset_ok_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.ok_button
		end

	is_size_and_position_remembered: BOOLEAN = False
			-- Indicates if the size and position information is remembered for the dialog	

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end
