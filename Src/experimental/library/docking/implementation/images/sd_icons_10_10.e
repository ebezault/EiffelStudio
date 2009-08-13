note
	description: "An Eiffel pixmap matrix accessor, generated by Eiffel Matrix Generator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	SD_ICONS_10_10

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize matrix
		local
			retried: BOOLEAN
		do
			if not retried then
				create {SD_ICON_MATRIX_10_10} raw_buffer.make
			else
					-- Fail safe, use blank pixmap
				create raw_buffer.make_with_size ((8 * 10) + 1,(1 * 10) + 1)
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	pixel_width: INTEGER = 10
			-- Element width

	pixel_height: INTEGER = 10
			-- Element width

	width: INTEGER = 8
			-- Matrix width

	height: INTEGER = 1
			-- Matrix height

	frozen tool_bar_unpin_icon: EV_PIXMAP
			-- Access to 'unpin' pixmap
		do
			Result := raw_buffer.sub_pixmap (pixel_rectangle (1, 1))

		end

	frozen tool_bar_unpin_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'unpin' pixmap pixel buffer
		do
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (1, 1))
		end

	frozen tool_bar_pin_icon: EV_PIXMAP
			-- Access to 'pin' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (2, 1))
		end

	frozen tool_bar_pin_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'pin' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (2, 1))
		end

	frozen tool_bar_maximize_icon: EV_PIXMAP
			-- Access to 'maximize' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (3, 1))
		end

	frozen tool_bar_maximize_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'maximize' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (3, 1))
		end

	frozen tool_bar_normalize_icon: EV_PIXMAP
			-- Access to 'normalize' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (4, 1))
		end

	frozen tool_bar_normalize_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'normalize' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (4, 1))
		end

	frozen tool_bar_close_icon: EV_PIXMAP
			-- Access to 'close' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (5, 1))
		end

	frozen tool_bar_close_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'close' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (5, 1))
		end

	frozen tool_bar_minimize_icon: EV_PIXMAP
			-- Access to 'minimize' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (6, 1))
		end

	frozen tool_bar_minimize_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'minimize' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (6, 1))
		end

	frozen tool_bar_hidden_dropdown_icon: EV_PIXMAP
			-- Access to 'hidden dropdown' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (7, 1))
		end

	frozen tool_bar_hidden_dropdown_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'hidden dropdown' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (7, 1))
		end

	frozen tool_bar_hidden_dropdown_small_icon: EV_PIXMAP
			-- Access to 'hidden dropdown small' pixmap
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (8, 1))
		end

	frozen tool_bar_hidden_dropdown_small_icon_buffer: EV_PIXEL_BUFFER
			-- Access to 'hidden dropdown small' pixmap pixel buffer
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (8, 1))
		end

feature {NONE} -- Query

	frozen pixel_rectangle (a_x: INTEGER; a_y: INTEGER): EV_RECTANGLE
			-- Retrieves a pixmap from matrix coordinates `a_x', `a_y'
		require
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= 8
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= 1
		local
			l_x_offset: INTEGER
			l_y_offset: INTEGER
		do
			l_x_offset := ((a_x - 1) * (10 + 1)) + 1
			l_y_offset := ((a_y - 1) * (10 + 1)) + 1

			Result := rectangle
			Result.set_x (l_x_offset)
			Result.set_y (l_y_offset)
			Result.set_width (10)
			Result.set_height (10)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	raw_buffer: EV_PIXEL_BUFFER
			-- raw matrix pixel buffer

	frozen rectangle: EV_RECTANGLE
			-- Reusable rectangle for `pixmap_from_constant'
		once
			create Result
		end

invariant
	raw_buffer_attached: raw_buffer /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class {SD_ICONS_10_10}
