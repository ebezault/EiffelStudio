note
	description: "Summary description for {WDOCS_EDIT_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_MODULE

inherit
	CMS_MODULE
		redefine
			register_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	WDOCS_MODULE_HELPER

create
	make

feature {NONE} -- Initialization

	make (wdocs: WDOCS_MODULE)
			-- Create current module
		do
			wdocs_module := wdocs
			version := "1.0"
			description := "Wiki Documentation Editing"
			package := "doc"
		end

feature -- Access

	name: STRING = "wdocs_edit"

	wdocs_module: WDOCS_MODULE

	wdocs_api: detachable WDOCS_API
		do
			Result := wdocs_module.wdocs_api
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		local
			h: WSF_URI_TEMPLATE_AGENT_HANDLER
		do
				-- Router			
			create h.make (agent handle_wikipage_source (a_api, ?, ?))
			a_router.handle ("/doc/{bookid}/{wikipageid}/source", h, a_router.methods_get)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/source", h, a_router.methods_get)

			create h.make (agent handle_wikipage_editing (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/edit", h, a_router.methods_get_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/edit", h, a_router.methods_get_post)

			create h.make (agent handle_wikipage_editing (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/add-child", h, a_router.methods_get_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/add-child", h, a_router.methods_get_post)

			create h.make (agent handle_wikipage_html_preview (a_api, ?, ?))
--			a_router.handle ("/doc/{bookid}/{wikipageid}/preview", h, a_router.methods_post)
			a_router.handle ("/doc/version/{version_id}/{bookid}/{wikipageid}/preview", h, a_router.methods_post)
		end

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		do
			Result := Precursor
			Result.force ("admin wdocs")
			Result.force ("edit wdocs page")
			Result.force ("create wdocs page")
			Result.force ("delete wdocs page")

			Result.force ("edit any wdocs page")
			Result.force ("delete any wdocs page")
			Result.force ("edit own wdocs page")
			Result.force ("delete own wdocs page")

			Result.force ("clear wdocs cache")
		end

feature -- Helper

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		do
			Result := wdocs_module.manager (a_version_id)
		end

feature -- Handlers

	handle_wikipage_source (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if req.is_get_request_method then
				if
					attached wdocs_module.wikipage_data_from_request (req) as pg_info and then
					attached pg_info.page as pg and then
					attached wdocs_api as l_wdocs_api and then
					attached l_wdocs_api.wiki_text (pg) as l_wiki_text
				then
					if attached pg.path as l_path then
						res.header.put_header_key_value ("X-WDOCS-file-location", l_path.utf_8_name)
						res.header.put_utc_date (file_date (l_path))
					end
					res.header.put_content_type_utf_8_text_plain
					res.header.put_content_length (l_wiki_text.count)
					res.put_string (l_wiki_text)
				else
					res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.not_found))
				end
			else
				res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
			end
		end

	handle_wikipage_editing (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if attached wdocs_api as l_api then
				if req.is_get_request_method then
					create {WDOCS_EDIT_FORM_RESPONSE} r.make (req, res, api, l_api, Current)
				elseif req.is_post_request_method then
					create {WDOCS_EDIT_FORM_RESPONSE} r.make (req, res, api, l_api, Current)
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				end
			else
				check has_wdocs_api: False end
				create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute
		end

	handle_wikipage_html_preview (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_xhtml: STRING
			l_preview_pg: like manager.new_wiki_page
			l_field: READABLE_STRING_GENERAL
			utf: UTF_CONVERTER
			wvis: WDOCS_WIKI_XHTML_GENERATOR
		do
			if req.is_post_request_method then
				if attached {WSF_STRING} req.query_parameter ("source_field") as s then
					l_field := s.value
				else
					l_field := "source"
				end
				if
					attached {WSF_STRING} req.form_parameter (l_field) as p_source and then
					attached wdocs_module.wikipage_data_from_request (req) as pg_info and then
					attached pg_info.manager as l_manager and then
					attached pg_info.page as pg and then
					attached pg.path as l_path --and then
--					attached wiki_text (l_path) as l_wiki_text
				then
					l_preview_pg := l_manager.new_wiki_page (pg.title, pg.parent_key)
					l_preview_pg.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (utf.utf_32_string_to_utf_8_string_8 (p_source.value)))

					create l_xhtml.make_empty
					create wvis.make (l_xhtml)
					wvis.set_link_resolver (l_manager)
					wvis.set_image_resolver (l_manager)
					wvis.set_template_resolver (l_manager)
					wvis.set_file_resolver (l_manager)
					wvis.visit_page (l_preview_pg)

					res.header.put_content_type_text_html
					res.header.put_content_length (l_xhtml.count)
					res.put_string (l_xhtml)
				else
					res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
				end
			else
				res.send (create {CMS_CUSTOM_RESPONSE_MESSAGE}.make ({HTTP_STATUS_CODE}.bad_request))
			end
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			loc: STRING
			l_version: detachable READABLE_STRING_GENERAL
		do
			if
				attached {WDOCS_PAGE_CMS_RESPONSE} a_response as l_wdocs_response
			then
				if attached l_wdocs_response.page as pg then
					l_version := l_wdocs_response.version_id
					loc := manager (l_version).wiki_page_uri_path (pg, l_wdocs_response.book_name, l_version)
					if loc.starts_with_general ("/") then
						loc.remove_head (1)
					end
				else
					loc := l_wdocs_response.location
				end

				if l_wdocs_response.has_permission ("edit wdocs page") then
					a_menu_system.primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Edit", loc + "/edit"))
					a_menu_system.primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Source", loc + "/source"))
				end
				if l_wdocs_response.has_permission ("create wdocs page") then
					if l_wdocs_response.book_name.is_empty then
							-- FIXME: add a link to create new book!
--						if l_wdocs_response.has_permission ("create wdocs book") then
--							a_menu_system.primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Create Book", loc + "/add-child"))
--						end
					else
						a_menu_system.primary_tabs.extend (create {CMS_LOCAL_LINK}.make ("Add Child", loc + "/add-child"))
					end
				end
			end
		end

	response_alter (a_response: CMS_RESPONSE)
		do

		end

end
