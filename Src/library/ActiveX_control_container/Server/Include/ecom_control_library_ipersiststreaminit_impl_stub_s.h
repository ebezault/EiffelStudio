/*-----------------------------------------------------------
Implemented `IPersistStreamInit' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTSTREAMINIT_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTSTREAMINIT_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistStreamInit_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IPersistStreamInit_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistStreamInit_impl_stub : public ecom_control_library::IPersistStreamInit
{
public:
  IPersistStreamInit_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IPersistStreamInit_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IPersist_GetClassID(  /* [out] */ GUID * p_class_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IPersistStreamInit_IsDirty( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Load(  /* [in] */ ecom_control_library::IStream * pstm );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP Save(  /* [in] */ ecom_control_library::IStream * pstm, /* [in] */ LONG f_clear_dirty );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IPersistStreamInit_GetSizeMax(  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_size );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP IPersistStreamInit_InitNew( void );


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
