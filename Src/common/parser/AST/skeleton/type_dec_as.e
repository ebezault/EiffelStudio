-- Abstract description of a type declaration

class TYPE_DEC_AS

inherit

	AST_EIFFEL
		redefine format, fill_calls_list, replicate
	end

feature -- Attributes

	id_list: EIFFEL_LIST [ID_AS];
			-- List of ids

	type: TYPE;
			-- Type

feature -- Initialization

	set is
			-- Yacc initialization
		do
			id_list ?= yacc_arg (0);
			type ?= yacc_arg (1);
		ensure then
			good_list: id_list /= Void;
			type_exists: type /= Void
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.set_separator(",");
			ctxt.no_new_line_between_tokens;
			id_list.format (ctxt);
			ctxt.put_special(": ");
			type.format(ctxt);
			ctxt.commit;
		end;

feature  -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			type.fill_calls_list (l);
				--| useful for like ... only
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := twin;
			Result.set_type (type.twin);
			Result.set_id_list (id_list.replicate (ctxt));
				--| useful for like ... only
		end;

feature {TYPE_DEC_AS} -- Replication

	set_type (t: like type) is
		require
			valid_t: t /= Void
		do
			type := t
		end; 

	set_id_list (id: like id_list) is
		require
			valid_t: id /= Void
		do
			id_list := id
		end; 

end
