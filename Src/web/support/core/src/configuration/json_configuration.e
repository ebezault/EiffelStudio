note
	description: "Provide access to json configuration"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CONFIGURATION

feature -- Application Configuration

	cookie_session_default (a_path: PATH): INTEGER_64
			-- Build a new database configuration.
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("cookie_session") as l_cookie_session and then
			     attached {JSON_NUMBER} l_cookie_session.item ("default") as l_item then
			     Result := l_item.integer_64_item
			 end
			end
		end

	cookie_session_remember_me (a_path: PATH): INTEGER_64
			-- Build a new database configuration.
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("cookie_session") as l_cookie_session and then
			     attached {JSON_NUMBER} l_cookie_session.item ("remember_me") as l_item then
			     Result := l_item.integer_64_item
			 end
			end
		end

	eiffel_stable_versions (a_path: PATH): LIST [STRING]
			-- List of eiffel stable versions.
		local
			l_parser: JSON_PARSER
		do
			create {ARRAYED_LIST [STRING]} Result.make (0)
			if
				attached json_file_from (a_path) as json_file
			then
				 l_parser := new_json_parser (json_file)
			 	if
			 		attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     	attached {JSON_ARRAY} jv.item ("versions") as l_versions
			    then
					across l_versions as c loop
						if attached {JSON_STRING} c.item as l_item then
							Result.force (l_item.item)
						end
					end
			 	end
			end
		end

	new_smtp_configuration (a_path: PATH): READABLE_STRING_32
			-- Build a new database configuration.
		local
			l_parser: JSON_PARSER
		do
			Result := ""
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("smtp") as l_smtp and then
			     attached {JSON_STRING} l_smtp.item ("server") as l_server then
			     Result := l_server.item
			 end
			end
		end

	new_database_configuration (a_path: PATH): detachable DATABASE_CONFIGURATION
			-- Build a new database configuration.
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("database") as l_database and then
			     attached {JSON_OBJECT} l_database.item ("datasource") as l_datasource and then
			     attached {JSON_STRING} l_datasource.item ("driver") as l_driver and then
			     attached {JSON_STRING} l_datasource.item ("environment") as l_envrionment and then
			     attached {JSON_OBJECT} l_database.item ("environments") as l_environments and then
				 attached {JSON_OBJECT} l_environments.item (l_envrionment.item) as l_environment_selected and then
				 attached {JSON_STRING} l_environment_selected.item ("connection_string") as l_connection_string then
				create Result.make (l_driver.item, l_connection_string.unescaped_string_8)
			 end
			end
		end


	new_logger_level_configuration (a_path: PATH): READABLE_STRING_32
			-- Retrieve a new logger level configuration.
			-- By default, level is set to `DEBUG'.
		local
			l_parser: JSON_PARSER
		do
			Result := "DEBUG"
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("logger") as l_logger and then
			     attached {JSON_STRING} l_logger.item ("level") as l_level then
			     Result := l_level.item
			 end
			end
		end

	new_database_configuration_test (a_path: PATH): detachable DATABASE_CONFIGURATION
			-- Build a new database configuration for testing purposes.
		local
			l_parser: JSON_PARSER
		do
			if attached json_file_from (a_path) as json_file then
			 l_parser := new_json_parser (json_file)
			 if  attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			     attached {JSON_OBJECT} jv.item ("database") as l_database and then
			     attached {JSON_OBJECT} l_database.item ("datasource") as l_datasource and then
			     attached {JSON_STRING} l_datasource.item ("driver") as l_driver and then
			     attached {JSON_STRING} l_datasource.item ("environment") as l_envrionment and then
			     attached {JSON_STRING} l_datasource.item ("trusted") as l_trusted and then
			     attached {JSON_OBJECT} l_database.item ("environments") as l_environments and then
				 attached {JSON_OBJECT} l_environments.item ("test") as l_environment_selected and then
				 attached {JSON_STRING} l_environment_selected.item ("connection_string") as l_connection_string and then
				 attached {JSON_STRING} l_environment_selected.item ("name") as l_name then
				create Result.make (l_driver.item, l_connection_string.unescaped_string_8)
			 end
			end
		end


feature {NONE} -- JSON

	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name.out)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_parser (a_string)
		end

end
