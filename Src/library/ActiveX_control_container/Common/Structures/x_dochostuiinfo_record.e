indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_DOCHOSTUIINFO_RECORD

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

	cb_size: INTEGER is
			-- No description available.
		do
			Result := ccom_x_dochostuiinfo_cb_size (item)
		end

	dw_flags: INTEGER is
			-- No description available.
		do
			Result := ccom_x_dochostuiinfo_dw_flags (item)
		end

	dw_double_click: INTEGER is
			-- No description available.
		do
			Result := ccom_x_dochostuiinfo_dw_double_click (item)
		end

	pch_host_css: INTEGER_REF is
			-- No description available.
		do
			Result := ccom_x_dochostuiinfo_pch_host_css (item)
		end

	pch_host_ns: INTEGER_REF is
			-- No description available.
		do
			Result := ccom_x_dochostuiinfo_pch_host_ns (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x_dochostuiinfo
		end

feature -- Basic Operations

	set_cb_size (a_cb_size: INTEGER) is
			-- Set `cb_size' with `a_cb_size'.
		do
			ccom_x_dochostuiinfo_set_cb_size (item, a_cb_size)
		end

	set_dw_flags (a_dw_flags: INTEGER) is
			-- Set `dw_flags' with `a_dw_flags'.
		do
			ccom_x_dochostuiinfo_set_dw_flags (item, a_dw_flags)
		end

	set_dw_double_click (a_dw_double_click: INTEGER) is
			-- Set `dw_double_click' with `a_dw_double_click'.
		do
			ccom_x_dochostuiinfo_set_dw_double_click (item, a_dw_double_click)
		end

	set_pch_host_css (a_pch_host_css: INTEGER_REF) is
			-- Set `pch_host_css' with `a_pch_host_css'.
		require
			non_void_a_pch_host_css: a_pch_host_css /= Void
		do
			ccom_x_dochostuiinfo_set_pch_host_css (item, a_pch_host_css)
		end

	set_pch_host_ns (a_pch_host_ns: INTEGER_REF) is
			-- Set `pch_host_ns' with `a_pch_host_ns'.
		require
			non_void_a_pch_host_ns: a_pch_host_ns /= Void
		do
			ccom_x_dochostuiinfo_set_pch_host_ns (item, a_pch_host_ns)
		end

feature {NONE}  -- Externals

	c_size_of_x_dochostuiinfo: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library__DOCHOSTUIINFO_s.h%"]"
		alias
			"sizeof(ecom_control_library::_DOCHOSTUIINFO)"
		end

	ccom_x_dochostuiinfo_cb_size (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *):EIF_INTEGER"
		end

	ccom_x_dochostuiinfo_set_cb_size (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *, ULONG)"
		end

	ccom_x_dochostuiinfo_dw_flags (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *):EIF_INTEGER"
		end

	ccom_x_dochostuiinfo_set_dw_flags (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *, ULONG)"
		end

	ccom_x_dochostuiinfo_dw_double_click (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *):EIF_INTEGER"
		end

	ccom_x_dochostuiinfo_set_dw_double_click (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *, ULONG)"
		end

	ccom_x_dochostuiinfo_pch_host_css (a_pointer: POINTER): INTEGER_REF is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *):EIF_REFERENCE"
		end

	ccom_x_dochostuiinfo_set_pch_host_css (a_pointer: POINTER; arg2: INTEGER_REF) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *, EIF_OBJECT)"
		end

	ccom_x_dochostuiinfo_pch_host_ns (a_pointer: POINTER): INTEGER_REF is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *):EIF_REFERENCE"
		end

	ccom_x_dochostuiinfo_set_pch_host_ns (a_pointer: POINTER; arg2: INTEGER_REF) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library__DOCHOSTUIINFO_s_impl.h%"](ecom_control_library::_DOCHOSTUIINFO *, EIF_OBJECT)"
		end

end -- X_DOCHOSTUIINFO_RECORD

