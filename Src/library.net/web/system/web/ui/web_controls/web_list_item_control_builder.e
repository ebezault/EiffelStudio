indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.ListItemControlBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_LIST_ITEM_CONTROL_BUILDER

inherit
	WEB_CONTROL_BUILDER
		redefine
			html_decode_literals,
			allow_whitespace_literals
		end

create
	make_web_list_item_control_builder

feature {NONE} -- Initialization

	frozen make_web_list_item_control_builder is
		external
			"IL creator use System.Web.UI.WebControls.ListItemControlBuilder"
		end

feature -- Basic Operations

	html_decode_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemControlBuilder"
		alias
			"HtmlDecodeLiterals"
		end

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class WEB_LIST_ITEM_CONTROL_BUILDER
