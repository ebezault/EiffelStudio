indexing

	description: 
		"Ace syntax stone.";
	date: "$Date$";
	revision: "$Revision $"

class ACE_SYNTAX_STONE

inherit

	SYNTAX_STONE
		redefine
			stone_type, stone_name, stone_cursor,
			process
		end;
	INTERFACE_W

creation

	make

feature -- Access

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with
			-- Current stone during transport.
		do
			Result := cur_System
		end;

	stone_type: INTEGER is 
		do 
			Result := System_type 
		end;

	stone_name: STRING is 
		do 
			Result := l_System 
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_ace_syntax (Current)
		end;

end -- class ACE_SYNTAX_STONE
