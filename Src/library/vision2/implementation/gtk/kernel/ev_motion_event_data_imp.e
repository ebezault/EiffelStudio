indexing
	description: "EiffelVision motion event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MOTION_EVENT_DATA_IMP
	
inherit
	EV_MOTION_EVENT_DATA_I
		select
			interface
		end
		
	EV_EVENT_DATA_IMP
		rename
			interface as x_interface
		redefine
			initialize
		end
	
	
creation
	make
	
feature -- Initialization
	
	initialize (p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		do
			Precursor (p)			
			interface.set_x (c_gdk_event_x (p))
			interface.set_y (c_gdk_event_y (p))
			interface.set_state (c_gdk_event_state (p))
		end
	
	
feature {NONE} -- Implementation
	
	
	c_gdk_event_x  (p: POINTER): DOUBLE is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end
	
	c_gdk_event_y (p: POINTER): DOUBLE is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_state (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
end
			
	
