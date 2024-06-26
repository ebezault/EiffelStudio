﻿note

	description: "Error object sent by the compiler to the workbench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class ERROR_STONE

inherit
	FILED_STONE
		redefine
			help_text,
			is_storable
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make (e: ERROR)
		do
			error_i := e
		end

feature -- Properties

	error_i: ERROR
			-- Associated error.

	uuid: detachable READABLE_STRING_32
			-- Optional UUID specifying a documentation page with a description of the error/warning.
		do
			Result := error_i.help_uuid
		ensure
			is_uuid: attached Result implies {UUID}.is_valid_uuid (Result)
		end

feature -- Access

	code: STRING
			-- Error code.
		do
			Result := error_i.code
		end

	header: STRING_GENERAL
		do
			if attached code as l_code then
				Result := l_code
			else
				create {STRING_32} Result.make_empty
			end
		end

	is_storable: BOOLEAN
			-- Error stone are not kept.
		do
			Result := False
		end

	help_text: STRING_32
			-- Content of the file where the help is.
		do
			if attached origin_text as l_text and then not l_text.is_empty then
				Result := l_text
			else
				Result := Interface_names.h_No_help_available.twin
			end
		end

	history_name: STRING_32
		do
			create Result.make_from_string (interface_names.err_error)
			Result.append_string (header.as_string_32)
		end

	file_name: STRING_32
			-- File where the help is.
		do
			Result := eiffel_layout.error_path.extended (error_i.help_file_name).name
		end

	stone_signature: STRING_32 do Result := code end

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
		do
			Result := Cursors.cur_Interro
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone.
		do
			Result := Cursors.cur_X_interro
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
