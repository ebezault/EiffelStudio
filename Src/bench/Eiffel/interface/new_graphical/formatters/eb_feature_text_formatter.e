indexing
	description: "Formatter displaying feature information in a text area."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FEATURE_TEXT_FORMATTER

inherit
	EB_FEATURE_INFO_FORMATTER
		redefine
			new_button
		end

feature -- Access

	new_button: EV_TOOL_BAR_RADIO_BUTTON is
			-- Create a new toolbar button and associate it with `Current'.
		do
			Result := Precursor {EB_FEATURE_INFO_FORMATTER}
			Result.drop_actions.extend (~on_feature_drop)
		end

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if editor = Void or else feature_cmd = Void then
				Result := empty_widget
			else
				Result := internal_widget
			end
		end

feature -- Status setting

	set_editor (an_editor: EB_CLICKABLE_EDITOR) is
			-- Set `editor' to `an_editor'.
			-- Used to share an editor between several formatters.
		require
			an_editor_non_void: an_editor /= Void
		do
			editor := an_editor
			internal_widget := an_editor.widget
		end

feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if
				displayed and then
				selected and then
				feature_cmd /= Void
			then
				editor.disable_feature_click
				if must_format then
					display_temp_header
					generate_text
				end
				if not last_was_error then
					if editor.current_text /= formatted_text then
						editor.process_text (formatted_text)
					end
					if editable then
						editor.enable_editable
					else
						editor.disable_editable
					end
				else
					editor.clear_window
					editor.display_message (Warning_messages.w_Formatter_failed)
				end
				display_header
				must_format := last_was_error
			end
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		do
			editor.clear_window
		end

	editor: EB_CLICKABLE_EDITOR
			-- Output editor.

	on_feature_drop (fs: FEATURE_STONE) is
			-- Notify `manager' of the dropping of `fs'.
		do
			if not selected then
				execute
			end
			if fs.e_feature /= associated_feature then
				manager.set_stone (fs)
			end
		end

	editable: BOOLEAN is
			-- Is the text generated by `Current' editable?
		do
			Result := False
		end

	internal_widget: EV_WIDGET
			-- Widget corresponding to `editor's text area.

	empty_widget: EV_WIDGET is
			-- Widget displayed when no information can be displayed.
		do
			if internal_empty_widget = Void then
				new_empty_widget
			end
			Result := internal_empty_widget
		end
		
	internal_empty_widget: EV_WIDGET
			-- Widget displayed when no information can be displayed.
	
	new_empty_widget is
			-- Initialize a default empty_widget.
		local
			def: EV_STOCK_COLORS
			manag: EB_FEATURES_VIEW
		do
			create def
			create {EV_CELL} internal_empty_widget
			internal_empty_widget.set_background_color (def.White)
			manag ?= widget_owner
			if manag = Void then
				internal_empty_widget.drop_actions.extend (~on_feature_drop) 
			else
				internal_empty_widget.drop_actions.extend (manag~drop_stone)
			end
		end

end -- class EB_FEATURE_TEXT_FORMATTER

