indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	WIRE_CLIPFORMAT_ALIAS

inherit
	X_USER_CLIPFORMAT_RECORD

creation
	make_from_alias,
	make,
	make_by_pointer

feature {NONE}  -- Initialization

	make_from_alias (an_alias: X_USER_CLIPFORMAT_RECORD) is
			-- Create from alias
		require
			non_void_alias: an_alias /= Void
		do
			make_by_pointer (an_alias.item)
			an_alias.set_shared
		end

end -- WIRE_CLIPFORMAT_ALIAS

