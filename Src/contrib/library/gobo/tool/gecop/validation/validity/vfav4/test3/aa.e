class AA

create

	make

feature

	make
		local
			i: INTEGER
		do
			i := Current [3]
			print ("Failed")
		end

	f alias "[]" alias "[]" (i: INTEGER): INTEGER
		do
			Result := i
		end

end
