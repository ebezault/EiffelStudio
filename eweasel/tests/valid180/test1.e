class
	TEST1

feature

	g alias "+" (other: TEST1): TEST1 is
			--
		do

		end

	f is
		do
		ensure
			Current + Current = Current
		end


end
