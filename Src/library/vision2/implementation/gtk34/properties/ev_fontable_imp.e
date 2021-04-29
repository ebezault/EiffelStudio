note
	description: "EiffelVision fontable, gtk implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I
		redefine
			interface
		end

feature -- Access

	font: EV_FONT
			-- Character appearance for `Current'.
		local
			l_private_font: like private_font
		do
			l_private_font := private_font
			if l_private_font = void then
				create Result
				-- Default create is standard gtk font
			else
				Result := l_private_font.twin
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		local
			font_imp: detachable EV_FONT_IMP
			l_private_font: detachable EV_FONT
			l_pango_context: POINTER
		do
			if private_font /= a_font then
				l_private_font := a_font.twin
				private_font := l_private_font
				font_imp ?= l_private_font.implementation
				check font_imp /= Void then end
					-- TODO check implementation with
					-- GtkStyleProvider example
					-- https://github.com/vain/slinp/commit/3f56e9473f62b3704d92b560715658556108ec78

					-- Examples using pango context
					-- https://cpp.hotexamples.com/examples/-/-/gtk_widget_get_pango_context/cpp-gtk_widget_get_pango_context-function-examples.html
				l_pango_context := {GTK2}.gtk_widget_get_pango_context (fontable_widget)
			end
		end

feature {NONE} -- Implementation

	visual_widget: POINTER
		deferred
		end

	fontable_widget: POINTER
			-- Pointer to the widget that is fontable.
		do
			Result := visual_widget
		end

	private_font: detachable EV_FONT

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FONTABLE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_FONTABLE_IMP
