note
	description: "[
		Notebook widget showing execution states and results.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_EXECUTION_WIDGET

inherit
	ES_TEST_RECORDS_TAB [TEST_EXECUTION_I]
		redefine
			record
		end

create
	make

feature {NONE} -- Access

	record (a_session: TEST_EXECUTION_I): TEST_EXECUTION_RECORD
			-- <Precursor>
		do
			Result := a_session.record
		end

feature {NONE} -- Factory

	create_grid_row (a_record: like record; a_row: EV_GRID_ROW): ES_TEST_RECORD_GRID_ROW [TEST_EXECUTION_I]
			-- <Precursor>
		do
			create {ES_TEST_EXECUTION_GRID_ROW} Result.make (a_record, a_row)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
