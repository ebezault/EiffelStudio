﻿note
	description: "[
			Singly linked lists.
			Random access takes linear time. 
			Once a position is found, inserting or removing elements to the right of it takes constant time 
			and doesn't require reallocation of other elements.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence
	manual_inv: true
	false_guards: true

frozen class
	V_LINKED_LIST [G]

inherit
	V_LIST [G]
		redefine
			first,
			last,
			new_cursor,
			is_equal_,
			reverse
		end

feature -- Initialization

	copy_ (other: V_LIST [G])
			-- Initialize by copying all the items of `other'.
		note
			explicit: wrapping
		require
			observers_open: across observers as o all o.is_open end
		local
			i: V_LIST_ITERATOR [G]
		do
			if other /= Current then
				wipe_out
				i := other.new_cursor
				append (i)
				other.forget_iterator (i)
			end
		ensure
			sequence_effect: sequence ~ old other.sequence
			observers_open: across observers as o all o.is_open end
			observers_preserved: other.observers ~ old other.observers
			modify_model ("sequence", Current)
			modify_field (["observers", "closed"], other)
		end

feature -- Access

	item alias "[]" (i: INTEGER): G assign put
			-- Value at position `i'.
		do
			check inv end
			if i = count then
				Result := last
			else
				Result := cell_at (i).item
			end
		end

	first: G
			-- First element.
		do
			check inv end
			if attached first_cell as c then
				Result := c.item
			else
				check
					from_precondition: False
				then
				end
			end
		end

	last: G
			-- Last element.
		do
			check inv end
			if attached last_cell as c then
				Result := c.item
			else
				check
					from_precondition: False
				then
				end
			end
		end

feature -- Iteration

	new_cursor: like at
			-- New iterator pointing to the first position.
		note
			status: impure
		do
			create Result.make (Current)
			Result.start
		end

	at (i: INTEGER): V_LINKED_LIST_ITERATOR [G]
			-- New iterator pointing at position `i'.
		note
			status: impure
		do
			create Result.make (Current)
			check Result.inv end
			check inv_only ("lower_definition") end
			if i < 1 then
				Result.go_before
			elseif i > count then
				Result.go_after
			else
				Result.go_to (i)
			end
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is list made of the same values in the same order as `other'?
			-- (Use reference comparison.)
		local
			c1, c2: V_LINKABLE [G]
			i_: INTEGER
		do
			check inv end
			if other = Current then
				Result := True
			elseif count = other.count then
				check
					other.inv
				end
				Result := True
				c1 := first_cell
				c2 := other.first_cell
				if attached c1 then
					if not attached c2 then
						check from_same_count_and_non_empty: False then end
					end
					from
						i_ := 1
					invariant
						1 <= i_ and i_ <= sequence.count + 1
						other.inv
						i_ <= sequence.count implies c1 = cells [i_] and c2 = other.cells [i_]
						i_ = sequence.count + 1 implies c1 = Void and c2 = Void
						if Result
							then across 1 |..| (i_ - 1) as k all sequence [k] = other.sequence [k] end
							else sequence [i_ - 1] /= other.sequence [i_ - 1] end
					until
						c1 = Void or not Result
					loop
						if not attached c2 then
							check from_exit_condition_and_loop_invariant: False then end
						end
						Result := c1.item = c2.item
						c1 := c1.right
						c2 := c2.right
						i_ := i_ + 1
					variant
						sequence.count - i_
					end
				end
			end
		end

feature -- Replacement

	put (v: G; i: INTEGER)
			-- Associate `v' with index `i'.
		note
			explicit: wrapping
		do
			check inv end
			put_cell (v, cell_at (i), i)
		end

	reverse
			-- Reverse the order of elements.
		note
			explicit: wrapping
		local
			rest, next: V_LINKABLE [G]
			rest_cells: MML_SEQUENCE [V_LINKABLE [G]]
		do
			lemma_cells_distinct
			unwrap
			from
				last_cell := first_cell
				rest := first_cell
				rest_cells := cells
				first_cell := Void
				create cells
				create sequence
			invariant
				across 1 |..| count_ as i all cells.old_ [i].is_wrapped end
				rest_cells.count = count_ - cells.count
				inv_only ("cells_domain", "first_cell_empty", "cells_exist", "sequence_implementation", "cells_linked", "cells_first", "cells_last")

				rest_cells.non_void
				is_linked (rest_cells)
				not rest_cells.is_empty implies rest = rest_cells.first and rest_cells.last.right = Void
				rest_cells.is_empty = (rest = Void)

				cells.old_.tail (cells.count + 1) = rest_cells
				across 1 |..| cells.count as i all cells [i] = cells.old_ [cells.count - i + 1] end
				cells.range = cells.old_.front (cells.count).range

				modify_field (["first_cell", "cells", "sequence"], Current)
				modify_model ("right", cells.old_.range)
			until
				rest = Void
			loop
				next := rest.right
				rest.put_right (first_cell)
				first_cell := rest
				check cells.prepended (rest).range = cells.range & rest end
				cells := cells.prepended (rest)
				sequence := sequence.prepended (rest.item)
				rest := next
				rest_cells := rest_cells.but_first
			variant
				rest_cells.count
			end
			wrap
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' at the front.
		local
			cell: V_LINKABLE [G]
		do
			create cell.put (v)
			if attached first_cell as f then
				cell.put_right (f)
			else
				last_cell := cell
			end
			first_cell := cell
			count_ := count_ + 1

			cells := cells.prepended (cell)
			sequence := sequence.prepended (v)
		ensure then
			cells_preserved: old cells ~ cells.but_first
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		local
			cell: V_LINKABLE [G]
		do
			create cell.put (v)
			if first_cell = Void then
				first_cell := cell
			else
				if attached last_cell as l then
					l.put_right (cell)
				else
					check from_condition: False then end
				end
			end
			last_cell := cell
			count_ := count_ + 1

			cells := cells & cell
			sequence := sequence & v
		ensure then
			cells_preserved: old cells ~ cells.but_last
		end

	extend_at (v: G; i: INTEGER)
			-- Insert `v' at position `i'.
		note
			explicit: wrapping
		do
			check inv end
			if i = 1 then
				extend_front (v)
			elseif i = count + 1 then
				extend_back (v)
			else
				extend_after (create {V_LINKABLE [G]}.put (v), cell_at (i - 1), i - 1)
			end
		end

	prepend (input: V_ITERATOR [G])
			-- Prepend sequence of values, over which `input' iterates.
		note
			explicit: wrapping
		local
			it: V_LINKED_LIST_ITERATOR [G]
		do
			if not input.after then
				check input.inv end
				extend_front (input.item)
				input.forth

				from
					it := new_cursor
				invariant
					1 <= input.index_ and input.index_ <= input.sequence.count + 1
					1 <= it.index_ and it.index_ <= it.sequence.count
					it.index_ = input.index_ - input.index_.old_
					sequence ~ input.sequence.interval (input.index_.old_, input.index_ - 1) + sequence.old_
					is_wrapped
					input.is_wrapped
					it.is_wrapped
					it.target = Current
					observers = observers.old_ & it
					across observers.old_ as o all o.is_open end
					cells.old_ ~ cells.tail (it.index_ + 1)
				until
					input.after
				loop
					check it.inv_only ("no_observers", "subjects_definition", "sequence_definition") end
					it.extend_right (input.item)
					check it.inv_only ("sequence_definition") end
					it.forth
					input.forth
				variant
					input.sequence.count - input.index_
				end
				forget_iterator (it)
			end
		ensure then
			cells_preserved: old cells ~ cells.tail (input.sequence.count - old input.index_ + 2)
		end

	insert_at (input: V_ITERATOR [G]; i: INTEGER)
			-- Insert sequence of values, over which `input' iterates, starting at position `i'.
		note
			explicit: wrapping
		local
			it: V_LINKED_LIST_ITERATOR [G]
			s: like sequence
		do
			if i = 1 then
				prepend (input)
			else
				from
					it := at (i - 1)
					check input.inv_only ("subjects_definition", "index_constraint", "no_observers") end
					check inv_only ("lower_definition") end
					create s
				invariant
					1 <= input.index_ and input.index_ <= input.sequence.count + 1
					i - 1 <= it.index_
					it.index_ <= it.sequence.count
					it.index_ - i + 1 = input.index_ - input.index_.old_
					s = input.sequence.interval (input.index_.old_, input.index_ - 1)
					sequence ~ sequence.old_.front (i - 1) + s + sequence.old_.tail (i)
					is_wrapped
					input.is_wrapped
					it.is_wrapped
					it.target = Current
					observers = observers.old_ & it
					across observers.old_ as o all o.is_open end
				until
					input.after
				loop
					check it.inv_only ("no_observers", "subjects_definition", "sequence_definition") end
					it.extend_right (input.item)
					s := s & input.item
					check it.inv_only ("sequence_definition") end
					it.forth
					input.forth
				variant
					input.sequence.count - input.index_
				end
				forget_iterator (it)
			end
		end

