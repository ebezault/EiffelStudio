
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Then uncomment declaration of feature `try' in TEST1.
	-- Recompile.  Compiler exception trace.

class 
	TEST
creation
	make
feature
	make is
		do
		end;
	
	a: TEST1 [STRING];
end

