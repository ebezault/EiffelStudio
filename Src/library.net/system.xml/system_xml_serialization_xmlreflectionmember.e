indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlReflectionMember"

external class
	SYSTEM_XML_SERIALIZATION_XMLREFLECTIONMEMBER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlReflectionMember"
		end

feature -- Access

	frozen get_soap_attributes: SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTES is
		external
			"IL signature (): System.Xml.Serialization.SoapAttributes use System.Xml.Serialization.XmlReflectionMember"
		alias
			"get_SoapAttributes"
		end

	frozen get_member_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlReflectionMember"
		alias
			"get_MemberName"
		end

	frozen get_is_return_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlReflectionMember"
		alias
			"get_IsReturnValue"
		end

	frozen get_xml_attributes: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTES is
		external
			"IL signature (): System.Xml.Serialization.XmlAttributes use System.Xml.Serialization.XmlReflectionMember"
		alias
			"get_XmlAttributes"
		end

	frozen get_member_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlReflectionMember"
		alias
			"get_MemberType"
		end

	frozen get_override_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlReflectionMember"
		alias
			"get_OverrideIsNullable"
		end

feature -- Element Change

	frozen set_member_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlReflectionMember"
		alias
			"set_MemberType"
		end

	frozen set_is_return_value (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlReflectionMember"
		alias
			"set_IsReturnValue"
		end

	frozen set_xml_attributes (value: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTES) is
		external
			"IL signature (System.Xml.Serialization.XmlAttributes): System.Void use System.Xml.Serialization.XmlReflectionMember"
		alias
			"set_XmlAttributes"
		end

	frozen set_member_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlReflectionMember"
		alias
			"set_MemberName"
		end

	frozen set_override_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlReflectionMember"
		alias
			"set_OverrideIsNullable"
		end

	frozen set_soap_attributes (value: SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTES) is
		external
			"IL signature (System.Xml.Serialization.SoapAttributes): System.Void use System.Xml.Serialization.XmlReflectionMember"
		alias
			"set_SoapAttributes"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLREFLECTIONMEMBER
