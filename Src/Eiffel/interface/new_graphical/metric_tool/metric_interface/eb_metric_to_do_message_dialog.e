indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TO_DO_MESSAGE_DIALOG

inherit
	EB_METRIC_TO_DO_MESSAGE_DIALOG_IMP

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			default_create,
			is_equal,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_METRIC_TOOL_INTERFACE
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like metric_tool) is
			-- Initialize `metric_tool' with `a_tool'.
		require
			a_tool_attached: a_tool /= Void
		do
			set_metric_tool (a_tool)
			default_create
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_text: EV_TEXT
			l_font: EV_FONT
			l_font_size: INTEGER
		do
			create l_text
			to_do_lbl.set_text (metric_names.t_to_do)
			close_btn.set_text (metric_names.t_close)
			close_btn.select_actions.extend (agent hide)
			create editor
			editor.set_cursors (create {EB_EDITOR_CURSORS})
			editor.set_reference_window (Current)
			editor.widget.set_minimum_size (Layout_constants.dialog_unit_to_pixels (200), Layout_constants.dialog_unit_to_pixels (100))
			editor_area.extend (editor.widget)
			set_size (Layout_constants.dialog_unit_to_pixels (700), Layout_constants.dialog_unit_to_pixels (300))

		end

feature -- Access

	editor: SELECTABLE_TEXT_PANEL
			-- Editor to display to-do message

feature -- Basic operations

	load_text (a_text: STRING) is
			-- Load `a_text' in `editor'.			
		do
			if a_text = Void then
				editor.load_text ("")
			else
				editor.load_text (a_text)
			end
		end

end -- class EB_METRIC_TO_DO_MESSAGE_DIALOG

