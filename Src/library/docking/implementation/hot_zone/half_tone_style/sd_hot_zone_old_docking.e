indexing
	description: "SD_HOT_ZONE for SD_DOCKING_ZONE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_DOCKING

inherit
	SD_HOT_ZONE
		redefine
			internal_zone
		end

create
	make

feature {NONE} -- Initlization
	make (a_zone: SD_DOCKING_ZONE) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
		do
			internal_zone := a_zone
			set_rectangle (create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height))
		end

	internal_zone: SD_DOCKING_ZONE

feature -- Redefine

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		local
			l_half_height, l_half_width: INTEGER
		do
			l_half_height := (internal_zone.height * 0.5).ceiling
			l_half_width := (internal_zone.width * 0.5).ceiling
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (internal_rectangle_top.left, internal_rectangle_top.top, internal_zone.width, l_half_height, internal_shared.line_width)
				Result := True
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (internal_rectangle_bottom.left, internal_rectangle_bottom.bottom - l_half_height, internal_zone.width, l_half_height, internal_shared.line_width)
				Result := True
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (internal_rectangle_left.left, internal_rectangle_left.top, l_half_width, internal_zone.height, internal_shared.line_width)
				Result := True
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (internal_rectangle_right.right - l_half_width, internal_rectangle_right.top, l_half_width, internal_zone.height, internal_shared.line_width)
				Result := True
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
				internal_shared.feedback.draw_rectangle (internal_zone.screen_x, internal_zone.screen_y, internal_zone.width, internal_zone.height, internal_shared.line_width)
				Result :=True
			end
		end

	update_for_pointer_position_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do

		end

	update_for_pointer_position_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do

		end

	clear_indicator is
			-- Redefine
		do

		end

	apply_change  (a_screen_x, a_screen_y: INTEGER; caller: SD_DOCKING_ZONE): BOOLEAN is
			-- Redefine
		do
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_top)
				Result := True
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_bottom)
				Result := True
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_left)
				Result := True
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_right)
				Result := True
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
				caller.content.state.move_to_docking_zone (internal_zone)
				Result := True
			end
		end

	drawn: BOOLEAN
			-- If alreay drawn the feedback rectangle which represent the window area.

feature -- Access

	set_rectangle (a_rect: EV_RECTANGLE) is
			-- Set the rectangle which allow user to dock.
		require
			a_rect_not_void: a_rect /= Void
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := (a_rect.width * {SD_HOT_ZONE_OLD_MAIN}.hot_zone_size_proportion).ceiling
			create internal_rectangle_left.make (a_rect.left , a_rect.top, l_width, a_rect.height)
			create internal_rectangle_right.make (a_rect.right - l_width, a_rect.top, l_width, l_height)

			l_height := (a_rect.height * {SD_HOT_ZONE_OLD_MAIN}.hot_zone_size_proportion).ceiling
			create internal_rectangle_top.make (a_rect.left, a_rect.top, a_rect.width, l_height)
			create internal_rectangle_bottom.make (a_rect.left, a_rect.bottom - l_height, a_rect.width, l_height)

			internal_rectangle_center := a_rect

		ensure
			a_rect_set: internal_rectangle_center = a_rect
			createed: internal_rectangle_top /= Void and internal_rectangle_bottom /= Void
				and internal_rectangle_left /= Void and internal_rectangle_right /= Void
		end


feature {NONE} -- Implementation

	internal_rectangle_left, internal_rectangle_right, internal_rectangle_top, internal_rectangle_bottom, internal_rectangle_center: EV_RECTANGLE
			-- Five rectangle areas which allow user dock a window in this zone.

invariant

	rectangle_not_void: internal_rectangle_left /= Void and internal_rectangle_right /= Void and internal_rectangle_top /= Void and internal_rectangle_bottom /= Void and internal_rectangle_center /= Void
	
end
