indexing
	description: "Creator of Array descriptor"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ARRAY_DATA_TYPE_CREATOR

inherit
	WIZARD_DATA_TYPE_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR is
			-- Create descriptor
		require
			valid_type_desc: a_type_desc /= Void
			valid_type_desc_type: is_carray (a_type_desc.var_type)
		local
			l_array_desc: ECOM_ARRAY_DESC
			i: INTEGER
			l_array: ARRAY [INTEGER]
		do
			type := a_type_desc.var_type
			l_array_desc := a_type_desc.array_desc
			array_element_descriptor := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, l_array_desc.type_desc, a_system_description)
			dimension_count := l_array_desc.count_dimension
			create l_array.make (1, dimension_count)
			from
				i := 1
			variant
				dimension_count - i + 1
			until
				i > dimension_count
			loop
				l_array.put (l_array_desc.bounds.item(i).element_count, i)
				i := i + 1
			end
			array_size := l_array
			create Result.make (Current)
		ensure
			non_void_descriptor: Result /= Void
			valid_descriptor: is_carray (Result.type)
			non_void_element_descriptor: Result.array_element_descriptor /= Void
			non_void_array_size: array_size /= Void
			valid_array_size: array_size.count = dimension_count
		end

	initialize_descriptor (a_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR) is
			-- Initialize `a_descriptor' attributes
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_type (type)
			a_descriptor.set_element_descriptor (array_element_descriptor)
			a_descriptor.set_dimension_count (dimension_count)
			a_descriptor.set_array_size (array_size)
		end

feature {NONE} -- Implementation

	array_element_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Description of array element type

	dimension_count: INTEGER
			-- Count of array dimmentions

	array_size: ARRAY[INTEGER]
			-- size of array in each dimmention

end -- class WIZARD_ARRAY_DATA_TYPE_CREATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

