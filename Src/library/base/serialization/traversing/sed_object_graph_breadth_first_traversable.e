indexing
	description: "Objects that traverse object graphs starting at the root object in a breadth first manner."
	author: "Stephanie Balzer"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
	
inherit
	SED_OBJECT_GRAPH_TRAVERSABLE

feature {NONE} -- Implementation

	new_dispenser: ARRAYED_QUEUE [ANY] is
			-- Create the dispenser to use for storing visited objects.
		do
			create Result.make (default_size)
		end

end
