indexing
	description: "Implemented `IEiffelCompletionInfo' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_COMPLETION_INFO_IMPL_PROXY

inherit
	IEIFFEL_COMPLETION_INFO_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_completion_info_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	target_features (target: STRING; feature_name: STRING; file_name: STRING): IENUM_COMPLETION_ENTRY_INTERFACE is
			-- Features accessible from target.
			-- `target' [in].  
			-- `feature_name' [in].  
			-- `file_name' [in].  
		do
			Result := ccom_target_features (initializer, target, feature_name, file_name)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_completion_info_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_target_features (cpp_obj: POINTER; target: STRING; feature_name: STRING; file_name: STRING): IENUM_COMPLETION_ENTRY_INTERFACE is
			-- Features accessible from target.
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy %"ecom_eiffel_compiler_IEiffelCompletionInfo_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT,EIF_OBJECT): EIF_REFERENCE"
		end

	ccom_delete_ieiffel_completion_info_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy %"ecom_eiffel_compiler_IEiffelCompletionInfo_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_completion_info_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy %"ecom_eiffel_compiler_IEiffelCompletionInfo_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy %"ecom_eiffel_compiler_IEiffelCompletionInfo_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IEIFFEL_COMPLETION_INFO_IMPL_PROXY

