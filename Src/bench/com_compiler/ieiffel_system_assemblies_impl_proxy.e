indexing
	description: "Implemented `IEiffelSystemAssemblies' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_PROXY

inherit
	IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_system_assemblies_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	assemblies: IENUM_ASSEMBLY_INTERFACE is
			-- Returns all of the assemblies in an enumerator
		do
			Result := ccom_assemblies (initializer)
		end

feature -- Status Report

	last_error_code: INTEGER is
			-- Last error code.
		do
			Result := ccom_last_error_code (initializer)
		end

	last_error_description: STRING is
			-- Last error description.
		do
			Result := ccom_last_error_description (initializer)
		end

	last_error_help_file: STRING is
			-- Last error help file.
		do
			Result := ccom_last_error_help_file (initializer)
		end

	last_source_of_exception: STRING is
			-- Last source of exception.
		do
			Result := ccom_last_source_of_exception (initializer)
		end

feature -- Basic Operations

	store is
			-- Save changes.
		do
			ccom_store (initializer)
		end

	add_assembly (assembly_prefix: STRING; cluster_name: STRING; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING) is
			-- Add a signed assembly to the project.
			-- `assembly_prefix' [in].  
			-- `cluster_name' [in].  
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		do
			ccom_add_assembly (initializer, assembly_prefix, cluster_name, a_name, a_version, a_culture, a_publickey)
		end

	add_local_assembly (assembly_prefix: STRING; cluster_name: STRING; a_path: STRING) is
			-- Add a local assembly to the project.
			-- `assembly_prefix' [in].  
			-- `cluster_name' [in].  
			-- `a_path' [in].  
		do
			ccom_add_local_assembly (initializer, assembly_prefix, cluster_name, a_path)
		end

	remove_assembly (assembly_identifier: STRING) is
			-- Remove an assembly from the project.
			-- `assembly_identifier' [in].  
		do
			ccom_remove_assembly (initializer, assembly_identifier)
		end

	assembly_properties (cluster_name: STRING): IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE is
			-- Assembly properties.
			-- `cluster_name' [in].  
		do
			Result := ccom_assembly_properties (initializer, cluster_name)
		end

	is_valid_cluster_name (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a assembly cluster name is valid
			-- `cluster_name' [in].  
		do
			Result := ccom_is_valid_cluster_name (initializer, cluster_name)
		end

	contains_assembly (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a assembly cluster name has already been added to the project
			-- `cluster_name' [in].  
		do
			Result := ccom_contains_assembly (initializer, cluster_name)
		end

	contains_gac_assembly (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- Checks to see if a signed assembly has already been added to the project
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		do
			Result := ccom_contains_gac_assembly (initializer, a_name, a_version, a_culture, a_publickey)
		end

	contains_local_assembly (a_path: STRING): BOOLEAN is
			-- Checks to see if a unsigned assembly has already been added to the project
			-- `a_path' [in].  
		do
			Result := ccom_contains_local_assembly (initializer, a_path)
		end

	cluster_name_from_gac_assembly (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): STRING is
			-- Retrieves the cluster name for a signed assembly in the project
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		do
			Result := ccom_cluster_name_from_gac_assembly (initializer, a_name, a_version, a_culture, a_publickey)
		end

	cluster_name_from_local_assembly (a_path: STRING): STRING is
			-- Retrieves the cluster name for a unsigned assembly in the project
			-- `a_path' [in].  
		do
			Result := ccom_cluster_name_from_local_assembly (initializer, a_path)
		end

	is_valid_prefix (assembly_prefix: STRING): BOOLEAN is
			-- Is 'prefix' a valid assembly prefix
			-- `assembly_prefix' [in].  
		do
			Result := ccom_is_valid_prefix (initializer, assembly_prefix)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_system_assemblies_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_store (cpp_obj: POINTER) is
			-- Save changes.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]()"
		end

	ccom_add_assembly (cpp_obj: POINTER; assembly_prefix: STRING; cluster_name: STRING; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING) is
			-- Add a signed assembly to the project.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_add_local_assembly (cpp_obj: POINTER; assembly_prefix: STRING; cluster_name: STRING; a_path: STRING) is
			-- Add a local assembly to the project.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_remove_assembly (cpp_obj: POINTER; assembly_identifier: STRING) is
			-- Remove an assembly from the project.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_assembly_properties (cpp_obj: POINTER; cluster_name: STRING): IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE is
			-- Assembly properties.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_is_valid_cluster_name (cpp_obj: POINTER; cluster_name: STRING): BOOLEAN is
			-- Checks to see if a assembly cluster name is valid
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT): EIF_BOOLEAN"
		end

	ccom_contains_assembly (cpp_obj: POINTER; cluster_name: STRING): BOOLEAN is
			-- Checks to see if a assembly cluster name has already been added to the project
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT): EIF_BOOLEAN"
		end

	ccom_contains_gac_assembly (cpp_obj: POINTER; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- Checks to see if a signed assembly has already been added to the project
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT): EIF_BOOLEAN"
		end

	ccom_contains_local_assembly (cpp_obj: POINTER; a_path: STRING): BOOLEAN is
			-- Checks to see if a unsigned assembly has already been added to the project
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT): EIF_BOOLEAN"
		end

	ccom_cluster_name_from_gac_assembly (cpp_obj: POINTER; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): STRING is
			-- Retrieves the cluster name for a signed assembly in the project
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_cluster_name_from_local_assembly (cpp_obj: POINTER; a_path: STRING): STRING is
			-- Retrieves the cluster name for a unsigned assembly in the project
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_is_valid_prefix (cpp_obj: POINTER; assembly_prefix: STRING): BOOLEAN is
			-- Is 'prefix' a valid assembly prefix
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](EIF_OBJECT): EIF_BOOLEAN"
		end

	ccom_assemblies (cpp_obj: POINTER): IENUM_ASSEMBLY_INTERFACE is
			-- Returns all of the assemblies in an enumerator
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_delete_ieiffel_system_assemblies_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_system_assemblies_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]():EIF_POINTER"
		end

	ccom_last_error_code (cpp_obj: POINTER): INTEGER is
			-- Last error code
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]():EIF_INTEGER"
		end

	ccom_last_error_description (cpp_obj: POINTER): STRING is
			-- Last error description
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

	ccom_last_error_help_file (cpp_obj: POINTER): STRING is
			-- Last error help file
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

	ccom_last_source_of_exception (cpp_obj: POINTER): STRING is
			-- Last source of exception
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

end -- IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_PROXY

