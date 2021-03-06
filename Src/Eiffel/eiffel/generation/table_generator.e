﻿note
	description: "[
		Description of a generator of table: the aim of this is the split
		of the routine/attribute offset table generation into several files
		because the C compilers don't support too heavy files of static
		declarations
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TABLE_GENERATOR

inherit
	SHARED_CODE_FILES
	SHARED_BYTE_CONTEXT
	SHARED_GENERATION
	SHARED_WORKBENCH
	SYSTEM_CONSTANTS

feature -- Initialization

	init (buffer: GENERATION_BUFFER)
			-- Initialization
		do
			current_buffer := buffer
			current_buffer.clear_all
				-- Start C code generation for next block
			current_buffer.start_c_specific_code
		end

feature -- Modification

	reset_counter
			-- Reset file counter for all tables.
		do
			file_counter_cell.put (1)
		ensure
			file_counter_set: file_counter = 1
		end

feature -- Access

	file_counter: INTEGER
			-- Count of generated files.
		do
			Result := file_counter_cell.item
		end

	size: INTEGER;
			-- Estimation of the size of the current generated file

	current_buffer: GENERATION_BUFFER;
			-- Current buffer

	postfix_file_name: STRING
			-- Postfix string for file names;
		deferred
		end;

	Size_limit: INTEGER = 10000;
			-- Limit of size for each generated file

	new_file: INDENT_FILE
			-- New file for generation
		local
			temp: STRING
			n, packet_number: INTEGER
		do
			temp := Epoly.twin
			n := file_counter
			temp.append_integer (n);
			packet_number := n // System.makefile_generator.System_packet_number + 2
			create Result.make_c_code_file (final_file_name (temp, postfix_file_name, packet_number))
		end;

	init_file (file: INDENT_FILE)
			-- Initialization of new file
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
			current_buffer_not_void: current_buffer /= Void
		deferred
		end; -- init_file

	update_size (value: INTEGER)
			-- Prepare `current_buffer' for writing a table with `value' number of entries.
		require
			value_not_negative: value >= 0
		do
			update
			size := size + value
		end

	update
			-- Update current file
		do
			if size > Size_limit then
				size := 0;
				finish
			end;
		end;

	finish
			-- Close `current_buffer'.
		require
			current_buffer_exists: current_buffer /= Void;
		local
			file: INDENT_FILE
		do
			file := new_file
			init_file (file)
			current_buffer.put_in_file (file)
			finish_file
			file.close
			increment_file_counter
		end;

	finish_file
			-- finish generation of `current_buffer'.
		require
			current_buffer_not_void: current_buffer /= Void
		do
				-- Clear buffer for Current generation
			current_buffer.clear_all

				-- Start C code generation
			current_buffer.start_c_specific_code
		end;

feature -- Settings

	increment_file_counter
			-- Increment `file_counter' from 1.
		do
			file_counter_cell.put (file_counter + 1)
		ensure
			file_counter_incremented: file_counter = (old file_counter + 1)
		end

feature {NONE} -- Implementation

	file_counter_cell: CELL [INTEGER]
			-- Shared value for file name generation in final mode only.
		once
			create Result.put (0)
		ensure
			file_counter_cell_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
