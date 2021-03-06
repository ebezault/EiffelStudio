﻿note
	description: "Keeper for non-void entity scopes that uses stacks to track voidness status."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_STACKED_SCOPE_KEEPER [G]

inherit
	AST_SCOPE_KEEPER

feature {NONE} -- Creation

	make (n: like count)
			-- Create storage to keep at least `n' variables.
		require
			non_negative_n: n >= 0
			n_small_enough: n <= max_count
		do
			scope := new_scope (n)
			create {ARRAYED_STACK [like scope]} outer_scopes.make (1)
			create {ARRAYED_STACK [like scope]} inner_scopes.make (1)
			count := n
		ensure
			count_set: count = n
		end

feature -- Status report: nesting

	nesting_level: INTEGER
			-- Current nesting level of a compound
		do
			Result := outer_scopes.count
		end

feature {AST_CONTEXT} -- Status report

	is_sibling_dominating: BOOLEAN
			-- <Precursor>
		do
			if has_siblings then
					-- Compare siblings.
				Result := is_dominating
			end
		end

feature {NONE} -- Status report

	is_dominating: BOOLEAN
			-- Does variable information of a sibling dominate the previous one?
		require
			is_nested: nesting_level > 0
			has_siblings: has_siblings
		deferred
		end

feature {AST_CONTEXT} -- Modification: nesting

	enter_realm
			-- Enter a new complex instruction
			-- with inner compound parts.
		do
				-- Record current scope information.
			outer_scopes.extend (scope)
				-- Start new scope from the state of an outer one.
			scope := duplicate (scope)
				-- Reserve stack for sibling information.
			inner_scopes.extend (({like scope}).default)
		ensure then
			not_has_siblings: not has_siblings
			not_is_sibling_dominating: not is_sibling_dominating
		end

	update_realm
			-- Update realm scope information
			-- from the current state.
		do
			outer_scopes.replace (duplicate (scope))
		end

	save_sibling
			-- Save scope information of a sibling in a complex instrution and restart recording using the outer scope.
			-- For example, Then_part of Elseif condition.
		do
			if has_siblings then
					-- Merge sibling scope information.
				merge_siblings
			else
					-- Record new sibling scope information.
				inner_scopes.replace (duplicate (scope))
			end
				-- Start new scope from the state of an outer one.
			scope := duplicate (outer_scopes.item)
		ensure then
			has_siblings: has_siblings
		end

	update_sibling
			-- Update scope information of a sibling in a complex instrution and reuse it for the current scope.
			-- For example, Loop body.
		do
			if has_siblings then
					-- Merge sibling scope information.
				merge_siblings
			else
					-- Record new sibling scope information.
				inner_scopes.replace (duplicate (scope))
			end
				-- Start new scope from the state of an updated inner one.
			scope := duplicate (inner_scopes.item)
		ensure then
			has_siblings: has_siblings
		end

feature {AST_CONTEXT, AST_VISITOR} -- Modification: nesting

	leave_realm
			-- Leave a complex instruction and
			-- promote scope information to the outer compound.
		do
			if has_siblings and then attached inner_scopes.item as i then
					-- Promote nested scope information to the outer level.
				scope := i
			end
				-- Remove inner scope information.
			inner_scopes.remove
				-- Remove outer scope information and use the latest one.
			outer_scopes.remove
		end

	leave_optional_realm
			-- Leave a complex instruction and
			-- discard its scope information.
			-- For example, Debug instruction.
		do
				-- Remove inner scope information.
			inner_scopes.remove
				-- Restore original scope information.
			scope := outer_scopes.item
				-- Remove outer scope information.
			outer_scopes.remove
		end

feature {NONE} -- Modification: nesting

	merge_siblings
			-- Merge sibling scope information from `scope'
			-- into `inner_scopes.item'.
		require
			has_siblings: has_siblings
		deferred
		end

feature {NONE} -- Status report

	has_siblings: BOOLEAN
			-- Are there any siblings in the current instruction?
		do
			Result := inner_scopes.item /= ({like scope}).default
		end

feature {NONE} -- Storage

	scope: G
			-- Current void-safe status of a local
			-- with True indicating non-void value and
			-- False indicating possibly void value

	outer_scopes: STACK [like scope]
			-- Outer scopes

	inner_scopes: STACK [detachable like scope]
			-- Inner scopes

feature {NONE} -- Initialization

	new_scope (n: like count): like scope
			-- New scope that can track attachment status of `n' variables.
		deferred
		ensure
			result_attached: Result /= Void
			result_not_default: Result /= ({like scope}).default
		end

feature {NONE} -- Duplication

	duplicate (s: like scope): like scope
			-- A duplicate of a scope `s'
		require
			s_attached: s /= Void
		do
			Result := s.twin
		ensure
			result_attached: Result /= Void
			result_set: Result ~ s
		end

invariant

	scope_attached: scope /= Void
	outer_scopes_attached: outer_scopes /= Void
	inner_scopes_attached: inner_scopes /= Void
	same_level: outer_scopes.count = inner_scopes.count

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
