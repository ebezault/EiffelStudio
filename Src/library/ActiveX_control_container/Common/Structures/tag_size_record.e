indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_SIZE_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
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

	cx: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_size_cx (item)
		end

	cy: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_size_cy (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_size
		end

feature -- Basic Operations

	set_cx (a_cx: INTEGER) is
			-- Set `cx' with `a_cx'.
		do
			ccom_tag_size_set_cx (item, a_cx)
		end

	set_cy (a_cy: INTEGER) is
			-- Set `cy' with `a_cy'.
		do
			ccom_tag_size_set_cy (item, a_cy)
		end

feature {NONE}  -- Externals

	c_size_of_tag_size: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagSIZE_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagSIZE)"
		end

	ccom_tag_size_cx (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagSIZE_s_impl.h%"](ecom_control_library::tagSIZE *):EIF_INTEGER"
		end

	ccom_tag_size_set_cx (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagSIZE_s_impl.h%"](ecom_control_library::tagSIZE *, LONG)"
		end

	ccom_tag_size_cy (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagSIZE_s_impl.h%"](ecom_control_library::tagSIZE *):EIF_INTEGER"
		end

	ccom_tag_size_set_cy (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagSIZE_s_impl.h%"](ecom_control_library::tagSIZE *, LONG)"
		end

end -- TAG_SIZE_RECORD

