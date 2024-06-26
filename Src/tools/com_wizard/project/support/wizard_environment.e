note
	description: "Information on data to be generated"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_ENVIRONMENT

inherit
	WIZARD_OUTPUT_LEVEL

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_ERRORS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize environment
		do
			is_in_process := True
			is_client := True
			Compile_c := True
			Compile_eiffel := True
			create abort_request_actions.make (10)
			create abort_request_actions_mutex.make
		end

feature -- Access

	is_eiffel_interface: BOOLEAN
			-- Is project COM interface to existing Eiffel project?

	is_new_component: BOOLEAN
			-- Is project for new COM component?

	is_client: BOOLEAN
			-- Is project for accessing existing COM component?

	marshaller_generated: BOOLEAN
			-- Should standard marshaller be generated?

	eiffel_class_name: READABLE_STRING_32
			-- Eiffel class name to generate IDL

	class_cluster_name: READABLE_STRING_32
			-- Cluster to which Eiffel class belongs

	eiffel_project_path: READABLE_STRING_32
			-- Eiffel project name

	eiffel_target: READABLE_STRING_32
			-- Eiffel target name

	idl_file_name: READABLE_STRING_32
			-- Path to definition file

	proxy_stub_file_name: READABLE_STRING_32
			-- Path to Proxy/Stub dll

	type_library_file_name: READABLE_STRING_32
			-- Path to type library

	is_in_process: BOOLEAN
			-- Should in process server code be generated?

	is_out_of_process: BOOLEAN
			-- Should out of process server code be generated?

	destination_folder: STRING_32
			-- Path to destination folder

	project_name: STRING_32
			-- Project name

	idl: BOOLEAN
			-- Is definition file an IDL file?

	abort: BOOLEAN
			-- Should code generation be aborted?

	error_code: INTEGER
			-- Last error code

	error_data: READABLE_STRING_32
			-- Error data if any

	compile_eiffel: BOOLEAN
			-- Should generated eiffel code be compiled?

	compile_c: BOOLEAN
			-- Should generated c code be compiled?

	backup: BOOLEAN
			-- Should wizard backup existing files?

	cleanup: BOOLEAN
			-- Should destination folder be cleaned up prior to generation?

	error_message: STRING_32
			-- Error message
		require
			has_error: abort and is_valid_error_code (error_code)
		do
			Result := error_title (error_code).twin
			if error_data /= Void then
				Result.append (":%R%N")
				Result.append (error_data)
			end
		ensure
			non_void_message: Result /= Void
		end

	expanded_path (a_path: READABLE_STRING_32): STRING_32
			-- Expand all environment variables in `a_path'.
		require
			non_void_path: a_path /= Void
		local
			l_list: LIST [READABLE_STRING_32]
			l_value: STRING_32
		do
			if not a_path.has ('$') then
				-- Optimization
				Result := a_path
			else
				create Result.make (a_path.count)
				l_list := a_path.split (Directory_separator)
				from
					l_list.start
					if not l_list.after then
						l_value := l_list.item
						if l_value.count > 0 and then l_value.item (1) = '$' then
							l_value.keep_tail (l_value.count - 1)
							l_value := item (l_value)
						end
						if l_value /= Void then
							Result.append (l_value)
						end
						l_list.forth
					end
				until
					l_list.after
				loop
					Result.append_character (Directory_separator)
					l_value := l_list.item
					if l_value.count > 0 and then l_value.item (1) = '$' then
						l_value.keep_tail (l_value.count - 1)
						l_value := item (l_value)
					end
					if l_value /= Void then
						Result.append (l_value)
					end
					l_list.forth
				end
			end
		ensure
			non_void_expanded_path: Result /= Void
		end

	Source_ecf_file_name: READABLE_STRING_32
			-- Name of the configuration file of an existing project where we add a new component.

	Ecf_file_name: PATH
			-- Name of the configuration file.
		require
			non_void_project_name: project_name /= Void
		do
			create Result.make_from_string (project_name)
			if is_client then
				Result := Result.appended ("_client")
			end
			Result := Result.appended_with_extension ("ecf")
		end

	Workbench_ace_file_name: STRING_32
			-- Ace file name
		require
			non_void_project_name: project_name /= Void
		once
			Result := project_name.twin
			Result.append (".workbench.ace")
		end

	Final_ace_file_name: STRING_32
			-- Ace file name
		require
			non_void_project_name: project_name /= Void
		once
			Result := project_name.twin
			Result.append (".final.ace")
		end

feature -- Element Change

	set_is_eiffel_interface
			-- Set `is_eiffel_interface' with `True'.
			-- Set `is_new_component' with `False'.
			-- Set `is_client' with `False'.
		do
			is_eiffel_interface := True
			is_new_component := False
			is_client := False
			update_idl_file_name
		ensure
			is_eiffel_interface: is_eiffel_interface
			not_is_new_component: not is_new_component
			not_is_client: not is_client
		end

	set_is_new_component
			-- Set `is_eiffel_interface' with `False'.
			-- Set `is_new_component' with `True'.
			-- Set `is_client' with `False'.
		do
			is_eiffel_interface := False
			is_new_component := True
			is_client := False
		ensure
			not_is_eiffel_interface: not is_eiffel_interface
			is_new_component: is_new_component
			not_is_client: not is_client
		end

	set_is_client
			-- Set `is_eiffel_interface' with `False'.
			-- Set `is_new_component' with `False'.
			-- Set `is_client' with `True'.
		do
			is_eiffel_interface := False
			is_new_component := False
			is_client := True
		ensure
			not_is_eiffel_interface: not is_eiffel_interface
			not_is_new_component: not is_new_component
			is_client: is_client
		end

	set_marshaller_generated (a_value: BOOLEAN)
			-- Set `marshaller_generated' with `a_value'.
		do
			marshaller_generated := a_value
		ensure
			marshaller_generated_set: marshaller_generated = a_value
		end

	set_is_in_process
			-- Set `is_in_process' with `True'.
			-- Set `is_out_of_process' with `False'.
		do
			is_in_process := True
			is_out_of_process := False
		ensure
			is_in_process_set: is_in_process
			is_out_of_process_set: not is_out_of_process
		end

	set_is_out_of_process
			-- Set `is_out_of_process' with `True'.
			-- Set `is_in_process' with `False'.
		do
			is_out_of_process := True
			is_in_process := False
		ensure
			is_out_of_process_set: is_out_of_process
			is_in_process_set: not is_in_process
		end

	set_eiffel_class_name (c_name: like eiffel_class_name)
			-- Set 'eiffel_class_name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			eiffel_class_name := c_name.as_upper
			update_idl_file_name
		ensure
			name_set: eiffel_class_name /= Void and then not eiffel_class_name.is_empty
		end

	set_class_cluster_name (c_name: like class_cluster_name)
			-- Set 'class_cluster_name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			class_cluster_name := c_name
		ensure
			name_set: class_cluster_name /= Void and then not class_cluster_name.is_empty
		end

	set_source_ecf_file_name (a_file: like source_ecf_file_name)
			-- Set `source_ecf_file_name' to `a_file'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		do
			source_ecf_file_name := a_file
		ensure
			source_ecf_file_name_set: source_ecf_file_name = a_file
		end

	set_eiffel_project_path (p_name: like eiffel_project_path)
			-- Set 'eiffel_project_name' to 'p_name'.
		require
			non_void_name: p_name /= Void
			valid_name: not p_name.is_empty
		do
			eiffel_project_path := expanded_path (p_name)
		ensure
			name_set: eiffel_project_path.is_equal (expanded_path (p_name))
		end

	set_eiffel_target (p_name: like eiffel_target)
			-- Set 'eiffel_target' to 'p_name'.
		require
			non_void_name: p_name /= Void
			valid_name: not p_name.is_empty
		do
			eiffel_target := expanded_path (p_name)
		ensure
			name_set: eiffel_target.is_equal (p_name)
		end


	set_destination_folder (a_folder: like destination_folder)
			-- Set `destination_folder' with `a_folder'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.is_empty
		do
			destination_folder := expanded_path (a_folder)
			if not destination_folder.is_empty and then destination_folder.item (destination_folder.count) /= Directory_separator then
				destination_folder.append_character (Directory_separator)
			end
			update_idl_file_name
		end

	set_project_name (a_name: like project_name)
			-- Set `project_name' with `a_name' and replace all non-alpha-numeric
			-- characters with underscores.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			i, nb: INTEGER
			l_project_name: like project_name
		do
			from
				i := 1
				l_project_name := a_name
				nb := l_project_name.count
			until
				i > nb
			loop
				if not a_name.item (i).is_alpha_numeric then
					if l_project_name = a_name then
						l_project_name := a_name.twin
					end
					l_project_name.put ('_', i)
				end
				i := i + 1
			end
			project_name := l_project_name
		ensure
			project_name_updated: project_name /= Void and then not project_name.is_empty
			project_name_preserved: valid_characters (a_name) implies project_name = a_name
		end

	set_idl_file_name (a_idl_file_name: like idl_file_name)
			-- Set `idl_file_name' with `a_idl_file_name'.
		require
			non_void_idl_file_name: a_idl_file_name /= Void
			valid_idl_file_name: not a_idl_file_name.is_empty
		do
			idl_file_name := expanded_path (a_idl_file_name)
			idl := True
		ensure
			idl_file_name_set: idl_file_name.is_equal (expanded_path (a_idl_file_name))
			idl: idl
		end

	set_proxy_stub_file_name (a_proxy_stub: like proxy_stub_file_name)
			-- Set `proxy_stub_file_name' with `a_proxy_stub'.
		require
			non_void_proxy_stub: a_proxy_stub /= Void
			valid_proxy_stub: not a_proxy_stub.is_empty
		do
			proxy_stub_file_name := expanded_path (a_proxy_stub)
		ensure
			proxy_stub_file_name_set: proxy_stub_file_name.is_equal (expanded_path (a_proxy_stub))
		end

	set_type_library_file_name (a_type_library_file_name: like type_library_file_name)
			-- Set `type_library_file_name' with `a_type_library_file_name'.
		require
			non_void_type_library_file_name: a_type_library_file_name /= Void
			valid_type_library_file_name: not a_type_library_file_name.is_empty
		do
			type_library_file_name := expanded_path (a_type_library_file_name)
		ensure
			type_library_file_name_set: type_library_file_name.is_equal (expanded_path (a_type_library_file_name))
		end

	set_idl (a_boolean: BOOLEAN)
			-- Set `idl' with `a_boolean'.
		do
			idl := a_boolean
		ensure
			idl_set: idl = a_boolean
		end

	set_abort (a_error_code: like error_code)
			-- Set `abort' to `True'.
			-- Set `error_code' with `a_error_code'.
		do
			abort := True
			error_code := a_error_code
			abort_request_actions_mutex.lock
			from
				abort_request_actions.start
			until
				abort_request_actions.after
			loop
				abort_request_actions.item.call (Void)
				abort_request_actions.forth
			end
			abort_request_actions_mutex.unlock
		ensure
			abort: abort
			error_code_set: error_code = a_error_code
		end

	set_error_data (a_error_data: like error_data)
			-- Set `error_data' with `a_error_data'.
		do
			error_data := a_error_data
		ensure
			error_data_set: error_data = a_error_data
		end

	set_no_abort
			-- Set `abort' to `False'.
		do
			abort := False
		ensure
			no_abort: not abort
		end

	set_compile_eiffel (a_boolean: like compile_eiffel)
			-- Set `compile_eiffel' to `a_boolean'.
		do
			compile_eiffel := a_boolean
		ensure
			compile_eiffel_set: compile_eiffel = a_boolean
		end

	set_compile_c (a_boolean: like compile_c)
			-- Set `compile_c' to `a_boolean'.
		do
			compile_c := a_boolean
		ensure
			compile_c_set: compile_c = a_boolean
		end

	set_backup (a_boolean: BOOLEAN)
			-- Set `backup' with `a_boolean'.
		do
			backup := a_boolean
		ensure
			backup_set: backup = a_boolean
		end

	set_cleanup (a_boolean: BOOLEAN)
			-- Set `cleanup' with `a_boolean'.
		do
			cleanup := a_boolean
		ensure
			cleanup_set: cleanup = a_boolean
		end

	add_abort_request_action (a_action: ROUTINE)
			-- Add `a_action' to `abort_request_actions'.
		require
			non_void_action: a_action /= Void
		do
			abort_request_actions_mutex.lock
			abort_request_actions.extend (a_action)
			abort_request_actions_mutex.unlock
		end

	remove_abort_request_action
			-- Remove last added action from `abort_request_actions'.
		do
			abort_request_actions_mutex.lock
			abort_request_actions.finish
			abort_request_actions.remove
			abort_request_actions_mutex.unlock
		end

	valid_characters (a_name: STRING_32): BOOLEAN
			-- Does `a_name' contain valid characters for a c++ identifier
		require
			initialized_name: a_name /= void
		local
			i, nb: INTEGER
			l_char: CHARACTER_32
		do
			if not a_name.is_empty and then (a_name.item (1).is_alpha or a_name.item (1) = '_') then
				from
					i := 2
					nb := a_name.count
					Result := True
				until
					i > nb or not Result
				loop
					l_char := a_name.item (i)
					Result := l_char.is_alpha_numeric or l_char = '_'
					i := i + 1
				end
			end
		ensure
			starts_without_number: Result implies not (a_name.item (1).is_digit)
		end

feature {NONE} -- Implementation

	update_idl_file_name
			-- Update `idl_file_name' according to `is_eiffel_interface', `destination_folder' and `eiffel_class_name'.
		local
			l_idl_file_name: STRING_32
		do
			if is_eiffel_interface and destination_folder /= Void and eiffel_class_name /= Void then
				l_idl_file_name := destination_folder.twin
				l_idl_file_name.append ("idl\")
				l_idl_file_name.append (eiffel_class_name.as_lower)
				l_idl_file_name.append (".idl")
				set_idl_file_name (l_idl_file_name)
			end
		end

	abort_request_actions: ARRAYED_LIST [ROUTINE]
			-- Abort request actions cell

	abort_request_actions_mutex: MUTEX
			-- Mutex used to access `abort_request_actions_mutex'

invariant
	valid_type: is_new_component xor is_eiffel_interface xor is_client
	valid_destination_folder: destination_folder /= Void implies (destination_folder.item (destination_folder.count) = Directory_separator)
	valid_eiffel_compilation_choice: compile_eiffel implies compile_c

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
