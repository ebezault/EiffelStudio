indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS
	
feature {NONE} -- Initialization

	initialize_constants is
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	cancel_button_text: STRING is "Cancel"
		-- `Result' is STRING constant named cancel_button_text.

	ok_button_text: STRING is "OK"
		-- `Result' is STRING constant named ok_button_text.

	default_button_width: INTEGER is 80
		-- `Result' is INTEGER constant named default_button_width.


feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN is
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	constant_by_name (a_name: STRING): STRING is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := clone (all_constants.item (a_name))
		ensure
			Result_not_void: Result /= Void
		end
		
	has_constant (a_name: STRING): BOOLEAN is
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN] is
			-- A cell to hold whether the constants have been loaded.
		once
			create Result
		end
		
	all_constants: HASH_TABLE [STRING, STRING] is
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING is "constants.txt"
		-- File name from which constants must be loaded.
		
	String_constant: STRING is "STRING"
	
	Integer_constant: STRING is "INTEGER"
		
	parse_file_contents (content: STRING) is
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.extend (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING is
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER		
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := clone (content)
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

invariant
	all_constants_not_void: all_constants /= Void

end -- class CONSTANTS
