-- Command to display class routines.

class SHOW_ROUTINES 

inherit

	ROUTINE_FORM

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showroutines) 
		end;
	
feature {NONE}

	command_name: STRING is do Result := l_Showroutines end;

	title_part: STRING is do Result := l_Routines_of end;

	criterium (f: FEATURE_STONE): BOOLEAN is
		do
--			Result := not f.is_attribute
		end

end
