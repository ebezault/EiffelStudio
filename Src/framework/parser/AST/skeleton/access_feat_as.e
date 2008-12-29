note
	description:
		"Abstract description of an access to an Eiffel feature (note %
		%that this access cannot be the first call of a nested %
		%expression)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_FEAT_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

	ID_SET_ACCESSOR
		rename
			make as make_id_set,
			id_set as routine_ids,
			set_id_set as set_routine_ids
		undefine
			is_equal, copy
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name; p: like internal_parameters)
			-- Create a new FEATURE_ACCESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
			set_parameters (p)
		ensure
			feature_name_set: feature_name = f
			internal_parameters_set: internal_parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_access_feat_as (Current)
		end

feature -- Attributes

	feature_name: ID_AS
			-- Name of the feature called

	parameters: EIFFEL_LIST [EXPR_AS]
			-- List of parameters
		local
			l_internal_paran: like internal_parameters
		do
			l_internal_paran := internal_parameters
			if l_internal_paran /= Void then
				Result := l_internal_paran.meaningful_content
			end
			if Result /= Void then
				Result.start
			end
		end

	parameter_count: INTEGER
			-- Count of parameters
		do
			if parameters /= Void then
				Result := parameters.count
			end
		end

	access_name: STRING
		do
			Result := feature_name.name
		end

	is_qualified: BOOLEAN
			-- Is current entity a call on an other object?
		do
			Result := True
		end

	is_local: BOOLEAN
			-- Is current entity a local?
		do
			Result := (flags & is_local_flag) = is_local_flag
		end

	is_argument: BOOLEAN
			-- Is the current entity an argument?
		do
			Result := (flags & is_argument_flag) = is_argument_flag
		end

	is_object_test_local: BOOLEAN
			-- Is the current entity an object test local?
		do
			Result := (flags & is_object_test_local_flag) = is_object_test_local_flag
		end

	is_tuple_access: BOOLEAN
			-- Is the current entity an access to one of the TUPLE labels?
		do
			Result := (flags & is_tuple_access_flag) = is_tuple_access_flag
		end

	class_id: INTEGER
			-- The class id of the qualified call.

	argument_position: INTEGER
			-- If the current entity is an argument this gives the position in the argument list.
		require
			is_argument: is_argument
		do
			Result := first
		end

	label_position: INTEGER
			-- If current entity is a tuple access, gives the position in the tuple actual generic argument list.
		require
			is_tuple_access: is_tuple_access
		do
			Result := first
		end

feature -- Roundtrip

	internal_parameters: PARAMETER_LIST_AS
			-- Internal list of parameters, in which "(" and ")" are stored

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := feature_name.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list = Void then
				if parameters /= Void then
					Result := parameters.last_token (a_list)
				else
					Result := feature_name.last_token (a_list)
				end
			else
				if internal_parameters /= Void then
					Result := internal_parameters.last_token (a_list)
				else
					Result := feature_name.last_token (a_list)
				end
			end
		end

feature -- Delayed calls

	is_delayed : BOOLEAN
			-- Is this access delayed?
		do
			-- Default: No
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and
				equivalent (parameters, other.parameters) and
				is_delayed = other.is_delayed
		end

feature -- Setting

	set_feature_name (name: like feature_name)
		require
			valid_arg: name /= Void
		do
			feature_name := name
		ensure
			feature_name_set: feature_name = name
		end

	set_parameters (p: like internal_parameters)
			-- Set `internal_parameters' with `p'.
		do
			internal_parameters := p
		ensure
			internal_parameters_set: internal_parameters = p
		end

	set_class_id (a_class_id: like class_id)
			-- Set `class_id' to `a_class_id'.
		require
			a_class_id_ok: a_class_id > 0 or a_class_id = -1
		do
			class_id := a_class_id
		ensure
			class_id_set: class_id = a_class_id
		end

	set_argument_position (an_argument_position: like argument_position)
			-- Set `argument_position' to `an_argument_position'.
		require
			is_argument: is_argument
		do
			first := an_argument_position
		ensure
			argument_position_set: argument_position = an_argument_position
		end

	set_label_position (a_pos: like label_position)
			-- Set `label_position' to `a_pos'.
		require
			is_tuple_access: is_tuple_access
		do
			first := a_pos
		ensure
			label_position_set: label_position = a_pos
		end

	enable_local
			-- Set `is_local' to true.
		do
			flags := flags | is_local_flag
		ensure
			is_local_set: is_local
		end

	enable_object_test_local
			-- Set `is_object_test_local' to true.
		do
			flags := flags | is_object_test_local_flag
		ensure
			is_object_test_local_set: is_object_test_local
		end

	enable_argument
			-- Set `is_argument' to true.
		do
			flags := flags | is_argument_flag
		ensure
			is_argument_set: is_argument
		end

	enable_tuple_access
			-- Set `is_tuple_access' to True.
		do
			flags := flags | is_tuple_access_flag
		ensure
			is_tuple_access_set: is_tuple_access
		end

feature {NONE} -- Implementation

	flags: NATURAL_8
			-- Store property of this node.

	is_local_flag: NATURAL_8 = 0x01
	is_argument_flag: NATURAL_8 = 0x02
	is_tuple_access_flag: NATURAL_8 = 0x04
	is_object_test_local_flag: NATURAL_8 = 0x08
			-- Various possible values for `flags'.

invariant
	not_local_and_argument_and_tuple_access: is_local and (not is_argument and not is_tuple_access) or
		is_argument and (not is_local and not is_tuple_access) or
		is_tuple_access and (not is_local and not is_argument) or
		not is_local and not is_argument and not is_tuple_access
	parameters_set: (internal_parameters /= Void implies parameters = internal_parameters.meaningful_content) and
					(internal_parameters = Void implies parameters = Void)
	parameter_count_correct: (parameters /= Void implies parameter_count > 0) and (parameters = Void implies parameter_count = 0)

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ACCESS_FEAT_AS
