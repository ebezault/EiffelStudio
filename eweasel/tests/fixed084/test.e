
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
	
	-- To reproduce the error:
	-- Compile with classes as is.

create
	make
feature
	
	make
		local
			x: TEST1;
		do 
			create x;
			x.f;
			x.h;
		end;

end 
