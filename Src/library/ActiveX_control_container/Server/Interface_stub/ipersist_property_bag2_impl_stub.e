indexing
	description: "Implemented `IPersistPropertyBag2' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPERSIST_PROPERTY_BAG2_IMPL_STUB

inherit
	IPERSIST_PROPERTY_BAG2_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	get_class_id (p_class_id: ECOM_GUID) is
			-- No description available.
			-- `p_class_id' [out].  
		do
			-- Put Implementation here.
		end

	init_new is
			-- No description available.
		do
			-- Put Implementation here.
		end

	load (p_prop_bag: IPROPERTY_BAG2_INTERFACE; p_err_log: IERROR_LOG_INTERFACE) is
			-- No description available.
			-- `p_prop_bag' [in].  
			-- `p_err_log' [in].  
		do
			-- Put Implementation here.
		end

	save (p_prop_bag: IPROPERTY_BAG2_INTERFACE; f_clear_dirty: INTEGER; f_save_all_properties: INTEGER) is
			-- No description available.
			-- `p_prop_bag' [in].  
			-- `f_clear_dirty' [in].  
			-- `f_save_all_properties' [in].  
		do
			-- Put Implementation here.
		end

	is_dirty is
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

	ccom_create_item (eif_object: IPERSIST_PROPERTY_BAG2_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IPersistPropertyBag2_impl_stub %"ecom_control_library_IPersistPropertyBag2_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IPERSIST_PROPERTY_BAG2_IMPL_STUB

