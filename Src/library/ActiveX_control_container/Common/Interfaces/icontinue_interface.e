indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	ICONTINUE_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	fcontinue_user_precondition: BOOLEAN is
			-- User-defined preconditions for `fcontinue'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	fcontinue is
			-- No description available.
		require
			fcontinue_user_precondition: fcontinue_user_precondition
		deferred

		end

end -- ICONTINUE_INTERFACE

