-- Eiffel class generated by the 2.3 to 3 translator.
-- Listener to ised to execute corresponding request (an IN_REQUEST)
-- Sender of request to ised (OUT_REQUEST)

class ISED_X_SLAVE 

inherit

	IO_HANDLER
		rename
			make as io_handler_create
		export
			{NONE} all
		redefine
			init_toolkit
		end;
	COMMAND_W
		export
			{NONE} all
		redefine
			init_toolkit, execute
		end;
	IO_CONST
		export
			{NONE} all
		end
	
feature {NONE}

	init_toolkit: OPENLOOK is once !!Result.make ("ewb") end;

feature 

	init_connection is
			-- Connect with ised (verify if it's ok),
			-- and watch for inputs from ised.
		local
			listen_to: UNIX_FILE
		do
			if (toolkit = Void) then io.putstring ("KATASTROPHEN!!%N") end;
			ised_x_slave_init_connect;
			io_handler_create;
			!!listen_to.make ("");
			listen_to.fd_open_read (Listen_to_const);
			set_read_call_back (listen_to, Current, Current);
			pass_adresses
		end;

feature {NONE}

	work (argument: ANY) is
		do
		end;

	execute (argument: ANY) is
		do
			received_request.execute
		end;

	pass_adresses is
			-- Create all possible kinds of IN_REQUESTs that the outside could
			-- send on the pipe `Listen_to_const', and pass the corresponding addresses to C
			-- so that C can set the proper object.
		local
			break_done: BREAK_DONE;
			except_done: EXCEPT_DONE;
			exit_done: EXIT_DONE;
			job_done: JOB_DONE
		do
			!!break_done.make;
			!!except_done.make;
			!!exit_done.make;
			!!job_done.make
		end;

feature {NONE} -- External features

	ised_x_slave_init_connect is
		external
			"C"
		alias
			"init_connect"
		end;

	received_request: IN_REQUEST is
		external
			"C"
		end

end
