indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CONTAINER_INTPTR"

deferred external class
	IMPLEMENTATION_CONTAINER_INTPTR

inherit
	CONTAINER_INTPTR
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONTAINER_INTPTR"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONTAINER_INTPTR"
		alias
			"deep_clone"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CONTAINER_INTPTR"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CONTAINER_INTPTR"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CONTAINER_INTPTR"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_changeable_comparison_criterion (current_: CONTAINER_INTPTR): BOOLEAN is
		external
			"IL static signature (CONTAINER_INTPTR): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"$$changeable_comparison_criterion"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CONTAINER_INTPTR"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"compare_objects"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONTAINER_INTPTR"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CONTAINER_INTPTR"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CONTAINER_INTPTR"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CONTAINER_INTPTR"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CONTAINER_INTPTR"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CONTAINER_INTPTR"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_compare_references (current_: CONTAINER_INTPTR) is
		external
			"IL static signature (CONTAINER_INTPTR): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"$$compare_references"
		end

	frozen ec_illegal_36_ec_illegal_36_compare_objects (current_: CONTAINER_INTPTR) is
		external
			"IL static signature (CONTAINER_INTPTR): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"$$compare_objects"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CONTAINER_INTPTR"
		alias
			"generating_type"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"object_comparison"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CONTAINER_INTPTR"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONTAINER_INTPTR"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_empty (current_: CONTAINER_INTPTR): BOOLEAN is
		external
			"IL static signature (CONTAINER_INTPTR): System.Boolean use Implementation.CONTAINER_INTPTR"
		alias
			"$$empty"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CONTAINER_INTPTR"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CONTAINER_INTPTR
