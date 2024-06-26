note
	description: "Eiffel deferred type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"	
	
class
	CODE_DEFERRED_TYPE
	
inherit
	CODE_GENERATED_TYPE
		redefine
			class_declaration
		end
		
create 
	make

feature -- Access

	is_interface: BOOLEAN
			-- Is generated type an interface?

feature -- Element Settings

	set_is_interface
			-- Set `is_interface' to `True'.
		do
			is_interface := True
		ensure
			is_interface_set: is_interface
		end		

feature {NONE} -- Code Generation

	class_declaration: STRING 
			-- Class declaration (including class name and qualifiers like deferred, expanded or frozen)
		do	
			create Result.make (120)
			Result.append ("deferred class")
			Result.append (Line_return)
			Result.append ("%T")
			Result.append (name.twin)
			Result.append (Line_return)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_DEFERRED_TYPE