feature -- Removal

	remove_front
			-- Remove first element.
		do
			if attached first_cell as f then
				if count_ = 1 then
					last_cell := Void
				else
					check f.right = cells [2] end
				end
				first_cell := f.right
			else
				check from_precondition: False then end
			end
			count_ := count_ - 1

			cells := cells.but_first
			sequence := sequence.but_first
		ensure then
			cells_preserved: cells ~ old cells.but_first
		end

	remove_back
			-- Remove last element.
		note
			explicit: wrapping
		do
			check inv end
			if count = 1 then
				wipe_out
				check inv_only ("cells_domain") end
			else
				remove_after (cell_at (count - 1), count - 1)
			end
		ensure then
			cells_preserved: cells ~ old cells.but_last
		end

	remove_at  (i: INTEGER)
			-- Remove element at position `i'.
		note
			explicit: wrapping
		do
			check inv end
			if i = 1 then
				remove_front
			else
				remove_after (cell_at (i - 1), i - 1)
			end
		ensure then
			cells_preserved: cells ~ old cells.removed_at (i)
		end

	wipe_out
			-- Remove all elements.
		do
			first_cell := Void
			last_cell := Void
			count_ := 0
			create cells
			create sequence
		ensure then
			old_cells_wrapped: across old owns as c all c.is_wrapped end
			cells_exist: (old cells).non_void
			cells_linked: is_linked (old cells)
			items_unchanged: across 1 |..| old sequence.count as i all (old sequence) [i] = (old cells) [i].item end
			cells_last: old cells.count > 0 implies (attached old last_cell as c and then not attached c.right)
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	first_cell: detachable V_LINKABLE [G]
			-- First cell of the list.

	last_cell: detachable V_LINKABLE [G]
			-- Last cell of the list.

	cell_at (i: INTEGER): V_LINKABLE [G]
			-- Cell at position `i'.
		require
			valid_position: 1 <= i and i <= cells.count
			inv_only ("cells_domain", "cells_exist", "cells_first", "cells_linked")
		local
			j: INTEGER
		do
			from
				j := 1
				Result := first_cell
				if not attached Result then
					check from_precondition: False then end
				end
			invariant
				1 <= j and j <= i
				Result = cells [j]
			until
				j = i
			loop
				if not attached Result then
					check from_loop_invariant: False then end
				end
				Result := Result.right
				j := j + 1
			end
		ensure
			definition: Result = cells [i]
		end

	put_cell (v: G; c: V_LINKABLE [G]; index_: INTEGER)
			-- Put `v' into `c' located at `index_'.
		require
			index_in_domain: cells.domain [index_]
			c_in_list: cells [index_] = c
			wrapped: is_wrapped
			observers_open: across observers as o all o.is_open end
		do
			lemma_cells_distinct
			unwrap
			c.put (v)
			sequence := sequence.replaced_at (index_, v)
			wrap
		ensure
			sequence ~ old sequence.replaced_at (index_, v)
			cells ~ old cells
			wrapped: is_wrapped
			modify_model ("sequence", Current)
		end

	extend_after (new, c: V_LINKABLE [G]; index_: INTEGER)
			-- Add a new cell with value `v' after `c'.
		require
			wrapped: is_wrapped
			observers_open: across observers as o all o.is_open end
			new_is_wrapped: new.is_wrapped

			new_not_current: new /= Current
			index_in_domain: 1 <= index_ and index_ <= cells.count
			c_in_list: cells [index_] = c
			new_right_void: new.right = Void
		do
			lemma_cells_distinct
			unwrap

			check index_ < cells.count implies c.right = cells [index_ + 1] end

			if c.right = Void then
				last_cell := new
			else
				new.put_right (c.right)
			end
			c.put_right (new)
			count_ := count_ + 1

			cells := cells.extended_at (index_ + 1, new)
			sequence := sequence.extended_at (index_ + 1, new.item)
			wrap
		ensure
			sequence ~ old sequence.extended_at (index_ + 1, new.item)
			cells ~ old cells.extended_at (index_ + 1, new)
			wrapped: is_wrapped
			modify_model ("sequence", Current)
			modify_model ("right", new)
		end

	remove_after (c: V_LINKABLE [G]; index_: INTEGER)
			-- Remove the cell to the right of `c'.
		require
			valid_index: 1 <= index_ and index_ <= sequence.count - 1
			c_in_list: cells [index_] = c
			wrapped: is_wrapped
			observers_open: across observers as o all o.is_open end
		do
			lemma_cells_distinct
			unwrap
			check c.right = cells [index_ + 1] end
			if attached c.right as r then
				check index_ + 1 < cells.count implies r.right = cells [index_ + 2] end
				c.put_right (r.right)
				if c.right = Void then
					last_cell := c
				end
			else
				check from_precondition: False then end
			end
			count_ := count_ - 1

			cells := cells.removed_at (index_ + 1)
			sequence := sequence.removed_at (index_ + 1)
			wrap
		ensure
			sequence ~ old sequence.removed_at (index_ + 1)
			cells ~ old cells.removed_at (index_ + 1)
			wrapped: is_wrapped
			modify_model ("sequence", Current)
		end

	merge_after (other: V_LINKED_LIST [G]; c: detachable V_LINKABLE [G]; index_: INTEGER)
			-- Merge `other' into `Current' after cell `c'. If `c' is `Void', merge to the front.
		require
			valid_index: 0 <= index_ and index_ <= cells.count
			c_void_if_before: (index_ = 0) = (c = Void)
			c_in_list_if_in_domain: 1 <= index_ implies cells [index_] = c
			other_not_current: other /= Current
			wrapped: is_wrapped
			other_wrapped: other.is_wrapped
			observers_open: across observers as o all o.is_open end
			other_observers_open: across other.observers as o all o.is_open end
		local
			other_first, other_last: V_LINKABLE [G]
			other_count: INTEGER
		do
			check other.inv_only ("count_definition", "cells_domain", "first_cell_empty", "owns_definition", "cells_first", "cells_last") end
			other_count := other.count_
			if other_count > 0 then
				lemma_cells_distinct
				other.lemma_cells_distinct

				other_first := other.first_cell
				other_last := other.last_cell
				if
					not attached other_first or else
					not attached other_last
				then
					check from_condition: False then end
				end
				other.wipe_out

				unwrap
				if c = Void then
					if attached first_cell as f then
						other_last.put_right (f)
					else
						last_cell := other_last
					end
					first_cell := other_first
				else
					check index_ < cells.count implies c.right = cells [index_ + 1] end
					if c.right = Void then
						last_cell := other_last
					else
						other_last.put_right (c.right)
					end
					c.put_right (other_first)
				end
				count_ := count_ + other_count
				cells := cells.front (index_) + other.cells.old_ + cells.tail (index_ + 1)
				sequence := sequence.front (index_) + other.sequence.old_ + sequence.tail (index_ + 1)
				wrap
			end
		ensure
			wrapped: is_wrapped
			other_wrapped: other.is_wrapped
			sequence_effect: sequence = old (sequence.front (index_) + other.sequence + sequence.tail (index_ + 1))
			other_sequence_effect: other.sequence.is_empty
			cells_effect: cells = old (cells.front (index_) + other.cells + cells.tail (index_ + 1))
			modify_model ("sequence", [Current, other])
		end

