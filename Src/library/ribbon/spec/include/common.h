#ifndef _COMMON_H_
#define _COMMON_H_
#define CINTERFACE
#include <windows.h>
#include <ObjBase.h>
#include <initguid.h>
#include <Uiribbon.h>
//#include "resource.h"

DEFINE_GUID(IID_IUIFRAMEWORK, 0xf4f0385d, 0x6872, 0x43a8, 0xad, 0x09, 0x4c, 0x33, 0x9c, 0xb3, 0xf5, 0xc5);
DEFINE_GUID(IID_IUIAPPLICATION, 0xd428903c, 0x729a, 0x491d, 0x91, 0x0d, 0x68, 0x2a, 0x08, 0xff, 0x25, 0x22);
DEFINE_GUID(IID_IUICommandHandler, 0xefc7bdf, 0x1fdc, 0x487a, 0xbc, 0x9b, 0x24, 0xcd, 0x19, 0x29, 0x1a, 0x17);// {0EFC7BDF-1FDC-487a-BC9B-24CD19291A17}
DEFINE_GUID(IID_IUIRIBBON, 0x803982ab, 0x370a, 0x4f7e, 0xa9, 0xe7, 0x87, 0x84, 0x03, 0x6a, 0x6e, 0x26);//("803982ab-370a-4f7e-a9e7-8784036a6e26"))

#endif

BOOL InitializeFramework(HWND hWnd);
void DestroyRibbon();