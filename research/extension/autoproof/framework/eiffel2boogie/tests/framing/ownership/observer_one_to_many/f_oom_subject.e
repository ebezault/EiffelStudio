note
	description: "Subject that keeps a list of subscribers and notifies then of its state changes."

class F_OOM_SUBJECT

create
	make

feature {NONE} -- Initialization

	make (v: INTEGER)
			-- Create a subject with state `v' and no subscribers.
		note
			status: creator
		do
			value := v
			create subscribers.make
			set_owns ([subscribers])
		ensure
			value_set: value = v
			no_subscribers: subscribers.is_empty
		end

feature -- Public access

	value: INTEGER
			-- State.

	subscribers: F_OOM_LIST [F_OOM_OBSERVER]
			-- List of observers subscribed to the state updates.

feature -- State update

	update (v: INTEGER)
			-- Update state to `v'.
		require
			observers_wrapped: across observers as o all o.item.is_wrapped end
			modify_field (["value", "closed"], Current)
			modify_field (["cache", "closed"], subscribers.sequence)
		local
			i: INTEGER
		do
			unwrap_all (observers)
			value := v

			from
				i := 1
			invariant
				across 1 |..| (i - 1) as j all subscribers.sequence [j.item].inv end
				modify_field (["cache"], subscribers.sequence)
			until
				i > subscribers.count
			loop
				subscribers [i].notify
				i := i + 1
			end

			wrap_all (observers)
		ensure
			observers_wrapped: across observers as o all o.item.is_wrapped end
			value_set: value = v
		end

feature {F_OOM_OBSERVER} -- Internal communication

	register (o: F_OOM_OBSERVER)
			-- Add `o' to `subscribers'.
		require
			wrapped: is_wrapped
			o_open: o.is_open
		do
			unwrap
			subscribers.extend_back (o)
			wrap
		ensure
			observers_extended: observers = old observers & o
			wrapped: is_wrapped
		end

invariant
	subscribers_exists: subscribers /= Void
	owns_structure: owns = [subscribers]
	all_subscribers_exist: across subscribers.sequence.domain as i all attached subscribers.sequence [i.item] end
	observers_structure: observers = subscribers.sequence.range

note
	explicit: owns
end
