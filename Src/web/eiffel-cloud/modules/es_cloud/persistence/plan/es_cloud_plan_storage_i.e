note
	description: "Interface for accessing plan from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_PLAN_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: plan

	plans: LIST [ES_CLOUD_PLAN]
		deferred
		end

	plan (a_plan_id: INTEGER): detachable ES_CLOUD_PLAN
		deferred
		end

feature -- Change

	save_plan (a_plan: ES_CLOUD_PLAN)
		deferred
		end

	delete_plan (a_plan: ES_CLOUD_PLAN)
		deferred
		end

feature -- Access: License

	licenses: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER]]
			-- Licenses
		deferred
		end

	licenses_for_plan (a_plan: ES_CLOUD_PLAN): like licenses
		deferred
		end

	license (a_license_id: INTEGER_64): detachable ES_CLOUD_LICENSE
		deferred
		end

	license_by_key (a_license_key: READABLE_STRING_GENERAL): detachable ES_CLOUD_LICENSE
		deferred
		end

	user_id_for_license (a_license: ES_CLOUD_LICENSE): INTEGER_64
		deferred
		end

	user_has_license (a_user: ES_CLOUD_USER; a_license_id: INTEGER_64): BOOLEAN
		deferred
		end

	user_licenses (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_USER_LICENSE]
		deferred
		end

	email_for_license (a_license: ES_CLOUD_LICENSE): detachable READABLE_STRING_8
		deferred
		end

	email_licenses (a_email: READABLE_STRING_8): LIST [ES_CLOUD_EMAIL_LICENSE]
		deferred
		end

feature -- Element change: license

	save_license (a_license: ES_CLOUD_LICENSE)
		deferred
		end

	assign_license_to_user (a_license: ES_CLOUD_LICENSE; a_user: ES_CLOUD_USER)
		require
			a_user.has_id
			user_id_for_license (a_license) = 0
		deferred
		ensure
			user_id_for_license (a_license) = a_user.id
		end

	assign_license_to_email (a_license: ES_CLOUD_LICENSE; a_email: READABLE_STRING_8)
		require
			user_id_for_license (a_license) = 0
			not a_email.is_whitespace
		deferred
		end

	move_email_license_to_user (a_email_license: ES_CLOUD_EMAIL_LICENSE; a_user: ES_CLOUD_USER)
		require
			a_user.has_id
		deferred
		ensure
			user_id_for_license (a_email_license.license) = a_user.id
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
