
class MOUSE_ENTER_EV 

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
			Result := - mouse_enter_ev_id
		end;

	make is
		do
			set_symbol (Mouse_Enter_pixmap);
			set_label (Mouse_Enter_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_enter_action (";	

end
