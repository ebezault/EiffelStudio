indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	X_GDI_OBJECT_UNION

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

	h_generic: POINTER is
			-- No description available.
		do
			Result := ccom_x__midl_iadvise_sink_0002_h_generic (item)
		end

	h_palette: POINTER is
			-- No description available.
		do
			Result := ccom_x__midl_iadvise_sink_0002_h_palette (item)
		end

	h_bitmap: POINTER is
			-- No description available.
		do
			Result := ccom_x__midl_iadvise_sink_0002_h_bitmap (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_x__midl_iadvise_sink_0002
		end

feature -- Basic Operations

	set_h_generic (a_h_generic: POINTER) is
			-- Set `h_generic' with `a_h_generic'.
		require
			non_void_a_h_generic: a_h_generic /= Void
			valid_a_h_generic: a_h_generic.item /= default_pointer
		do
			ccom_x__midl_iadvise_sink_0002_set_h_generic (item, a_h_generic.item)
		end

	set_h_palette (a_h_palette: POINTER) is
			-- Set `h_palette' with `a_h_palette'.
		require
			non_void_a_h_palette: a_h_palette /= Void
			valid_a_h_palette: a_h_palette.item /= default_pointer
		do
			ccom_x__midl_iadvise_sink_0002_set_h_palette (item, a_h_palette.item)
		end

	set_h_bitmap (a_h_bitmap: POINTER) is
			-- Set `h_bitmap' with `a_h_bitmap'.
		require
			non_void_a_h_bitmap: a_h_bitmap /= Void
			valid_a_h_bitmap: a_h_bitmap.item /= default_pointer
		do
			ccom_x__midl_iadvise_sink_0002_set_h_bitmap (item, a_h_bitmap.item)
		end

feature {NONE}  -- Externals

	c_size_of_x__midl_iadvise_sink_0002: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s.h%"]"
		alias
			"sizeof(ecom_control_library::__MIDL_IAdviseSink_0002)"
		end

	ccom_x__midl_iadvise_sink_0002_h_generic (a_pointer: POINTER): POINTER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s_impl.h%"](ecom_control_library::__MIDL_IAdviseSink_0002 *):EIF_REFERENCE"
		end

	ccom_x__midl_iadvise_sink_0002_set_h_generic (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s_impl.h%"](ecom_control_library::__MIDL_IAdviseSink_0002 *, ecom_control_library::_userHGLOBAL *)"
		end

	ccom_x__midl_iadvise_sink_0002_h_palette (a_pointer: POINTER): POINTER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s_impl.h%"](ecom_control_library::__MIDL_IAdviseSink_0002 *):EIF_REFERENCE"
		end

	ccom_x__midl_iadvise_sink_0002_set_h_palette (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s_impl.h%"](ecom_control_library::__MIDL_IAdviseSink_0002 *, ecom_control_library::_userHPALETTE *)"
		end

	ccom_x__midl_iadvise_sink_0002_h_bitmap (a_pointer: POINTER): POINTER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s_impl.h%"](ecom_control_library::__MIDL_IAdviseSink_0002 *):EIF_REFERENCE"
		end

	ccom_x__midl_iadvise_sink_0002_set_h_bitmap (a_pointer: POINTER; arg2: POINTER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library___MIDL_IAdviseSink_0002_s_impl.h%"](ecom_control_library::__MIDL_IAdviseSink_0002 *, ecom_control_library::_userHBITMAP *)"
		end

end -- X_GDI_OBJECT_UNION

