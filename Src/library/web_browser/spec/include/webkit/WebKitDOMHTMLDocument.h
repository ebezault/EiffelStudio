/*
    This file is part of the WebKit open source project.
    This file has been generated by generate-bindings.pl. DO NOT MODIFY!

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef WebKitDOMHTMLDocument_h
#define WebKitDOMHTMLDocument_h

#include "webkit/webkitdomdefines.h"
#include <glib-object.h>
#include <webkit/webkitdefines.h>
#include "webkit/WebKitDOMDocument.h"


G_BEGIN_DECLS
#define WEBKIT_TYPE_DOM_HTML_DOCUMENT            (webkit_dom_html_document_get_type())
#define WEBKIT_DOM_HTML_DOCUMENT(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_DOM_HTML_DOCUMENT, WebKitDOMHTMLDocument))
#define WEBKIT_DOM_HTML_DOCUMENT_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_DOM_HTML_DOCUMENT, WebKitDOMHTMLDocumentClass)
#define WEBKIT_DOM_IS_HTML_DOCUMENT(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_DOM_HTML_DOCUMENT))
#define WEBKIT_DOM_IS_HTML_DOCUMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_DOM_HTML_DOCUMENT))
#define WEBKIT_DOM_HTML_DOCUMENT_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_DOM_HTML_DOCUMENT, WebKitDOMHTMLDocumentClass))

struct _WebKitDOMHTMLDocument {
    WebKitDOMDocument parent_instance;
};

struct _WebKitDOMHTMLDocumentClass {
    WebKitDOMDocumentClass parent_class;
};

WEBKIT_API GType
webkit_dom_html_document_get_type (void);

/**
 * webkit_dom_html_document_open:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_open(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_close:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_close(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_clear:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_clear(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_capture_events:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_capture_events(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_release_events:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_release_events(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_has_focus:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_html_document_has_focus(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_embeds:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_html_document_get_embeds(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_plugins:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_html_document_get_plugins(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_scripts:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_html_document_get_scripts(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_width:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_document_get_width(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_height:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API glong
webkit_dom_html_document_get_height(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_dir:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_dir(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_dir:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_dir(WebKitDOMHTMLDocument* self, const gchar* value);

/**
 * webkit_dom_html_document_get_design_mode:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_design_mode(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_design_mode:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_design_mode(WebKitDOMHTMLDocument* self, const gchar* value);

/**
 * webkit_dom_html_document_get_compat_mode:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_compat_mode(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_active_element:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_html_document_get_active_element(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_get_bg_color:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_bg_color(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_bg_color:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_bg_color(WebKitDOMHTMLDocument* self, const gchar* value);

/**
 * webkit_dom_html_document_get_fg_color:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_fg_color(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_fg_color:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_fg_color(WebKitDOMHTMLDocument* self, const gchar* value);

/**
 * webkit_dom_html_document_get_alink_color:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_alink_color(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_alink_color:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_alink_color(WebKitDOMHTMLDocument* self, const gchar* value);

/**
 * webkit_dom_html_document_get_link_color:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_link_color(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_link_color:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_link_color(WebKitDOMHTMLDocument* self, const gchar* value);

/**
 * webkit_dom_html_document_get_vlink_color:
 * @self: A #WebKitDOMHTMLDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_html_document_get_vlink_color(WebKitDOMHTMLDocument* self);

/**
 * webkit_dom_html_document_set_vlink_color:
 * @self: A #WebKitDOMHTMLDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_html_document_set_vlink_color(WebKitDOMHTMLDocument* self, const gchar* value);

G_END_DECLS

#endif /* WebKitDOMHTMLDocument_h */
