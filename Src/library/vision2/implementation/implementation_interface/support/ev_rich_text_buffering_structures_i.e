indexing
	description: "[
		Objects that contain all structures required for buffering RTF for saving/loading/implementation.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_BUFFERING_STRUCTURES_I
	
inherit
	EV_RICH_TEXT_CONSTANTS_I
		export
			{NONE} all
		end
		
	EV_FONT_CONSTANTS
		export
			{NONE} all
		end
		
create
	set_rich_text

feature -- Status Setting

	set_rich_text (a_rich_text: EV_RICH_TEXT_I) is
			-- Assign `a_rich_text' to `rich_text' and initialize buffering structures.
		require
			a_rich_text_not_void: a_rich_text /= Void
		do
			rich_text := a_rich_text
			clear_structures
		end

	clear_structures is
			-- Clear all structures used for buffering into RTF format.
		do
				-- Rebuild structures used for buffering RTF.
			create start_formats.make (default_structure_size)
			create end_formats.make (default_structure_size)
			create formats.make (default_structure_size)
			create formats_index.make (default_structure_size)
			create heights.make (default_structure_size)
			create hashed_formats.make (default_structure_size)
			create format_offsets.make (default_structure_size)
			
				-- Rebuild structures used for optimizing contents of RTF.
				-- i.e. those that prevent repeated fonts and colors from being defined.
			create hashed_colors.make (default_structure_size)
			create color_offset.make (default_structure_size)
			create back_color_offset.make (default_structure_size)
			create hashed_fonts.make (default_structure_size)
			create font_offset.make (default_structure_size)

				-- Reset all other attributes used by buffering.			
			internal_text := ""
			internal_text.resize (default_string_size)
			is_current_format_underlined := False
			is_current_format_striked_through := False
			is_current_format_bold := False
			is_current_format_italic := False
			current_vertical_offset := 0
			color_text := color_table_start.twin
			font_text := font_table_start.twin
			font_count := 0
			color_count := 0
			buffered_text := ""
		end
		
	initialize_for_saving is
			-- Initialize `Current' for saving'.
		do
			clear_structures
		end

	append_text_for_rtf (a_text: STRING; a_format: EV_CHARACTER_FORMAT_I) is
			-- Append RTF representation of `a_text' with format `a_format' to `internal_text'
			-- and store information required from `a_format' ready for completion of buffering.
		local
			hashed_character_format: STRING
			temp_string: STRING
			format_index: INTEGER
			vertical_offset, counter: INTEGER
			character: CHARACTER
			format_underlined, format_striked, format_bold, format_italic: BOOLEAN
			height_in_half_points: INTEGER
		do
			hashed_character_format := a_format.interface.hash_value
			if not hashed_formats.has (hashed_character_format) then
				hashed_formats.put (a_format.interface, hashed_character_format)
				formats.extend (a_format.interface)
				heights.extend (pixels_to_half_points (a_format.height))
				format_offsets.put (hashed_formats.count, hashed_character_format)
			
				build_color_from_format (a_format)
				
				build_font_from_format (a_format)
			end

			format_index := format_offsets.item (hashed_character_format)
				
					-- Must clone otherwise we will always be modifying `highlight_string'.
			temp_string := highlight_string.twin
			temp_string.append (back_color_offset.i_th (format_index).out)
			temp_string.append (color_string)
			temp_string.append (color_offset.i_th (format_index).out)
			
			format_underlined := a_format.is_underlined
			if not is_current_format_underlined and format_underlined then
				temp_string.append (start_underline_string)
				is_current_format_underlined := True
			elseif is_current_format_underlined and not format_underlined then
				temp_string.append (end_underline_string)
				is_current_format_underlined := False
			end
			format_striked := a_format.is_striked_out
			if not is_current_format_striked_through and format_striked then
				temp_string.append (start_strikeout_string)
				is_current_format_striked_through := True
			elseif is_current_format_striked_through and not format_striked then
				temp_string.append (end_strikeout_string)
				is_current_format_striked_through := False
			end
			format_bold := a_format.is_bold
			if not is_current_format_bold and format_bold then
				temp_string.append (start_bold_string)
				is_current_format_bold := True
			elseif is_current_format_bold and not format_bold then
				temp_string.append (end_bold_string)
				is_current_format_bold := False
			end
			format_italic := a_format.shape = shape_italic
			if not is_current_format_italic and format_italic then
				temp_string.append (start_italic_string)
				is_current_format_italic := True
			elseif is_current_format_italic and not format_italic then
				temp_string.append (end_italic_string)
				is_current_format_italic := False
			end
			vertical_offset := a_format.vertical_offset
			if vertical_offset /= current_vertical_offset then
				temp_string.append (start_vertical_offset)
				height_in_half_points := (pixels_to_half_points (vertical_offset))
				temp_string.append (height_in_half_points.out)
				current_vertical_offset := vertical_offset
			end
			
			temp_string.append (font_string)
			temp_string.append (font_offset.i_th (format_index).out)
			temp_string.append (font_size_string)
			temp_string.append (heights.i_th (format_index).out)
			temp_string.append (space_string)
			internal_text.append (temp_string)
			from
				counter := 1
			until
				counter > a_text.count
			loop
				character := a_text.item (counter)
				if character = '%N' then
					internal_text.append (rtf_newline)
				elseif character = '\' then
					internal_text.append (rtf_backslash)
				elseif character = '{' then
					internal_text.append (rtf_open_brace)	
				elseif character = '}' then
					internal_text.append (rtf_close_brace)
				else
					internal_text.append_character (a_text.item (counter))
				end
				counter := counter + 1
			end
		end
		
	pixels_to_half_points (pixels: INTEGER): INTEGER is
			-- `Result' is pixels converted to half points, being
			-- the meaurement used for font sizes in RTF.
		do
			Result := (pixels * 72 // screen.vertical_resolution) * 2
		end
		
	generate_paragraph_information (a_text: STRING) is
			-- `Result' is index of first character of every line in `a_text' upon
			-- which the paragraph formatting changes, as determined by '%N'.
		require
			text_not_void: a_text /= Void
		local
			counter: INTEGER
		do
			create paragraph_start_indexes.make (50)
			create paragraph_formats.make (50)

				-- Add the first line which is always 1.
			paragraph_start_indexes.extend (1)
			
			build_paragraph_from_format (rich_text.internal_paragraph_format (1))
				-- Now iterate `a_string' and determine each line as determined by `%N'.
			from
				counter := 1
			until
				counter > a_text.count
			loop
				if a_text.item (counter).is_equal ('%N') then
				if not rich_text.internal_paragraph_format_contiguous (counter, counter + 2) then
						-- Note that we checked "counter + 2" as we find the %N that signifies a new line, and then
						-- we must add one to convert to caret positions, and one to check that we are checking the first character
						-- of the next line (past the %N) to determine if the format changed.
					paragraph_start_indexes.extend (counter + 1)
					build_paragraph_from_format (rich_text.internal_paragraph_format (counter + 1))
				end
				end
				counter := counter + 1
			end
		ensure
			start_indexes_not_void: paragraph_start_indexes /= Void
			formats_not_void: paragraph_formats /= Void
			count_greater_or_equal_to_one: paragraph_start_indexes.count >= 1
			counts_equal: paragraph_start_indexes.count = paragraph_formats.count
		end
		
	set_with_rtf (rtf_text: STRING) is
			-- Set `text' and formatting of `Current' from `rtf_text' in RTF format.
		local
			current_character: CHARACTER
		do
			create format_stack.make (8)
			create current_format
			plain_text := ""
			from
				main_iterator := 1
			until
				main_iterator > rtf_text.count
			loop
				current_character := get_character (rtf_text, main_iterator)
				if current_character = '{' then
						-- Store state on stack
					format_stack.extend (current_format.twin)
				elseif current_character = '}' then
						-- retrieve state from stack.
					current_format := format_stack.item
					format_stack.remove
				elseif current_character = '\' then
					process_keyword (rtf_text, main_iterator)
				elseif current_character = ' '  then
					process_text (rtf_text, main_iterator)
				elseif rtf_text.item (main_iterator - 1) = '%N' or rtf_text.item (main_iterator - 1) = '}' then
						-- We are now one character past the tag for the text. This may occur when a keyword
						-- is ended with a '%N' or we have just skipped a bracket section that contained the "\*"
						-- keyword. As in this case, `current_character' is the start of the text, call `process_text'
						-- from the previous position, as the first index is ignored.
					process_text (rtf_text, main_iterator - 1)
				end
				move_main_iterator (1)
					-- Move the iterator by one. This may or may not be required
					-- if other routines have just called it within this loop.
				
				update_main_iterator
			end
			check
				no_carriage_returns: not plain_text.has ('%R')
			end
			rich_text.set_text (plain_text)
		end
		
	process_text (rtf_text:STRING; index: INTEGER) is
			-- Process RTF string `rtf_text' for text data from `index' until
			-- text is exhausted signified through encountering a control character.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (index)
		local
			l_index: INTEGER
			text_completed: BOOLEAN
			current_text: STRING
			current_character: CHARACTER
		do
			current_text := ""
			from
				l_index := 1
			until
				text_completed
			loop
				current_character := get_character (rtf_text, l_index + index)
				if current_character /= '%N' and current_character /= '%R' then
						-- New line characters have no effect on the RTF contents, so
						-- simply ignore these characters.
					if current_character = '\' or current_character = '}' or current_character = '{' then
						text_completed := True
					end
					if not text_completed then
						current_text.append_character (current_character)
					end
				end
				l_index := l_index + 1
			end
			plain_text.append (current_text)
			
			--| FIXME should this ever be empty?
			if current_text.count > 0 then
				move_main_iterator (current_text.count)
			end
		end
	
	get_character (rtf_text: STRING; index: INTEGER): CHARACTER is
			-- `Result' is character `index' within `rtf_text'.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (index)
		do
			Result := rtf_text.item (index)
		ensure
			Result_not_void: Result /= Void
		end
		
	process_keyword  (rtf_text: STRING; index: INTEGER) is
			-- Process RTF string `rtf_text' for a keyword starting at position `index'
			-- until a rtf character is received signifying the end of the keyword.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (index)
		local
			l_index: INTEGER
			current_character: CHARACTER
			tag: STRING
			tag_value: STRING
			performed_one_iteration: BOOLEAN
			tag_completed: BOOLEAN
			reading_tag_value: BOOLEAN
			tag_start_position: INTEGER
		do
			tag_start_position := index
			tag := ""
			tag_value := ""
				-- Set to space as default.
			current_character := ' '
			from
				l_index := 1
			until
				tag_completed
			loop
				current_character := get_character (rtf_text, l_index + index)
				
				if (current_character = ' ' or
					current_character = '\' or
					current_character = '}' or
					current_character = '{') or
					current_character = '%N' or
					current_character = '%R' then
					
						-- Note that newline characters are not permitted in the middle of tags.
						-- We must perform at least one iteration, ensuring that we enter the loop.
					if performed_one_iteration = True then
							-- Flag the tag as completed so the loop is exited.
							-- This is only set once the tag value has also been read.
						tag_completed := True
					end
				elseif current_character.is_digit then
						-- We have found a digit which signifies the end of the tag, but
						-- the start of the tag value. Not all tags have an INTEGER value.
					reading_tag_value := True
				end
				if not tag_completed then
					if current_character /= '%N' then
						if not reading_tag_value then
								-- If still reading the tag, add the current character.
							tag.append_character (current_character)
						else
								-- If now reading the tags value, add the current character.
							tag_value.append_character (current_character)
						end
						performed_one_iteration := True
					end
					l_index := l_index + 1
				end
			end
			--print ("Tag : " + tag.out + " Value : " + tag_value + "%N")
				-- Now process the found keyword.
			if tag.is_equal (rtf_fonttable) then
			elseif tag.is_equal (rtf_colortbl) then
			elseif tag.is_equal (rtf_bold) then
			elseif tag.is_equal (rtf_highlight) then
			elseif tag.is_equal (rtf_color) then
			elseif tag.is_equal (rtf_font) then
			elseif tag.is_equal (rtf_font_size) then
			elseif tag.is_equal (rtf_new_line) then
				plain_text.append_character ('%N')
			elseif tag.is_equal (rtf_user_props) then
				check
					is_start_of_group: rtf_text.substring (tag_start_position - 1, tag_start_position + 1).is_equal ("{\*")
				end
				move_to_end_of_tag (rtf_text, tag_start_position - 1)
			else
				--print ("Unhandled tag : " + tag.out + "%N")
			end	
			
			move_main_iterator (tag.count + tag_value.count + 1)
		end
		
		
	move_to_end_of_tag (rtf_text: STRING; start_index: INTEGER) is
			-- Move `main_iterator' to the next character immediately following the closing brace
			-- associated with the opening brace at `start_index' within RTF text `rtf_text'
			-- This includes the depth of the brace, and will find the brace pair, not just the next closing brace.
		require
			rtf_text_not_void: rtf_text /= Void
			valid_index: rtf_text.valid_index (start_index)
			index_points_to_start_tag: rtf_text.item (start_index) = '{'
		local
			l_index: INTEGER
			depth: INTEGER
			current_character: CHARACTER
		do
			depth := 1
			from
				l_index := 1
			until
					-- We go one down from the starting position, as we do not include
					-- the first brace in the searched characters.
				depth = 0
			loop
				current_character := get_character (rtf_text, start_index + l_index)
				if current_character.is_equal (rtf_open_brace_character) then
					depth := depth + 1
				elseif current_character.is_equal (rtf_close_brace_character) then
					depth := depth - 1
				end
				if depth /= 0 then
					l_index := l_index + 1
				end
			end
			move_main_iterator (l_index)
		end
		
	current_format: RTF_FORMAT_I
		-- The current format retrieved from the RTF.
		
	format_stack: ARRAYED_STACK [RTF_FORMAT_I]
		-- A stack to hold current formatting for RTF being loaded.
		-- Each set of formatting contained within braces is only local to those braces,
		-- so we pop and push the current formats from the stack as we enter and leave braces.
		
	main_iterator: INTEGER
		-- The index currently iterated within the RTF file that is being loaded.
		-- This must be accessible to `move_main_iterator'.
		
	temp_iterator: INTEGER
		-- A temporary value used by `move_main_iterator' to ensure that multiple calls to
		-- move forwards do not move backwards. For exampel
	
	plain_text: STRING
		-- A string representation of the contents of from the last
		-- RTF file loaded.
		
	update_main_iterator is
			-- Ensure `main_iterator' takes the value of `temp_iterator'.
		do
			main_iterator := temp_iterator
		ensure
			main_iterator_set: main_iterator = temp_iterator
		end

	move_main_iterator (step: INTEGER) is
			-- Ensure `main_iterator' is moved `step' characters next time `update_main_iterator' is called.
			-- Each call will not move the iterator back to less than one of the previous calls
			-- as enforced by the value of `temp_iterator'.
			-- i.e. calling `move_main_iterator three times with 5, 12, and 2 as arguments, ensures that
			-- next time `update_main_iterator' is called it will increase by 12.
		require
			step_positive: step > 0
		do
			if main_iterator + step > temp_iterator then
				temp_iterator := main_iterator + step
			end
		ensure
			temp_iterator_moved_forwards: temp_iterator >= old temp_iterator
		end

feature -- Access

	rich_text: EV_RICH_TEXT_I
			-- Rich text associated with `Current'.

	internal_text: STRING
			-- Text used for building RTF strings internally before buffering or saving.

feature {EV_ANY_I} -- Implementation			

	generate_complete_rtf_from_buffering is
			-- Generate the rtf heading for buffered operations into `internal_text'.
			-- Current contents of `internal_text' are lost.
		local
			internal_text_twin: STRING
		do
				-- `font_text' contents is generated by each call to `buffered_append',
				-- so simply close the tag.
			font_text.append ("}")

				-- `color_text' contents is generated by each call to `buffered_append',
				-- so simply close the tag.
			color_text.append ("}")
			
			internal_text_twin := internal_text.twin
			internal_text := font_text.twin
			internal_text.append ("%R%N")
			internal_text.append (color_text)
			internal_text.append ("%R%N")
			internal_text.append (internal_text_twin)
			internal_text.append ("}")
		end
		
feature {NONE} -- Implementation

	build_paragraph_from_format (a_format: EV_PARAGRAPH_FORMAT) is
			-- Add RTF representation of `a_format' to `paragraph_formats' is
		require
			formats_not_void: paragraph_formats /= Void
		local
			format: STRING
		do
			format := new_paragraph.twin
			if a_format.is_left_aligned then
				format.append (paragraph_left_aligned)
			elseif a_format.is_center_aligned then
				format.append (paragraph_center_aligned)
			elseif a_format.is_right_aligned then
				format.append (paragraph_right_aligned)
			elseif a_format.is_justified then
				format.append (paragraph_justified)
			end
			if a_format.left_margin /= 0 then
				format.append (paragraph_left_indent)
				format.append (pixels_to_half_points (a_format.left_margin * 10).out)
			end
			if a_format.right_margin /= 0 then
				format.append (paragraph_right_indent)
				format.append (pixels_to_half_points (a_format.right_margin * 10).out)
			end
			if a_format.top_spacing /= 0 then
				format.append (paragraph_space_before)
				format.append (pixels_to_half_points (a_format.top_spacing * 10).out)
			end
			if a_format.bottom_spacing /= 0 then
				format.append (paragraph_space_after)
				format.append (pixels_to_half_points (a_format.bottom_spacing * 10).out)
			end
			format.append_character (' ')
			paragraph_formats.extend (format)
		ensure
			formats_count_increased: paragraph_formats.count = old paragraph_formats.count + 1
		end
		

	build_font_from_format (a_format: EV_CHARACTER_FORMAT_I) is
			-- Update font text `font_text' for addition of a new format to the buffering.
		local
			current_family: INTEGER
			family: STRING
			temp_string: STRING
		do
			current_family := a_format.family
			inspect current_family
			when family_screen then 
				family := rtf_family_tech
			when family_roman then 
				family := rtf_family_roman
			when family_sans then 
				family := rtf_family_swiss
			when family_typewriter then 
				family := rtf_family_script
			when family_modern then 
				family := rtf_family_modern
			else
				family := rtf_family_nill
			end
			temp_string := "\"
			temp_string.append (family)
			temp_string.append ("\fcharset")
			temp_string.append (a_format.char_set.out)
			temp_string.append (space_string)
			temp_string.append (a_format.name)
			hashed_fonts.search (temp_string)
			if not hashed_fonts.found then
				font_count := font_count + 1
				hashed_fonts.put (font_count, temp_string)
				font_offset.force (hashed_fonts.found_item)
				font_text.append ("{\f")
				font_text.append (font_count.out)
				font_text.append (temp_string)
				font_text.append ("}")
			else
				font_offset.force (hashed_fonts.item (temp_string))
			end
		end
		
		
	build_color_from_format (a_format: EV_CHARACTER_FORMAT_I) is
			-- Update color text `color_text' for addition of a new format to the buffering.
		local
			l_color: INTEGER
			hashed_color, hashed_back_color: STRING
			red, green, blue: INTEGER
		do
			l_color := a_format.fcolor
			hashed_color := rtf_red.twin
			red := l_color & 0x000000ff
			l_color := l_color |>> 8
			green := l_color & 0x000000ff
			l_color := l_color |>> 8
			blue := l_color & 0x000000ff
			hashed_color.append (red.out)
			hashed_color.append (rtf_green.twin)
			hashed_color.append (green.out)
			hashed_color.append (rtf_blue.twin)
			hashed_color.append (blue.out)
			hashed_color.append_character (';')


			hashed_colors.search (hashed_color)
				-- If the color does not already exist.
			if not hashed_colors.found then
					-- Add the color to `colors' for later retrieval.
				color_count := color_count + 1
				hashed_colors.put (color_count, hashed_color)
					-- Store the offset from the character index to the new color index for retrieval.
				color_offset.force (hashed_colors.found_item)
				color_text.append (hashed_color)
			else
				color_offset.force (hashed_colors.item (hashed_color))
			end
			
			l_color := a_format.bcolor
			hashed_back_color := rtf_red.twin
			red := l_color & 0x000000ff
			l_color := l_color |>> 8
			green := l_color & 0x000000ff
			l_color := l_color |>> 8
			blue := l_color & 0x000000ff
			hashed_back_color.append (red.out)
			hashed_back_color.append (rtf_green.twin)
			hashed_back_color.append (green.out)
			hashed_back_color.append (rtf_blue.twin)
			hashed_back_color.append (blue.out)
			hashed_back_color.append_character (';')

			hashed_colors.search (hashed_back_color)
				-- If the color does not already exist.
			if not hashed_colors.found then
				-- Add the color to `colors' for later retrieval.
				color_count := color_count + 1
				hashed_colors.put (color_count, hashed_back_color)
					-- Store the offset from the character index to the new color index for retrieval.
				back_color_offset.force (hashed_colors.found_item)
				color_text.append (hashed_back_color)
			else
				back_color_offset.force (hashed_colors.item (hashed_back_color))
			end
		end
		
feature {EV_ANY_I} -- Implementation

	paragraph_start_indexes: ARRAYED_LIST [INTEGER]
		-- Indexes of every paragraph format change in a document in order.
		-- Call `generate_paragraph_information' to fill.
		
	paragraph_formats: ARRAYED_LIST [STRING]
		-- A string representation of Each paragraph change found in
		-- `paragraph_start_indexes'. Call `generate_paragraph_information' to fill.
			
feature {NONE} -- Implementation

	default_structure_size: INTEGER is 20
		-- Default size used to initalize all buffering structures.

	default_string_size: INTEGER is 50000
		-- Default size used for all internal strings for buffering.
		-- This reduces the need to resize the string as the formatting is applied.
		-- Resizing strings can be slow, so is to be avoided wherever possible.

	-- `hashed_formats', `format_offsets' and `color_offsets' are only used in the
	-- buffered append operations, while the other lists and hash tables are used
	-- in the buffered formatting operations.

	hashed_formats: HASH_TABLE [EV_CHARACTER_FORMAT, STRING]
			-- A list of all character formats to be applied to buffering, accessible
			-- through `hash_value' of EV_CHARACTER_FORMAT. This ensures that repeated formats
			-- are not stored multiple times.
		
	format_offsets: HASH_TABLE [INTEGER, STRING]
			-- The index of each format in `hashed_formats' within the RTF document that must be generated.
			-- For each set of formatting that must be applied, a reference to the format in the document
			-- must be specified, and this table holds the appropriate offset of that formatting.

	buffered_text: STRING
		-- Internal representation of `text' used only when flushing the buffers. Prevents the need
		-- to stream the contents of `current', every time that the `text' is needed.
		
	lowest_buffered_value, highest_buffered_value: INTEGER
		-- Used when applying a buffered format, these values represent the lowest and highest character indexes
		-- that have been buffered. This allows implementations to only stream between these indexes if possible.
		
	formats: ARRAYED_LIST [EV_CHARACTER_FORMAT]
			-- All character formats used in `Current'.
		
	heights: ARRAYED_LIST [INTEGER]
			-- All heights of formats used in `Current', corresponding to contents of `forrmats'.

	formats_index: HASH_TABLE [INTEGER, INTEGER]
			-- The index of each format relative to a paticular character index. This permits the correct
			-- format to be looked up when the start positions of the formats are traversed.

	start_formats: HASH_TABLE [STRING, INTEGER]
			-- The format type applicable at a paticular character position. The `item' is used to look up the
			-- character format from `hashed_formats'.

	end_formats: HASH_TABLE [STRING, INTEGER]
			-- The format type applicable at a paticular character position. The integer represents the index of the
			-- closing caret index.

			-- These attributes are used to stop multiple versions of the same color being
			-- generated in the RTF.

	hashed_colors: HASH_TABLE [INTEGER, STRING]
			-- All colors currently stored for buffering, accessible via the
			-- actual RTF output, in the form ";\red255\green0\blue0". The integer `item'
			-- corresponds to the offset of the color in `colors'.
		
	color_offset: ARRAYED_LIST [INTEGER]
			-- All color indexes to use for foreground colors in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the color offset to use from
			-- the color table for the 20th character format.
		
	back_color_offset: ARRAYED_LIST [INTEGER]
			-- All color indexes to use for background colors in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the color offset to use from
			-- the color table for the 20th character format.
			
	color_count: INTEGER
		-- Number of colors currently buffered.		
	
	color_text: STRING
		-- The RTF string correponding to all colors in the document.
		
			-- These attributes are used to stop multiple versions of the same font being
			-- generate in the RTF.
			
	hashed_fonts: HASH_TABLE [INTEGER, STRING]
			-- All fonts currently stored for buffering, accessible via the
			-- actual RTF output, in the form "\froman\fcharset0 System". The integer `item'
			-- corresponds to the offset of the font in `fonts'.
	
	font_offset: ARRAYED_LIST [INTEGER]
			-- All font indexes  in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the font offset to use from
			-- the font table for the 20th character format.
	
	font_count: INTEGER
		-- Number of fonts currently buffered.
	
	font_text:STRING
		-- The RTF string corresponding to all fonts in the document.
		
	is_current_format_underlined: BOOLEAN
	is_current_format_striked_through: BOOLEAN
	is_current_format_bold: BOOLEAN
	is_current_format_italic: BOOLEAN
	current_vertical_offset: INTEGER
		-- Booleans used to determine current formatting. These are used to prevent
		-- repeatedly opening the same tags each time a new format is encountered.
		
	screen: EV_SCREEN is
			-- Once acces to EV_SCREEN object.
		once
			create Result
		end
		
invariant
	rich_text_not_void: rich_text /= Void

end -- class EV_RICH_TEXT_BUFFERING_STRUCTURES_I
