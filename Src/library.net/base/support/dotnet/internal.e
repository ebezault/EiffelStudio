indexing
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN is
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		local
			l_types: like known_types
		do
			l_types := known_types
			l_types.search (type_id)
			if l_types.found then
				Result := l_types.found_item.is_instance_of_type (object)
			end
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		require
			type1_nonnegative: type1 >= 0
			type2_nonnegative: type2 >= 0
		local
			l_child, l_parent: TYPE
			l_types: like known_types
		do
			if type1 = type2 then
				Result := True
			else
				l_types := known_types
				l_types.search (type1)
				if l_types.found then
					l_child := l_types.found_item
					l_types.search (type2)
					if l_types.found then
						l_parent := l_types.found_item
						Result := l_parent.is_assignable_from (l_child)
					end
				end
			end
		end
		
feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER is
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
		local
			t: TYPE
			l_class_type: SYSTEM_STRING
		do
			l_class_type := class_type.to_cil
			load_assemblies
			eiffel_type_mapping.search (class_type)
			if eiffel_type_mapping.found then
					-- It is an Eiffel type which was recorded in `load_assemblies'.
				t := eiffel_type_mapping.found_item
			else
					-- Could not find it, let's try the .NET name.
				t := feature {TYPE}.get_type_string (l_class_type)
			end
			if t /= Void then
				Result := get_type_index (t)
			else
				Result := -1
			end
		ensure
			dynamic_type_from_string_valid: Result = -1 or else Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY is
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
		require
			type_id_nonnegative: type_id >= 0
			not_special_type: not is_special_type (type_id)
		local
			c: CONSTRUCTOR_INFO
			l_types: like known_types
		do
			l_types := known_types
			l_types.search (type_id)
			if l_types.found then
				c := l_types.found_item.get_constructor (feature {TYPE}.empty_types)
				if c /= Void then
					Result ?= c.invoke (Void)
				end
			end
		ensure
			not_special_type: not is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [ANY] is
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `TO_SPECIAL'.
		require
			count_valid: count >= 0
			type_id_nonnegative: type_id >= 0
			special_type: is_special_any_type (type_id)
		do
			check
				False
			end
		ensure
			special_type: is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
			count_set: Result.count = count
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_nonnegative: type_id >= 0
		do
			check
				False
			end
		end

	is_special_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_nonnegative: type_id >= 0
		do
			check
				False
			end
		end

	is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
			-- It only recognized a special object 
			-- initialized within a TO_SPECIAL object.
		require
			object_not_void: object /= Void
		local
			cvs: SPECIAL [ANY]
		do
			cvs ?= object
			Result := cvs /= Void
		end

	is_marked (obj: ANY): BOOLEAN is
			-- Is `obj' marked?
		require
			object_not_void: obj /= Void
		do
			Result := Marked_objects.contains (obj)
		end
		
feature -- Access

	Pointer_type: INTEGER is 0

	Reference_type: INTEGER is 1

	Character_type: INTEGER is 2

	Boolean_type: INTEGER is 3

	Integer_type, integer_32_type: INTEGER is 4
	
	Real_type: INTEGER is 5

	Double_type: INTEGER is 6

	Expanded_type: INTEGER is 7

	Bit_type: INTEGER is 8

	Integer_8_type: INTEGER is 9

	Integer_16_type: INTEGER is 10

	Integer_64_type: INTEGER is 11

	Wide_character_type: INTEGER is 12
	
	natural_8_type: INTEGER is 13
	
	natural_16_type: INTEGER is 14
	
	natural_32_type: INTEGER is 15
	
	natural_64_type: INTEGER is 16

	max_predefined_type: INTEGER is 17
			-- See non-exported definition of `object_type' below.

	class_name (object: ANY): STRING is
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end
		
	class_name_of_type (type_id: INTEGER): STRING is
			-- Name of class associated with dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		local
			l_types: like known_types
			l_name: EIFFEL_NAME_ATTRIBUTE
			l_type: TYPE
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
		do
			l_types := known_types
			l_types.search (type_id)
			if l_types.found then
				l_type := l_types.found_item
				l_attributes := l_type.get_custom_attributes (eiffel_name_attribute_type, False)
				if l_attributes.count > 0 then
						-- This is an eiffel defined attribute
					check
						valid_number_of_custom_attributes: l_attributes.count = 1
					end
					l_name ?= l_attributes.item (0)
					Result := l_name.name
				else
					Result := l_type.name
				end
			end
		end

	type_name (object: ANY): STRING is
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		require
			object_not_void: object /= Void
		do
			Result := object.generating_type
		end

	type_name_of_type (type_id: INTEGER): STRING is
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			check
				False
			end
		end

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		local
			l_obj: SYSTEM_OBJECT
		do
			l_obj := object
			Result := get_type_index (l_obj.get_type)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_count (obj: ANY): INTEGER is
			-- Number of generic parameter in `obj'.
		require
			obj_not_void: obj /= Void
		do
			Result := feature {ISE_RUNTIME}.generic_parameter_count (obj)
		end

	generic_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of generic parameter in `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			check
				False
			end
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_not_void: object /= Void
			object_generic: generic_count (object) > 0
			i_valid: i > 0 and i <= generic_count (object)
		local
			generic_type: TYPE
		do
			generic_type := feature {ISE_RUNTIME}.type_of_generic_parameter (object, i)
			Result := get_type_index (generic_type)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_dynamic_type_of_type (type_id, i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `type_id' at position `i'.
		require
			type_id_nonnegative: type_id >= 0
			type_id_generic: generic_count_of_type (type_id) > 0
			i_valid: i > 0 and i <= generic_count_of_type (type_id)
		do
			check
				False
			end
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	field (i: INTEGER; object: ANY): ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		local
			l_obj: SYSTEM_OBJECT
			l_nat8: NATURAL_8
			l_nat16: NATURAL_16
			l_nat32: NATURAL_32
			l_nat64: NATURAL_64
			l_int8: INTEGER_8
			l_int16: INTEGER_16
			l_int32: INTEGER
			l_int64: INTEGER_64
			l_char: CHARACTER
			l_boolean: BOOLEAN
			l_real: REAL
			l_double: DOUBLE
			l_pointer: POINTER
			l_dtype: INTEGER
		do
			l_dtype := dynamic_type (object)
			l_obj := field_of_type (i, object, l_dtype)
			inspect
				field_type_of_type (i, l_dtype)
			when Pointer_type then
				l_pointer ?= l_obj
				Result := l_pointer

			when Character_type then
				l_char ?= l_obj
				Result := l_char

			when Boolean_type then
				l_boolean ?= l_obj
				Result := l_boolean

			when natural_8_type then
				l_nat8 ?= l_obj
				Result := l_nat8

			when natural_16_type then
				l_nat16 ?= l_obj
				Result := l_nat16

			when natural_32_type then
				l_nat32 ?= l_obj
				Result := l_nat32

			when natural_64_type then
				l_nat64 ?= l_obj
				Result := l_nat64

			when Integer_8_type then
				l_int8 ?= l_obj
				Result := l_int8

			when Integer_16_type then
				l_int16 ?= l_obj
				Result := l_int16

			when Integer_32_type then
				l_int32 ?= l_obj
				Result := l_int32

			when Integer_64_type then
				l_int64 ?= l_obj
				Result := l_int64

			when Real_type then
				l_real ?= l_obj
				Result := l_real

			when Double_type then
				l_double ?= l_obj
				Result := l_double
			
			else
					-- A reference, so nothing to be done
				Result := l_obj
			end
		end

	field_name (i: INTEGER; object: ANY): STRING is
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := field_name_of_type (i, dynamic_type (object))
		ensure
			Result_exists: Result /= Void
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING is
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		local
			m: like get_members
			l_field: FIELD_INFO
			l_name: EIFFEL_NAME_ATTRIBUTE
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				l_field := m.i_th (i)
				l_attributes := l_field.get_custom_attributes_type (eiffel_name_attribute_type, False)
				if l_attributes.count > 0 then
						-- This is an eiffel defined attribute
					check
						valid_number_of_custom_attributes: l_attributes.count = 1
					end
					l_name ?= l_attributes.item (0)
					Result := l_name.name
				else
					Result := l_field.name
				end
			end
		end

	field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := 4 * i
		end

	field_type (i: INTEGER; object: ANY): INTEGER is
			-- Abstract type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := field_type_of_type (i, dynamic_type (object))
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			l_m: like get_members
			l_field: FIELD_INFO
			l_type: TYPE
		do
			l_m := get_members (type_id)
			if l_m /= Void and then l_m.valid_index (i) then
				l_field := l_m.i_th (i)
				l_type := l_field.field_type
				if abstract_types.contains (l_type) then
					Result ?= abstract_types.item (l_type)
				else
						-- FIXME: BIT not supported
					if
						l_type.is_subclass_of (
						feature {TYPE}.get_type_string (("System.Enum").to_cil))
					then
						Result := Expanded_type
					else
						Result := Reference_type
					end
				end
			end
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			l_m: like get_members
			l_field: FIELD_INFO
		do
			l_m := get_members (type_id)
			if l_m /= Void and then l_m.valid_index (i) then
				l_field := l_m.i_th (i)
				Result := get_type_index (l_field.field_type)
			end
		ensure
			field_type_nonnegative: Result >= 0
		end

	expanded_field_type (i: INTEGER; object: ANY): STRING is
			-- Class name associated with the `i'-th
			-- expanded field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_expanded: field_type (i, object) = Expanded_type
		do
			check
				False
			end
		ensure
			Result_exists: Result /= Void
		end

	character_field (i: INTEGER; object: ANY): CHARACTER is
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	natural_8_field (i: INTEGER; object: ANY): NATURAL_8 is
			-- NATURAL_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	natural_16_field (i: INTEGER; object: ANY): NATURAL_16 is
			-- NATURAL_16 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	natural_32_field (i: INTEGER; object: ANY): NATURAL_32 is
			-- NATURAL_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_field: field_type (i, object) = natural_32_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	natural_64_field (i: INTEGER; object: ANY): NATURAL_64 is
			-- NATURAL_64 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	integer_8_field (i: INTEGER; object: ANY): INTEGER_8 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	integer_16_field (i: INTEGER; object: ANY): INTEGER_16 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	integer_field, integer_32_field (i: INTEGER; object: ANY): INTEGER is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	integer_64_field (i: INTEGER; object: ANY): INTEGER_64 is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	real_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

	double_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			Result ?= field_of_type (i, object, dynamic_type (object))
		end

feature -- Version

	compiler_version: INTEGER is
		do
			-- Built-in.
		end

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			reference_field: field_type (i, object) = Reference_type
			value_conforms_to_field_static_type:
				value /= Void implies 
					type_conforms_to (dynamic_type (value), 
						field_static_type_of_type (i, dynamic_type (object))) 
		do
			internal_set_reference_field (i, object, value)
		end

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_8_field (i: INTEGER; object: ANY; value: NATURAL_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_16_field (i: INTEGER; object: ANY; value: NATURAL_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_field (i: INTEGER; object: ANY; value: NATURAL_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_32_field: field_type (i, object) = natural_32_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_natural_64_field (i: INTEGER; object: ANY; value: NATURAL_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_field, set_integer_32_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			internal_set_reference_field (i, object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			internal_set_reference_field (i, object, value)
		end

feature -- Measurement

	field_count (object: ANY): INTEGER is
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := get_members (dynamic_type (object)).count
		end

	field_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of logical fields in dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := get_members (type_id).count
		end

	bit_size (i: INTEGER; object: ANY): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_bit: field_type (i, object) = Bit_type
		do
			Result := 4
		ensure
			positive_result: Result > 0
		end

	physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' in bytes
		require
			object_not_void: object /= Void
		do
			Result := 4
		end

feature -- Marking

	mark (obj: ANY) is
			-- Mark `obj'.
		require
			object_not_void: obj /= Void
		do
			Marked_objects.add (obj, obj)
		ensure
			marked: is_marked (obj)
		end
		
	unmark (obj: ANY) is
			-- Unmark `obj'.
		require
			object_not_void: obj /= Void
			object_marked: is_marked (obj)
		do
			Marked_objects.remove (obj)
		ensure
			not_marked: not is_marked (obj)
		end
		
feature {NONE} -- Implementation

	object_type: INTEGER is 17
			-- System.Object type ID
	
	new_known_type_id: CELL [INTEGER] is
			-- ID for new stored type
		once
			create Result.put (max_predefined_type + 1)
		end

	field_of_type (i: INTEGER; object: ANY; type_id: INTEGER): SYSTEM_OBJECT is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
			type_id_nonnegative: type_id >= 0
			valid_type: dynamic_type (object) = type_id
		local
			m: like get_members
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				Result := m.i_th (i).get_value (object)
			end
		end

	field_dynamic_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Type of `i'-th field of dynamic type `type_id'
			-- Not used yet, but might be in future.
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		local
			m: like get_members
		do
			m := get_members (type_id)
			if m /= Void and then m.valid_index (i) then
				Result := get_type_index (m.i_th (i).get_type)
			end
		end

	get_type_index (t: TYPE): INTEGER is
			-- If type is a known type, return its index,
			-- otherwise add it to the known types and return its index.
		require
			t_not_void: t /= Void
		local
			l_types: like known_types_id
			l_id: like new_known_type_id
			l_id_object: SYSTEM_OBJECT
		do
			l_types := known_types_id
			l_id_object := l_types.item (t)
			if l_id_object = Void then
				l_id := new_known_type_id
				Result := l_id.item
				known_types.put (t, Result)
				l_types.add (t, Result)
				l_id.put (Result + 1)
			else	
				Result ?= l_id_object
			end
		end

	load_assemblies is
			-- Analyzes current loaded assembly in current AppDomain. Assemblies
			-- loaded after are loaded by hooking `load_eiffel_types_from_assembly'
			-- to the `add_assembly_load' event.
		local
			l_assemblies: NATIVE_ARRAY [ASSEMBLY]
			i, nb: INTEGER
			l_handler: ASSEMBLY_LOAD_EVENT_HANDLER
		once
			l_assemblies := feature {APP_DOMAIN}.current_domain.get_assemblies
			create l_handler.make (Current, $assembly_load_event)
			feature {APP_DOMAIN}.current_domain.add_assembly_load (l_handler)
			from
				i := 0
				nb := l_assemblies.count - 1
			until
				i > nb
			loop
				load_eiffel_types_from_assembly (l_assemblies.item (i))
				i := i + 1
			end
		end

	assembly_load_event (sender: SYSTEM_OBJECT; args: ASSEMBLY_LOAD_EVENT_ARGS) is
			-- Action executed when a new assembly is loaded.
		do
			if args /= Void then
				check
					has_loaded_assembly: args.loaded_assembly /= Void
				end
				load_eiffel_types_from_assembly (args.loaded_assembly)
			end
		end
		
	load_eiffel_types_from_assembly (an_assembly: ASSEMBLY) is
			-- Load all Eiffel types from `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		local
			l_types: NATIVE_ARRAY [TYPE]
			l_name: EIFFEL_NAME_ATTRIBUTE
			l_cas: NATIVE_ARRAY [SYSTEM_OBJECT]
			i, nb: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_types := an_assembly.get_types
				from
					i := 0
					nb := l_types.count - 1
				until
					i > nb
				loop
					l_cas := l_types.item (i).get_custom_attributes_type (eiffel_name_attribute_type, False)
					if l_cas /= Void and then l_cas.count > 0 then
						l_name ?= l_cas.item (0)
						check
							l_name_not_void: l_name /= Void
						end
						eiffel_type_mapping.force (l_types.item (i), l_name.name)
					end
					i := i + 1
				end
			end
		rescue
				-- It could fail in `an_assembly.get_types' and we don't want to
				-- prevent the assembly to load by failing here.
			retried := True
			retry
		end

	eiffel_type_mapping: HASH_TABLE [TYPE, STRING] is
			-- Mapping between Eiffel class names and .NET types.
		once
			create Result.make (50)
		end

	known_types: HASH_TABLE [TYPE, INTEGER] is
			-- All types that have already been identified.
		once
				-- FIXME: We do not support BIT
			create Result.make (50)
			Result.put (feature {TYPE}.get_type_string ("System.IntPtr"), Pointer_type)
			Result.put (feature {TYPE}.get_type_string ("System.Char"), Character_type)
			Result.put (feature {TYPE}.get_type_string ("System.Boolean"), Boolean_type)
			Result.put (feature {TYPE}.get_type_string ("System.Single"), Real_type)
			Result.put (feature {TYPE}.get_type_string ("System.Double"), Double_type)
			Result.put (feature {TYPE}.get_type_string ("System.Byte"), natural_8_type)
			Result.put (feature {TYPE}.get_type_string ("System.UInt16"), natural_16_type)
			Result.put (feature {TYPE}.get_type_string ("System.UInt32"), natural_32_type)
			Result.put (feature {TYPE}.get_type_string ("System.UInt64"), natural_64_type)
			Result.put (feature {TYPE}.get_type_string ("System.SByte"), Integer_8_type)
			Result.put (feature {TYPE}.get_type_string ("System.Int16"), Integer_16_type)
			Result.put (feature {TYPE}.get_type_string ("System.Int32"), Integer_32_type)
			Result.put (feature {TYPE}.get_type_string ("System.Int64"), Integer_64_type)
			Result.put (feature {TYPE}.get_type_string ("System.Object"), Object_type)
		end

	known_types_id: HASHTABLE is
			-- Id of all types that have already been identified.
			-- Key: type
			-- Value: ID
			--| Reverse of `known_types'.
		once
				-- FIXME: We do not support BIT
			create Result.make_from_capacity (50)
			Result.add (feature {TYPE}.get_type_string ("System.IntPtr"), Pointer_type)
			Result.add (feature {TYPE}.get_type_string ("System.Char"), Character_type)
			Result.add (feature {TYPE}.get_type_string ("System.Boolean"), Boolean_type)
			Result.add (feature {TYPE}.get_type_string ("System.Single"), Real_type)
			Result.add (feature {TYPE}.get_type_string ("System.Double"), Double_type)
			Result.add (feature {TYPE}.get_type_string ("System.Byte"), natural_8_type)
			Result.add (feature {TYPE}.get_type_string ("System.UInt16"), natural_16_type)
			Result.add (feature {TYPE}.get_type_string ("System.UInt32"), natural_32_type)
			Result.add (feature {TYPE}.get_type_string ("System.UInt64"), natural_64_type)
			Result.add (feature {TYPE}.get_type_string ("System.SByte"), Integer_8_type)
			Result.add (feature {TYPE}.get_type_string ("System.Int16"), Integer_16_type)
			Result.add (feature {TYPE}.get_type_string ("System.Int32"), Integer_32_type)
			Result.add (feature {TYPE}.get_type_string ("System.Int64"), Integer_64_type)
			Result.add (feature {TYPE}.get_type_string ("System.Object"), Object_type)
		end

	abstract_types: HASHTABLE is
			-- List of all known basic types.
			-- Key: type
			-- Value: ID
		once
			create Result.make_from_capacity (10)
			Result.add (feature {TYPE}.get_type_string ("System.IntPtr"), Pointer_type)
			Result.add (feature {TYPE}.get_type_string ("System.Char"), Character_type)
			Result.add (feature {TYPE}.get_type_string ("System.Boolean"), Boolean_type)
			Result.add (feature {TYPE}.get_type_string ("System.Single"), Real_type)
			Result.add (feature {TYPE}.get_type_string ("System.Double"), Double_type)
			Result.add (feature {TYPE}.get_type_string ("System.Byte"), natural_8_type)
			Result.add (feature {TYPE}.get_type_string ("System.UInt16"), natural_16_type)
			Result.add (feature {TYPE}.get_type_string ("System.UInt32"), natural_32_type)
			Result.add (feature {TYPE}.get_type_string ("System.UInt64"), natural_64_type)
			Result.add (feature {TYPE}.get_type_string ("System.SByte"), Integer_8_type)
			Result.add (feature {TYPE}.get_type_string ("System.Int16"), Integer_16_type)
			Result.add (feature {TYPE}.get_type_string ("System.Int32"), Integer_32_type)
			Result.add (feature {TYPE}.get_type_string ("System.Int64"), Integer_64_type)
		end
		
	get_members (type_id: INTEGER): ARRAYED_LIST [FIELD_INFO] is
			-- Retrieve all members of type `type_id'.
			-- We need permission to retrieve non-public members.
			-- Only fields and properties are returned.
		local
			fa: BINDING_FLAGS
			l_field_info: FIELD_INFO
			allm: NATIVE_ARRAY [MEMBER_INFO]
			c, i: INTEGER
			l_members: like known_members
			l_types: like known_types
			l_cv_f_name: STRING
		do
			l_members := Known_members
			l_members.search (type_id)
			if l_members.found then
				Result := l_members.found_item
			else
				l_types := known_types
				l_types.search (type_id)
				if l_types.found then
					fa := 	feature {BINDING_FLAGS}.instance |
							feature {BINDING_FLAGS}.public |
							feature {BINDING_FLAGS}.non_public
					allm := l_types.found_item.get_members_binding_flags (fa)
					c := allm.count
					create Result.make (10)
					from
						
					until
						i = c
					loop
						l_field_info ?= allm.item (i)
						if l_field_info /= Void then
							l_cv_f_name := l_field_info.name
							if not l_cv_f_name.is_equal ("$$____type") then
								Result.extend (l_field_info)
							end
						end
						i := i + 1
					end
				end
				l_members.put (Result, type_id)
			end
		end

	internal_set_reference_field (i: INTEGER; object: ANY; value: SYSTEM_OBJECT) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		local
			m: like get_members
		do
			m := get_members (dynamic_type (object))
			if m /= Void and then m.valid_index (i) then
				m.i_th (i).set_value (object, value)
			end
		end

	known_members: HASH_TABLE [ARRAYED_LIST [FIELD_INFO], INTEGER] is
			-- Buffer for `get_members' lookups
		once
			create Result.make (50)
		end

	marked_objects: HASHTABLE is
			-- Contains all objects marked.
		once
			create Result.make_from_capacity (50)
		end

	eiffel_name_attribute_type: TYPE is
			-- Get actual type of EIFFEL_NAME_ATTRIBUTE while
			-- waiting for `typeof' operator.
		local
			l_name: EIFFEL_NAME_ATTRIBUTE
		once
			create l_name.make ("Test")
			Result := l_name.get_type
		end
	
indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class INTERNAL
