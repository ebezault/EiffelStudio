class AA

create

	make

feature

	make
		local
			c: detachable ANY
			d: detachable STRING
		do
			c := Void
			d := Void
			if c /= d then
				print ("Failed")
			else
				print ("Passed")
			end
		end
		
end
