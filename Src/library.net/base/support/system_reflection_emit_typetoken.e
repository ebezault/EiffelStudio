indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.TypeToken"

frozen expanded external class
	SYSTEM_REFLECTION_EMIT_TYPETOKEN

inherit
	SYSTEM_VALUETYPE
		redefine
			get_hash_code,
			is_equal
		end

feature -- Access

	frozen empty: SYSTEM_REFLECTION_EMIT_TYPETOKEN is
		external
			"IL static_field signature :System.Reflection.Emit.TypeToken use System.Reflection.Emit.TypeToken"
		alias
			"Empty"
		end

	frozen get_token: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.TypeToken"
		alias
			"get_Token"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.TypeToken"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.TypeToken"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_REFLECTION_EMIT_TYPETOKEN
