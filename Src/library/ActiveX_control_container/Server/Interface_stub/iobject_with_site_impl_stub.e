indexing
	description: "Implemented `IObjectWithSite' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOBJECT_WITH_SITE_IMPL_STUB

inherit
	IOBJECT_WITH_SITE_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	set_site (p_unk_site: ECOM_INTERFACE) is
			-- No description available.
			-- `p_unk_site' [in].  
		do
			-- Put Implementation here.
		end

	get_site (riid: ECOM_GUID; ppv_site: CELL [POINTER]) is
			-- No description available.
			-- `riid' [in].  
			-- `ppv_site' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IOBJECT_WITH_SITE_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IObjectWithSite_impl_stub %"ecom_control_library_IObjectWithSite_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IOBJECT_WITH_SITE_IMPL_STUB

