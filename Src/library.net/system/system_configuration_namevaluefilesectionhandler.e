indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.NameValueFileSectionHandler"

external class
	SYSTEM_CONFIGURATION_NAMEVALUEFILESECTIONHANDLER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_CONFIGURATION_ICONFIGURATIONSECTIONHANDLER

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

	frozen Create_ (parent: ANY; config_context: ANY; section: SYSTEM_XML_XMLNODE): ANY is
		external
			"IL signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Configuration.NameValueFileSectionHandler"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Configuration.NameValueFileSectionHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_CONFIGURATION_NAMEVALUEFILESECTIONHANDLER
