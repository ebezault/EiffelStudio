indexing
	description: "Implemented `IEiffelSystemClusters' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_SYSTEM_CLUSTERS_IMPL_PROXY

inherit
	IEIFFEL_SYSTEM_CLUSTERS_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_system_clusters_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	cluster_tree: IENUM_CLUSTER_PROP_INTERFACE is
			-- Cluster tree.
		do
			Result := ccom_cluster_tree (initializer)
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

	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
			-- `cluster_name' [in].  
			-- `parent_name' [in].  
			-- `cluster_path' [in].  
		do
			ccom_add_cluster (initializer, cluster_name, parent_name, cluster_path)
		end

	remove_cluster (cluster_name: STRING) is
			-- Remove a cluster from the project.
			-- `cluster_name' [in].  
		do
			ccom_remove_cluster (initializer, cluster_name)
		end

	cluster_properties (cluster_name: STRING): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `cluster_name' [in].  
		do
			Result := ccom_cluster_properties (initializer, cluster_name)
		end

	cluster_properties_by_id (cluster_id: INTEGER): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `cluster_id' [in].  
		do
			Result := ccom_cluster_properties_by_id (initializer, cluster_id)
		end

	change_cluster_name (a_name: STRING; a_new_name: STRING) is
			-- Change cluster name.
			-- `a_name' [in].  
			-- `a_new_name' [in].  
		do
			ccom_change_cluster_name (initializer, a_name, a_new_name)
		end

	is_valid_name (cluster_name: STRING): BOOLEAN is
			-- Checks to see if a cluster name is valid
			-- `cluster_name' [in].  
		do
			Result := ccom_is_valid_name (initializer, cluster_name)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_system_clusters_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_cluster_tree (cpp_obj: POINTER): IENUM_CLUSTER_PROP_INTERFACE is
			-- Cluster tree.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](): EIF_REFERENCE"
		end

	ccom_store (cpp_obj: POINTER) is
			-- Save changes.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]()"
		end

	ccom_add_cluster (cpp_obj: POINTER; cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_remove_cluster (cpp_obj: POINTER; cluster_name: STRING) is
			-- Remove a cluster from the project.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_cluster_properties (cpp_obj: POINTER; cluster_name: STRING): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_cluster_properties_by_id (cpp_obj: POINTER; cluster_id: INTEGER): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_change_cluster_name (cpp_obj: POINTER; a_name: STRING; a_new_name: STRING) is
			-- Change cluster name.
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_is_valid_name (cpp_obj: POINTER; cluster_name: STRING): BOOLEAN is
			-- Checks to see if a cluster name is valid
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](EIF_OBJECT): EIF_BOOLEAN"
		end

	ccom_delete_ieiffel_system_clusters_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_system_clusters_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]():EIF_POINTER"
		end

	ccom_last_error_code (cpp_obj: POINTER): INTEGER is
			-- Last error code
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]():EIF_INTEGER"
		end

	ccom_last_error_description (cpp_obj: POINTER): STRING is
			-- Last error description
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

	ccom_last_error_help_file (cpp_obj: POINTER): STRING is
			-- Last error help file
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

	ccom_last_source_of_exception (cpp_obj: POINTER): STRING is
			-- Last source of exception
		external
			"C++ [ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy %"ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

end -- IEIFFEL_SYSTEM_CLUSTERS_IMPL_PROXY

