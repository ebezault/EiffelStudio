indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_CALPOLESTR_RECORD

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

	c_elems: INTEGER is
			-- No description available.
		do
			Result := ccom_tag_calpolestr_c_elems (item)
		end

	p_elems: CELL [STRING] is
			-- No description available.
		do
			Result := ccom_tag_calpolestr_p_elems (item)
		ensure
			valid_p_elems: Result.item /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure
		do
			Result := c_size_of_tag_calpolestr
		end

feature -- Basic Operations

	set_c_elems (a_c_elems: INTEGER) is
			-- Set `c_elems' with `a_c_elems'.
		do
			ccom_tag_calpolestr_set_c_elems (item, a_c_elems)
		end

	set_p_elems (a_p_elems: CELL [STRING]) is
			-- Set `p_elems' with `a_p_elems'.
		require
			non_void_a_p_elems: a_p_elems /= Void
			valid_a_p_elems: a_p_elems.item /= Void
		do
			ccom_tag_calpolestr_set_p_elems (item, a_p_elems)
		end

feature {NONE}  -- Externals

	c_size_of_tag_calpolestr: INTEGER is
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagCALPOLESTR_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagCALPOLESTR)"
		end

	ccom_tag_calpolestr_c_elems (a_pointer: POINTER): INTEGER is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCALPOLESTR_s_impl.h%"](ecom_control_library::tagCALPOLESTR *):EIF_INTEGER"
		end

	ccom_tag_calpolestr_set_c_elems (a_pointer: POINTER; arg2: INTEGER) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCALPOLESTR_s_impl.h%"](ecom_control_library::tagCALPOLESTR *, ULONG)"
		end

	ccom_tag_calpolestr_p_elems (a_pointer: POINTER): CELL [STRING] is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCALPOLESTR_s_impl.h%"](ecom_control_library::tagCALPOLESTR *):EIF_REFERENCE"
		end

	ccom_tag_calpolestr_set_p_elems (a_pointer: POINTER; arg2: CELL [STRING]) is
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagCALPOLESTR_s_impl.h%"](ecom_control_library::tagCALPOLESTR *, EIF_OBJECT)"
		end

end -- TAG_CALPOLESTR_RECORD

