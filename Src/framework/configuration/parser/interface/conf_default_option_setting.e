note
	description: "Global flag that specifies what is the default value of options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_DEFAULT_OPTION_SETTING

feature -- Access

	is_63_compatible: BOOLEAN
			-- Are default options initialized in 6.3 or older compatibility mode?
		do
			Result := is_63_compatible_cell.item
		end

feature -- Setting

	set_is_63_compatible (v: like is_63_compatible)
			-- Set `is_63_compatible' with `v'.
		do
			is_63_compatible_cell.put (v)
		ensure
			set: is_63_compatible = v
		end

feature {NONE} -- Implementation

	is_63_compatible_cell: CELL [BOOLEAN]
			-- Storage for `is_63_compatible'.
		once
				-- By default we are not 6.3 compatible.
			create Result.put (False)
		ensure
			is_63_compatible_cell_not_void: Result /= Void
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
