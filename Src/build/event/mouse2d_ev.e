
class MOUSE2D_EV 

inherit

	EV_IDENTIFIERS
		export
			{NONE} all
		end;

	EVENT
		;

	EV_PIXMAPS
		export
			{NONE} all
		end;

	EVENT_LABELS
		export
			{NONE} all
		end


creation

	make

	
feature 

	identifier: INTEGER is
		do
			Result := - mouse2d_ev_id
		end;

	make is
		do
			set_symbol (Mouse2d_pixmap);
			set_label (Mouse2d_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_press_action (2, ";

end
