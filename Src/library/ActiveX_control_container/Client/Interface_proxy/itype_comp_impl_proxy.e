indexing
	description: "Implemented `ITypeComp' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ITYPE_COMP_IMPL_PROXY

inherit
	ITYPE_COMP_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_itype_comp_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	remote_bind (sz_name: STRING; l_hash_val: INTEGER; w_flags: INTEGER; pp_tinfo: CELL [ITYPE_INFO_2_INTERFACE]; p_desc_kind: INTEGER_REF; pp_func_desc: CELL [TAG_FUNCDESC_RECORD]; pp_var_desc: CELL [TAG_VARDESC_RECORD]; pp_type_comp: CELL [ITYPE_COMP_INTERFACE]; p_dummy: INTEGER_REF) is
			-- No description available.
			-- `sz_name' [in].  
			-- `l_hash_val' [in].  
			-- `w_flags' [in].  
			-- `pp_tinfo' [out].  
			-- `p_desc_kind' [out].  
			-- `pp_func_desc' [out].  
			-- `pp_var_desc' [out].  
			-- `pp_type_comp' [out].  
			-- `p_dummy' [out].  
		do
			ccom_remote_bind (initializer, sz_name, l_hash_val, w_flags, pp_tinfo, p_desc_kind, pp_func_desc, pp_var_desc, pp_type_comp, p_dummy)
		end

	remote_bind_type (sz_name: STRING; l_hash_val: INTEGER; pp_tinfo: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
			-- `sz_name' [in].  
			-- `l_hash_val' [in].  
			-- `pp_tinfo' [out].  
		do
			ccom_remote_bind_type (initializer, sz_name, l_hash_val, pp_tinfo)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_itype_comp_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_remote_bind (cpp_obj: POINTER; sz_name: STRING; l_hash_val: INTEGER; w_flags: INTEGER; pp_tinfo: CELL [ITYPE_INFO_2_INTERFACE]; p_desc_kind: INTEGER_REF; pp_func_desc: CELL [TAG_FUNCDESC_RECORD]; pp_var_desc: CELL [TAG_VARDESC_RECORD]; pp_type_comp: CELL [ITYPE_COMP_INTERFACE]; p_dummy: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeComp_impl_proxy %"ecom_control_library_ITypeComp_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_remote_bind_type (cpp_obj: POINTER; sz_name: STRING; l_hash_val: INTEGER; pp_tinfo: CELL [ITYPE_INFO_2_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::ITypeComp_impl_proxy %"ecom_control_library_ITypeComp_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER,EIF_OBJECT)"
		end

	ccom_delete_itype_comp_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::ITypeComp_impl_proxy %"ecom_control_library_ITypeComp_impl_proxy_s.h%"]()"
		end

	ccom_create_itype_comp_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::ITypeComp_impl_proxy %"ecom_control_library_ITypeComp_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::ITypeComp_impl_proxy %"ecom_control_library_ITypeComp_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- ITYPE_COMP_IMPL_PROXY

