indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MANAGER

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_VISITOR_FACTORIES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	WIZARD_MESSAGE_OUTPUT
		export
			{NONE} all
		end

	WIZARD_PROGRESS_REPORT
		rename
			finish as report_finish,
			parent as report_parent
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	WIZARD_REJECTED_TYPE_LIBRARIES
		export
			{NONE} all
		end

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent) is
			-- Initialize manager.
		require
			non_void_parent: a_parent /= Void
		do
			set_output_window (a_parent)
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	parent: MAIN_WINDOW
			-- Parent window used to parent.add_title messages

	Idl_compilation_title: STRING is "IDL Compilation"
			-- IDL compilation title
	
	Iid_compilation_title: STRING is "C Compilation Step 1"
			-- Iid generated C file compilation title
	
	Data_compilation_title: STRING is "C Compilation Step 2"
			-- Inprocess dll generated C file compilation title
	
	Ps_compilation_title: STRING is "C Compilation Step 3"
			-- Proxy/stub generated C file compilation title
	
	Link_title: STRING is "Creating Proxy Stub Dll"
			-- Link title

	Analysis_title: STRING is "Analysing Type Library"
			-- Analysis title

	Generation_title2: STRING is "Generating Code"
			-- Generation title

feature -- Basic Operations

	run is
			-- Start generation.
		do		
			if shared_wizard_environment.abort then
				finish
			else
				set_parent (parent)
				initialize_log_file
				set_title (Idl_compilation_title)
				start
				-- Compile IDL
				if shared_wizard_environment.idl then
					if shared_wizard_environment.use_universal_marshaller then
						set_range (1)
					else
						set_range (5)
					end
					parent.add_title (Idl_compilation_title)
					Idl_compiler.compile_idl
					if shared_wizard_environment.abort then
						finish
					else
						step
						-- Create Proxy/Stub
						if not shared_wizard_environment.use_universal_marshaller then
							-- Compile c iid file
							parent.add_title (Iid_compilation_title)
							Idl_compiler.compile_iid
							if shared_wizard_environment.abort then
								finish
							else
								step
								-- Compile c dlldata file
								parent.add_title (Data_compilation_title)
								Idl_compiler.compile_data
								if shared_wizard_environment.abort then
									finish
								else
									step
									-- Compile c proxy/stub file
									parent.add_title (Ps_compilation_title)
									Idl_compiler.compile_ps
									if shared_wizard_environment.abort then
										finish
									else
										step
										-- Final link
										parent.add_title (Link_title)
										Idl_compiler.link
										if shared_wizard_environment.abort then
											finish
										else
											step
											generate
										end
									end
								end
							end
						else

							generate
						end
					end
				else
					generate
				end
				close_log_file
			end
		rescue
			if not failed_on_rescue then
				shared_wizard_environment.set_abort (Standard_abort_value)
				close_log_file
				retry
			end
		end

