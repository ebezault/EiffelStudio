indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlElementEventArgs"

external class
	SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTARGS

inherit
	SYSTEM_EVENTARGS

create {NONE}

feature -- Access

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_LinePosition"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_LineNumber"
		end

	frozen get_element: SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (): System.Xml.XmlElement use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_Element"
		end

	frozen get_object_being_deserialized: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_ObjectBeingDeserialized"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTARGS
