indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResourceReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	RESOURCE_READER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IRESOURCE_READER
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			dispose as system_idisposable_dispose
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResourceReader"
		end

	frozen make_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResourceReader"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResourceReader"
		alias
			"GetHashCode"
		end

	frozen get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Resources.ResourceReader"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.ResourceReader"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResourceReader"
		alias
			"Equals"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Resources.ResourceReader"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Resources.ResourceReader"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Resources.ResourceReader"
		alias
			"System.IDisposable.Dispose"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Resources.ResourceReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class RESOURCE_READER
