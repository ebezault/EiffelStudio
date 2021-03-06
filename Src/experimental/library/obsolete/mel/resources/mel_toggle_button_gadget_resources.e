note

	description: 
		"Toggle Button Gadget resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON_GADGET_RESOURCES

feature -- Implementation

	XmNfillOnSelect: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNfillOnSelect"
		end;

	XmNindicatorOn: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNindicatorOn"
		end;

	XmNindicatorSize: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNindicatorSize"
		end;

	XmNindicatorType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNindicatorType"
		end;

	XmNselectColor: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNselectColor"
		end;

	XmNselectInsensitivePixmap: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNselectInsensitivePixmap"
		end;

	XmNselectPixmap: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNselectPixmap"
		end;

	XmNset: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNset"
		end;

	XmNspacing: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNspacing"
		end;

	XmNvisibleWhenOff: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNvisibleWhenOff"
		end;

	XmNarmCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNarmCallback"
		end;

	XmNdisarmCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNdisarmCallback"
		end;

	XmNvalueChangedCallback: POINTER
			-- Motif resource
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_POINTER"
		alias
			"XmNvalueChangedCallback"
		end;

	XmN_OF_MANY: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_INTEGER"
		alias
			"XmN_OF_MANY"
		end;

	XmONE_OF_MANY: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/ToggleBG.h>]: EIF_INTEGER"
		alias
			"XmONE_OF_MANY"
		end;

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




end -- class MEL_TOGGLE_BUTTON_GADGET_RESOURCES


