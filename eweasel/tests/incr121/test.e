
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make
		do
			create table.make (0)
			table.put ("turkey", "wimp")
		end
	
	table: HASH_TABLE [STRING, $ACTUAL_GENERIC]

end