feature {NONE} -- Implementation

	generate is
			-- Generate Eiffel/C++ code.
		local
			i, a_range: INTEGER
		do
			-- Initialization
			parent.add_title (Analysis_title)
			set_system_descriptor (create {WIZARD_SYSTEM_DESCRIPTOR}.make)
			set_range (0)
			set_progress (0)
			intialize_file_directories

			-- Descriptors generation
			if directories_initialized then
				system_descriptor.generate (shared_wizard_environment.type_library_file_name)
			end
			
			-- Code generation
			if directories_initialized and not Shared_wizard_environment.abort then
				parent.add_title (Generation_title)
				from
					system_descriptor.start
				until
					system_descriptor.after
				loop
					if 
						not Non_generated_type_libraries.has (system_descriptor.library_descriptor_for_iteration.guid) 
					then
						a_range := a_range + system_descriptor.library_descriptor_for_iteration.descriptors.count
					end
					system_descriptor.forth
				end
				set_range (a_range)
				from
					system_descriptor.start
					start
					set_title (Generation_title2)
				until
					system_descriptor.after
				loop
					if 
						not Non_generated_type_libraries.has (system_descriptor.library_descriptor_for_iteration.guid) 
					then
						from
							i := 1
						until
							i > system_descriptor.library_descriptor_for_iteration.descriptors.count or Shared_wizard_environment.abort
						loop
							if system_descriptor.library_descriptor_for_iteration.descriptors.item (i) /= Void then
								if shared_wizard_environment.client then
									c_client_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
									eiffel_client_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
								end
								if shared_wizard_environment.server then
									c_server_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
									eiffel_server_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
								end
							end
							i := i + 1
							step
						end	
					end
					system_descriptor.forth
				end
				if Shared_wizard_environment.abort then
					parent.add_message (Generation_Aborted)
				else
					from
						system_descriptor.interfaces.start
					until
						system_descriptor.interfaces.after
						or Shared_wizard_environment.abort
					loop
						if shared_wizard_environment.client then
							c_client_visitor.visit (system_descriptor.interfaces.item)
							eiffel_client_visitor.visit (system_descriptor.interfaces.item)
						end
						system_descriptor.interfaces.forth
					end
				end

				if Shared_wizard_environment.abort then
					parent.add_message (Generation_Aborted)
				else

					-- Generation of runtime functions
					Shared_file_name_factory.create_generated_mapper_file_name (Generated_ce_mapper_writer)
					Generated_ce_mapper_writer.save_file (Shared_file_name_factory.last_created_file_name)
					Generated_ce_mapper_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
					Shared_file_name_factory.create_generated_mapper_file_name (Generated_ec_mapper_writer)
					Generated_ec_mapper_writer.save_file (Shared_file_name_factory.last_created_file_name)
					Generated_ec_mapper_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
					parent.add_message (Generation_Successful)
				end
				report_finish
			end
		end
		
	finish is
			-- Abort code generation.
		local
			a_string: STRING
		do
			inspect
				Shared_wizard_environment.return_code
			when Standard_abort_value then
				a_string := clone (Standard_failure_error_message)
			else
				a_string.append_integer (Shared_wizard_environment.return_code)
				a_string := clone (Failed_message)
			end
			parent.add_error (a_string)
			if running then
				report_finish
			end
			parent.enable
		end

	Idl_compiler: WIZARD_IDL_COMPILER is
			-- IDL compiler
		once
			create Result.make (parent)
		end

	intialize_file_directories is
			-- Create generated files directories.
		local
			a_file: RAW_FILE
			a_path, a_path2: STRING
		do
			-- Initialize Common subdirectory
			a_path := clone (shared_wizard_environment.destination_folder)
			a_path.append (Common)
			initialize_directory (a_path)
			a_path.append_character (Directory_separator)
			a_path2 := clone (a_path)
			a_path2.append (Clib)
			initialize_directory (a_path2)
			a_path2 := clone (a_path)
			a_path2.append (Include)
			initialize_directory (a_path2)
			a_path2 := clone (a_path)
			a_path2.append (Interfaces)
			initialize_directory (a_path2)
			a_path2 := clone (a_path)
			a_path2.append (Structures)
			initialize_directory (a_path2)

			-- Initialize Client subdirectory
			if Shared_wizard_environment.client then
				a_path := clone (Shared_wizard_environment.destination_folder)
				a_path.append (Client)
				initialize_directory (a_path)
				a_path.append_character (Directory_separator)
				a_path2 := clone (a_path)
				a_path2.append (Clib)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Include)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Component)
				initialize_directory (a_path2)
			end
	
			-- Initialize Server subdirectory
			if Shared_wizard_environment.server then
				a_path := clone (Shared_wizard_environment.destination_folder)
				a_path.append (Server)
				initialize_directory (a_path)
				a_path.append_character (Directory_separator)
				a_path2 := clone (a_path)
				a_path2.append (Clib)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Include)
				initialize_directory (a_path2)
				a_path2 := clone (a_path)
				a_path2.append (Component)
				initialize_directory (a_path2)
			end
		end

	initialize_directory (a_path: STRING) is
			-- Create directory `a_path' if does not exist.
		require
			-- is_directory (a_path)
			-- only last directory in path is not created
		local
			a_file: RAW_FILE
			a_string: STRING
			a_directory: DIRECTORY
		do
			directories_initialized := True
			create a_file.make (a_path)
			if a_file.exists then
				if not a_file.is_directory then
					a_string := clone (File_already_exists)
					a_string.append (Colon)
					a_string.append (Space)
					a_string.append (a_path)
					add_warning (Current, a_string)
					add_message (Current, File_backed_up)
					a_string := clone (a_path)
					a_string.append (Backup_file_extension)
					file_copy (a_path, a_string)
					file_delete (a_path)
					create a_directory.make (a_path)
					check
						not_exists: not a_directory.exists
					end
					a_directory.create_dir
				end
			else
				create a_directory.make (a_path)
				check
					not_exists: not a_directory.exists
				end
				a_directory.create_dir
			end
		end
					
	directories_initialized: BOOLEAN
			-- Were directories correctly initialized?

	Failed_message: STRING is "Failed with return code "
			-- Failure message
	
	Standard_failure_error_message: STRING is "Failed"
			-- Generic failure message

	Generation_title: STRING is "Generating code"
			-- Generation message
		
end -- class WIZARD_MANAGER

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
