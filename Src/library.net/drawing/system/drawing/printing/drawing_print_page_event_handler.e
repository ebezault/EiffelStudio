indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PrintPageEventHandler"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PRINT_PAGE_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_drawing_print_page_event_handler

feature {NONE} -- Initialization

	frozen make_drawing_print_page_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Drawing.Printing.PrintPageEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: DRAWING_PRINT_PAGE_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Drawing.Printing.PrintPageEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Printing.PrintPageEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Printing.PrintPageEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: DRAWING_PRINT_PAGE_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Drawing.Printing.PrintPageEventArgs): System.Void use System.Drawing.Printing.PrintPageEventHandler"
		alias
			"Invoke"
		end

end -- class DRAWING_PRINT_PAGE_EVENT_HANDLER
