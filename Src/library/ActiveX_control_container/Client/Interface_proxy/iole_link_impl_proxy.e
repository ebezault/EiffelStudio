indexing
	description: "Implemented `IOleLink' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_LINK_IMPL_PROXY

inherit
	IOLE_LINK_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_link_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	set_update_options (dw_update_opt: INTEGER) is
			-- No description available.
			-- `dw_update_opt' [in].  
		do
			ccom_set_update_options (initializer, dw_update_opt)
		end

	get_update_options (pdw_update_opt: INTEGER_REF) is
			-- No description available.
			-- `pdw_update_opt' [out].  
		do
			ccom_get_update_options (initializer, pdw_update_opt)
		end

	set_source_moniker (pmk: IMONIKER_INTERFACE; rclsid: ECOM_GUID) is
			-- No description available.
			-- `pmk' [in].  
			-- `rclsid' [in].  
		local
			pmk_item: POINTER
			a_stub: ECOM_STUB
		do
			if pmk /= Void then
				if (pmk.item = default_pointer) then
					a_stub ?= pmk
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pmk_item := pmk.item
			end
			ccom_set_source_moniker (initializer, pmk_item, rclsid.item)
		end

	get_source_moniker (ppmk: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `ppmk' [out].  
		do
			ccom_get_source_moniker (initializer, ppmk)
		end

	set_source_display_name (psz_status_text: STRING) is
			-- No description available.
			-- `psz_status_text' [in].  
		do
			ccom_set_source_display_name (initializer, psz_status_text)
		end

	get_source_display_name (ppsz_display_name: CELL [STRING]) is
			-- No description available.
			-- `ppsz_display_name' [out].  
		do
			ccom_get_source_display_name (initializer, ppsz_display_name)
		end

	bind_to_source (bindflags: INTEGER; pbc: IBIND_CTX_INTERFACE) is
			-- No description available.
			-- `bindflags' [in].  
			-- `pbc' [in].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			ccom_bind_to_source (initializer, bindflags, pbc_item)
		end

	bind_if_running is
			-- No description available.
		do
			ccom_bind_if_running (initializer)
		end

	get_bound_source (ppunk: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `ppunk' [out].  
		do
			ccom_get_bound_source (initializer, ppunk)
		end

	unbind_source is
			-- No description available.
		do
			ccom_unbind_source (initializer)
		end

	update (pbc: IBIND_CTX_INTERFACE) is
			-- No description available.
			-- `pbc' [in].  
		local
			pbc_item: POINTER
			a_stub: ECOM_STUB
		do
			if pbc /= Void then
				if (pbc.item = default_pointer) then
					a_stub ?= pbc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pbc_item := pbc.item
			end
			ccom_update (initializer, pbc_item)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_link_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_set_update_options (cpp_obj: POINTER; dw_update_opt: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_get_update_options (cpp_obj: POINTER; pdw_update_opt: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_set_source_moniker (cpp_obj: POINTER; pmk: POINTER; rclsid: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](ecom_control_library::IMoniker *,GUID *)"
		end

	ccom_get_source_moniker (cpp_obj: POINTER; ppmk: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_set_source_display_name (cpp_obj: POINTER; psz_status_text: STRING) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_get_source_display_name (cpp_obj: POINTER; ppsz_display_name: CELL [STRING]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_bind_to_source (cpp_obj: POINTER; bindflags: INTEGER; pbc: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_INTEGER,ecom_control_library::IBindCtx *)"
		end

	ccom_bind_if_running (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"]()"
		end

	ccom_get_bound_source (cpp_obj: POINTER; ppunk: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_unbind_source (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"]()"
		end

	ccom_update (cpp_obj: POINTER; pbc: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](ecom_control_library::IBindCtx *)"
		end

	ccom_delete_iole_link_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_link_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleLink_impl_proxy %"ecom_control_library_IOleLink_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IOLE_LINK_IMPL_PROXY

