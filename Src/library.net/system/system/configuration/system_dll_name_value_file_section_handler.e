indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.NameValueFileSectionHandler"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_NAME_VALUE_FILE_SECTION_HANDLER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICONFIGURATION_SECTION_HANDLER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Configuration.NameValueFileSectionHandler"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Configuration.NameValueFileSectionHandler"
		alias
			"GetHashCode"
		end

	frozen create_ (parent: SYSTEM_OBJECT; config_context: SYSTEM_OBJECT; section: SYSTEM_XML_XML_NODE): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Configuration.NameValueFileSectionHandler"
		alias
			"Create"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Configuration.NameValueFileSectionHandler"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Configuration.NameValueFileSectionHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Configuration.NameValueFileSectionHandler"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_NAME_VALUE_FILE_SECTION_HANDLER
