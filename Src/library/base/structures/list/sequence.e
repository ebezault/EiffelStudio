
indexing

	description:
		"Sequences, i.e. structures where existing items are arranged%
		%and accessed sequentially, and new ones can be added at the end.";

	copyright: "See notice at end of class";
	names: sequence;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SEQUENCE [G] inherit

	ACTIVE [G]
		redefine
				prune_all
		end;

	SEQUENTIAL [G];

	FINITE [G]

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not off
		end;


	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not off
		end;

feature -- Element change

	put, force (v: like item) is
			-- Add `v' to end.
		require else
			extendible
		do
			extend (v)
		ensure then
	 		--new_count: count = old count + 1;
			item_inserted: has (v)
		end;

	append (s: SEQUENCE [G]) is
			-- Append a copy of `s'.
		require
			argument_not_void: s /= Void
		do
			from
				s.start
			until
				s.off
			loop
				extend (s.item);
				s.forth
			end
		ensure
	 		--new_count: count >= old count
		end;

feature -- Removal

	prune (v: like item) is
			-- Remove one occurrence of `v' if any.
		do
			start;
			search (v);
			if not exhausted then
				remove
			end
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
		do
			from
				start
			until
				exhausted
			loop
				search (v);
				if not exhausted then
					remove
				end
			end
		end;

end -- class SEQUENCE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
