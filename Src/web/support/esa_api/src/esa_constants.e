note
	description: "Summary description for {ESA_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONSTANTS

feature -- Access

	major: INTEGER = 0
	minor: INTEGER = 1
	built: STRING = "0001"

	version: STRING
		do
			Result := major.out + "." + minor.out + "." + built
		end

end
