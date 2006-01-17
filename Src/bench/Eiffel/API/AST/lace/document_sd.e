indexing
	description: "AST structure in Lace file for document option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class DOCUMENT_SD

inherit

	OPTION_SD

feature -- Properties

	option_name: STRING is "document"

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			document_name: STRING;
			d_name: DIRECTORY_NAME;
			error_raised: BOOLEAN
		do
			if value /= Void then
				document_name := value.value;	
				if list = Void then
					create d_name.make_from_string (document_name);
				else
					error_raised := True;
					error (value);
				end;
			end;
			if not error_raised then
				if list = Void then
					Context.current_cluster.set_document_path (d_name)
				end
			end;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class DOCUMENT_SD 
