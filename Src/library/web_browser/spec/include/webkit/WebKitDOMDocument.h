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

#ifndef WebKitDOMDocument_h
#define WebKitDOMDocument_h

#include "webkit/webkitdomdefines.h"
#include <glib-object.h>
#include <webkit/webkitdefines.h>
#include "webkit/WebKitDOMNode.h"


G_BEGIN_DECLS
#define WEBKIT_TYPE_DOM_DOCUMENT            (webkit_dom_document_get_type())
#define WEBKIT_DOM_DOCUMENT(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_DOM_DOCUMENT, WebKitDOMDocument))
#define WEBKIT_DOM_DOCUMENT_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_DOM_DOCUMENT, WebKitDOMDocumentClass)
#define WEBKIT_DOM_IS_DOCUMENT(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_DOM_DOCUMENT))
#define WEBKIT_DOM_IS_DOCUMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_DOM_DOCUMENT))
#define WEBKIT_DOM_DOCUMENT_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_DOM_DOCUMENT, WebKitDOMDocumentClass))

struct _WebKitDOMDocument {
    WebKitDOMNode parent_instance;
};

struct _WebKitDOMDocumentClass {
    WebKitDOMNodeClass parent_class;
};

WEBKIT_API GType
webkit_dom_document_get_type (void);

