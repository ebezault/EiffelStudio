indexing

	description: 
		"EiffelVision implementation of a Motif frame widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FRAME_M 

inherit

	FRAME_I;

	MANAGER_M
        rename
            is_shown as shown
		end;

	MEL_FRAME
		rename
			make as mel_frame_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
            is_shown as shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_frame: FRAME; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif frame.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_frame_make (a_frame.identifier,
					mel_parent (a_frame, widget_index),
					man);
		end

end -- class FRAME

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
