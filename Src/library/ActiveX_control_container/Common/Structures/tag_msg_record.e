indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_MSG_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

creation
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	h_wnd: POINTER is
			-- No description available.
		do
			Result := ccom_tag_msg_h_wnd (item)
		end

	message: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_msg_message (item)
		end

	w_param: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_msg_w_param (item)
		end

	l_param: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_msg_l_param (item)
		end

	time: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_msg_time (item)
		end

	pt: TAG_POINT_RECORD is
			-- No description available.
		do
			Result := ccom_tag_msg_pt (item)
		ensure
			valid_pt: Result.item /= default_pointer
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_msg
		end

feature -- Basic Operations

	set_h_wnd (a_h_wnd: POINTER) is
			-- Set `h_wnd' with `a_h_wnd'.
		do
			ccom_tag_msg_set_h_wnd (item, a_h_wnd)
		end

	set_message (a_message: INTEGER) is
			-- Set `message' with `a_message'.
		do
			ccom_tag_msg_set_message (item, a_message)
		end

	set_w_param (a_w_param: INTEGER) is
			-- Set `w_param' with `a_w_param'.
		do
			ccom_tag_msg_set_w_param (item, a_w_param)
		end

	set_l_param (a_l_param: INTEGER) is
			-- Set `l_param' with `a_l_param'.
		do
			ccom_tag_msg_set_l_param (item, a_l_param)
		end

	set_time (a_time: INTEGER) is
			-- Set `time' with `a_time'.
		do
			ccom_tag_msg_set_time (item, a_time)
		end

	set_pt (a_pt: TAG_POINT_RECORD) is
			-- Set `pt' with `a_pt'.
		require
			non_void_a_pt: a_pt /= Void
			valid_a_pt: a_pt.item /= default_pointer
		do
			ccom_tag_msg_set_pt (item, a_pt.item)
		end

feature {NONE}  -- Externals

	c_size_of_tag_msg: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagMSG_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagMSG)"
		end

	ccom_tag_msg_h_wnd (a_pointer: POINTER): POINTER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *):EIF_POINTER"
		end

	ccom_tag_msg_set_h_wnd (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *, ecom_control_library::wireHWND)"
		end

	ccom_tag_msg_message (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *):EIF_INTEGER"
		end

	ccom_tag_msg_set_message (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *, UINT)"
		end

	ccom_tag_msg_w_param (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *):EIF_INTEGER"
		end

	ccom_tag_msg_set_w_param (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *, UINT)"
		end

	ccom_tag_msg_l_param (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *):EIF_INTEGER"
		end

	ccom_tag_msg_set_l_param (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *, LONG)"
		end

	ccom_tag_msg_time (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *):EIF_INTEGER"
		end

	ccom_tag_msg_set_time (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *, ULONG)"
		end

	ccom_tag_msg_pt (a_pointer: POINTER): TAG_POINT_RECORD is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *):EIF_REFERENCE"
		end

	ccom_tag_msg_set_pt (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagMSG_s_impl.h%"](ecom_control_library::tagMSG *, ecom_control_library::tagPOINT *)"
		end

end -- TAG_MSG_RECORD

