indexing
	description: "Microsoft HTML Help 1.x project"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_HELP_PROJECT

inherit
	HELP_PROJECT

create
	make
		
feature -- Commands

	build_table_of_contents is
			-- Build table of contents and write to file
		do
			create_toc_file
		end

	generate is
			-- Generate
		local
			l_generator: HELP_GENERATOR
		do
			create l_generator.make (Current)
			l_generator.generate
		end		
		
feature -- File

	project_file: PLAIN_TEXT_FILE is
			-- Project file to use for compilation
		local
			xml: XM_DOCUMENT
			element: XM_ELEMENT
		do
			xml := settings.xm_document
			if xml /= Void then
				create Result.make_create_read_write (Project_file_name)
				Result.put_string ("[OPTIONS]")
				element := xml.root_element.element_by_name (Shared_constants.Help_constants.Files_tag)
				write_option_value ("Compiled file", Shared_constants.Help_constants.Compiled_file_tag, element, Result)
				write_option_value ("Contents file", Shared_constants.Help_constants.Toc_file_tag, element, Result)
				write_option_value ("Error log file", Shared_constants.Help_constants.Log_file_tag, element, Result)
				Result.put_string ("%NBinary TOC=Yes")
				Result.put_string ("%NCompatibility=1.1 or later")				
				Result.put_string ("%NDisplay compile progress=No")
				Result.put_string ("%NLanguage=0x409 English (United States)")
				Result.put_string ("%NDefault topic=index.html")
				Result.put_string ("%NFull-text search=Yes")
				if not shared_constants.application_constants.is_gui_mode then
					Result.put_string ("%NDefault Window=EDHC")
					Result.put_string ("%NFull text search stop list file=stop_words.stp")								
					Result.put_string ("%NTitle=Eiffel Developer Help Center")
					Result.put_string ("%N%N%N[WINDOWS]")
					Result.put_string ("%NEDHC=%"Eiffel Developer Help Center 2.0%",%"docs.hhc%",,%"index.html%",%"index.html%",,,,,0x63520,,0x304e,,0x30000,,,,,,0")
				end				
				Result.close
			end		
		end

	project_filename_extension: STRING is
			-- Extension for this project type
		do
			Result := "hhp"
		end

	compiled_filename_extension: STRING is
			-- Extension for compiled help file
		do
			Result := "chm"
		end	
		
	toc_filename_extension: STRING is
			-- Extension for compiled help file
		do
			Result := "hhc"
		end	

feature {NONE} -- Implementation

	write_option_value (option, el_name: STRING; el: XM_ELEMENT file: PLAIN_TEXT_FILE) is
			-- Write `option' with `value' to `file'.  If `el_name' is Void
			-- just write `option'
		local
			element: XM_ELEMENT
		do
			element := el.element_by_name (el_name)
			if element /= Void and then not element.text.is_empty then
				file.put_new_line
				if el_name /= Void then
					file.put_string (option + "=" + element.text)
				else
					file.put_string (option)
				end
			end
		end

	create_toc_file is
			-- Create TOC file
		local
			contents_file: PLAIN_TEXT_FILE
		do			
			create contents_file.make_create_read_write (toc_file_name)
			contents_file.putstring (full_toc_text)
			contents_file.close
		end		

	full_toc_text: STRING is
			-- Full TOC text
		local
			l_formatter: TABLE_OF_CONTENTS_HTML_HELP_FORMATTER
		do
			create l_formatter.make (toc)
			Result := l_formatter.html_help_text
		end

end -- class HTML_HELP_PROJECT
