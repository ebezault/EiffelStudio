indexing

	description:
		"Sequential, dynamically modifiable lists, %
		%without commitment to a particular representation"

	copyright: "See notice at end of class";
	names: dynamic_list, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DYNAMIC_LIST [G] inherit

	LIST [G]
		undefine
			off, prune,
			sequential_index_of, sequential_has,
			remove, prune_all
		end;

	DYNAMIC_CHAIN [G]
		rename
			wipe_out as chain_wipe_out
		export
			{NONE} chain_wipe_out
		undefine
			search
		redefine
			add_left, add_right,
			remove_left, remove_right
		end;

	DYNAMIC_CHAIN [G]
		undefine
			search
		redefine
			add_left, add_right,
			remove_left, remove_right, wipe_out
		select
			wipe_out
		end

feature -- Element change

	add_left (v: like item) is
			-- Put `v' to the left of cursor position.
			-- Do not move cursor.
		require else
			not_before: not before
		local
			temp: like item
		do
			if after then
				back;
				add_right (v);
				move (2)
			else
				temp := item;
				replace (v);
				add_right (temp);
				forth
			end
		end;

	add_right (v: like item) is
			-- Put `v' to the right of cursor position.
			-- Do not move cursor.
		require else
			not_after: not after
		deferred
		end;

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		require else
			not_before: not before;
			other_exists: other /= Void
		do
			from
				other.start
			until
				other.empty
			loop
				add_left (other.item);
				other.remove
			end
		end;

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		require else
			not_after: not after;
			other_exists: other /= Void
		do
			from
				other.finish
			until
				other.empty
			loop
				add_right (other.item);
				other.back;
				other.remove_right
			end
		end;

feature -- Removal

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		deferred
		ensure then
			empty implies after
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require else
			not_before: not before
		deferred
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		deferred
		end;

	wipe_out is
			-- Remove all elements.
		do
			chain_wipe_out;
			back
		ensure then
			before: before
		end;

feature -- Obsolete

	put_left (v: like item) is obsolete "Use ``add_left''"
		require
			not_offleft_unless_empty: offleft implies empty
		do
			if before then forth end;
			add_left (v)
		end;

	put_right (v: like item) is obsolete "Use ``add_right''"
		require
			not_offright_unless_empty: offright implies empty
		do
			if after then back end;
			add_right (v)
		end;

end -- class DYNAMIC_LIST


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
