indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	CHARACTER_DIALOG

inherit
	CHARACTER_DIALOG_IMP


feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do	
			set_default_cancel_button (dummy_cancel_button)
			close_request_actions.extend (agent hide)
			xml_character_list.set_column_title ("Character", 1)
			xml_character_list.set_column_title ("Code", 2)
			xml_character_list.set_column_widths (<<100, 100>>)
			html_character_list.set_column_title ("Character", 1)
			html_character_list.set_column_title ("Code", 2)
			html_character_list.set_column_widths (<<100, 100>>)
			populate_xml_list
			populate_html_list
		end

feature {NONE} -- Implementation

	populate_xml_list is
			-- Populate XML character list
		local
			l_item: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				xml_characters.start
			until
				xml_characters.after
			loop
				create l_item.default_create
				l_item.extend (xml_characters.item_for_iteration)
				l_item.extend (xml_characters.key_for_iteration)
				l_item.pointer_double_press_actions.force_extend (agent write_character (xml_characters.key_for_iteration))
				xml_character_list.extend (l_item)
				xml_characters.forth
			end
		end	
		
	populate_html_list is
			-- Populate HTML character list
		local
			l_item: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				html_characters.start
			until
				html_characters.after
			loop
				create l_item.default_create
				l_item.extend (html_characters.item_for_iteration)
				l_item.extend (html_characters.key_for_iteration)
				l_item.pointer_double_press_actions.force_extend (agent write_character (html_characters.key_for_iteration))
				html_character_list.extend (l_item)
				html_characters.forth
			end
		end	

	write_character (a_code: STRING) is
			-- Write character to document
		local
			l_editor: DOCUMENT_EDITOR
		do
			l_editor := (create {SHARED_OBJECTS}).shared_document_editor
			if l_editor.current_widget /= Void then
				l_editor.current_widget.internal_edit_widget.insert_text (a_code)
			end
		end		

	xml_characters: HASH_TABLE [STRING, STRING] is
			-- XML special characters hashed by code/escape sequence
		once
			create Result.make (5)
			Result.compare_objects
			Result.extend ("<", "&lt;")
			Result.extend (">", "&gt;")
			Result.extend ("'", "&apos;")
			Result.extend ("%"", "&quot;")
			Result.extend ("&", "&amp;")
		end

	html_characters: HASH_TABLE [STRING, STRING] is
			-- HTML special characters hashed by code/escape sequence
		once
			create Result.make (10)
			Result.compare_objects
			Result.extend ("<", "&lt;")
			Result.extend (">", "&gt;")
			Result.extend ("'", "&apos;")
			Result.extend ("%"", "&quot;")
			Result.extend ("&", "&amp;")
			Result.extend ("@", "&amp;#064;")
			Result.extend ("...", "&amp;#133;")
			Result.extend ("TM", "&amp;#153;")
			Result.extend ("copyright", "&amp;#169;")
			Result.extend ("registered trademark", "&amp;#174;")			
			Result.extend ("blank space", "&amp;nbsp;")
		end

end -- class CHARACTER_DIALOG

