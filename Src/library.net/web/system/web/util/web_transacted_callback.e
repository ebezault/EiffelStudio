indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Util.TransactedCallback"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_TRANSACTED_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_transacted_callback

feature {NONE} -- Initialization

	frozen make_web_transacted_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.Util.TransactedCallback"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Util.TransactedCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Util.TransactedCallback"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Web.Util.TransactedCallback"
		alias
			"Invoke"
		end

end -- class WEB_TRANSACTED_CALLBACK