/**
 * webkit_dom_document_create_element:
 * @self: A #WebKitDOMDocument
 * @tag_name: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_create_element(WebKitDOMDocument* self, const gchar* tag_name, GError **error);

/**
 * webkit_dom_document_create_document_fragment:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMDocumentFragment*
webkit_dom_document_create_document_fragment(WebKitDOMDocument* self);

/**
 * webkit_dom_document_create_text_node:
 * @self: A #WebKitDOMDocument
 * @data: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMText*
webkit_dom_document_create_text_node(WebKitDOMDocument* self, const gchar* data);

/**
 * webkit_dom_document_create_comment:
 * @self: A #WebKitDOMDocument
 * @data: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMComment*
webkit_dom_document_create_comment(WebKitDOMDocument* self, const gchar* data);

/**
 * webkit_dom_document_create_cdata_section:
 * @self: A #WebKitDOMDocument
 * @data: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMCDATASection*
webkit_dom_document_create_cdata_section(WebKitDOMDocument* self, const gchar* data, GError **error);

/**
 * webkit_dom_document_create_processing_instruction:
 * @self: A #WebKitDOMDocument
 * @target: A #gchar
 * @data: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMProcessingInstruction*
webkit_dom_document_create_processing_instruction(WebKitDOMDocument* self, const gchar* target, const gchar* data, GError **error);

/**
 * webkit_dom_document_create_attribute:
 * @self: A #WebKitDOMDocument
 * @name: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMAttr*
webkit_dom_document_create_attribute(WebKitDOMDocument* self, const gchar* name, GError **error);

/**
 * webkit_dom_document_create_entity_reference:
 * @self: A #WebKitDOMDocument
 * @name: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMEntityReference*
webkit_dom_document_create_entity_reference(WebKitDOMDocument* self, const gchar* name, GError **error);

/**
 * webkit_dom_document_get_elements_by_tag_name:
 * @self: A #WebKitDOMDocument
 * @tagname: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeList*
webkit_dom_document_get_elements_by_tag_name(WebKitDOMDocument* self, const gchar* tagname);

/**
 * webkit_dom_document_import_node:
 * @self: A #WebKitDOMDocument
 * @imported_node: A #WebKitDOMNode
 * @deep: A #gboolean
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNode*
webkit_dom_document_import_node(WebKitDOMDocument* self, WebKitDOMNode* imported_node, gboolean deep, GError **error);

/**
 * webkit_dom_document_create_element_ns:
 * @self: A #WebKitDOMDocument
 * @namespace_uri: A #gchar
 * @qualified_name: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_create_element_ns(WebKitDOMDocument* self, const gchar* namespace_uri, const gchar* qualified_name, GError **error);

/**
 * webkit_dom_document_create_attribute_ns:
 * @self: A #WebKitDOMDocument
 * @namespace_uri: A #gchar
 * @qualified_name: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMAttr*
webkit_dom_document_create_attribute_ns(WebKitDOMDocument* self, const gchar* namespace_uri, const gchar* qualified_name, GError **error);

/**
 * webkit_dom_document_get_elements_by_tag_name_ns:
 * @self: A #WebKitDOMDocument
 * @namespace_uri: A #gchar
 * @local_name: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeList*
webkit_dom_document_get_elements_by_tag_name_ns(WebKitDOMDocument* self, const gchar* namespace_uri, const gchar* local_name);

/**
 * webkit_dom_document_get_element_by_id:
 * @self: A #WebKitDOMDocument
 * @element_id: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_get_element_by_id(WebKitDOMDocument* self, const gchar* element_id);

/**
 * webkit_dom_document_adopt_node:
 * @self: A #WebKitDOMDocument
 * @source: A #WebKitDOMNode
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNode*
webkit_dom_document_adopt_node(WebKitDOMDocument* self, WebKitDOMNode* source, GError **error);

/**
 * webkit_dom_document_create_event:
 * @self: A #WebKitDOMDocument
 * @event_type: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMEvent*
webkit_dom_document_create_event(WebKitDOMDocument* self, const gchar* event_type, GError **error);

/**
 * webkit_dom_document_create_range:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMRange*
webkit_dom_document_create_range(WebKitDOMDocument* self);

/**
 * webkit_dom_document_create_node_iterator:
 * @self: A #WebKitDOMDocument
 * @root: A #WebKitDOMNode
 * @what_to_show: A #gulong
 * @filter: A #WebKitDOMNodeFilter
 * @expand_entity_references: A #gboolean
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeIterator*
webkit_dom_document_create_node_iterator(WebKitDOMDocument* self, WebKitDOMNode* root, gulong what_to_show, WebKitDOMNodeFilter* filter, gboolean expand_entity_references, GError **error);

/**
 * webkit_dom_document_create_tree_walker:
 * @self: A #WebKitDOMDocument
 * @root: A #WebKitDOMNode
 * @what_to_show: A #gulong
 * @filter: A #WebKitDOMNodeFilter
 * @expand_entity_references: A #gboolean
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMTreeWalker*
webkit_dom_document_create_tree_walker(WebKitDOMDocument* self, WebKitDOMNode* root, gulong what_to_show, WebKitDOMNodeFilter* filter, gboolean expand_entity_references, GError **error);

/**
 * webkit_dom_document_get_override_style:
 * @self: A #WebKitDOMDocument
 * @element: A #WebKitDOMElement
 * @pseudo_element: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMCSSStyleDeclaration*
webkit_dom_document_get_override_style(WebKitDOMDocument* self, WebKitDOMElement* element, const gchar* pseudo_element);

/**
 * webkit_dom_document_create_expression:
 * @self: A #WebKitDOMDocument
 * @expression: A #gchar
 * @resolver: A #WebKitDOMXPathNSResolver
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMXPathExpression*
webkit_dom_document_create_expression(WebKitDOMDocument* self, const gchar* expression, WebKitDOMXPathNSResolver* resolver, GError **error);

/**
 * webkit_dom_document_create_ns_resolver:
 * @self: A #WebKitDOMDocument
 * @node_resolver: A #WebKitDOMNode
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMXPathNSResolver*
webkit_dom_document_create_ns_resolver(WebKitDOMDocument* self, WebKitDOMNode* node_resolver);

/**
 * webkit_dom_document_evaluate:
 * @self: A #WebKitDOMDocument
 * @expression: A #gchar
 * @context_node: A #WebKitDOMNode
 * @resolver: A #WebKitDOMXPathNSResolver
 * @type: A #gushort
 * @in_result: A #WebKitDOMXPathResult
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMXPathResult*
webkit_dom_document_evaluate(WebKitDOMDocument* self, const gchar* expression, WebKitDOMNode* context_node, WebKitDOMXPathNSResolver* resolver, gushort type, WebKitDOMXPathResult* in_result, GError **error);

/**
 * webkit_dom_document_exec_command:
 * @self: A #WebKitDOMDocument
 * @command: A #gchar
 * @user_interface: A #gboolean
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_exec_command(WebKitDOMDocument* self, const gchar* command, gboolean user_interface, const gchar* value);

/**
 * webkit_dom_document_query_command_enabled:
 * @self: A #WebKitDOMDocument
 * @command: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_query_command_enabled(WebKitDOMDocument* self, const gchar* command);

/**
 * webkit_dom_document_query_command_indeterm:
 * @self: A #WebKitDOMDocument
 * @command: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_query_command_indeterm(WebKitDOMDocument* self, const gchar* command);

/**
 * webkit_dom_document_query_command_state:
 * @self: A #WebKitDOMDocument
 * @command: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_query_command_state(WebKitDOMDocument* self, const gchar* command);

/**
 * webkit_dom_document_query_command_supported:
 * @self: A #WebKitDOMDocument
 * @command: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_query_command_supported(WebKitDOMDocument* self, const gchar* command);

/**
 * webkit_dom_document_query_command_value:
 * @self: A #WebKitDOMDocument
 * @command: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_query_command_value(WebKitDOMDocument* self, const gchar* command);

/**
 * webkit_dom_document_get_elements_by_name:
 * @self: A #WebKitDOMDocument
 * @element_name: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeList*
webkit_dom_document_get_elements_by_name(WebKitDOMDocument* self, const gchar* element_name);

/**
 * webkit_dom_document_element_from_point:
 * @self: A #WebKitDOMDocument
 * @x: A #glong
 * @y: A #glong
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_element_from_point(WebKitDOMDocument* self, glong x, glong y);

/**
 * webkit_dom_document_caret_range_from_point:
 * @self: A #WebKitDOMDocument
 * @x: A #glong
 * @y: A #glong
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMRange*
webkit_dom_document_caret_range_from_point(WebKitDOMDocument* self, glong x, glong y);

/**
 * webkit_dom_document_create_css_style_declaration:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMCSSStyleDeclaration*
webkit_dom_document_create_css_style_declaration(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_elements_by_class_name:
 * @self: A #WebKitDOMDocument
 * @tagname: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeList*
webkit_dom_document_get_elements_by_class_name(WebKitDOMDocument* self, const gchar* tagname);

/**
 * webkit_dom_document_query_selector:
 * @self: A #WebKitDOMDocument
 * @selectors: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_query_selector(WebKitDOMDocument* self, const gchar* selectors, GError **error);

/**
 * webkit_dom_document_query_selector_all:
 * @self: A #WebKitDOMDocument
 * @selectors: A #gchar
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMNodeList*
webkit_dom_document_query_selector_all(WebKitDOMDocument* self, const gchar* selectors, GError **error);

/**
 * webkit_dom_document_webkit_cancel_full_screen:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_webkit_cancel_full_screen(WebKitDOMDocument* self);

/**
 * webkit_dom_document_webkit_get_flow_by_name:
 * @self: A #WebKitDOMDocument
 * @name: A #gchar
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMWebKitNamedFlow*
webkit_dom_document_webkit_get_flow_by_name(WebKitDOMDocument* self, const gchar* name);

/**
 * webkit_dom_document_get_doctype:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMDocumentType*
webkit_dom_document_get_doctype(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_implementation:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMDOMImplementation*
webkit_dom_document_get_implementation(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_document_element:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_get_document_element(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_input_encoding:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_input_encoding(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_xml_encoding:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_xml_encoding(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_xml_version:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_xml_version(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_xml_version:
 * @self: A #WebKitDOMDocument
 * @value: A #gchar
 * @error: #GError
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_xml_version(WebKitDOMDocument* self, const gchar* value, GError **error);

/**
 * webkit_dom_document_get_xml_standalone:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_get_xml_standalone(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_xml_standalone:
 * @self: A #WebKitDOMDocument
 * @value: A #gboolean
 * @error: #GError
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_xml_standalone(WebKitDOMDocument* self, gboolean value, GError **error);

/**
 * webkit_dom_document_get_document_uri:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_document_uri(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_document_uri:
 * @self: A #WebKitDOMDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_document_uri(WebKitDOMDocument* self, const gchar* value);

/**
 * webkit_dom_document_get_default_view:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMDOMWindow*
webkit_dom_document_get_default_view(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_style_sheets:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMStyleSheetList*
webkit_dom_document_get_style_sheets(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_title:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_title(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_title:
 * @self: A #WebKitDOMDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_title(WebKitDOMDocument* self, const gchar* value);

/**
 * webkit_dom_document_get_referrer:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_referrer(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_domain:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_domain(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_cookie:
 * @self: A #WebKitDOMDocument
 * @error: #GError
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_cookie(WebKitDOMDocument* self, GError **error);

/**
 * webkit_dom_document_set_cookie:
 * @self: A #WebKitDOMDocument
 * @value: A #gchar
 * @error: #GError
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_cookie(WebKitDOMDocument* self, const gchar* value, GError **error);

/**
 * webkit_dom_document_get_body:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLElement*
webkit_dom_document_get_body(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_body:
 * @self: A #WebKitDOMDocument
 * @value: A #WebKitDOMHTMLElement
 * @error: #GError
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API void
webkit_dom_document_set_body(WebKitDOMDocument* self, WebKitDOMHTMLElement* value, GError **error);

/**
 * webkit_dom_document_get_head:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLHeadElement*
webkit_dom_document_get_head(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_images:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_document_get_images(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_applets:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_document_get_applets(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_links:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_document_get_links(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_forms:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_document_get_forms(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_anchors:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMHTMLCollection*
webkit_dom_document_get_anchors(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_last_modified:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_last_modified(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_charset:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_charset(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_charset:
 * @self: A #WebKitDOMDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_charset(WebKitDOMDocument* self, const gchar* value);

/**
 * webkit_dom_document_get_default_charset:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_default_charset(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_ready_state:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_ready_state(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_character_set:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_character_set(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_preferred_stylesheet_set:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_preferred_stylesheet_set(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_selected_stylesheet_set:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_selected_stylesheet_set(WebKitDOMDocument* self);

/**
 * webkit_dom_document_set_selected_stylesheet_set:
 * @self: A #WebKitDOMDocument
 * @value: A #gchar
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_document_set_selected_stylesheet_set(WebKitDOMDocument* self, const gchar* value);

/**
 * webkit_dom_document_get_compat_mode:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_compat_mode(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_webkit_is_full_screen:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_get_webkit_is_full_screen(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_webkit_full_screen_keyboard_input_allowed:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_get_webkit_full_screen_keyboard_input_allowed(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_webkit_current_full_screen_element:
 * @self: A #WebKitDOMDocument
 *
 * Returns: (transfer none):
 *
**/
WEBKIT_API WebKitDOMElement*
webkit_dom_document_get_webkit_current_full_screen_element(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_webkit_visibility_state:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_document_get_webkit_visibility_state(WebKitDOMDocument* self);

/**
 * webkit_dom_document_get_webkit_hidden:
 * @self: A #WebKitDOMDocument
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_document_get_webkit_hidden(WebKitDOMDocument* self);

G_END_DECLS

#endif /* WebKitDOMDocument_h */
