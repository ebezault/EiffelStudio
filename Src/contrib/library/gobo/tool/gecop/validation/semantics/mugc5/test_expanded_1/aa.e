class AA

create

	make

feature

	make
		do
			b.set_value (2)
			print ("## copy expected%N")
			f (b)
		end

	b: BB

	f (a: BB)
		do
			print ("##%N")
			print ("b.value = " + b.value.out + "%N")
			print ("a.value = " + a.value.out + "%N")
			b.set_value (3)
			print ("b.value = " + b.value.out + "%N")
			print ("a.value = " + a.value.out + "%N")
			a.set_value (4)
			print ("b.value = " + b.value.out + "%N")
			print ("a.value = " + a.value.out + "%N")
		end

end
