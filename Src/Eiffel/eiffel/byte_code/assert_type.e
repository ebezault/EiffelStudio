﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ASSERT_TYPE

feature -- Access

	In_precondition: INTEGER = 1
			-- Assertion is a precondition.

	In_postcondition: INTEGER = 2
			-- Assertion is a postcondition.

	In_check: INTEGER = 3
			-- Assertion is a check.

	In_guard: INTEGER = 4
			-- Assertion is a guard.

	In_loop_invariant: INTEGER = 5
			-- Assertion in a loop.

	In_loop_variant: INTEGER = 6
			-- Variant in a loop.

	In_invariant: INTEGER = 7
			-- Class invariant.

	is_assertion (t: INTEGER): BOOLEAN
		do
			inspect t
			when
				In_precondition,
				In_postcondition,
				In_check,
				In_guard,
				In_loop_invariant,
				In_loop_variant,
				In_invariant
			then
				Result := True
			else
					-- False otherwise.
			end
		ensure
			instance_free: class
			definition: Result = (<<
				in_precondition,
				in_postcondition,
				in_check,
				in_guard,
				in_loop_invariant,
				in_loop_variant,
				in_invariant
			>>).has (t)
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
