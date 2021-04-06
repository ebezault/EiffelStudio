note
	description: "Summary description for {SCM_STATUS_GRID}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_GRID

inherit
	SCM_GRID
		redefine
			initialize
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create,
			copy
		end

create
	make_with_workspace

feature {NONE} -- Initialization

	make_with_workspace (box: SCM_STATUS_BOX; ws: SCM_WORKSPACE)
		do
			default_create
			status_box := box
			set_workspace (ws)
		end

	initialize
		do
			Precursor

			set_column_count_to (4)
			column (checkbox_column).set_title ("")
			column (name_column).set_title ("Name")
			column (scm_column).set_title ("SCM")
			column (info_column).set_title ("...")

			set_auto_resizing_column (checkbox_column, True)
--			column (checkbox_column).set_width (20)
			set_auto_resizing_column (name_column, True)
			set_auto_resizing_column (scm_column, True)

			row_select_actions.extend (agent on_row_selected)
			row_deselect_actions.extend (agent on_row_deselected)

			enable_default_tree_navigation_behavior (True, True, True, True)
			key_press_actions.extend (agent  (k: EV_KEY)
				do
					if k.code = {EV_KEY_CONSTANTS}.key_space then
						if attached selected_rows_in_grid as lst then
							across
								lst as ic
							loop
								if attached {EV_GRID_CHECKABLE_LABEL_ITEM} ic.item.item (checkbox_column) as cb then
									cb.toggle_is_checked
								end
							end
						end
					end
				end
			)
		end

feature -- Events

	on_row_selected (r: EV_GRID_ROW)
		do
			if attached {SCM_STATUS_WC_ROW} r.data as l_wc_row then
				on_wc_selected (l_wc_row)
			end
		end

	on_row_deselected (r: EV_GRID_ROW)
		do
			if attached {SCM_STATUS_WC_ROW} r.data as l_wc_row then
				on_wc_deselected (l_wc_row)
			end
		end

	on_wc_selected (a_repo: SCM_STATUS_WC_ROW)
		do
			status_box.set_selected_repository (a_repo.root_location)
			if a_repo.changes_count > 0 then
				status_box.save_selected_repo_button.enable_sensitive
			else
				status_box.save_selected_repo_button.disable_sensitive
			end
		end

	on_wc_deselected (a_repo: SCM_STATUS_WC_ROW)
		do
			status_box.set_selected_repository (Void)
		end

	on_changes_updated (a_repo: SCM_STATUS_WC_ROW)
		local
			nb: INTEGER
		do
			across
				scm_rows as ic
			loop
				nb := nb + ic.item.changes_count
			end
			if nb > 0 then
				status_box.save_all_repo_button.enable_sensitive
			else
				status_box.save_all_repo_button.disable_sensitive
			end
			if
				attached status_box.selected_repository as loc and then
				loc.same_as (a_repo.root_location)
			then
				if a_repo.changes_count > 0 then
					status_box.save_selected_repo_button.enable_sensitive
				else
					status_box.save_selected_repo_button.disable_sensitive
				end
			end
		end

feature -- Access

	status_box: detachable SCM_STATUS_BOX

	workspace: detachable SCM_WORKSPACE

	scm_rows: detachable ARRAYED_LIST [SCM_STATUS_WC_ROW]

	unversioned_files_included: BOOLEAN

feature -- Query

	changes_for	(loc: SCM_LOCATION): detachable SCM_CHANGELIST
		local
		do
			across
				scm_rows as ic
			until
				Result /= Void
			loop
				if attached ic.item as l_row and then l_row.root_location.location.same_as (loc.location) then
					Result := l_row.changes
				end
			end
		end

feature -- Layout settings

	checkbox_column: INTEGER = 2
	name_column: INTEGER = 1
	scm_column: INTEGER = 3
	info_column: INTEGER = 4

feature -- Operations

	populate
		local
			r: SCM_LOCATION
			l_row: EV_GRID_ROW
			i: INTEGER
			l_supported: BOOLEAN
			l_wc_row: SCM_STATUS_WC_ROW
		do
			set_row_count_to (0)
--			scm_rows := Void
			create scm_rows.make (1)
			if
				attached workspace as ws and then
				attached ws.locations_by_root as locs and then
				not locs.is_empty
			then
--				set_row_count_to (locs.count)
				across
					locs as ic
				loop
					i := i + 1
					insert_new_row (row_count + 1)
					l_row := row (row_count)
					r := ic.item.root
					l_supported := True
					if attached {SCM_SVN_LOCATION} r as r_svn then
						create {SCM_SVN_ROW} l_wc_row.make (Current, r_svn, ic.item.groups)
					elseif attached {SCM_GIT_LOCATION} r as r_git then
						create {SCM_GIT_ROW} l_wc_row.make (Current, r_git, ic.item.groups)
					else
						create {SCM_UNSUPPORTED_ROW} l_wc_row.make (Current, r, ic.item.groups)
						l_supported := False
					end
					l_wc_row.attach_to_grid_row (Current, l_row)
					scm_rows.force (l_wc_row)
				end
--				resize_columns
			end
		end

	fill_empty_grid_items (r: EV_GRID_ROW)
		local
			i, n: INTEGER
		do
			from
				i := 1
				n := column_count
			until
				i > n
			loop
				if i > r.count or else r.item (i) = Void then
					r.set_item (i, create {EV_GRID_ITEM})
				end
				i := i + 1
			end
		end

	reset
		do
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					ic.item.reset
				end
				refresh_now
			end
		end

	update_statuses (loc: detachable SCM_LOCATION)
		do
			if attached scm_rows as lst then
				across
					lst as ic
				loop
					if loc = Void or else loc.same_as (ic.item.root_location) then
						ic.item.update_statuses
					end
				end
				refresh_now
			end
		end

feature -- Basic operation

	set_workspace (ws: SCM_WORKSPACE)
		do
			workspace := ws
			populate
		end

	include_unversioned_files (b: BOOLEAN)
		do
			if unversioned_files_included /= b then
				unversioned_files_included := b
				update_statuses (Void)
			end
		end

invariant

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
