/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagSTATDATA
	formatetc: typedef
			-- No description available.
	advf: ULONG
			-- No description available.
	pAdvSink: Pointed Type
			-- No description available.
	dwConnection: ULONG
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGSTATDATA_S_H__
#define __ECOM_CONTROL_LIBRARY_TAGSTATDATA_S_H__
#ifdef __cplusplus
extern "C" {
#endif


namespace ecom_control_library
{
struct tagtagSTATDATA;
typedef struct ecom_control_library::tagtagSTATDATA tagSTATDATA;
}

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_control_library_IAdviseSink_s.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library
{
struct tagtagSTATDATA
{	ecom_control_library::tagFORMATETC formatetc;
	ULONG advf;
	ecom_control_library::IAdviseSink * pAdvSink;
	ULONG dwConnection;
};
}
#ifdef __cplusplus
}
#endif

#endif