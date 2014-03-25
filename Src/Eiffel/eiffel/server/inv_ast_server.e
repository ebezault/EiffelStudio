note
	description: "Server for abstract syntax description of invariant indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INV_AST_SERVER

inherit
	READ_SERVER [INVARIANT_AS]
		redefine
			has, item, remove
		end

create
	make

feature

	cache: CACHE [INVARIANT_AS]
			-- Cache for routine tables
		once
			create Result.make
		end

	has (an_id: INTEGER): BOOLEAN
			-- Is the id `an_id' present either in Current or in
			-- `Tmp_inv_ast_server' ?
		do
			Result := Tmp_ast_server.invariant_has (an_id) or else Precursor (an_id)
		end

	item (an_id: INTEGER): detachable INVARIANT_AS
			-- Invariant of class of id `an_id'. Look for it first in
			-- the associated temporary server
	   do
			Result := Tmp_ast_server.invariant_item (an_id)
			if Result = Void then
				Result := Precursor (an_id)
			end
		end

	remove (an_id: INTEGER_32)
			-- <Precursor>
		do
			tmp_ast_server.invariant_remove (an_id)
			Precursor (an_id)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
