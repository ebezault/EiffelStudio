indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPERSIST_PROPERTY_BAG2_INTERFACE

inherit
	IPERSIST_INTERFACE

feature -- Status Report

	init_new_user_precondition: BOOLEAN is
			-- User-defined preconditions for `init_new'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	load_user_precondition (p_prop_bag: IPROPERTY_BAG2_INTERFACE; p_err_log: IERROR_LOG_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `load'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	save_user_precondition (p_prop_bag: IPROPERTY_BAG2_INTERFACE; f_clear_dirty: INTEGER; f_save_all_properties: INTEGER): BOOLEAN is
			-- User-defined preconditions for `save'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_dirty_user_precondition: BOOLEAN is
			-- User-defined preconditions for `is_dirty'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	init_new is
			-- No description available.
		require
			init_new_user_precondition: init_new_user_precondition
		deferred

		end

	load (p_prop_bag: IPROPERTY_BAG2_INTERFACE; p_err_log: IERROR_LOG_INTERFACE) is
			-- No description available.
			-- `p_prop_bag' [in].  
			-- `p_err_log' [in].  
		require
			load_user_precondition: load_user_precondition (p_prop_bag, p_err_log)
		deferred

		end

	save (p_prop_bag: IPROPERTY_BAG2_INTERFACE; f_clear_dirty: INTEGER; f_save_all_properties: INTEGER) is
			-- No description available.
			-- `p_prop_bag' [in].  
			-- `f_clear_dirty' [in].  
			-- `f_save_all_properties' [in].  
		require
			save_user_precondition: save_user_precondition (p_prop_bag, f_clear_dirty, f_save_all_properties)
		deferred

		end

	is_dirty is
			-- No description available.
		require
			is_dirty_user_precondition: is_dirty_user_precondition
		deferred

		end

end -- IPERSIST_PROPERTY_BAG2_INTERFACE

