indexing
	description: "Processing interface for Eiffel server coclass."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR
		redefine
			process_property,
			process_function
		end

create
	make

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			a_prop_generator: WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR
		do
			create a_prop_generator.generate (component, a_property)
			add_property_rename (a_prop_generator)
		end


	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			a_func_generator: WIZARD_EIFFEL_SERVER_FUNCTION_GENERATOR
		do
			create a_func_generator.generate (component, a_function)
			add_feature_rename (a_func_generator)
		end

end -- class WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
