-- Command to display the short version of a class

class SHOW_SHORT

inherit

	FILTERABLE
		rename
			filter_context as short_context
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showshort 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showshort 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showshort end;

	title_part: STRING is do Result := l_Short_form_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display flat|short form of `c'.
		do
			text_window.process_text (short_context (c).text)
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Producing short form...")
		end;

end
