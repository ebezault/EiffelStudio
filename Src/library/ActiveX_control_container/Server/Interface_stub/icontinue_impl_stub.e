indexing
	description: "Implemented `IContinue' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ICONTINUE_IMPL_STUB

inherit
	ICONTINUE_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	fcontinue is
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

	ccom_create_item (eif_object: ICONTINUE_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IContinue_impl_stub %"ecom_control_library_IContinue_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- ICONTINUE_IMPL_STUB

