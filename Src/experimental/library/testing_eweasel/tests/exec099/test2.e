
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST2 [G]
feature
	wimp (arg: G) is
		do
			io.putstring ("In wimp%N");
			print (arg); io.new_line;
		end
	
end
