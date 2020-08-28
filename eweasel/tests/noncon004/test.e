
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit PARENT_CLASS

create
	make

feature
	make
		do
			if attached {attached NON_CONFORMING_CLASS} Current as x then
				print ("CONFORMANCE%N")
			else
				print ("NONCONFORMANCE%N")
			end
		end
end 
