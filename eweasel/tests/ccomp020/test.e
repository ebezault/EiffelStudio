--| Copyright (c) 1993-2018 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

create
	make

feature
	make
		do
			c.weasel
			create c.make
		end

	c: TEST1
end
