indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlGenericControl"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLGENERICCONTROL

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL
		rename
			get_tag_name as get_tag_name_string
		redefine
			get_tag_name_string
		end

create
	make_htmlgenericcontrol,
	make_htmlgenericcontrol_1

feature {NONE} -- Initialization

	frozen make_htmlgenericcontrol is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlGenericControl"
		end

	frozen make_htmlgenericcontrol_1 (tag: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.HtmlControls.HtmlGenericControl"
		end

feature -- Access

	frozen get_tag_name_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlGenericControl"
		alias
			"get_TagName"
		end

feature -- Element Change

	frozen set_tag_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlGenericControl"
		alias
			"set_TagName"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLGENERICCONTROL
