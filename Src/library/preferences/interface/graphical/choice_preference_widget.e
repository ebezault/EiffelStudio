indexing
	description	: "[
		Default widget for viewing and editing resources represented in string
		format (i.e. STRING, INTEGER and ARRAY resources).
		]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	CHOICE_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource,
			set_resource,
			change_item_widget
		end

create
	make,
	make_with_resource

feature -- Access
	
	change_item_widget: EV_COMBO_BOX
			-- Widget to change the value of this resource.

	graphical_type: STRING is
			-- Graphical type identfier
		do
			Result := "COMBO"
		end	

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		require else
			resource_is_choice: new_resource.is_choice
		local
			l_values: ARRAY [STRING]
			cnt: INTEGER
		do
			Precursor (new_resource)
			check
				change_item_widget_created: change_item_widget /= Void
			end

			change_item_widget.wipe_out
			change_item_widget.select_actions.block
			from
				l_values := resource.value
				cnt := 1
			until
				cnt > l_values.count
			loop
				change_item_widget.extend (create {EV_LIST_ITEM}.make_with_text (l_values.item (cnt)))
				cnt := cnt + 1
			end
			change_item_widget.i_th (new_resource.selected_index).enable_select
			change_item_widget.select_actions.resume	
		end

feature {NONE} -- Command

	update_changes is
			-- Update the changes made in `change_item_widget' to `resource'.
		local
			l_value: STRING
		do
			from
				create l_value.make_empty
				change_item_widget.start
			until
				change_item_widget.after
			loop
				if change_item_widget.item = change_item_widget.selected_item then
					l_value.append_character ('[')
					l_value.append (change_item_widget.item.text)
					l_value.append_character (']')
				else
					l_value.append (change_item_widget.item.text)
				end
				change_item_widget.forth
				if not change_item_widget.after then
					l_value.append_character (';')
				end
			end
			resource.set_value_from_string (l_value)
		end

	update_resource is
			--	Update resource.	
		do			
		end		

	reset is
			-- Reset.
		do
			if resource.has_default_value then
				resource.reset
			end	
			set_resource (resource)
		end		

feature {NONE} -- Implementation

	resource: ARRAY_PREFERENCE
			-- Actual resource.

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.disable_edit
			change_item_widget.select_actions.extend (agent update_changes)			
		end

end -- class CHOICE_PREFERENCE_WIDGET
