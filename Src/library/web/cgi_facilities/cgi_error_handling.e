indexing
	description: "Error Handling"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_ERROR_HANDLING
	
inherit
	CGI_IN_AND_OUT

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Basic Operations

	handle_exception is
			-- General exception hanlding.
		do
			set_error ("Internal error")
			raise_error
		end

	raise_error is
			-- Display error message `msg' and exit.
		do
			response_header.generate_text_header
			response_header.send_to_browser
			output.put_string(error_message)
			die(0)
		end

	set_error (msg: STRING) is
			-- Set error message.
		require
			msg_exists: msg /= Void
		do
			if not error_happened then
				error_message := msg
				error_happened := True
			end
		end

feature {NONE} -- Implementation

	error_happened: BOOLEAN
			-- Did an error occur?

	error_message: STRING
			-- Message describing the error.

end -- class CGI_ERROR_HANDLING
