indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Options_list -> Options_list_element Options_list |

class S_OPTIONS_LIST

inherit

	RB_AGGREGATE
		rename 
			make as old_make
		end

creation
	make

feature 

	make is
		do
			old_make
			set_optional
		end

	construct_name: STRING is
		once
			Result := "OPTIONS_LIST"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			element: OPTIONS_LIST_ELEMENT
			list: OPTIONS_LIST
		once
			!! Result.make
			Result.forth

			!! element.make
			put (element)

			!! list.make
			put (list)
		end

end -- class S_OPTIONS_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
