/*-----------------------------------------------------------
Implemented `IProvideMultipleClassInfo' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROVIDEMULTIPLECLASSINFO_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROVIDEMULTIPLECLASSINFO_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IProvideMultipleClassInfo_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IProvideMultipleClassInfo_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IProvideMultipleClassInfo_impl_stub : public ecom_control_library::IProvideMultipleClassInfo
{
public:
  IProvideMultipleClassInfo_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IProvideMultipleClassInfo_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetClassInfo(  /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_ti );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetGUID(  /* [in] */ ULONG dw_guid_kind, /* [out] */ GUID * p_guid );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetMultiTypeInfoCount(  /* [out] */ ULONG * pcti );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetInfoOfIndex(  /* [in] */ ULONG iti, /* [in] */ ULONG dw_flags, /* [out] */ ecom_control_library::ITypeInfo_2 * * ppti_co_class, /* [out] */ ULONG * pdw_tiflags, /* [out] */ ULONG * pcdispid_reserved, /* [out] */ GUID * piid_primary, /* [out] */ GUID * piid_source );


  /*-----------------------------------------------------------
  Decrement reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) Release();


  /*-----------------------------------------------------------
  Increment reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) AddRef();


  /*-----------------------------------------------------------
  Query Interface
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
  /*-----------------------------------------------------------
  Reference counter
  -----------------------------------------------------------*/
  LONG ref_count;


  /*-----------------------------------------------------------
  Corresponding Eiffel object
  -----------------------------------------------------------*/
  EIF_OBJECT eiffel_object;


  /*-----------------------------------------------------------
  Eiffel type id
  -----------------------------------------------------------*/
  EIF_TYPE_ID type_id;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
