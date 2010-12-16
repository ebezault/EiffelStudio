note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ARCHIVER_UTILS

inherit
	NS_CODER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSArchiver

	archived_data_with_root_object_ (a_root_object: detachable NS_OBJECT): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_root_object__item: POINTER
		do
			if attached a_root_object as a_root_object_attached then
				a_root_object__item := a_root_object_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_archived_data_with_root_object_ (l_objc_class.item, a_root_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like archived_data_with_root_object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like archived_data_with_root_object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	archive_root_object__to_file_ (a_root_object: detachable NS_OBJECT; a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_root_object__item: POINTER
			a_path__item: POINTER
		do
			if attached a_root_object as a_root_object_attached then
				a_root_object__item := a_root_object_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_archive_root_object__to_file_ (l_objc_class.item, a_root_object__item, a_path__item)
		end

feature {NONE} -- NSArchiver Externals

	objc_archived_data_with_root_object_ (a_class_object: POINTER; a_root_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object archivedDataWithRootObject:$a_root_object];
			 ]"
		end

	objc_archive_root_object__to_file_ (a_class_object: POINTER; a_root_object: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object archiveRootObject:$a_root_object toFile:$a_path];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSArchiver"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end