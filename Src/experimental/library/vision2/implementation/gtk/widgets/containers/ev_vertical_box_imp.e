﻿note
	description:
		"EiffelVision vertical box. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_BOX_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a GTK vertical box.
		do
			assign_interface (an_interface)
		end

	make
		do
			set_c_object ({GTK}.gtk_vbox_new (Default_homogeneous, Default_spacing))
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

    interface: detachable EV_VERTICAL_BOX note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_VERTICAL_BOX_IMP
