/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef __XMLDOMDID_H__
#define __XMLDOMDID_H__

#define DISPID_DOM_BASE 0x00000001

#define DISPID_DOM_COLLECTION_BASE 1000000
#define DISPID_DOM_COLLECTION_MAX 2999999

#define DISPID_DOM_NODE (DISPID_DOM_BASE)
#define DISPID_DOM_NODE_NODENAME (DISPID_DOM_BASE + 1)
#define DISPID_DOM_NODE_NODEVALUE (DISPID_DOM_BASE + 2)
#define DISPID_DOM_NODE_NODETYPE (DISPID_DOM_BASE + 3)
#define DISPID_DOM_NODE_NODETYPEENUM (DISPID_DOM_BASE + 4)
#define DISPID_DOM_NODE_PARENTNODE (DISPID_DOM_BASE + 5)
#define DISPID_DOM_NODE_CHILDNODES (DISPID_DOM_BASE + 6)
#define DISPID_DOM_NODE_FIRSTCHILD (DISPID_DOM_BASE + 7)
#define DISPID_DOM_NODE_LASTCHILD (DISPID_DOM_BASE + 8)
#define DISPID_DOM_NODE_PREVIOUSSIBLING (DISPID_DOM_BASE + 9)
#define DISPID_DOM_NODE_NEXTSIBLING (DISPID_DOM_BASE + 10)
#define DISPID_DOM_NODE_ATTRIBUTES (DISPID_DOM_BASE + 11)
#define DISPID_DOM_NODE_INSERTBEFORE (DISPID_DOM_BASE + 12)
#define DISPID_DOM_NODE_REPLACECHILD (DISPID_DOM_BASE + 13)
#define DISPID_DOM_NODE_REMOVECHILD (DISPID_DOM_BASE + 14)
#define DISPID_DOM_NODE_APPENDCHILD (DISPID_DOM_BASE + 15)
#define DISPID_DOM_NODE_HASCHILDNODES (DISPID_DOM_BASE + 16)
#define DISPID_DOM_NODE_OWNERDOC (DISPID_DOM_BASE + 17)
#define DISPID_DOM_NODE_CLONENODE (DISPID_DOM_BASE + 18)
#define DISPID_XMLDOM_NODE (DISPID_DOM_BASE + 19)
#define DISPID_XMLDOM_NODE_STRINGTYPE (DISPID_DOM_BASE + 20)
#define DISPID_XMLDOM_NODE_SPECIFIED (DISPID_DOM_BASE + 21)
#define DISPID_XMLDOM_NODE_DEFINITION (DISPID_DOM_BASE + 22)
#define DISPID_XMLDOM_NODE_TEXT (DISPID_DOM_BASE + 23)
#define DISPID_XMLDOM_NODE_NODETYPEDVALUE (DISPID_DOM_BASE + 24)
#define DISPID_XMLDOM_NODE_DATATYPE (DISPID_DOM_BASE + 25)
#define DISPID_XMLDOM_NODE_XML (DISPID_DOM_BASE + 26)
#define DISPID_XMLDOM_NODE_TRANSFORMNODE (DISPID_DOM_BASE + 27)
#define DISPID_XMLDOM_NODE_SELECTNODES (DISPID_DOM_BASE + 28)
#define DISPID_XMLDOM_NODE_SELECTSINGLENODE (DISPID_DOM_BASE + 29)
#define DISPID_XMLDOM_NODE_PARSED (DISPID_DOM_BASE + 30)
#define DISPID_XMLDOM_NODE_NAMESPACE (DISPID_DOM_BASE + 31)
#define DISPID_XMLDOM_NODE_PREFIX (DISPID_DOM_BASE + 32)
#define DISPID_XMLDOM_NODE_BASENAME (DISPID_DOM_BASE + 33)
#define DISPID_XMLDOM_NODE_TRANSFORMNODETOOBJECT (DISPID_DOM_BASE + 34)
#define DISPID_XMLDOM_NODE__TOP (DISPID_DOM_BASE + 35)
#define DISPID_DOM_DOCUMENT (DISPID_DOM_BASE + 36)
#define DISPID_DOM_DOCUMENT_DOCTYPE (DISPID_DOM_BASE + 37)
#define DISPID_DOM_DOCUMENT_IMPLEMENTATION (DISPID_DOM_BASE + 38)
#define DISPID_DOM_DOCUMENT_DOCUMENTELEMENT (DISPID_DOM_BASE + 39)
#define DISPID_DOM_DOCUMENT_CREATEELEMENT (DISPID_DOM_BASE + 40)
#define DISPID_DOM_DOCUMENT_CREATEDOCUMENTFRAGMENT (DISPID_DOM_BASE + 41)
#define DISPID_DOM_DOCUMENT_CREATETEXTNODE (DISPID_DOM_BASE + 42)
#define DISPID_DOM_DOCUMENT_CREATECOMMENT (DISPID_DOM_BASE + 43)
#define DISPID_DOM_DOCUMENT_CREATECDATASECTION (DISPID_DOM_BASE + 44)
#define DISPID_DOM_DOCUMENT_CREATEPROCESSINGINSTRUCTION (DISPID_DOM_BASE + 45)
#define DISPID_DOM_DOCUMENT_CREATEATTRIBUTE (DISPID_DOM_BASE + 46)
#define DISPID_DOM_DOCUMENT_CREATEENTITY (DISPID_DOM_BASE + 47)
#define DISPID_DOM_DOCUMENT_CREATEENTITYREFERENCE (DISPID_DOM_BASE + 48)
#define DISPID_DOM_DOCUMENT_GETELEMENTSBYTAGNAME (DISPID_DOM_BASE + 49)
#define DISPID_DOM_DOCUMENT_TOP (DISPID_DOM_BASE + 50)
#define DISPID_XMLDOM_DOCUMENT (DISPID_DOM_BASE + 51)
#define DISPID_XMLDOM_DOCUMENT_DOCUMENTNODE (DISPID_DOM_BASE + 52)
#define DISPID_XMLDOM_DOCUMENT_CREATENODE (DISPID_DOM_BASE + 53)
#define DISPID_XMLDOM_DOCUMENT_CREATENODEEX (DISPID_DOM_BASE + 54)
#define DISPID_XMLDOM_DOCUMENT_NODEFROMID (DISPID_DOM_BASE + 55)
#define DISPID_XMLDOM_DOCUMENT_DOCUMENTNAMESPACES (DISPID_DOM_BASE + 56)
#define DISPID_XMLDOM_DOCUMENT_LOAD (DISPID_DOM_BASE + 57)
#define DISPID_XMLDOM_DOCUMENT_PARSEERROR (DISPID_DOM_BASE + 58)
#define DISPID_XMLDOM_DOCUMENT_URL (DISPID_DOM_BASE + 59)
#define DISPID_XMLDOM_DOCUMENT_ASYNC (DISPID_DOM_BASE + 60)
#define DISPID_XMLDOM_DOCUMENT_ABORT (DISPID_DOM_BASE + 61)
#define DISPID_XMLDOM_DOCUMENT_LOADXML (DISPID_DOM_BASE + 62)
#define DISPID_XMLDOM_DOCUMENT_SAVE (DISPID_DOM_BASE + 63)
#define DISPID_XMLDOM_DOCUMENT_VALIDATE (DISPID_DOM_BASE + 64)
#define DISPID_XMLDOM_DOCUMENT_RESOLVENAMESPACE (DISPID_DOM_BASE + 65)
#define DISPID_XMLDOM_DOCUMENT_PRESERVEWHITESPACE (DISPID_DOM_BASE + 66)
#define DISPID_XMLDOM_DOCUMENT_ONREADYSTATECHANGE (DISPID_DOM_BASE + 67)
#define DISPID_XMLDOM_DOCUMENT_ONDATAAVAILABLE (DISPID_DOM_BASE + 68)
#define DISPID_XMLDOM_DOCUMENT_ONTRANSFORMNODE (DISPID_DOM_BASE + 69)
#define DISPID_XMLDOM_DOCUMENT__TOP (DISPID_DOM_BASE + 70)
#define DISPID_DOM_NODELIST (DISPID_DOM_BASE + 71)
#define DISPID_DOM_NODELIST_ITEM (DISPID_DOM_BASE + 72)
#define DISPID_DOM_NODELIST_LENGTH (DISPID_DOM_BASE + 73)
#define DISPID_XMLDOM_NODELIST (DISPID_DOM_BASE + 74)
#define DISPID_XMLDOM_NODELIST_NEXTNODE (DISPID_DOM_BASE + 75)
#define DISPID_XMLDOM_NODELIST_RESET (DISPID_DOM_BASE + 76)
#define DISPID_XMLDOM_NODELIST_NEWENUM (DISPID_DOM_BASE + 77)
#define DISPID_XMLDOM_NODELIST__TOP (DISPID_DOM_BASE + 78)
#define DISPID_DOM_NAMEDNODEMAP (DISPID_DOM_BASE + 79)
#define DISPID_DOM_NAMEDNODEMAP_GETNAMEDITEM (DISPID_DOM_BASE + 82)
#define DISPID_DOM_NAMEDNODEMAP_SETNAMEDITEM (DISPID_DOM_BASE + 83)
#define DISPID_DOM_NAMEDNODEMAP_REMOVENAMEDITEM (DISPID_DOM_BASE + 84)
#define DISPID_XMLDOM_NAMEDNODEMAP (DISPID_DOM_BASE + 85)
#define DISPID_XMLDOM_NAMEDNODEMAP_GETQUALIFIEDITEM (DISPID_DOM_BASE + 86)
#define DISPID_XMLDOM_NAMEDNODEMAP_REMOVEQUALIFIEDITEM (DISPID_DOM_BASE + 87)
#define DISPID_XMLDOM_NAMEDNODEMAP_NEXTNODE (DISPID_DOM_BASE + 88)
#define DISPID_XMLDOM_NAMEDNODEMAP_RESET (DISPID_DOM_BASE + 89)
#define DISPID_XMLDOM_NAMEDNODEMAP_NEWENUM (DISPID_DOM_BASE + 90)
#define DISPID_XMLDOM_NAMEDNODEMAP__TOP (DISPID_DOM_BASE + 91)
#define DISPID_DOM_W3CWRAPPERS (DISPID_DOM_BASE + 92)
#define DISPID_DOM_DOCUMENTFRAGMENT (DISPID_DOM_BASE + 93)
#define DISPID_DOM_DOCUMENTFRAGMENT__TOP (DISPID_DOM_BASE + 94)
#define DISPID_DOM_ELEMENT (DISPID_DOM_BASE + 95)
#define DISPID_DOM_ELEMENT_GETTAGNAME (DISPID_DOM_BASE + 96)
#define DISPID_DOM_ELEMENT_GETATTRIBUTES (DISPID_DOM_BASE + 97)
#define DISPID_DOM_ELEMENT_GETATTRIBUTE (DISPID_DOM_BASE + 98)
#define DISPID_DOM_ELEMENT_SETATTRIBUTE (DISPID_DOM_BASE + 99)
#define DISPID_DOM_ELEMENT_REMOVEATTRIBUTE (DISPID_DOM_BASE + 100)
#define DISPID_DOM_ELEMENT_GETATTRIBUTENODE (DISPID_DOM_BASE + 101)
#define DISPID_DOM_ELEMENT_SETATTRIBUTENODE (DISPID_DOM_BASE + 102)
#define DISPID_DOM_ELEMENT_REMOVEATTRIBUTENODE (DISPID_DOM_BASE + 103)
#define DISPID_DOM_ELEMENT_GETELEMENTSBYTAGNAME (DISPID_DOM_BASE + 104)
#define DISPID_DOM_ELEMENT_NORMALIZE (DISPID_DOM_BASE + 105)
#define DISPID_DOM_ELEMENT__TOP (DISPID_DOM_BASE + 106)
#define DISPID_DOM_DATA (DISPID_DOM_BASE + 107)
#define DISPID_DOM_DATA_DATA (DISPID_DOM_BASE + 108)
#define DISPID_DOM_DATA_LENGTH (DISPID_DOM_BASE + 109)
#define DISPID_DOM_DATA_SUBSTRING (DISPID_DOM_BASE + 110)
#define DISPID_DOM_DATA_APPEND (DISPID_DOM_BASE + 111)
#define DISPID_DOM_DATA_INSERT (DISPID_DOM_BASE + 112)
#define DISPID_DOM_DATA_DELETE (DISPID_DOM_BASE + 113)
#define DISPID_DOM_DATA_REPLACE (DISPID_DOM_BASE + 114)
#define DISPID_DOM_DATA__TOP (DISPID_DOM_BASE + 115)
#define DISPID_DOM_ATTRIBUTE (DISPID_DOM_BASE + 116)
#define DISPID_DOM_ATTRIBUTE_GETNAME (DISPID_DOM_BASE + 117)
#define DISPID_DOM_ATTRIBUTE_SPECIFIED (DISPID_DOM_BASE + 118)
#define DISPID_DOM_ATTRIBUTE_VALUE (DISPID_DOM_BASE + 119)
#define DISPID_DOM_ATTRIBUTE__TOP (DISPID_DOM_BASE + 120)
#define DISPID_DOM_TEXT (DISPID_DOM_BASE + 121)
#define DISPID_DOM_TEXT_SPLITTEXT (DISPID_DOM_BASE + 122)
#define DISPID_DOM_TEXT_JOINTEXT (DISPID_DOM_BASE + 123)
#define DISPID_DOM_TEXT__TOP (DISPID_DOM_BASE + 124)
#define DISPID_DOM_PI (DISPID_DOM_BASE + 125)
#define DISPID_DOM_PI_TARGET (DISPID_DOM_BASE + 126)
#define DISPID_DOM_PI_DATA (DISPID_DOM_BASE + 127)
#define DISPID_DOM_PI__TOP (DISPID_DOM_BASE + 128)
#define DISPID_DOM_DOCUMENTTYPE (DISPID_DOM_BASE + 129)
#define DISPID_DOM_DOCUMENTTYPE_NAME (DISPID_DOM_BASE + 130)
#define DISPID_DOM_DOCUMENTTYPE_ENTITIES (DISPID_DOM_BASE + 131)
#define DISPID_DOM_DOCUMENTTYPE_NOTATIONS (DISPID_DOM_BASE + 132)
#define DISPID_DOM_DOCUMENTTYPE__TOP (DISPID_DOM_BASE + 133)
#define DISPID_DOM_NOTATION (DISPID_DOM_BASE + 134)
#define DISPID_DOM_NOTATION_PUBLICID (DISPID_DOM_BASE + 135)
#define DISPID_DOM_NOTATION_SYSTEMID (DISPID_DOM_BASE + 136)
#define DISPID_DOM_NOTATION__TOP (DISPID_DOM_BASE + 137)
#define DISPID_DOM_ENTITY (DISPID_DOM_BASE + 138)
#define DISPID_DOM_ENTITY_PUBLICID (DISPID_DOM_BASE + 139)
#define DISPID_DOM_ENTITY_SYSTEMID (DISPID_DOM_BASE + 140)
#define DISPID_DOM_ENTITY_NOTATIONNAME (DISPID_DOM_BASE + 141)
#define DISPID_DOM_ENTITY__TOP (DISPID_DOM_BASE + 142)
#define DISPID_DOM_W3CWRAPPERS_TOP (DISPID_DOM_BASE + 142)
#define DISPID_DOM_IMPLEMENTATION (DISPID_DOM_BASE + 143)
#define DISPID_DOM_IMPLEMENTATION_HASFEATURE (DISPID_DOM_BASE + 144)
#define DISPID_DOM_IMPLEMENTATION__TOP (DISPID_DOM_BASE + 145)
#define DISPID_DOM__TOP (DISPID_DOM_BASE + 175)
#define DISPID_DOM_ERROR (DISPID_DOM_BASE + 176)
#define DISPID_DOM_ERROR_ERRORCODE (DISPID_DOM_BASE + 177)
#define DISPID_DOM_ERROR_URL (DISPID_DOM_BASE + 178)
#define DISPID_DOM_ERROR_REASON (DISPID_DOM_BASE + 179)
#define DISPID_DOM_ERROR_SRCTEXT (DISPID_DOM_BASE + 180)
#define DISPID_DOM_ERROR_LINE (DISPID_DOM_BASE + 181)
#define DISPID_DOM_ERROR_LINEPOS (DISPID_DOM_BASE + 182)
#define DISPID_DOM_ERROR_FILEPOS (DISPID_DOM_BASE + 183)
#define DISPID_DOM_ERROR__TOP (DISPID_DOM_BASE + 184)
#define DISPID_XTLRUNTIME (DISPID_DOM_BASE + 185)
#define DISPID_XTLRUNTIME_UNIQUEID (DISPID_DOM_BASE + 186)
#define DISPID_XTLRUNTIME_DEPTH (DISPID_DOM_BASE + 187)
#define DISPID_XTLRUNTIME_CHILDNUMBER (DISPID_DOM_BASE + 188)
#define DISPID_XTLRUNTIME_ANCESTORCHILDNUMBER (DISPID_DOM_BASE + 189)
#define DISPID_XTLRUNTIME_ABSOLUTECHILDNUMBER (DISPID_DOM_BASE + 190)
#define DISPID_XTLRUNTIME_FORMATINDEX (DISPID_DOM_BASE + 191)
#define DISPID_XTLRUNTIME_FORMATNUMBER (DISPID_DOM_BASE + 192)
#define DISPID_XTLRUNTIME_FORMATDATE (DISPID_DOM_BASE + 193)
#define DISPID_XTLRUNTIME_FORMATTIME (DISPID_DOM_BASE + 194)
#define DISPID_XTLRUNTIME__TOP (DISPID_DOM_BASE + 195)
#define DISPID_XMLDOMEVENT (DISPID_DOM_BASE + 196)
#define DISPID_XMLDOMEVENT_ONREADYSTATECHANGE (DISPID_READYSTATECHANGE)
#define DISPID_XMLDOMEVENT_ONDATAAVAILABLE (DISPID_DOM_BASE + 197)
#define DISPID_XMLDOMEVENT__TOP (DISPID_DOM_BASE + 198)
#endif
