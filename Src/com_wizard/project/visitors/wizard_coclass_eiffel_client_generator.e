indexing
	description: "Coclass eiffel client generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COCLASS_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COCLASS_EIFFEL_GENERATOR
		redefine
			generate
		end

	WIZARD_COMPONENT_EIFFEL_CLIENT_GENERATOR

feature -- Access

	generate (a_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Generate eiffel class for coclass.
		local
			a_class_name: STRING
		do
			Precursor {WIZARD_COCLASS_EIFFEL_GENERATOR} (a_descriptor)

			a_class_name := name_for_class (a_descriptor.name, a_descriptor.type_kind, True)
			eiffel_writer.set_class_name (a_class_name)

			add_default_features (a_descriptor)
			if dispatch_interface then
				eiffel_writer.add_feature (last_error_code_feature, Status_report)
				eiffel_writer.add_feature (last_error_description_feature, Status_report)
				eiffel_writer.add_feature (last_error_help_file_feature, Status_report)
				eiffel_writer.add_feature (last_source_of_exception_feature, Status_report)
				eiffel_writer.add_feature (ccom_last_error_code_feature (a_descriptor), Externals)
				eiffel_writer.add_feature (ccom_last_error_description_feature (a_descriptor), Externals)
				eiffel_writer.add_feature (ccom_last_error_help_file_feature (a_descriptor), Externals)
				eiffel_writer.add_feature (ccom_last_source_of_exception_feature (a_descriptor), Externals)

			end

			Shared_file_name_factory.create_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

			eiffel_writer := Void
		end

	process_interfaces (a_coclass: WIZARD_COCLASS_DESCRIPTOR) is
			-- Process coclass interfaces.
		local
			interface_processor: WIZARD_COCLASS_INTERFACE_EIFFEL_CLIENT_PROCESSOR
		do
			create interface_processor.make (a_coclass, eiffel_writer)
			interface_processor.process_interfaces
			dispatch_interface := interface_processor.dispatch_interface
		end

feature --  Basic operation

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY) is
			-- Create file name.
		do
			a_factory.process_coclass_eiffel_client
		end

feature {NONE} -- Implementation

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS) is
			-- Set default ancestors
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
		do
			create tmp_writer.make
			tmp_writer.set_name (Queriable_type)
			an_eiffel_writer.add_inherit_clause (tmp_writer)
		end


	add_default_features (a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Add default features to coclass client. 
			-- e.g. make, constructor, destructor, delete wrapper etc.
		local
			a_coclass_name: STRING
		do
			a_coclass_name := name_for_feature (clone (a_coclass_descriptor.eiffel_class_name))

			create ccom_create_feature_name.make (1000)
			ccom_create_feature_name.append (Ccom_clause)
			ccom_create_feature_name.append ("create_")
			ccom_create_feature_name.append (a_coclass_name)

			create ccom_create_from_pointer_feature_name.make (1000)
			ccom_create_from_pointer_feature_name.append (ccom_create_feature_name)
			ccom_create_from_pointer_feature_name.append ("_from_pointer")

			create ccom_delete_feature_name.make (1000)
			ccom_delete_feature_name.append (Ccom_clause)
			ccom_delete_feature_name.append ("delete_")
			ccom_delete_feature_name.append (a_coclass_name)

			if is_typeflag_fcancreate (a_coclass_descriptor.flags) then
				eiffel_writer.add_feature (create_coclass_feature (a_coclass_descriptor), Externals)
				eiffel_writer.add_feature (make_feature, Initialization)
			end
			eiffel_writer.add_feature (delete_coclass_feature (a_coclass_descriptor), Externals)
			eiffel_writer.add_feature (delete_wrapper_feature, Implementation)
			eiffel_writer.add_feature (create_coclass_from_pointer_feature (a_coclass_descriptor), Externals)
			eiffel_writer.add_feature (ccom_item_feature (a_coclass_descriptor), Externals)
			eiffel_writer.add_feature (make_from_pointer_feature, Initialization)

		end

	make_feature: WIZARD_WRITER_FEATURE is
			-- `make' feature.
		require
			non_void_eiffel_writer: eiffel_writer /= Void
		local
			feature_body: STRING
		do
			create Result.make
			Result.set_name ("make")
			Result.set_comment ("Creation")

			create feature_body.make (1000)
			feature_body.append (Tab_tab_tab)
			feature_body.append (Initializer_variable)
			feature_body.append (Space)
			feature_body.append (Assignment)
			feature_body.append (Space)
			feature_body.append (ccom_create_feature_name)
			feature_body.append (New_line_tab_tab_tab)
			feature_body.append (Item_clause)
			feature_body.append (Space)
			feature_body.append (Assignment)
			feature_body.append (Space)
			feature_body.append (Ccom_item_function_name)
			feature_body.append (Space)
			feature_body.append (Open_parenthesis)
			feature_body.append (Initializer_variable)
			feature_body.append (Close_parenthesis)

			Result.set_effective
			Result.set_body (feature_body)
		ensure
			non_void_feature: Result /= Void
			non_void_feature_name: Result.name /= Void
			non_void_feature_body: Result.body /= Void
		end

	add_creation is
			-- Add creation routines.
		do
			if is_typeflag_fcancreate (coclass_descriptor.flags) then
				eiffel_writer.add_creation_routine (Make_word)
			end
			eiffel_writer.add_creation_routine (Make_from_other)
			eiffel_writer.add_creation_routine (Make_from_pointer)
		end

end -- class WIZARD_COCLASS_EIFFEL_CLIENT_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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
 

