indexing
	description: "Path to EiffelCodeDomProvider components"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_CODE_DOM_PATH

inherit
	ECDP_REGISTRY_KEYS
		export
			{NONE} all
		end

feature -- Access

	Codedom_installation_path: STRING is
			-- Path to installed CodeDom provider
		local
			l_retried: BOOLEAN
			l_key: REGISTRY_KEY
		once
			if not l_retried then
				l_key := feature {REGISTRY}.local_machine.open_sub_key (Setup_key, False)
				if l_key = Void then
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_setup_key, [])
				else
					Result ?= l_key.get_value (Installation_dir_value)
					if Result = Void then
						(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_installation_directory, [])
					end
				end
			end
		ensure
			ends_with_directory_separator: Result /= Void implies Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	Eiffel_compiler_path: STRING is
			-- Path to access eiffel compiler.
		once
			if Codedom_installation_path /= Void then
				create Result.make_from_string (Codedom_installation_path)
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				Result.append ("studio")
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				Result.append ("spec")
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				Result.append ("windows")
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				Result.append ("bin")
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
		ensure
			ends_with_directory_separator: Result /= Void implies Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

end -- class ECDP_CODE_DOM_PATH

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
