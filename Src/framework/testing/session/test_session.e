﻿note
	description: "Base implementation of {TEST_SESSION_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SESSION

inherit
	TEST_SESSION_I

	SHARED_LOCALE

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite; a_is_gui: BOOLEAN)
			-- Initizialize `Current'.
			--
			-- `a_test_suite': Test suite instanciating `Current'.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
		do
			test_suite := a_test_suite
			is_gui := a_is_gui
			create proceeded_event
			create error_event
		ensure
			test_suite_set: test_suite = a_test_suite
			is_gui_set: is_gui = a_is_gui
		end

feature -- Access

	test_suite: TEST_SUITE_S
			-- <Precursor>

	connection: EVENT_CONNECTION_I [TEST_SESSION_OBSERVER, TEST_SESSION_I]
			-- <Precursor>
		local
			l_result: like connection_cache
		do
			l_result := connection_cache
			if l_result = Void then
				l_result := create {EVENT_CONNECTION [TEST_SESSION_OBSERVER, TEST_SESSION_I]}.make (
					agent (an_observer: TEST_SESSION_OBSERVER): ARRAY [TUPLE[ EVENT_TYPE [TUPLE], PROCEDURE]]
						do
							Result := {ARRAY [TUPLE [EVENT_TYPE, PROCEDURE]]} <<
									[proceeded_event, agent an_observer.on_proceeded],
									[error_event, agent an_observer.on_error]
								>>
						end)
				connection_cache := l_result
			end
			Result := l_result
		end

feature -- Status report

	is_gui: BOOLEAN
			-- Are we launched from the UI or from batch?

feature {NONE} -- Status setting

	clean_record
			-- If `record_cache' is attached, call `complete' on it and set `record_cache' Void.
		do
			if attached record_cache as l_record then
				if l_record.is_running then
					l_record.complete
				end
				record_cache := Void
			end
		ensure
			old_record_not_running: (attached old record_cache as l_record) implies not l_record.is_running
			record_cache_detached: record_cache = Void
		end

feature {NONE} -- Basic operations

	append_output (a_procedure: PROCEDURE [TEXT_FORMATTER]; a_activate: BOOLEAN)
			-- Append output for `Current'.
			--
			-- `a_precedure': Procedure called with corresponding {TEXT_FORMATTER} instance.
			-- `a_active': Force activation of {OUTPUT_I} instance before calling `a_procedure'
			--             (make sure testing output window is visible).
		require
			a_procedure_attached: a_procedure /= Void
		do
			if attached test_suite.output (Current) as l_output then
				if a_activate then
					l_output.activate (True)
				end
				l_output.lock
				a_procedure (l_output.formatter)
				l_output.unlock
			end
		end

feature {NONE} -- Events

	proceeded_event: EVENT_TYPE [TUPLE [TEST_SESSION_I]]
			-- <Precursor>

	error_event: EVENT_TYPE [TUPLE [session: TEST_SESSION_I; error: READABLE_STRING_GENERAL]]
			-- <Precursor>

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
