class CC [G, H -> DD [G]]

create

	set

feature

	set (a_item1: G; a_item2: H)
		do
			item1 := a_item1
			item2 := a_item2
		end
		
	item1: G
	item2: H

	f
		do
				-- H conforms to DD [G].
			item1 := item2.item
		end

end