feature -- Specificaton

	cells: MML_SEQUENCE [V_LINKABLE [G]]
			-- Sequence of linakble cells.
		note
			status: ghost
		attribute
 			check is_executable: False then end
		end

feature {V_CONTAINER, V_ITERATOR} -- Specificaton	

	lemma_cells_distinct
			-- All cells in `cells' are distinct.
		note
			status: lemma
		require
			closed
		do
			check inv end
			if cells.count > 0 then
				lemma_cells_distinct_from (1)
			end
		ensure
			cells_distinct: cells.no_duplicates
		end

	lemma_cells_distinct_from (i: INTEGER)
			-- All cells in `cells' starting from `i' are distinct.
		note
			status: lemma
		require
			in_bounds: 1 <= i and i <= cells.count
			inv_only ("cells_domain", "cells_exist", "cells_linked", "cells_last")
			decreases (cells.count - i)
		do
			if i /= cells.count then
				lemma_cells_distinct_from (i + 1)
				check cells [i].right = cells [i + 1] end
				check across (i + 1) |..| (cells.count - 1) as j all cells [j].right = cells [j + 1] end end
			end
		ensure
			cells_distinct: across i |..| cells.count as j all
				across i |..| cells.count as k all
					j < k implies cells [j] /= cells [k]
				end
			end
		end

	is_linked (cs: like cells): BOOLEAN
			-- Are adjacent cells of `cs' liked to each other?
		note
			status: ghost, functional, static
		require
			cs.non_void
			reads_field ("right", cs)
		do
			Result := across 1 |..| cs.count as i all
				across 1 |..| cs.count as j all
					i + 1 = j implies cs [i].right = cs [j] end end
		end

invariant
	cells_domain: sequence.count = cells.count
	first_cell_empty: cells.is_empty = (first_cell = Void)
	last_cell_empty: cells.is_empty = (last_cell = Void)
	owns_definition: owns = cells.range
	cells_exist: cells.non_void
	sequence_implementation: across 1 |..| cells.count as i all sequence [i] = cells [i].item end
	cells_linked: is_linked (cells)
	cells_first: cells.count > 0 implies first_cell = cells.first
	cells_last: cells.count > 0 implies attached last_cell as l and then l = cells.last and then l.right = Void

note
	explicit: observers
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
