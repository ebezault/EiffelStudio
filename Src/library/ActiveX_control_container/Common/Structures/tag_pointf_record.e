indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_POINTF_RECORD

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

	x: REAL is
			-- No description available.
		do
			Result := ccom_tag_pointf_x (item)
		end

	y: REAL is
			-- No description available.
		do
			Result := ccom_tag_pointf_y (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_pointf
		end

feature -- Basic Operations

	set_x (a_x: REAL) is
			-- Set `x' with `a_x'.
		do
			ccom_tag_pointf_set_x (item, a_x)
		end

	set_y (a_y: REAL) is
			-- Set `y' with `a_y'.
		do
			ccom_tag_pointf_set_y (item, a_y)
		end

feature {NONE}  -- Externals

	c_size_of_tag_pointf: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagPOINTF_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagPOINTF)"
		end

	ccom_tag_pointf_x (a_pointer: POINTER): REAL is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPOINTF_s_impl.h%"](ecom_control_library::tagPOINTF *):EIF_REAL"
		end

	ccom_tag_pointf_set_x (a_pointer: POINTER; arg2: REAL) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPOINTF_s_impl.h%"](ecom_control_library::tagPOINTF *, FLOAT)"
		end

	ccom_tag_pointf_y (a_pointer: POINTER): REAL is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPOINTF_s_impl.h%"](ecom_control_library::tagPOINTF *):EIF_REAL"
		end

	ccom_tag_pointf_set_y (a_pointer: POINTER; arg2: REAL) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPOINTF_s_impl.h%"](ecom_control_library::tagPOINTF *, FLOAT)"
		end

end -- TAG_POINTF_RECORD

