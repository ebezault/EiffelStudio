note
	description: "[
		The ecosystem's default implementation for the {CODE_ANALYZER_S} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ANALYZER_VIOLATION_CURSOR

inherit
	ITERATION_CURSOR [CA_RULE_VIOLATION]

create
	make

feature {NONE} -- Creation.

	make (violations: like {CA_CODE_ANALYZER}.rule_violations)
			-- Initialize cursor with data from `collection`.
		do
			outer_cursor := violations.new_cursor
			if not outer_cursor.after then
				inner_cursor := outer_cursor.item.new_cursor
			end
		end

feature -- Access

	item: CA_RULE_VIOLATION
			-- <Precursor>
		do
			check
				from_precondition: attached inner_cursor as c
			then
				Result := c.item
			end
		end

feature -- Status report	

	after: BOOLEAN
			-- <Precursor>
		do
			Result := attached inner_cursor as c implies c.after
		ensure then
			false_definition: not Result implies (attached inner_cursor as c and then not c.after)
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			check
				inner_cursor_attached_from_precondition: attached inner_cursor as c
			then
				check
					inner_cursor_not_after_from_precondition: not c.after
				end
				c.forth
				if c.after then
					check
						outer_cursor_not_after_from_precondition: not outer_cursor.after
					end
					outer_cursor.forth
					if outer_cursor.after then
						inner_cursor := Void
					end
				end
			end
		end

feature {NONE} -- Implementation: Internal cache

	outer_cursor: like {CA_CODE_ANALYZER}.rule_violations.new_cursor
			-- Outer cursor.

	inner_cursor: detachable like {CA_CODE_ANALYZER}.rule_violations.new_cursor.item.new_cursor
			-- Inner cursor.

invariant

	consistent_cursors: outer_cursor.after /= attached inner_cursor

note
	copyright: "Copyright (c) 2017, Eiffel Software"
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
