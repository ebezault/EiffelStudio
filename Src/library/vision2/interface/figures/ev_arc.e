indexing
	description: "EffeilVision arc figure."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ARC

inherit
	EV_OPEN_FIGURE
			redefine
				recompute
			end

	EV_PATH
			redefine
				make
			end

	EV_ENDED_FIGURE

	EV_ANGLE_ROUTINES
			export
				{NONE} all
			end
	MATH_CONST
		export
			{ANY} Pi
		end

create
	make

feature -- Initialization

	make is
			-- Create current arc.
		do
			init_fig (Void)
			{EV_PATH} Precursor
			create center.make
			create angle1.make_in_degrees (0)
			create angle2.make_in_degrees (0)
		end

feature -- Access

	angle1: EV_ANGLE
			-- Angle which specifies start position of
			-- current arc relative to the orientation

	angle2: EV_ANGLE
			-- Angle which specifies end position of
			-- current arc relative to the start of
			-- current arc

	center: EV_POINT
			-- Center of the arc

	orientation: EV_ANGLE
			-- Angle which specifies the position of the first ray
			-- (length `radius1') relative to the three-o'clock position
			-- from the center

	origin: EV_POINT is
			-- Origin of line
		do
			inspect origin_user_type
			when 1 then
				Result := origin_user
			when 2 then
				Result := center
			end
		end

	radius1: INTEGER
			-- First radius of the arc

	radius2: INTEGER
			-- Second radius of the arc

feature -- Element change

	set_angle1 (an_angle: like angle1) is
			-- Set angle1 to `an_angle'.
		do
			angle1 := an_angle
			set_modified
		ensure
			angle1 = an_angle
		end

	set_angle2 (an_angle: like angle2) is
			-- Set angle2 to `an_angle'.
		require
			an_angle.radians <= Pi * 2
		do
			angle2 := an_angle
			set_modified
		ensure
			angle2 = an_angle
		end

	set_center (a_center: like center) is
			-- Set `center' to `an_center'.
		require
			a_center_exists: a_center /= Void
		do
			center := a_center
			set_modified
		ensure
			center = a_center
		end

	set_orientation (an_orientation: like orientation) is
			-- Set `orientation' to `an_orientation'.
		require
		do
			orientation := an_orientation
			set_modified
		ensure
			orientation = an_orientation
		end

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 2
		ensure
			origin.is_superimposable (center)
		end

	set_radius1 (a_radius: like radius1) is
			-- Set `radius1' to `a_radius'.
		require
			a_radius_positive: a_radius >= 0
		do
			radius1 := a_radius
				set_modified
		ensure
			radius1 = a_radius
		end

	set_radius2 (a_radius: like radius2) is
			-- Set `radius2' to `a_radius'.
		require
			a_radius_positive: a_radius >= 0
		do
			radius2 := a_radius
			set_modified
		ensure
			radius2 = a_radius
		end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in radians.
		do
			center.xyrotate (a, px, py)
			orientation := orientation + a 
			set_modified
		end

	xyscale (f: REAL px, py: INTEGER) is
		-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			center.xyscale (f, px, py)
			radius1 := (radius1*f).truncated_to_integer
			radius2 := (radius2*f).truncated_to_integer
			set_modified
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			center.xytranslate (vx, vy)
			set_modified
		end

feature -- Output

	draw is
			-- draw the arc.
 		local
			lpath: EV_PATH
		do
			if drawing.is_drawable then
				create lpath.make
				lpath.get_drawing_attributes (drawing)
--				drawing.set_cap_style (cap_style)
				set_drawing_attributes (drawing)
				drawing.draw_arc (center, radius1, radius2, angle1, angle2,
					orientation, -1)
				lpath.set_drawing_attributes (drawing)
			end
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is `other' superimposable to current arc ?
			--! not done
		do
		end

feature {CONFIGURE_NOTIFY} -- Updating

	recompute is
			-- Recompute.
		local
			diameter: INTEGER
			radius: INTEGER
		do
			if radius1 > radius2 then
				radius := radius1
			else
				radius := radius2
			end
			diameter := radius + radius
			surround_box.set (center.x - radius, center.y - radius, diameter, diameter)
			unset_modified
		end

invariant
	center_exists: center /= Void
	origin_type_constraint: origin_user_type <= 2
	meaningful_radius1: radius1 >= 0
	meaningful_radius2: radius2 >= 0
	
end -- class EV_ARC

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

