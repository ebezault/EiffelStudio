﻿note
	description: "Object to generate feature local variable domains used in Eiffel query language."

class
	QL_LOCAL_DOMAIN_GENERATOR

inherit
	QL_DOMAIN_GENERATOR
		redefine
			criterion,
			item_type
		end

create
	default_create,
	make

feature -- Access

	criterion: QL_LOCAL_CRITERION
			-- Criterion used when generating new items

	domain: QL_LOCAL_DOMAIN
			-- Generated domain
		do
			if internal_domain = Void then
				create internal_domain.make
			end
			Result := internal_domain
		ensure then
			result_set: Result = internal_domain
		end

	scope: QL_SCOPE
			-- Scope of current generator
		do
			Result := local_scope
		ensure then
			good_result: Result = local_scope
		end

feature -- Visit

	process_target (a_item: QL_TARGET)
			-- Process `a_item'.
		do
			process_groups_from_target (a_item.target, a_item, agent process_group)
		end

	process_group (a_item: QL_GROUP)
			-- Process `a_item'.
		do
			process_classes_from_group (a_item.group, a_item, agent process_class)
		end

	process_class (a_item: QL_CLASS)
			-- Process `a_item'.
		do
			process_feature_from_class (a_item, agent process_real_feature, agent process_invariant)
		end

	process_feature (a_item: QL_FEATURE)
			-- Process `a_item'.
		local
			l_locals: EIFFEL_LIST [LIST_DEC_AS]
			l_type_dec_as: LIST_DEC_AS
			l_local: QL_LOCAL
			l_cnt: INTEGER
			i: INTEGER
		do
			if a_item.is_real_feature then
				l_locals := a_item.e_feature.locals
				if l_locals /= Void and then not l_locals.is_empty then
					from
						l_locals.start
					until
						l_locals.after
					loop
						l_type_dec_as := l_locals.item
						from
							i := 1
							l_cnt := l_type_dec_as.id_list.count
						until
							i > l_cnt
						loop
							create l_local.make_with_ast (l_type_dec_as.item_name (i), l_type_dec_as, a_item, a_item.written_class)
							evaluate_item (l_local)
							i := i + 1
						end
						l_locals.forth
					end
				end
			end
		end

	process_real_feature (a_item: QL_REAL_FEATURE)
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_invariant (a_item: QL_INVARIANT)
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_quantity (a_item: QL_QUANTITY)
			-- Process `a_item'.
		do
		end

	process_line (a_item: QL_LINE)
			-- Process `a_item'.
		do
		end

	process_generic (a_item: QL_GENERIC)
			-- Process `a_item'.
		do
		end

	process_local (a_item: QL_LOCAL)
			-- Process `a_item'.
		do
			evaluate_item (a_item)
		end

	process_argument (a_item: QL_ARGUMENT)
			-- Process `a_item'.
		do
		end

	process_assertion (a_item: QL_ASSERTION)
			-- Process `a_item'.
		do
		end

feature{NONE} -- Implementation

	tautology_criterion: like criterion
			-- Tautology criterion
		do
			Result :=
				local_criterion_factory.simple_criterion_with_index (local_criterion_factory.c_is_compiled) and
				local_criterion_factory.simple_criterion_with_index (local_criterion_factory.c_true)
		end

	compiled_criterion: like criterion
			-- A criterion that only compiled items can satisfy
		do
			Result := local_criterion_factory.simple_criterion_with_index (local_criterion_factory.c_is_compiled)
		end

feature{NONE} -- Observable

	item_type: QL_LOCAL
			-- Anchor type for items of generated domain

feature{NONE} -- Implementation/Criterion interaction

	temp_domain: like domain
			-- Temporary domain used to store candidate items from relation criterion such as "ancestor_is", "descendant_is"
		do
			if temp_domain_internal = Void then
				create temp_domain_internal.make
			end
			Result := temp_domain_internal
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
