note

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PROMPT_I 

inherit

	TERMINAL_I

feature 

	add_apply_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	add_help_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	add_ok_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	hide_apply_button
			-- Make apply button invisible.
		deferred
		end;

	hide_cancel_button
			-- Make cancel button invisible.
		deferred
		end;

	hide_help_button
			-- Make help button invisible.
		deferred
		end;

	hide_ok_button
			-- Make ok button invisible.
		deferred
		end;

	remove_apply_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	remove_help_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end;

	selection_text: STRING
			-- Current text in selection box
		deferred
		end;

	set_apply_label (a_label: STRING)
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end;

	set_cancel_label (a_label: STRING)
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end;

	set_help_label (a_label: STRING)
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end;

	set_ok_label (a_label: STRING)
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		require
			not_label_void: not (a_label = Void)
		deferred
		end;

	set_selection_label (a_label: STRING)
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		deferred
		end;

	set_selection_text (a_text: STRING)
			-- Set selection text to `a_text'.
		require
			a_text_not_void: not (a_text = Void)
		deferred
		end;

	show_apply_button
			-- Make apply button visible.
		deferred
		end;

	show_cancel_button
			-- Make cancel button visible.
		deferred
		end;

	show_help_button
			-- Make help button visible.
		deferred
		end;

	show_ok_button
			-- Make ok button visible.
		deferred
		end

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




end

