
--| Copyright (c) 1993-2019 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class TEST1
feature
	weasel is
		do
			p := agent weasel
			p := agent wimp
		end

	p: PROCEDURE

	wimp is
		deferred
		end
end
