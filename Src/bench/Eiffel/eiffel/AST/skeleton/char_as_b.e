indexing

	description: "Node for character constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class CHAR_AS_B

inherit

	CHAR_AS;
		
	ATOMIC_AS_B
		undefine
			good_character, simple_format, string_value,
			is_character
		redefine
			is_character, type_check, byte_node, value_i,
			good_character, make_character, format
		end;

	CHARACTER_ROUTINES

feature -- Conveniences

	value_i: CHAR_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_char_val (value);
		end;

	type_check is
			-- Type check character
		do
			context.put (Character_type);
		end;

	byte_node: CHAR_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

	make_character: CHAR_VAL_B is
			-- Character value
		do
		   !!Result.make (value);
		end;

	format (ctxt : FORMAT_CONTEXT_B) is
		do
			ctxt.always_succeed;
			ctxt.put_text_item (ti_Quote);
			ctxt.put_string (char_text (value));
			ctxt.put_text_item (ti_Quote)
		end;

end -- class CHAR_AS_B
