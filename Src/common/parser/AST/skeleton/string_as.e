indexing

	description: 
		"AST representation for string constants.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_AS

inherit

	PART_COMPARABLE;
	ATOMIC_AS;
	CHARACTER_ROUTINES

feature {NONE} -- Initilization

	set is
			-- Yacc initialization
		do
			value ?= yacc_arg (0);
		ensure then
			value_exists: value /= Void;
		end;

feature -- Properties

	value: STRING;
			-- Integer value

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := value < other.value
		end;

feature -- Output

	string_value: STRING is
		do
			Result := eiffel_string (value)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Double_quote);
			ctxt.put_string (eiffel_string (value));
			ctxt.put_text_item_without_tabs (ti_Double_quote);
		end;

feature {INFIX_AS} 

	set_value (s: STRING) is
		do
			value := s;
		end;

end -- class STRING_AS
