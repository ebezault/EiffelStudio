indexing
	description: "Implemented `IPersistStorage' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_STORAGE_IMPL_STUB

inherit
	IPERSIST_STORAGE_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID) is
			-- No description available.
			-- `p_class_id' [out].  
		do
			-- Put Implementation here.
		end

	is_dirty is
			-- No description available.
		do
			-- Put Implementation here.
		end

	init_new (pstg: ISTORAGE_INTERFACE) is
			-- No description available.
			-- `pstg' [in].  
		do
			-- Put Implementation here.
		end

	load (pstg: ISTORAGE_INTERFACE) is
			-- No description available.
			-- `pstg' [in].  
		do
			-- Put Implementation here.
		end

	save (p_stg_save: ISTORAGE_INTERFACE; f_same_as_load: INTEGER) is
			-- No description available.
			-- `p_stg_save' [in].  
			-- `f_same_as_load' [in].  
		do
			-- Put Implementation here.
		end

	save_completed (p_stg_new: ISTORAGE_INTERFACE) is
			-- No description available.
			-- `p_stg_new' [in].  
		do
			-- Put Implementation here.
		end

	hands_off_storage is
			-- No description available.
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IPERSIST_STORAGE_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IPersistStorage_impl_stub %"ecom_control_library_IPersistStorage_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IPERSIST_STORAGE_IMPL_STUB

