class AA

create

	make

feature

	make
		local
			c: ANY
			d: ANY
		do
			c := {INTEGER_8} 4
			d := {CHARACTER_8} '%/4/'
			if c /~ d then
				print ("Passed")
			else
				print ("Failed")
			end
		end
		
end
