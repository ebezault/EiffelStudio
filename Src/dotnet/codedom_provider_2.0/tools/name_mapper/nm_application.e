indexing
	description: "Objects that represent the Vision2 application.%
		%The original version of this class has been generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	NM_APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch
	
feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			default_create
			create main_window.make
			main_window.set_help_context (agent help_context)
			set_help_engine (create {CODE_HELP_ENGINE})
			main_window.show
			launch
		end
		
feature {NONE} -- Implementation

	help_context: CODE_HELP_CONTEXT is
			-- Help context
		do
			create Result.make_from_string ("tools/name_mapper.html")
		end

	main_window: NM_MAIN_WINDOW
		-- Main window of `Current'.

end -- class NM_APPLICATION

--+--------------------------------------------------------------------
--| Name Mapper
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------