indexing
	description: 
		"EiffelVision text container, gtk implementation.%
		% For every textable widget, we create a gtk box to put %
		% in the widget. The pixmap and the label will then be put%
		% in this box."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
	
	EV_FONTABLE_IMP
	
	EV_GTK_CONTAINERS_EXTERNALS
	EV_GTK_EXTERNALS
	EV_GTK_WIDGETS_EXTERNALS
	EV_GTK_TYPES_EXTERNALS
	
feature {NONE} -- Initialization

	make is
			-- feature `make'.
		deferred
		end
	
	initialize is
			-- Creation of the `box', where the label and the pixmap
			-- will be put in.
			-- Common initialization for textable widgets,
			-- except for status bar and radio buttons.

		do
			-- Creation of an gtk_box.
			box := gtk_hbox_new (False, 5)
			gtk_widget_show (box)

			-- Adding the box in the widget.
			gtk_container_add (GTK_CONTAINER (widget), box)
		end

	create_text_label (txt: STRING) is
			-- Create the label for the text and
			-- put it in `box'.
		require
			call_only_once: label_widget = default_pointer
			box_already_created: box /= default_pointer
		local
                        a: ANY
		do
			a := txt.to_c
			
			set_label_widget (gtk_label_new ($a))
			gtk_widget_show (label_widget)
			gtk_box_pack_end (GTK_BOX (box), label_widget, True, True, 0)

			-- We left-align and vertical_center-position the text.
			gtk_misc_set_alignment (gtk_misc (label_widget), 0.0, 0.5)
		end			

	make_with_text (txt: STRING) is
			-- Create an item with `txt' as label.
		do
			make
			set_text (txt)
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			!!Result.make (0)
			if label_widget /= Default_pointer then
				gtk_label_get (label_widget, $p)
				Result.from_c (p)
			end
		end
	
feature -- Status setting

        set_center_alignment is
                        -- Set text alignment of current label to center.
                do
			gtk_misc_set_alignment (gtk_misc (label_widget), 0.5, 0.5)
 		end

        set_right_alignment is
                -- Set text alignment of current label to right.
                do
			gtk_misc_set_alignment (gtk_misc (label_widget), 1, 0.5)
		end

        set_left_alignment is
                        -- Set text alignment of current label to left.
                do
			gtk_misc_set_alignment (gtk_misc (label_widget), 0, 0.5)
                end
	
feature -- Element change	
	
	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			a: ANY
		do
			if label_widget = Default_pointer then
				create_text_label (txt)	
			else
				a := txt.to_c
				gtk_label_set_text (label_widget, $a)
			end
		end
	
feature {EV_ANY_I} -- Implementation
	
	widget: POINTER is
		deferred
		end

feature {EV_PIXMAP_CONTAINER_IMP} -- Implementation
	
	box: POINTER
			-- Box inside the text container

feature {NONE} -- Implementation
	
	set_label_widget (new_label_widget: POINTER) is
			-- new pointer for label_widget 
		deferred
		end
	
	label_widget: POINTER is
			-- This has to be defined to be the actual 
			-- label widget
		deferred
		end

end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
