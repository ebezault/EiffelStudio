indexing

	description: 
		"AST representation of a call as an expression.";
	date: "$Date$";
	revision: "$Revision$"

class EXPR_CALL_AS

inherit

	EXPR_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			call ?= yacc_arg (0);
		ensure then
			call_exists: call /= Void;
		end;

feature -- Property

	call: CALL_AS;
			-- Expression call

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (call)
		end;

feature {EXPR_CALL_AS}

	set_call (c: like call) is
		require
			valid_arg: c /= Void
		do
			call := c;
		end

end -- class EXPR_CALL_AS
