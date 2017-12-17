note

	description:
		"The objects available from the operating system";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"


class OPERATING_ENVIRONMENT

feature

	Directory_separator: CHARACTER
			-- Character used to separate subdirectories in a path name on this platform.
			--| To build portable path names, use PATH_NAME and its descendants.
		once
			Result := c_dir_separator
		end

	Current_directory_name_representation: STRING
			-- Representation of the current directory
		once
			Result := eif_current_dir_representation
		end

	home_directory_supported: BOOLEAN
			-- Is the notion of home directory supported on this platform?
		external
			"C | %"eif_path_name.h%""
		alias
			"eif_home_dir_supported"
		ensure
			is_class: class
		end

	root_directory_supported: BOOLEAN
			-- Is the notion of root directory supported on this platform?
		external
			"C | %"eif_path_name.h%""
		alias
			"eif_root_dir_supported"
		ensure
			is_class: class
		end

	case_sensitive_path_names: BOOLEAN
			-- Are path names case sensitive?
		external
			"C | %"eif_path_name.h%""
		alias
			"eif_case_sensitive_path_names"
		ensure
			is_class: class
		end

feature {NONE} -- Implementation

	c_dir_separator: CHARACTER
		external
			"C | %"eif_dir.h%""
		alias
			"eif_dir_separator"
		ensure
			is_class: class
		end

	eif_current_dir_representation: STRING
		external
			"C | %"eif_path_name.h%""
		ensure
			is_class: class
		end

end -- class OPERATING_ENVIRONMENT

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

