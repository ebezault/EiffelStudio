class TEST

inherit
	ANY
		export {NONE}
			print
		end

create
	make

feature

	make
		do
			print ("Hello")
		end

end
