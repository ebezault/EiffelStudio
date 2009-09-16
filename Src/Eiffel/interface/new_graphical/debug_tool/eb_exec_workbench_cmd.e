note
	description: "Command to execute the workbench code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_WORKBENCH_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Execution

	execute
			-- Execute Current.
		do
			debugger_manager.controller.start_workbench_application (debugger_manager.current_execution_parameters)
		end

	execute_with_parameters (params: DEBUGGER_EXECUTION_PROFILE)
			-- Execute Current with parameters.
		do
			debugger_manager.controller.start_workbench_application (debugger_manager.resolved_execution_parameters (params))
		end

feature -- Properties

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon_buffer
		end

	description: STRING_GENERAL
			-- Text describing `Current' in the customize tool bar dialog.
		do
			Result := Interface_names.f_Run_workbench
		end

	tooltip: STRING_GENERAL
			-- Short description of Current.
		do
			Result := Interface_names.f_Run_workbench
		end

	tooltext: STRING_GENERAL
			-- Short description of Current.
		do
			Result := Interface_names.b_Run_workbench
		end

	name: STRING = "Run_workbench"
			-- Text internally defining Current.

	menu_name: STRING_GENERAL
			-- Name used in menu entry
		do
			Result := Interface_names.m_Run_workbench
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

end -- class EB_EXEC_WORKBENCH_CMD
