note
	description: "[
		An agumented assembly resolver to support consumer's ability to consume assemblies with dependencies
		in disparate locations.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CONSUMER_AGUMENTED_RESOLVER

inherit
	SYSTEM_OBJECT

	AR_RESOLVER
		rename
			make as resolver_make,
			make_with_name as resolver_make_with_name,
			common_initialization as resolver_common_initialization
		redefine
			resolve_by_name,
			get_assembly_name,
			load_assembly
		end

	SHARED_ASSEMBLY_LOADER
		export
			{NONE} all
		end

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make (a_paths: ARRAYED_LIST [READABLE_STRING_32])
			-- Initialize instance
		require
			a_paths_attached: a_paths /= Void
		do
			create names_table.make (13)
			names_table.compare_objects
			look_up_file_names := a_paths
			resolver_make
			common_initialization (a_paths)
		ensure
			names_table_attached: names_table /= Void
			names_table_compares_objects: names_table.object_comparison
		end

	make_with_name (a_paths: ARRAYED_LIST [READABLE_STRING_32]; a_name: attached like friendly_name)
			-- Initialize instance and set `friendly_name' with `a_name'
		require
			a_paths_attached: a_paths /= Void
			a_name_not_void: a_name /= Void
		do
			create names_table.make (13)
			names_table.compare_objects
			look_up_file_names := a_paths
			resolver_make_with_name (a_name)
			common_initialization (a_paths)
		ensure
			friendly_name_set: friendly_name = a_name
			names_table_attached: names_table /= Void
			names_table_compares_objects: names_table.object_comparison
		end

	common_initialization (a_paths: ARRAYED_LIST [READABLE_STRING_32])
			-- Additional initialization.
		require
			a_paths_attached: a_paths /= Void
		local
			l_paths: ARRAYED_LIST [READABLE_STRING_32]
		do
			if a_paths.count > 0 then
				create l_paths.make (a_paths.count)
				l_paths.append (a_paths)
				from l_paths.start until l_paths.after loop
					if {SYSTEM_DIRECTORY}.exists (l_paths.item) then
							-- Not a file but a directory, so add it to the list of resolve paths.
						add_resolve_path (l_paths.item)
						l_paths.remove
					else
						l_paths.forth
					end
				end
				look_up_file_names := l_paths
			end
		ensure
			look_up_file_names_attached: look_up_file_names /= Void
		end

feature -- Resolution

	resolve_by_name (a_domain: APP_DOMAIN; a_name: READABLE_STRING_32; a_version, a_culture, a_key: detachable READABLE_STRING_32): detachable PATH
			-- Resolve an assembly in app domain `a_domain' where name of assembly comprises of assembly name `a_name'
			-- and optionally version `a_version', culture `a_culture' and public key token `a_key'
		local
			l_name: like get_assembly_name
			l_cursor: CURSOR
		do
			l_cursor := look_up_file_names.cursor
			from
				look_up_file_names.start
			until
				look_up_file_names.after or Result /= Void
			loop
				l_name := Void
				if {SYSTEM_FILE}.exists (look_up_file_names.item) then
					l_name := get_assembly_name (look_up_file_names.item)
				end
				if l_name /= Void then
					if does_name_match (l_name, a_name, a_version, a_culture, a_key) then
						create Result.make_from_string (look_up_file_names.item)
					end
				end
				look_up_file_names.forth
			end
			look_up_file_names.go_to (l_cursor)
			if Result = Void then
				Result := Precursor {AR_RESOLVER} (a_domain, a_name, a_version, a_culture, a_key)
			end
		ensure then
			look_up_file_names_cursor_unmoved: look_up_file_names.cursor.is_equal (old look_up_file_names.cursor)
		end

feature {NONE} -- Implementation

	load_assembly (a_path: PATH): detachable ASSEMBLY
			-- Attempts to load assembly from `a_path'
		do
			Result := assembly_loader.load_from (a_path.name)
		end

	get_assembly_name (a_path: READABLE_STRING_32): detachable ASSEMBLY_NAME
			-- Retrieve an assembly name from `a_path'
		do
			Result := names_table.item (a_path)
			if Result = Void then
				Result := Precursor {AR_RESOLVER} (a_path)
				if Result /= Void then
					names_table.extend (Result, a_path)
				end
			end
		end

	look_up_file_names: ARRAYED_LIST [READABLE_STRING_32]
			-- Lookup files names

	names_table: STRING_TABLE [ASSEMBLY_NAME]
			-- Table of path/assembly names
			-- Key: assembly file name path
			-- Value: Assembly name

invariant
	look_up_file_names_not_void: look_up_file_names /= Void
	names_table_not_void: names_table /= Void
	names_table_compares_objects: names_table.object_comparison

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


end -- class CONSUMER_AGUMENTED_RESOLVER
