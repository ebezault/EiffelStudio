indexing
	description:
		"Action sequences for EV_GAUGE_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_GAUGE_ACTION_SEQUENCES_I


feature -- Event handling

	change_actions: EV_VALUE_CHANGE_ACTION_SEQUENCE is
			-- Actions to be performed when `value' changes.
		do
			if change_actions_internal = Void then
				change_actions_internal :=
					 create_change_actions
			end
			Result := change_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_change_actions: EV_VALUE_CHANGE_ACTION_SEQUENCE is
			-- Create a change action sequence.
		deferred
		end

	change_actions_internal: EV_VALUE_CHANGE_ACTION_SEQUENCE
			-- Implementation of once per object `change_actions'.

end
