indexing
	description: 
	"EiffelVision text field. To query single line of text from the user"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_TEXT_FIELD

inherit
	EV_TEXT_COMPONENT
		redefine
			make,
			implementation
		end

create
	make,
	make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a text field with, `par' as
			-- parent
		do
			!EV_TEXT_FIELD_IMP!implementation.make
			widget_make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		require
			valid_parent: parent_needed implies par /= Void
		do
			!EV_TEXT_FIELD_IMP!implementation.make_with_text (txt)
			widget_make (par)
		end

feature -- Status setting

	set_maximum_text_length (value: INTEGER) is
			-- Make `value' the new maximal lenght of the text
			-- in character number.
		require
			exist: not destroyed
			valid_length: value >= 0
		do
			implementation.set_maximum_text_length (value)
		end

	get_maximum_text_length: INTEGER is
			-- Return the maximum number of characters
			-- that the user may enter into the text field.
		require
			exist: not destroyed
		do
			Result := implementation.get_maximum_text_length
		end

feature -- Event - command association

	add_return_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text field is activated, ie when the user
			-- press the enter key.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_return_command (cmd, arg)
		end	

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text field is activated, ie when the user
			-- press the enter key.
		obsolete
			"Use add_return command instead."
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_return_command (cmd, arg)
		end	

feature -- Event -- removing command association

	remove_return_commands is
			-- Empty the list of commands to be executed
			-- when the text field is activated, ie when the user
			-- press the enter key.
		require
			exists: not destroyed
		do
			implementation.remove_return_commands
		end

	remove_activate_commands is
			-- Empty the list of commands to be executed
			-- when the text field is activated, ie when the user
			-- press the enter key.
		obsolete
			"Use remove_return_command instead."
		require
			exists: not destroyed
		do
			implementation.remove_return_commands
		end

feature {NONE} -- Implementation

	implementation: EV_TEXT_FIELD_I
			-- Implementation 
			
end -- class EV_TEXT_AREA

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

