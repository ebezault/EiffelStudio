indexing
	description: "Implemented `IPropertyNotifySink' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IPROPERTY_NOTIFY_SINK_IMPL_STUB

inherit
	IPROPERTY_NOTIFY_SINK_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	on_changed (disp_id: INTEGER) is
			-- No description available.
			-- `disp_id' [in].  
		do
			-- Put Implementation here.
		end

	on_request_edit (disp_id: INTEGER) is
			-- No description available.
			-- `disp_id' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IPROPERTY_NOTIFY_SINK_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IPropertyNotifySink_impl_stub %"ecom_control_library_IPropertyNotifySink_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IPROPERTY_NOTIFY_SINK_IMPL_STUB

