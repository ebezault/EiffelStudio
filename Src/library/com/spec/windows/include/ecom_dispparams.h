/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record DISPPARAMS
	rgvarg: Pointed Type
			-- No description available.
	rgdispidNamedArgs: Pointed Type
			-- No description available.
	cArgs: UINT
			-- No description available.
	cNamedArgs: UINT
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_DISPPARAMS_H__
#define __ECOM_DISPPARAMS_H__
#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus
}
#endif

#include "ecom_rt_globals.h"

#ifdef __cplusplus


#define ccom_dispparams_rgvarg(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_pointed_variant (((DISPPARAMS *)_ptr_)->rgvarg))

#define ccom_dispparams_set_rgvarg(_ptr_, _field_) ((((DISPPARAMS *)_ptr_)->rgvarg) = (VARIANT *)_field_)

#define ccom_dispparams_rgdispid_named_args(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_pointed_long (((DISPPARAMS *)_ptr_)->rgdispidNamedArgs, NULL))

#define ccom_dispparams_set_rgdispid_named_args(_ptr_, _field_) ((((DISPPARAMS *)_ptr_)->rgdispidNamedArgs) = rt_ec.ccom_ec_pointed_long (eif_access (_field_), NULL))

#define ccom_dispparams_c_args(_ptr_) (EIF_INTEGER)(UINT)(((DISPPARAMS *)_ptr_)->cArgs)

#define ccom_dispparams_set_c_args(_ptr_, _field_) ((((DISPPARAMS *)_ptr_)->cArgs) = (UINT)_field_)

#define ccom_dispparams_c_named_args(_ptr_) (EIF_INTEGER)(UINT)(((DISPPARAMS *)_ptr_)->cNamedArgs)

#define ccom_dispparams_set_c_named_args(_ptr_, _field_) ((((DISPPARAMS *)_ptr_)->cNamedArgs) = (UINT)_field_)

#endif

#endif