indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.CaptureCollection"

external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURECOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.CaptureCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (i: INTEGER): SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURE is
		external
			"IL signature (System.Int32): System.Text.RegularExpressions.Capture use System.Text.RegularExpressions.CaptureCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Text.RegularExpressions.CaptureCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.CaptureCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.CaptureCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.CaptureCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Text.RegularExpressions.CaptureCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.CaptureCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Text.RegularExpressions.CaptureCollection"
		alias
			"CopyTo"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.RegularExpressions.CaptureCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.CaptureCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_CAPTURECOLLECTION
