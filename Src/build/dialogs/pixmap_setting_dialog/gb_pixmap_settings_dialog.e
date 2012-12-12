note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PIXMAP_SETTINGS_DIALOG

inherit
	GB_PIXMAP_SETTINGS_DIALOG_IMP
		redefine
			is_in_default_state
		end

	GB_EV_PIXMAP_HANDLER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EIFFEL_RESERVED_WORDS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	BUILD_RESERVED_WORDS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_implementation
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

	GB_FILE_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make,
	make_in_modify_mode

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make (a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

	make_in_modify_mode (a_pixmap_name: STRING; a_components: GB_INTERNAL_COMPONENTS)
			-- Create `Current' in mode for modification of a pre-existing pixmap and
			-- assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			mode_is_modify := True
			make (a_components)
				-- Modify the interface appropriately.
			select_directory_button.hide

			absolute_text.change_actions.block
			relative_text.change_actions.block

				-- While setting the texts, the change
				-- actions must be blocked, to ensure that
				-- no processing is performed as a result.
			absolute_text.set_text (a_pixmap_name)
			relative_text.set_text (a_pixmap_name)

			absolute_text.change_actions.resume
			relative_text.change_actions.resume

			absolute_text.disable_sensitive
			relative_text.disable_sensitive
			set_title (modify_pixmap_dialog_title)
		ensure
			components_set: components = a_components
		end

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_default_cancel_button (cancel_button)
			absolute_constant_radio_button.enable_select
			pixmap_list.set_pixmaps_size (32, 32)
			check_buttons_box.hide
			check_buttons_cell.hide
			all_object_and_event_names := components.object_handler.all_object_and_event_names
			retrieve_all_names
			retrieve_all_paths
			set_icon_pixmap (Icon_build_window @ 1)
		end

	user_create_interface_objects
			-- Create any auxilliary objects needed for MAIN_WINDOW.
			-- Initialization for these objects must be performed in `user_initialization'.
		do
			-- Create attached types defined in class here, initialize them in `user_initialization'.

		end

feature {NONE} -- Implementation

	all_object_and_event_names: ARRAYED_LIST [STRING]
		-- All object and event names currently in system.

	select_pixmap_pressed
			-- Called by `select_actions' of `select_pixmap_button'.
		do
			modify_pixmap
		end

	select_directory_pressed
			-- Called by `select_actions' of `select_directory_button'.
		do
			modify_directory
		end

	absolute_radio_button_selected
			-- respond to `absolute_constant_radio_button' selection by
			-- enabling/disabling relevent parts of interface.
		do
			relative_constant_box.disable_sensitive
			absolute_constant_box1.enable_sensitive
		end

	relative_radio_button_selected
			-- respond to `relative_constant_radio_button' selection by
			-- enabling/disabling relevent parts of interface.
		do
			relative_constant_box.enable_sensitive
			absolute_constant_box1.disable_sensitive
		end

	ok_button_pressed
			-- Called by `select_actions' of `ok_button'.
		local
			confirmation_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			constant_matching_absolute: STRING
			pixmap_constant: GB_PIXMAP_CONSTANT
			warning_dialog: NO_DIRECTORY_SPECIFIED_WARNING_DIALOG
			cancelled: BOOLEAN
			added_directory_name: STRING
			directory_constant: GB_DIRECTORY_CONSTANT
			add_constant_command: GB_COMMAND_ADD_CONSTANT
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			check
				item_selected_in_list: pixmap_list.selected_item /= Void
			end
			if mode_is_modify then
				-- A new pixmap must not be added, but the existing one must be modified.
				pixmap_constant ?= components.constants.all_constants.item (absolute_text.text)
				check
					pixmap_constant_not_void: pixmap_constant /= Void
				end
				if relative_constant_radio_button.is_selected then
					if relative_directory_combo.text.is_empty then
						pixmap_constant.set_attributes (relative_text.text, pixmap_constant.value, file_path, file_title, False, components)
					else
						pixmap_constant.set_attributes (relative_text.text, pixmap_constant.value, relative_directory_combo.text, file_title, False, components)
					end
				else
					pixmap_constant.set_attributes (absolute_text.text, pixmap_constant.value, file_path, file_title, True, components)
				end
				if not pixmap_constant.is_absolute and pixmap_constant.directory.is_equal (file_path) and
					components.constants.matching_directory_constant_name (file_path) = Void then
					create warning_dialog.make_with_components (components)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.show_modal_to_window (Current)
					if not warning_dialog.cancelled then
						added_directory_name := warning_dialog.directory_name
						create directory_constant.make_with_name_and_value (added_directory_name, file_path, components)
						create add_constant_command.make (directory_constant, components)
						add_constant_command.execute
						pixmap_constant.set_attributes (pixmap_constant.name, pixmap_constant.value, added_directory_name, pixmap_constant.filename, pixmap_constant.is_absolute, components)
					else
						cancelled := True
					end
				elseif (components.constants.matching_directory_constant_name (pixmap_constant.directory.as_lower) = Void) and
						(components.constants.directory_constant_by_name (pixmap_constant.directory.as_lower) = Void) then
							-- No directory exists matching the specified name, so make it and create the pixmap relative to it.
					--	add_relative_directory_and_constant (pixmap_constant, pixmap_constant.directory)
					create directory_constant.make_with_name_and_value (pixmap_constant.directory, file_path, components)
					create add_constant_command.make (directory_constant, components)
					add_constant_command.execute
				else
					if components.constants.matching_directory_constant_name (pixmap_constant.directory) /= Void and not pixmap_constant.is_absolute then
							-- A directory matches the name set for the directory of this relative pixmap, so
							-- create a pixmap relative to this.
						pixmap_constant.set_attributes (pixmap_constant.name, pixmap_constant.value, components.constants.matching_directory_constant_name (pixmap_constant.directory), pixmap_constant.filename, pixmap_constant.is_absolute, components)
--					else
--						check
--							directory_is_constant: constants.directory_constant_by_name (pixmap_constant.directory) /= Void
--						end
					end
--				--	add_relative_constant (pixmap_constant)
				end
				if not cancelled then
					pixmap_constant.update
					editors := components.object_editors.all_editors
					from
						editors.start
					until
						editors.off
					loop
						editors.i_th (editors.index).constant_changed (pixmap_constant)
						editors.forth
					end
				end
				hide
			else
				--Add one or more new pixmaps to the system.
				from
					pixmap_list.start
				until
					pixmap_list.off or cancelled
				loop
					pixmap_constant ?= pixmap_list.item.data
					check
						data_was_pixmap_constant: pixmap_constant /= Void
					end
					if pixmap_list.item.is_selected then
							-- We must update the information regarding the selected
							-- item, as it will not be up to date.
						if relative_constant_radio_button.is_selected then
							if relative_directory_combo.text.is_empty then
								pixmap_constant.set_attributes (relative_text.text, pixmap_constant.value, file_path, pixmap_constant.filename, False, components)
							else
								pixmap_constant.set_attributes (relative_text.text, pixmap_constant.value, relative_directory_combo.text, pixmap_constant.filename, False, components)
							end
						else
							pixmap_constant.set_attributes (absolute_text.text, pixmap_constant.value, pixmap_constant.directory, pixmap_constant.filename, True, components)
						end
					end
					if pixmap_list.is_item_checked (pixmap_list.item) then
						if pixmap_constant.is_absolute then
								-- We are dealing with an absolute constant.
								constant_matching_absolute := components.constants.matching_absolute_pixmap_constant (pixmap_constant.value)
								if constant_matching_absolute /= Void then
										-- If an absolute constant already exists, warn for duplication
									create confirmation_dialog.make_initialized (2, preferences.dialog_data.show_repeated_absolute_constant_warning, "An absolute pixmap constant named %"" +
										constant_matching_absolute + "%" already references this image file.%NAre you sure you wish to add another?", "Do not show this dialog again, and always add.",
										preferences.preferences)
									confirmation_dialog.set_icon_pixmap (Icon_build_window @ 1)
									confirmation_dialog.set_ok_action (agent add_absolute_constant)
									confirmation_dialog.show_modal_to_window (Current)
								else
										-- Add a new absolute constant.
									add_absolute_constant (pixmap_constant)
								end
						else
							if not pixmap_constant.is_absolute and pixmap_constant.directory.is_equal (file_path) and added_directory_name = Void and
								components.constants.matching_directory_constant_name (file_path) = Void then
									-- If constant is relative, and a name has not been entered for a directory, and the add directory has
									-- not already been shown, then retrieve a name for the directroy, and add both,
								create warning_dialog.make_with_components (components)
								warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
								warning_dialog.show_modal_to_window (Current)
								if not warning_dialog.cancelled then
									added_directory_name := warning_dialog.directory_name
									add_relative_directory_and_constant (pixmap_constant, added_directory_name)
								else
									cancelled := True
								end
							elseif not pixmap_constant.is_absolute and pixmap_constant.directory.is_equal (file_path) and added_directory_name /= Void then
									-- If constant is relative, no directory name has been specified, and a directory has already been selected from
									-- `warning_dialog', add the constant relative to that directory. May only occur if multiple pixmaps are being added.
								pixmap_constant.set_attributes (pixmap_constant.name, pixmap_constant.value, added_directory_name, pixmap_constant.filename, pixmap_constant.is_absolute, components)
								add_relative_constant (pixmap_constant)
							elseif (components.constants.matching_directory_constant_name (pixmap_constant.directory.as_lower) = Void) and
								(components.constants.directory_constant_by_name (pixmap_constant.directory.as_lower) = Void) then
									-- No directory exists matching the specified name, so make it and create the pixmap relative to it.
								add_relative_directory_and_constant (pixmap_constant, pixmap_constant.directory)
							else
								if components.constants.matching_directory_constant_name (pixmap_constant.directory) /= Void then
										-- A directory matches the name set for the directory of this relative pixmap, so
										-- create a pixmap relative to this.
									pixmap_constant.set_attributes (pixmap_constant.name, pixmap_constant.value, components.constants.matching_directory_constant_name (pixmap_constant.directory), pixmap_constant.filename, pixmap_constant.is_absolute, components)
								else
									check
										directory_is_constant: components.constants.directory_constant_by_name (pixmap_constant.directory) /= Void
									end
								end
								add_relative_constant (pixmap_constant)
							end
						end
			--| FIXME These warning have been turned off for the time being.
			--| When turning them on, they must be implemented correctly. Just uncommenting the code may not be enough.
			--				if absolute_constant_radio_button.is_selected then
			--					constant_matching_absolute := constants.matching_absolute_pixmap_constant (last_pixmap_name.as_lower)
			--					if constant_matching_absolute /= Void then
			--						create confirmation_dialog.make_initialized (2, show_repeated_absolute_constant_warning, "An absolute pixmap constant named %"" +
			--							constant_matching_absolute + "%" already references this image file.%NAre you sure you wish to add another?", "Do not show this dialog again, and always add.")
			--						confirmation_dialog.set_ok_action (agent add_absolute_constant)
			--						confirmation_dialog.show_modal_to_window (Current)
			--					else
			--						add_absolute_constant
			--					end
			--				elseif relative_constant_radio_button.is_selected then
			--					if constants.directory_constant_by_name (relative_directory_combo.text) = Void then -- Add check here
			--					create confirmation_dialog.make_initialized (2, show_create_new_directory_constant_warning,
			--						"You have entered a directory constant that does not exist.%NWould you like to create both the PIXMAP constant%Nand DIRECTORY constant %"" + relative_directory_combo.text.as_lower + "%" on which it relies?",
			--						"Do not show this dialog again, and always create new directory constants.")	
			--						confirmation_dialog.set_ok_action (agent add_relative_directory_and_constant)
			--						confirmation_dialog.show_modal_to_window (Current)
			--					else
			--						add_relative_constant
			--					end
			--				end
					end
					pixmap_list.forth
				end
			end
		end

	add_absolute_constant (pixmap_constant: GB_PIXMAP_CONSTANT)
			-- Add an absolute pixmap constant `pixmap_constant' to system.
		require
			pixmap_constant_not_void: pixmap_constant /= Void
		local
			add_constant_command: GB_COMMAND_ADD_CONSTANT
		do
			pixmap_constant.convert_to_full
			create add_constant_command.make (pixmap_constant, components)
			add_constant_command.execute
				-- Update project to reflect change.
			components.system_status.mark_as_dirty

				-- Now hide `Current'.
			hide
		end

	add_relative_directory_and_constant (pixmap_constant: GB_PIXMAP_CONSTANT; directory_name: STRING)
			-- Add a new directory constant named `directory_name' with value `directory' of `pixmap_constant',
			-- and a new pixmap constant `pixmap_constant' to system.
		require
			pixmap_constant_not_void: pixmap_constant /= Void
			directory_name_not_void: directory_name  /= void
			directory_name_not_exists: components.constants.directory_constant_by_name (directory_name) = Void
		local
			directory_constant: GB_DIRECTORY_CONSTANT
			add_constant_command: GB_COMMAND_ADD_CONSTANT
		do
			create directory_constant.make_with_name_and_value (directory_name, file_path, components)
			create add_constant_command.make (directory_constant, components)
			add_constant_command.execute
			pixmap_constant.set_attributes (pixmap_constant.name, pixmap_constant.value, directory_name, pixmap_constant.filename, pixmap_constant.is_absolute, components)
			add_relative_constant (pixmap_constant)
			check
				cross_referer_set: directory_constant.cross_referers.has (pixmap_constant)
			end
		end


	add_relative_constant (pixmap_constant: GB_PIXMAP_CONSTANT)
			-- Add a relative pixmap constant `pixmap_constant' to system.
		require
			pixmap_constant_not_void: pixmap_constant /= Void
		local
			add_constant_command: GB_COMMAND_ADD_CONSTANT
		do
			pixmap_constant.convert_to_full
			create add_constant_command.make (pixmap_constant, components)
			add_constant_command.execute
				-- Update project to reflect change.
			components.system_status.mark_as_dirty

				-- Now hide `Current'.
			hide
		end

	check_all_button_selected
			-- Called by `select_actions' of `check_all_button'.
		do
			pixmap_list.check_actions.block
			pixmap_list.do_all (agent pixmap_list.check_item (?))
			pixmap_list.check_actions.resume
			update_ok_button
		end

	uncheck_all_button_selected
			-- Called by `select_actions' of `uncheck_all_button'.
		do
			pixmap_list.uncheck_actions.block
			pixmap_list.do_all (agent pixmap_list.uncheck_item (?))
			pixmap_list.uncheck_actions.resume
			update_ok_button
		end

	item_checked (a_list_item: EV_LIST_ITEM)
			-- Called by `check_actions' of `pixmap_list'.
		do
			update_ok_button
		end

	item_unchecked (a_list_item: EV_LIST_ITEM)
			-- Called by `uncheck_actions' of `pixmap_list'.
		do
			update_ok_button
		end

	update_ok_button
			-- Update status of `ok_button'.
		do
			if not pixmap_list.checked_items.is_empty then
				ok_button.enable_sensitive
			else
				ok_button.disable_sensitive
			end
		end

	cancel_button_pressed
			-- Called by `select_actions' of `cancel_button'.
		do
			hide
		end

	basic_valid_name (a_name:STRING): BOOLEAN
			-- Is `a_name' a valid pixmap name?
		require
			a_name_not_void: a_name /= Void
		do
			Result :=  valid_class_name (a_name) and not Reserved_words.has (a_name) and
			not components.object_handler.string_used_globally_as_object_or_feature_name (a_name)
		end


	absolute_text_changed
			-- Called by `change_actions' of `absolute_text'.
		local
			text: STRING
		do
			text := absolute_text.text.as_lower
			if valid_class_name (text) and not existing_names.has (text) then
				absolute_text.set_foreground_color (black)
				ok_button.enable_sensitive
			else
				absolute_text.set_foreground_color (red)
				ok_button.disable_sensitive
			end
		end

	relative_text_changed
			-- Called by `change_actions' of `relative_text'.
		local
			text: STRING
		do
			text := relative_text.text.as_lower
			if valid_class_name (text) and not existing_names.has (text) then
				relative_text.set_foreground_color (black)
				ok_button.enable_sensitive
			else
				relative_text.set_foreground_color (red)
				ok_button.disable_sensitive
			end
		end

	relative_directory_text_changed
			-- Called by `select_actions' of `relative_directory_combo'.
		local
			text: STRING
		do
			text := relative_directory_combo.text.as_lower
			if basic_valid_name (text) and (not existing_names.has (text) or components.constants.directory_constant_by_name (text) /= Void) then
				--| FIXME check current names also.
				relative_directory_combo.set_foreground_color (black)
				ok_button.enable_sensitive
			elseif not relative_directory_combo.text.is_empty then
					-- Do not disable the "Ok" button when text is empty,
					-- as Build can add a directory constant automatically
					-- for any pixmaps for which it is not set.
				relative_directory_combo.set_foreground_color (red)
				ok_button.disable_sensitive
			end
		end

	modify_pixmap
			-- Display a dialog allowing user input for
			-- selected pixmap.
		local
			dialog: EV_FILE_OPEN_DIALOG
			shown_once, opened_file: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
			list_item: EV_LIST_ITEM
			directory_constant: GB_DIRECTORY_CONSTANT
			pixmap_constant: GB_PIXMAP_CONSTANT
			new_pixmap: EV_PIXMAP
			rescued: BOOLEAN
		do
			from
				if not rescued then
					create dialog
				end
			until
				(dialog.file_name.is_empty and shown_once) or opened_file
			loop
				shown_once := True
				dialog.show_modal_to_window (Current)
				if not dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_cancel) then
					pixmap_list.wipe_out
					if not mode_is_modify then
						reset_labels
					end
				end
				if not dialog.file_name.is_empty and then valid_file_extension (dialog.file_name.substring (dialog.file_name.count -2, dialog.file_name.count)) then
					create new_pixmap
					new_pixmap.set_with_named_file (dialog.file_name)
					last_pixmap_name := dialog.file_name
					file_title := dialog.file_title
					file_path := dialog.file_path
					pixmap_path_label.set_text (last_pixmap_name)
					pixmap_path_label.set_tooltip (last_pixmap_name)
						-- Must set the pixmap before the stretch takes place.
					create list_item.make_with_text (file_title)
					list_item.set_pixmap (new_pixmap)
					pixmap_list.extend (list_item)
					if not pixmap_paths.has (dialog.file_name) then
						pixmap_list.check_item (list_item)
					end
					create pixmap_constant.set_attributes (get_unique_pixmap_name (file_title), "", file_path, file_title, False, components)
					list_item.set_data (pixmap_constant)
					display_pixmap_info (list_item)
					list_item.select_actions.extend (agent display_pixmap_info (list_item))
					list_item.deselect_actions.extend (agent item_unselected (list_item))
					built_from_frame.enable_sensitive
					pixmap_location_label.enable_sensitive
					ok_button.enable_sensitive
					opened_file := True
					check_buttons_box.enable_sensitive
					pixmap_list.i_th (1).enable_select
				elseif not dialog.file_name.is_empty then
					create error_dialog
					error_dialog.set_icon_pixmap (Icon_build_window @ 1)
					error_dialog.set_text (invalid_type_warning)
					error_dialog.show_modal_to_window (Current)
				end
			end
			if not dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_cancel) then
				if not mode_is_modify then
					absolute_text.set_text (get_unique_pixmap_name (file_title))
					relative_text.set_text (get_unique_pixmap_name (file_title))
				end
				if components.constants.matching_directory_constant_name (file_path) /= Void then
					directory_constant ?= components.constants.all_constants.item (components.constants.matching_directory_constant_name (file_path))
					check
						directory_constant_exists: directory_constant /= Void
					end
					create list_item.make_with_text (directory_constant.name)
					list_item.set_data (directory_constant.name)
					relative_directory_combo.extend (list_item)
				end
			end
			update_ok_button
		rescue
			rescued := True
			Show_invalid_file_warning
			retry
		end

	show_invalid_file_warning
			-- Display a dialog informing user of invalid file.
		local
			warning_dialog: EV_WARNING_DIALOG
		do
			create warning_dialog.make_with_text ("Unable to load selected image, as it appears to be invalid.%N%NPlease select a valid image file.")
			warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
			warning_dialog.show_modal_to_window (Current)
		end

	modify_directory
			-- Display a dialog prompting for searching in a paticular directory.
		local
			dialog: EV_DIRECTORY_DIALOG
			directory: DIRECTORY
			supported_types: LINEAR [STRING_32]
			files: ARRAYED_LIST [PATH]
			current_filename: STRING
			filename_ext: STRING
			pixmap: EV_PIXMAP
			filename: PATH
			list_item: EV_LIST_ITEM
			pixmap_constant: GB_PIXMAP_CONSTANT
			rescued: BOOLEAN
			rescued_index: INTEGER
		do
			if not rescued then
				create dialog
				dialog.show_modal_to_window (Current)
				if not dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_cancel) then
					pixmap_list.wipe_out
					reset_labels
				end
			end
			if not dialog.path.is_empty or not dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_cancel) then
				if not rescued then
					pixmap_list.check_actions.block
					file_path := dialog.directory
					create directory.make_with_path (dialog.path)
					supported_types := (create {EV_ENVIRONMENT}).supported_image_formats
					files := directory.entries
				end
				from
					if not rescued then
						files.start
					else
						files.go_i_th (rescued_index + 1)
					end
				until
					files.off
				loop
					current_filename := files.item.name.as_string_8
					filename_ext := current_filename.substring (current_filename.substring_index (".", 1) + 1, current_filename.count)
					if supported_types.has (filename_ext.as_upper) then
						create pixmap
							-- Now must prune last directory separator if we are a drive.
						filename := directory.path.extended (current_filename)
						pixmap.set_with_named_path (filename)
						pixmap.set_minimum_size (pixmap.width, pixmap.height)
						create list_item.make_with_text (current_filename)
						list_item.set_pixmap (pixmap)
						pixmap_list.extend (list_item)
						create pixmap_constant.set_attributes (get_unique_pixmap_name (current_filename), filename.name.as_string_8, directory.name, current_filename, False, components)
						list_item.set_data (pixmap_constant)
						if not pixmap_paths.has (filename.name) then
							pixmap_list.check_item (list_item)
						end
						list_item.select_actions.extend (agent display_pixmap_info (list_item))
						list_item.deselect_actions.extend (agent item_unselected (list_item))

							-- Now add name to `existing_names' so clashes can be checked.
						existing_names.put (pixmap_constant.name, pixmap_constant.name)
					end
					files.forth
				end
				if pixmap_list.count > 1 then
					check_buttons_box.show
					check_buttons_cell.show
					pixmap_list.check_actions.resume
					pixmap_list.i_th (1).enable_select
				else
					-- Display warning that there are no files found?
				end
			end
			update_ok_button
		rescue
			rescued := True
			rescued_index := files.index
			retry
		end

	display_pixmap_info (a_list_item: EV_LIST_ITEM)
			-- Display information regarding `a_list_item' in `Current'.
		local
			pixmap_constant: GB_PIXMAP_CONSTANT
			directory_constant: GB_DIRECTORY_CONSTANT
			list_item: EV_LIST_ITEM
			matching_directory_names: ARRAYED_LIST [STRING]
		do
			built_from_frame.enable_sensitive
			pixmap_location_label.enable_sensitive
			ok_button.enable_sensitive
			pixmap_constant ?= a_list_item.data
			check
				data_was_pixmap_constant: pixmap_constant /= Void
			end
				-- Now remove name from `existing_names' so it does not clash with itself.
				-- The current name must be replaced after modification is complete.
			existing_names.remove (pixmap_constant.name)

			pixmap_path_label.set_text (directory_with_separator (pixmap_constant.directory) + pixmap_constant.filename)

			if pixmap_constant.is_absolute then
				absolute_constant_radio_button.enable_select
			else
				relative_constant_radio_button.enable_select
			end
			if not mode_is_modify then
				absolute_text.set_text (pixmap_constant.name)
				relative_text.set_text (pixmap_constant.name)
			end
			if pixmap_constant.directory.is_empty then
				relative_directory_combo.remove_text
			end
			if attached components.constants.matching_directory_constant_name (file_path) as l_constant_name then
				directory_constant ?= components.constants.all_constants.item (l_constant_name)
				check
					directory_constant_exists: directory_constant /= Void
				end
				relative_directory_combo.wipe_out
				matching_directory_names := components.constants.matching_directory_constant_names (file_path)
				from
					matching_directory_names.start
				until
					matching_directory_names.off
				loop
					create list_item.make_with_text (matching_directory_names.item)--directory_constant.name)
					list_item.set_data (directory_constant.name)
					relative_directory_combo.extend (list_item)
					matching_directory_names.forth
				end

			end
			if not pixmap_constant.directory.is_empty and not pixmap_constant.directory.is_equal (file_path) then
				relative_directory_combo.set_text (pixmap_constant.directory)
			end
				--As the selected item has changed, update the display in the naming fields.
			absolute_text_changed
			relative_text_changed
			relative_directory_text_changed
		end

	item_unselected (a_list_item: EV_LIST_ITEM)
			-- `a_list_item' has been unselected in `Current'
		local
			pixmap_constant: GB_PIXMAP_CONSTANT
			directory_location: STRING
		do
			pixmap_constant ?= a_list_item.data
			check
				data_was_pixmap_constant: pixmap_constant /= Void
			end
			if absolute_constant_radio_button.is_selected and not absolute_text.foreground_color.is_equal (red) then
				pixmap_constant.set_attributes (absolute_text.text.as_lower, pixmap_constant.value, pixmap_constant.directory, pixmap_constant.filename, True, components)
					-- Add new name to `exising_names' so clashes may be determined.
				existing_names.put (pixmap_constant.name, pixmap_constant.name)
			elseif not relative_text.foreground_color.is_equal (red) and not relative_directory_combo.foreground_color.is_equal (red) then
				directory_location := relative_directory_combo.text
					-- If the directory entry is empty, reset it back to the
					-- directory of the files.
				if directory_location.is_empty then
					directory_location := pixmap_constant.directory
				end
				pixmap_constant.set_attributes (relative_text.text.as_lower, pixmap_constant.value, directory_location, pixmap_constant.filename, False, components)
					-- Add new name to `exising_names' so clashes may be determined.
				existing_names.put (pixmap_constant.name, pixmap_constant.name)
			end
		end

	get_unique_pixmap_name (a_file_name: STRING): STRING
		require
			file_name_not_void: a_file_name /= Void
			-- `Result' is a name based on `a_file_name' but guaranteed to be unique.
		do
			Result := pixmap_file_title_to_constant_name (a_file_name)
				-- As a filename may not be a valid Eiffel feature name, we must update it
				-- if necessary. For example, names may start with digits which is not permitted.
			if not valid_class_name (Result) then
				Result := invalid_pixmap_name_prefix + Result
			end
			Result := unique_name_from_hash_table (existing_names, Result)
		ensure
			Result_not_void: Result /= Void
		end

	retrieve_all_names
			-- Retrieve all names in use in system in `existing_names'.
		do
			create existing_names.make (200)
			components.object_handler.all_object_and_event_names.do_all (agent add_to_existing_names)
			components.constants.all_constant_names.do_all (agent add_to_existing_names)
			Reserved_words.linear_representation.do_all (agent add_to_existing_names)
			Build_reserved_words.linear_representation.do_all (agent add_to_existing_names)
		end

	retrieve_all_paths
			-- Retrieve all paths of pixmaps in system, into `existing_names'.
		local
			pixmap_constants: ARRAYED_LIST [GB_CONSTANT]
			pixmap_constant: GB_PIXMAP_CONSTANT
		do
			create pixmap_paths.make (50)
			pixmap_constants := components.constants.pixmap_constants
			from
				pixmap_constants.start
			until
				pixmap_constants.off
			loop
				pixmap_constant ?= pixmap_constants.item
				pixmap_paths.put (pixmap_constant.value_as_string, pixmap_constant.value_as_string)
				pixmap_constants.forth
			end
		end

	reset_labels
			-- `Reset' labels back to their original state, as a new selection is taking place.
		do
			pixmap_location_label.disable_sensitive
			pixmap_path_label.remove_text
			absolute_text.remove_text
			relative_directory_combo.remove_text
			relative_text.remove_text
			built_from_frame.disable_sensitive
		ensure
			is_in_default_state: is_in_default_state
		end

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := not pixmap_location_label.is_sensitive and
				pixmap_path_label.text.is_empty and
				absolute_text.text.is_empty and
				relative_directory_combo.text.is_empty and
				relative_text.text.is_empty and
				not built_from_frame.is_sensitive
		end

	add_to_existing_names (current_name: STRING)
		require
			current_name_not_void: current_name /= Void
		do
			existing_names.put (current_name, current_name)
		ensure
			name_added: existing_names.has (current_name)
		end

	existing_names: HASH_TABLE [STRING, STRING]
		-- All names already in use in system. Initially generated when `Current' is displayed,
		--and subsequently updated as a user modifies file names.

	pixmap_paths: STRING_TABLE [READABLE_STRING_GENERAL]
		-- Full paths of all pixmaps in system, when `Current' is created.

	last_pixmap_name: STRING

	file_title: STRING

	file_path: STRING

	mode_is_modify: BOOLEAN;
		-- Is `Current' in modify mode, where the pixmap may be modified only?

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_PIXMAP_SETTINGS_DIALOG

