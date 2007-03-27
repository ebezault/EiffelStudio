

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 6.00.0366 */
/* Compiler settings for fusion.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __fusion_h__
#define __fusion_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IAssemblyCache_FWD_DEFINED__
#define __IAssemblyCache_FWD_DEFINED__
typedef interface IAssemblyCache IAssemblyCache;
#endif 	/* __IAssemblyCache_FWD_DEFINED__ */


#ifndef __IAssemblyCacheItem_FWD_DEFINED__
#define __IAssemblyCacheItem_FWD_DEFINED__
typedef interface IAssemblyCacheItem IAssemblyCacheItem;
#endif 	/* __IAssemblyCacheItem_FWD_DEFINED__ */


#ifndef __IAssemblyName_FWD_DEFINED__
#define __IAssemblyName_FWD_DEFINED__
typedef interface IAssemblyName IAssemblyName;
#endif 	/* __IAssemblyName_FWD_DEFINED__ */


#ifndef __IAssemblyEnum_FWD_DEFINED__
#define __IAssemblyEnum_FWD_DEFINED__
typedef interface IAssemblyEnum IAssemblyEnum;
#endif 	/* __IAssemblyEnum_FWD_DEFINED__ */


#ifndef __IInstallReferenceItem_FWD_DEFINED__
#define __IInstallReferenceItem_FWD_DEFINED__
typedef interface IInstallReferenceItem IInstallReferenceItem;
#endif 	/* __IInstallReferenceItem_FWD_DEFINED__ */


#ifndef __IInstallReferenceEnum_FWD_DEFINED__
#define __IInstallReferenceEnum_FWD_DEFINED__
typedef interface IInstallReferenceEnum IInstallReferenceEnum;
#endif 	/* __IInstallReferenceEnum_FWD_DEFINED__ */


/* header files for imported files */
#include "objidl.h"

#ifdef __cplusplus
extern "C"{
#endif 

void * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void * ); 

/* interface __MIDL_itf_fusion_0000 */
/* [local] */ 


#ifdef _MSC_VER
#pragma comment(lib,"uuid.lib")
#endif

//---------------------------------------------------------------------------=
// Fusion Interfaces.

#ifdef _MSC_VER
#pragma once
#endif




typedef /* [public] */ 
enum __MIDL___MIDL_itf_fusion_0000_0001
    {	ASM_CACHE_ZAP	= 0x1,
	ASM_CACHE_GAC	= 0x2,
	ASM_CACHE_DOWNLOAD	= 0x4,
	ASM_CACHE_ROOT	= 0x8
    } 	ASM_CACHE_FLAGS;

typedef /* [public] */ 
enum __MIDL___MIDL_itf_fusion_0000_0002
    {	peNone	= 0,
	peMSIL	= 0x1,
	peI386	= 0x2,
	peIA64	= 0x3,
	peAMD64	= 0x4,
	peInvalid	= 0xffffffff
    } 	PEKIND;



extern RPC_IF_HANDLE __MIDL_itf_fusion_0000_v0_0_c_ifspec;
extern RPC_IF_HANDLE __MIDL_itf_fusion_0000_v0_0_s_ifspec;

#ifndef __IAssemblyCache_INTERFACE_DEFINED__
#define __IAssemblyCache_INTERFACE_DEFINED__

/* interface IAssemblyCache */
/* [unique][uuid][object][local] */ 

// {8cedc215-ac4b-488b-93c0-a50a49cb2fb8}
EXTERN_GUID(FUSION_REFCOUNT_UNINSTALL_SUBKEY_GUID, 0x8cedc215, 0xac4b, 0x488b, 0x93, 0xc0, 0xa5, 0x0a, 0x49, 0xcb, 0x2f, 0xb8);

// {b02f9d65-fb77-4f7a-afa5-b391309f11c9}
EXTERN_GUID(FUSION_REFCOUNT_FILEPATH_GUID, 0xb02f9d65, 0xfb77, 0x4f7a, 0xaf, 0xa5, 0xb3, 0x91, 0x30, 0x9f, 0x11, 0xc9);

// {2ec93463-b0c3-45e1-8364-327e96aea856}
EXTERN_GUID(FUSION_REFCOUNT_OPAQUE_STRING_GUID, 0x2ec93463, 0xb0c3, 0x45e1, 0x83, 0x64, 0x32, 0x7e, 0x96, 0xae, 0xa8, 0x56);
 // {25df0fc1-7f97-4070-add7-4b13bbfd7cb8} // this GUID cannot be used for installing into GAC.
EXTERN_GUID(FUSION_REFCOUNT_MSI_GUID,  0x25df0fc1, 0x7f97, 0x4070, 0xad, 0xd7, 0x4b, 0x13, 0xbb, 0xfd, 0x7c, 0xb8); 
 // {d16d444c-56d8-11d5-882d-0080c847b195}
EXTERN_GUID(FUSION_REFCOUNT_OSINSTALL_GUID, 0xd16d444c, 0x56d8, 0x11d5, 0x88, 0x2d, 0x00, 0x80, 0xc8, 0x47, 0xb1, 0x95); 
typedef struct _FUSION_INSTALL_REFERENCE_
    {
    DWORD cbSize;
    DWORD dwFlags;
    GUID guidScheme;
    LPCWSTR szIdentifier;
    LPCWSTR szNonCannonicalData;
    } 	FUSION_INSTALL_REFERENCE;

typedef struct _FUSION_INSTALL_REFERENCE_ *LPFUSION_INSTALL_REFERENCE;

typedef const FUSION_INSTALL_REFERENCE *LPCFUSION_INSTALL_REFERENCE;

typedef struct _ASSEMBLY_INFO
    {
    ULONG cbAssemblyInfo;
    DWORD dwAssemblyFlags;
    ULARGE_INTEGER uliAssemblySizeInKB;
    LPWSTR pszCurrentAssemblyPathBuf;
    ULONG cchBuf;
    } 	ASSEMBLY_INFO;

#define IASSEMBLYCACHE_INSTALL_FLAG_REFRESH       (0x00000001)
#define IASSEMBLYCACHE_INSTALL_FLAG_FORCE_REFRESH (0x00000002)
#define IASSEMBLYCACHE_UNINSTALL_DISPOSITION_UNINSTALLED (1)
#define IASSEMBLYCACHE_UNINSTALL_DISPOSITION_STILL_IN_USE (2)
#define IASSEMBLYCACHE_UNINSTALL_DISPOSITION_ALREADY_UNINSTALLED (3)
#define IASSEMBLYCACHE_UNINSTALL_DISPOSITION_DELETE_PENDING (4)
#define IASSEMBLYCACHE_UNINSTALL_DISPOSITION_HAS_INSTALL_REFERENCES (5)
#define IASSEMBLYCACHE_UNINSTALL_DISPOSITION_REFERENCE_NOT_FOUND (6)
#define QUERYASMINFO_FLAG_VALIDATE        (0x00000001)
#define QUERYASMINFO_FLAG_GETSIZE         (0x00000002)
#define ASSEMBLYINFO_FLAG_INSTALLED       (0x00000001)
#define ASSEMBLYINFO_FLAG_PAYLOADRESIDENT (0x00000002)

EXTERN_C const IID IID_IAssemblyCache;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("e707dcde-d1cd-11d2-bab9-00c04f8eceae")
    IAssemblyCache : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE UninstallAssembly( 
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszAssemblyName,
            /* [in] */ LPCFUSION_INSTALL_REFERENCE pRefData,
            /* [optional][out] */ ULONG *pulDisposition) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE QueryAssemblyInfo( 
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszAssemblyName,
            /* [out][in] */ ASSEMBLY_INFO *pAsmInfo) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CreateAssemblyCacheItem( 
            /* [in] */ DWORD dwFlags,
            /* [in] */ PVOID pvReserved,
            /* [out] */ IAssemblyCacheItem **ppAsmItem,
            /* [optional][in] */ LPCWSTR pszAssemblyName) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE CreateAssemblyScavenger( 
            /* [out] */ IUnknown **ppUnkReserved) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE InstallAssembly( 
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszManifestFilePath,
            /* [in] */ LPCFUSION_INSTALL_REFERENCE pRefData) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAssemblyCacheVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IAssemblyCache * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IAssemblyCache * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IAssemblyCache * This);
        
        HRESULT ( STDMETHODCALLTYPE *UninstallAssembly )( 
            IAssemblyCache * This,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszAssemblyName,
            /* [in] */ LPCFUSION_INSTALL_REFERENCE pRefData,
            /* [optional][out] */ ULONG *pulDisposition);
        
        HRESULT ( STDMETHODCALLTYPE *QueryAssemblyInfo )( 
            IAssemblyCache * This,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszAssemblyName,
            /* [out][in] */ ASSEMBLY_INFO *pAsmInfo);
        
        HRESULT ( STDMETHODCALLTYPE *CreateAssemblyCacheItem )( 
            IAssemblyCache * This,
            /* [in] */ DWORD dwFlags,
            /* [in] */ PVOID pvReserved,
            /* [out] */ IAssemblyCacheItem **ppAsmItem,
            /* [optional][in] */ LPCWSTR pszAssemblyName);
        
        HRESULT ( STDMETHODCALLTYPE *CreateAssemblyScavenger )( 
            IAssemblyCache * This,
            /* [out] */ IUnknown **ppUnkReserved);
        
        HRESULT ( STDMETHODCALLTYPE *InstallAssembly )( 
            IAssemblyCache * This,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszManifestFilePath,
            /* [in] */ LPCFUSION_INSTALL_REFERENCE pRefData);
        
        END_INTERFACE
    } IAssemblyCacheVtbl;

    interface IAssemblyCache
    {
        CONST_VTBL struct IAssemblyCacheVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAssemblyCache_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAssemblyCache_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAssemblyCache_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAssemblyCache_UninstallAssembly(This,dwFlags,pszAssemblyName,pRefData,pulDisposition)	\
    (This)->lpVtbl -> UninstallAssembly(This,dwFlags,pszAssemblyName,pRefData,pulDisposition)

#define IAssemblyCache_QueryAssemblyInfo(This,dwFlags,pszAssemblyName,pAsmInfo)	\
    (This)->lpVtbl -> QueryAssemblyInfo(This,dwFlags,pszAssemblyName,pAsmInfo)

#define IAssemblyCache_CreateAssemblyCacheItem(This,dwFlags,pvReserved,ppAsmItem,pszAssemblyName)	\
    (This)->lpVtbl -> CreateAssemblyCacheItem(This,dwFlags,pvReserved,ppAsmItem,pszAssemblyName)

#define IAssemblyCache_CreateAssemblyScavenger(This,ppUnkReserved)	\
    (This)->lpVtbl -> CreateAssemblyScavenger(This,ppUnkReserved)

#define IAssemblyCache_InstallAssembly(This,dwFlags,pszManifestFilePath,pRefData)	\
    (This)->lpVtbl -> InstallAssembly(This,dwFlags,pszManifestFilePath,pRefData)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE IAssemblyCache_UninstallAssembly_Proxy( 
    IAssemblyCache * This,
    /* [in] */ DWORD dwFlags,
    /* [in] */ LPCWSTR pszAssemblyName,
    /* [in] */ LPCFUSION_INSTALL_REFERENCE pRefData,
    /* [optional][out] */ ULONG *pulDisposition);


void __RPC_STUB IAssemblyCache_UninstallAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyCache_QueryAssemblyInfo_Proxy( 
    IAssemblyCache * This,
    /* [in] */ DWORD dwFlags,
    /* [in] */ LPCWSTR pszAssemblyName,
    /* [out][in] */ ASSEMBLY_INFO *pAsmInfo);


void __RPC_STUB IAssemblyCache_QueryAssemblyInfo_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyCache_CreateAssemblyCacheItem_Proxy( 
    IAssemblyCache * This,
    /* [in] */ DWORD dwFlags,
    /* [in] */ PVOID pvReserved,
    /* [out] */ IAssemblyCacheItem **ppAsmItem,
    /* [optional][in] */ LPCWSTR pszAssemblyName);


void __RPC_STUB IAssemblyCache_CreateAssemblyCacheItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyCache_CreateAssemblyScavenger_Proxy( 
    IAssemblyCache * This,
    /* [out] */ IUnknown **ppUnkReserved);


void __RPC_STUB IAssemblyCache_CreateAssemblyScavenger_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyCache_InstallAssembly_Proxy( 
    IAssemblyCache * This,
    /* [in] */ DWORD dwFlags,
    /* [in] */ LPCWSTR pszManifestFilePath,
    /* [in] */ LPCFUSION_INSTALL_REFERENCE pRefData);


void __RPC_STUB IAssemblyCache_InstallAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAssemblyCache_INTERFACE_DEFINED__ */


#ifndef __IAssemblyCacheItem_INTERFACE_DEFINED__
#define __IAssemblyCacheItem_INTERFACE_DEFINED__

/* interface IAssemblyCacheItem */
/* [unique][uuid][object][local] */ 

#define STREAM_FORMAT_COMPLIB_MODULE    0
#define STREAM_FORMAT_COMPLIB_MANIFEST  1
#define STREAM_FORMAT_WIN32_MODULE      2
#define STREAM_FORMAT_WIN32_MANIFEST    4
#define IASSEMBLYCACHEITEM_COMMIT_FLAG_REFRESH       (0x00000001)
#define IASSEMBLYCACHEITEM_COMMIT_FLAG_FORCE_REFRESH (0x00000002)
#define IASSEMBLYCACHEITEM_COMMIT_DISPOSITION_INSTALLED (1)
#define IASSEMBLYCACHEITEM_COMMIT_DISPOSITION_REFRESHED (2)
#define IASSEMBLYCACHEITEM_COMMIT_DISPOSITION_ALREADY_INSTALLED (3)

EXTERN_C const IID IID_IAssemblyCacheItem;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("9e3aaeb4-d1cd-11d2-bab9-00c04f8eceae")
    IAssemblyCacheItem : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE CreateStream( 
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszStreamName,
            /* [in] */ DWORD dwFormat,
            /* [in] */ DWORD dwFormatFlags,
            /* [out] */ IStream **ppIStream,
            /* [optional][in] */ ULARGE_INTEGER *puliMaxSize) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Commit( 
            /* [in] */ DWORD dwFlags,
            /* [optional][out] */ ULONG *pulDisposition) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE AbortItem( void) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAssemblyCacheItemVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IAssemblyCacheItem * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IAssemblyCacheItem * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IAssemblyCacheItem * This);
        
        HRESULT ( STDMETHODCALLTYPE *CreateStream )( 
            IAssemblyCacheItem * This,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPCWSTR pszStreamName,
            /* [in] */ DWORD dwFormat,
            /* [in] */ DWORD dwFormatFlags,
            /* [out] */ IStream **ppIStream,
            /* [optional][in] */ ULARGE_INTEGER *puliMaxSize);
        
        HRESULT ( STDMETHODCALLTYPE *Commit )( 
            IAssemblyCacheItem * This,
            /* [in] */ DWORD dwFlags,
            /* [optional][out] */ ULONG *pulDisposition);
        
        HRESULT ( STDMETHODCALLTYPE *AbortItem )( 
            IAssemblyCacheItem * This);
        
        END_INTERFACE
    } IAssemblyCacheItemVtbl;

    interface IAssemblyCacheItem
    {
        CONST_VTBL struct IAssemblyCacheItemVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAssemblyCacheItem_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAssemblyCacheItem_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAssemblyCacheItem_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAssemblyCacheItem_CreateStream(This,dwFlags,pszStreamName,dwFormat,dwFormatFlags,ppIStream,puliMaxSize)	\
    (This)->lpVtbl -> CreateStream(This,dwFlags,pszStreamName,dwFormat,dwFormatFlags,ppIStream,puliMaxSize)

#define IAssemblyCacheItem_Commit(This,dwFlags,pulDisposition)	\
    (This)->lpVtbl -> Commit(This,dwFlags,pulDisposition)

#define IAssemblyCacheItem_AbortItem(This)	\
    (This)->lpVtbl -> AbortItem(This)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE IAssemblyCacheItem_CreateStream_Proxy( 
    IAssemblyCacheItem * This,
    /* [in] */ DWORD dwFlags,
    /* [in] */ LPCWSTR pszStreamName,
    /* [in] */ DWORD dwFormat,
    /* [in] */ DWORD dwFormatFlags,
    /* [out] */ IStream **ppIStream,
    /* [optional][in] */ ULARGE_INTEGER *puliMaxSize);


void __RPC_STUB IAssemblyCacheItem_CreateStream_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyCacheItem_Commit_Proxy( 
    IAssemblyCacheItem * This,
    /* [in] */ DWORD dwFlags,
    /* [optional][out] */ ULONG *pulDisposition);


void __RPC_STUB IAssemblyCacheItem_Commit_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyCacheItem_AbortItem_Proxy( 
    IAssemblyCacheItem * This);


void __RPC_STUB IAssemblyCacheItem_AbortItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAssemblyCacheItem_INTERFACE_DEFINED__ */


#ifndef __IAssemblyName_INTERFACE_DEFINED__
#define __IAssemblyName_INTERFACE_DEFINED__

/* interface IAssemblyName */
/* [unique][uuid][object][local] */ 

typedef /* [unique] */ IAssemblyName *LPASSEMBLYNAME;

typedef /* [public] */ 
enum __MIDL_IAssemblyName_0001
    {	CANOF_PARSE_DISPLAY_NAME	= 0x1,
	CANOF_SET_DEFAULT_VALUES	= 0x2,
	CANOF_VERIFY_FRIEND_ASSEMBLYNAME	= 0x4,
	CANOF_PARSE_FRIEND_DISPLAY_NAME	= CANOF_PARSE_DISPLAY_NAME | CANOF_VERIFY_FRIEND_ASSEMBLYNAME
    } 	CREATE_ASM_NAME_OBJ_FLAGS;

typedef /* [public] */ 
enum __MIDL_IAssemblyName_0002
    {	ASM_NAME_PUBLIC_KEY	= 0,
	ASM_NAME_PUBLIC_KEY_TOKEN	= ASM_NAME_PUBLIC_KEY + 1,
	ASM_NAME_HASH_VALUE	= ASM_NAME_PUBLIC_KEY_TOKEN + 1,
	ASM_NAME_NAME	= ASM_NAME_HASH_VALUE + 1,
	ASM_NAME_MAJOR_VERSION	= ASM_NAME_NAME + 1,
	ASM_NAME_MINOR_VERSION	= ASM_NAME_MAJOR_VERSION + 1,
	ASM_NAME_BUILD_NUMBER	= ASM_NAME_MINOR_VERSION + 1,
	ASM_NAME_REVISION_NUMBER	= ASM_NAME_BUILD_NUMBER + 1,
	ASM_NAME_CULTURE	= ASM_NAME_REVISION_NUMBER + 1,
	ASM_NAME_PROCESSOR_ID_ARRAY	= ASM_NAME_CULTURE + 1,
	ASM_NAME_OSINFO_ARRAY	= ASM_NAME_PROCESSOR_ID_ARRAY + 1,
	ASM_NAME_HASH_ALGID	= ASM_NAME_OSINFO_ARRAY + 1,
	ASM_NAME_ALIAS	= ASM_NAME_HASH_ALGID + 1,
	ASM_NAME_CODEBASE_URL	= ASM_NAME_ALIAS + 1,
	ASM_NAME_CODEBASE_LASTMOD	= ASM_NAME_CODEBASE_URL + 1,
	ASM_NAME_NULL_PUBLIC_KEY	= ASM_NAME_CODEBASE_LASTMOD + 1,
	ASM_NAME_NULL_PUBLIC_KEY_TOKEN	= ASM_NAME_NULL_PUBLIC_KEY + 1,
	ASM_NAME_CUSTOM	= ASM_NAME_NULL_PUBLIC_KEY_TOKEN + 1,
	ASM_NAME_NULL_CUSTOM	= ASM_NAME_CUSTOM + 1,
	ASM_NAME_MVID	= ASM_NAME_NULL_CUSTOM + 1,
	ASM_NAME_FILE_MAJOR_VERSION	= ASM_NAME_MVID + 1,
	ASM_NAME_FILE_MINOR_VERSION	= ASM_NAME_FILE_MAJOR_VERSION + 1,
	ASM_NAME_FILE_BUILD_NUMBER	= ASM_NAME_FILE_MINOR_VERSION + 1,
	ASM_NAME_FILE_REVISION_NUMBER	= ASM_NAME_FILE_BUILD_NUMBER + 1,
	ASM_NAME_RETARGET	= ASM_NAME_FILE_REVISION_NUMBER + 1,
	ASM_NAME_SIGNATURE_BLOB	= ASM_NAME_RETARGET + 1,
	ASM_NAME_CONFIG_MASK	= ASM_NAME_SIGNATURE_BLOB + 1,
	ASM_NAME_ARCHITECTURE	= ASM_NAME_CONFIG_MASK + 1,
	ASM_NAME_MAX_PARAMS	= ASM_NAME_ARCHITECTURE + 1
    } 	ASM_NAME;

typedef /* [public] */ 
enum __MIDL_IAssemblyName_0003
    {	ASM_DISPLAYF_VERSION	= 0x1,
	ASM_DISPLAYF_CULTURE	= 0x2,
	ASM_DISPLAYF_PUBLIC_KEY_TOKEN	= 0x4,
	ASM_DISPLAYF_PUBLIC_KEY	= 0x8,
	ASM_DISPLAYF_CUSTOM	= 0x10,
	ASM_DISPLAYF_PROCESSORARCHITECTURE	= 0x20,
	ASM_DISPLAYF_LANGUAGEID	= 0x40,
	ASM_DISPLAYF_RETARGET	= 0x80,
	ASM_DISPLAYF_CONFIG_MASK	= 0x100,
	ASM_DISPLAYF_MVID	= 0x200,
	ASM_DISPLAYF_FULL	= ASM_DISPLAYF_VERSION | ASM_DISPLAYF_CULTURE | ASM_DISPLAYF_PUBLIC_KEY_TOKEN | ASM_DISPLAYF_RETARGET | ASM_DISPLAYF_PROCESSORARCHITECTURE
    } 	ASM_DISPLAY_FLAGS;

typedef /* [public] */ 
enum __MIDL_IAssemblyName_0004
    {	ASM_CMPF_NAME	= 0x1,
	ASM_CMPF_MAJOR_VERSION	= 0x2,
	ASM_CMPF_MINOR_VERSION	= 0x4,
	ASM_CMPF_BUILD_NUMBER	= 0x8,
	ASM_CMPF_REVISION_NUMBER	= 0x10,
	ASM_CMPF_VERSION	= ASM_CMPF_MAJOR_VERSION | ASM_CMPF_MINOR_VERSION | ASM_CMPF_BUILD_NUMBER | ASM_CMPF_REVISION_NUMBER,
	ASM_CMPF_PUBLIC_KEY_TOKEN	= 0x20,
	ASM_CMPF_CULTURE	= 0x40,
	ASM_CMPF_CUSTOM	= 0x80,
	ASM_CMPF_DEFAULT	= 0x100,
	ASM_CMPF_RETARGET	= 0x200,
	ASM_CMPF_ARCHITECTURE	= 0x400,
	ASM_CMPF_CONFIG_MASK	= 0x800,
	ASM_CMPF_MVID	= 0x1000,
	ASM_CMPF_SIGNATURE	= 0x2000,
	ASM_CMPF_IL_ALL	= ASM_CMPF_NAME | ASM_CMPF_VERSION | ASM_CMPF_PUBLIC_KEY_TOKEN | ASM_CMPF_CULTURE,
	ASM_CMPF_IL_NO_VERSION	= ASM_CMPF_NAME | ASM_CMPF_PUBLIC_KEY_TOKEN | ASM_CMPF_CULTURE
    } 	ASM_CMP_FLAGS;


EXTERN_C const IID IID_IAssemblyName;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CD193BC0-B4BC-11d2-9833-00C04FC31D2E")
    IAssemblyName : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE SetProperty( 
            /* [in] */ DWORD PropertyId,
            /* [in] */ LPVOID pvProperty,
            /* [in] */ DWORD cbProperty) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetProperty( 
            /* [in] */ DWORD PropertyId,
            /* [out] */ LPVOID pvProperty,
            /* [out][in] */ LPDWORD pcbProperty) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Finalize( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetDisplayName( 
            /* [out] */ LPOLESTR szDisplayName,
            /* [out][in] */ LPDWORD pccDisplayName,
            /* [in] */ DWORD dwDisplayFlags) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Reserved( 
            /* [in] */ REFIID refIID,
            /* [in] */ IUnknown *pUnkReserved1,
            /* [in] */ IUnknown *pUnkReserved2,
            /* [in] */ LPCOLESTR szReserved,
            /* [in] */ LONGLONG llReserved,
            /* [in] */ LPVOID pvReserved,
            /* [in] */ DWORD cbReserved,
            /* [out] */ LPVOID *ppReserved) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetName( 
            /* [out][in] */ LPDWORD lpcwBuffer,
            /* [out] */ WCHAR *pwzName) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE GetVersion( 
            /* [out] */ LPDWORD pdwVersionHi,
            /* [out] */ LPDWORD pdwVersionLow) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE IsEqual( 
            /* [in] */ IAssemblyName *pName,
            /* [in] */ DWORD dwCmpFlags) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Clone( 
            /* [out] */ IAssemblyName **pName) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAssemblyNameVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IAssemblyName * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IAssemblyName * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IAssemblyName * This);
        
        HRESULT ( STDMETHODCALLTYPE *SetProperty )( 
            IAssemblyName * This,
            /* [in] */ DWORD PropertyId,
            /* [in] */ LPVOID pvProperty,
            /* [in] */ DWORD cbProperty);
        
        HRESULT ( STDMETHODCALLTYPE *GetProperty )( 
            IAssemblyName * This,
            /* [in] */ DWORD PropertyId,
            /* [out] */ LPVOID pvProperty,
            /* [out][in] */ LPDWORD pcbProperty);
        
        HRESULT ( STDMETHODCALLTYPE *Finalize )( 
            IAssemblyName * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetDisplayName )( 
            IAssemblyName * This,
            /* [out] */ LPOLESTR szDisplayName,
            /* [out][in] */ LPDWORD pccDisplayName,
            /* [in] */ DWORD dwDisplayFlags);
        
        HRESULT ( STDMETHODCALLTYPE *Reserved )( 
            IAssemblyName * This,
            /* [in] */ REFIID refIID,
            /* [in] */ IUnknown *pUnkReserved1,
            /* [in] */ IUnknown *pUnkReserved2,
            /* [in] */ LPCOLESTR szReserved,
            /* [in] */ LONGLONG llReserved,
            /* [in] */ LPVOID pvReserved,
            /* [in] */ DWORD cbReserved,
            /* [out] */ LPVOID *ppReserved);
        
        HRESULT ( STDMETHODCALLTYPE *GetName )( 
            IAssemblyName * This,
            /* [out][in] */ LPDWORD lpcwBuffer,
            /* [out] */ WCHAR *pwzName);
        
        HRESULT ( STDMETHODCALLTYPE *GetVersion )( 
            IAssemblyName * This,
            /* [out] */ LPDWORD pdwVersionHi,
            /* [out] */ LPDWORD pdwVersionLow);
        
        HRESULT ( STDMETHODCALLTYPE *IsEqual )( 
            IAssemblyName * This,
            /* [in] */ IAssemblyName *pName,
            /* [in] */ DWORD dwCmpFlags);
        
        HRESULT ( STDMETHODCALLTYPE *Clone )( 
            IAssemblyName * This,
            /* [out] */ IAssemblyName **pName);
        
        END_INTERFACE
    } IAssemblyNameVtbl;

    interface IAssemblyName
    {
        CONST_VTBL struct IAssemblyNameVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAssemblyName_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAssemblyName_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAssemblyName_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAssemblyName_SetProperty(This,PropertyId,pvProperty,cbProperty)	\
    (This)->lpVtbl -> SetProperty(This,PropertyId,pvProperty,cbProperty)

#define IAssemblyName_GetProperty(This,PropertyId,pvProperty,pcbProperty)	\
    (This)->lpVtbl -> GetProperty(This,PropertyId,pvProperty,pcbProperty)

#define IAssemblyName_Finalize(This)	\
    (This)->lpVtbl -> Finalize(This)

#define IAssemblyName_GetDisplayName(This,szDisplayName,pccDisplayName,dwDisplayFlags)	\
    (This)->lpVtbl -> GetDisplayName(This,szDisplayName,pccDisplayName,dwDisplayFlags)

#define IAssemblyName_Reserved(This,refIID,pUnkReserved1,pUnkReserved2,szReserved,llReserved,pvReserved,cbReserved,ppReserved)	\
    (This)->lpVtbl -> Reserved(This,refIID,pUnkReserved1,pUnkReserved2,szReserved,llReserved,pvReserved,cbReserved,ppReserved)

#define IAssemblyName_GetName(This,lpcwBuffer,pwzName)	\
    (This)->lpVtbl -> GetName(This,lpcwBuffer,pwzName)

#define IAssemblyName_GetVersion(This,pdwVersionHi,pdwVersionLow)	\
    (This)->lpVtbl -> GetVersion(This,pdwVersionHi,pdwVersionLow)

#define IAssemblyName_IsEqual(This,pName,dwCmpFlags)	\
    (This)->lpVtbl -> IsEqual(This,pName,dwCmpFlags)

#define IAssemblyName_Clone(This,pName)	\
    (This)->lpVtbl -> Clone(This,pName)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE IAssemblyName_SetProperty_Proxy( 
    IAssemblyName * This,
    /* [in] */ DWORD PropertyId,
    /* [in] */ LPVOID pvProperty,
    /* [in] */ DWORD cbProperty);


void __RPC_STUB IAssemblyName_SetProperty_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_GetProperty_Proxy( 
    IAssemblyName * This,
    /* [in] */ DWORD PropertyId,
    /* [out] */ LPVOID pvProperty,
    /* [out][in] */ LPDWORD pcbProperty);


void __RPC_STUB IAssemblyName_GetProperty_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_Finalize_Proxy( 
    IAssemblyName * This);


void __RPC_STUB IAssemblyName_Finalize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_GetDisplayName_Proxy( 
    IAssemblyName * This,
    /* [out] */ LPOLESTR szDisplayName,
    /* [out][in] */ LPDWORD pccDisplayName,
    /* [in] */ DWORD dwDisplayFlags);


void __RPC_STUB IAssemblyName_GetDisplayName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_Reserved_Proxy( 
    IAssemblyName * This,
    /* [in] */ REFIID refIID,
    /* [in] */ IUnknown *pUnkReserved1,
    /* [in] */ IUnknown *pUnkReserved2,
    /* [in] */ LPCOLESTR szReserved,
    /* [in] */ LONGLONG llReserved,
    /* [in] */ LPVOID pvReserved,
    /* [in] */ DWORD cbReserved,
    /* [out] */ LPVOID *ppReserved);


void __RPC_STUB IAssemblyName_Reserved_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_GetName_Proxy( 
    IAssemblyName * This,
    /* [out][in] */ LPDWORD lpcwBuffer,
    /* [out] */ WCHAR *pwzName);


void __RPC_STUB IAssemblyName_GetName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_GetVersion_Proxy( 
    IAssemblyName * This,
    /* [out] */ LPDWORD pdwVersionHi,
    /* [out] */ LPDWORD pdwVersionLow);


void __RPC_STUB IAssemblyName_GetVersion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_IsEqual_Proxy( 
    IAssemblyName * This,
    /* [in] */ IAssemblyName *pName,
    /* [in] */ DWORD dwCmpFlags);


void __RPC_STUB IAssemblyName_IsEqual_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyName_Clone_Proxy( 
    IAssemblyName * This,
    /* [out] */ IAssemblyName **pName);


void __RPC_STUB IAssemblyName_Clone_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAssemblyName_INTERFACE_DEFINED__ */


#ifndef __IAssemblyEnum_INTERFACE_DEFINED__
#define __IAssemblyEnum_INTERFACE_DEFINED__

/* interface IAssemblyEnum */
/* [unique][uuid][object][local] */ 


EXTERN_C const IID IID_IAssemblyEnum;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("21b8916c-f28e-11d2-a473-00c04f8ef448")
    IAssemblyEnum : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE GetNextAssembly( 
            /* [in] */ LPVOID pvReserved,
            /* [out] */ IAssemblyName **ppName,
            /* [in] */ DWORD dwFlags) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Reset( void) = 0;
        
        virtual HRESULT STDMETHODCALLTYPE Clone( 
            /* [out] */ IAssemblyEnum **ppEnum) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAssemblyEnumVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IAssemblyEnum * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IAssemblyEnum * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IAssemblyEnum * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetNextAssembly )( 
            IAssemblyEnum * This,
            /* [in] */ LPVOID pvReserved,
            /* [out] */ IAssemblyName **ppName,
            /* [in] */ DWORD dwFlags);
        
        HRESULT ( STDMETHODCALLTYPE *Reset )( 
            IAssemblyEnum * This);
        
        HRESULT ( STDMETHODCALLTYPE *Clone )( 
            IAssemblyEnum * This,
            /* [out] */ IAssemblyEnum **ppEnum);
        
        END_INTERFACE
    } IAssemblyEnumVtbl;

    interface IAssemblyEnum
    {
        CONST_VTBL struct IAssemblyEnumVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAssemblyEnum_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAssemblyEnum_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAssemblyEnum_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAssemblyEnum_GetNextAssembly(This,pvReserved,ppName,dwFlags)	\
    (This)->lpVtbl -> GetNextAssembly(This,pvReserved,ppName,dwFlags)

#define IAssemblyEnum_Reset(This)	\
    (This)->lpVtbl -> Reset(This)

#define IAssemblyEnum_Clone(This,ppEnum)	\
    (This)->lpVtbl -> Clone(This,ppEnum)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE IAssemblyEnum_GetNextAssembly_Proxy( 
    IAssemblyEnum * This,
    /* [in] */ LPVOID pvReserved,
    /* [out] */ IAssemblyName **ppName,
    /* [in] */ DWORD dwFlags);


void __RPC_STUB IAssemblyEnum_GetNextAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyEnum_Reset_Proxy( 
    IAssemblyEnum * This);


void __RPC_STUB IAssemblyEnum_Reset_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT STDMETHODCALLTYPE IAssemblyEnum_Clone_Proxy( 
    IAssemblyEnum * This,
    /* [out] */ IAssemblyEnum **ppEnum);


void __RPC_STUB IAssemblyEnum_Clone_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAssemblyEnum_INTERFACE_DEFINED__ */


#ifndef __IInstallReferenceItem_INTERFACE_DEFINED__
#define __IInstallReferenceItem_INTERFACE_DEFINED__

/* interface IInstallReferenceItem */
/* [unique][uuid][object][local] */ 


EXTERN_C const IID IID_IInstallReferenceItem;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("582dac66-e678-449f-aba6-6faaec8a9394")
    IInstallReferenceItem : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE GetReference( 
            /* [out] */ LPFUSION_INSTALL_REFERENCE *ppRefData,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPVOID pvReserved) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IInstallReferenceItemVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IInstallReferenceItem * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IInstallReferenceItem * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IInstallReferenceItem * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetReference )( 
            IInstallReferenceItem * This,
            /* [out] */ LPFUSION_INSTALL_REFERENCE *ppRefData,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPVOID pvReserved);
        
        END_INTERFACE
    } IInstallReferenceItemVtbl;

    interface IInstallReferenceItem
    {
        CONST_VTBL struct IInstallReferenceItemVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IInstallReferenceItem_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IInstallReferenceItem_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IInstallReferenceItem_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IInstallReferenceItem_GetReference(This,ppRefData,dwFlags,pvReserved)	\
    (This)->lpVtbl -> GetReference(This,ppRefData,dwFlags,pvReserved)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE IInstallReferenceItem_GetReference_Proxy( 
    IInstallReferenceItem * This,
    /* [out] */ LPFUSION_INSTALL_REFERENCE *ppRefData,
    /* [in] */ DWORD dwFlags,
    /* [in] */ LPVOID pvReserved);


void __RPC_STUB IInstallReferenceItem_GetReference_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IInstallReferenceItem_INTERFACE_DEFINED__ */


#ifndef __IInstallReferenceEnum_INTERFACE_DEFINED__
#define __IInstallReferenceEnum_INTERFACE_DEFINED__

/* interface IInstallReferenceEnum */
/* [unique][uuid][object][local] */ 


EXTERN_C const IID IID_IInstallReferenceEnum;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("56b1a988-7c0c-4aa2-8639-c3eb5a90226f")
    IInstallReferenceEnum : public IUnknown
    {
    public:
        virtual HRESULT STDMETHODCALLTYPE GetNextInstallReferenceItem( 
            /* [out] */ IInstallReferenceItem **ppRefItem,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPVOID pvReserved) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IInstallReferenceEnumVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IInstallReferenceEnum * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IInstallReferenceEnum * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IInstallReferenceEnum * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetNextInstallReferenceItem )( 
            IInstallReferenceEnum * This,
            /* [out] */ IInstallReferenceItem **ppRefItem,
            /* [in] */ DWORD dwFlags,
            /* [in] */ LPVOID pvReserved);
        
        END_INTERFACE
    } IInstallReferenceEnumVtbl;

    interface IInstallReferenceEnum
    {
        CONST_VTBL struct IInstallReferenceEnumVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IInstallReferenceEnum_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IInstallReferenceEnum_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IInstallReferenceEnum_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IInstallReferenceEnum_GetNextInstallReferenceItem(This,ppRefItem,dwFlags,pvReserved)	\
    (This)->lpVtbl -> GetNextInstallReferenceItem(This,ppRefItem,dwFlags,pvReserved)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT STDMETHODCALLTYPE IInstallReferenceEnum_GetNextInstallReferenceItem_Proxy( 
    IInstallReferenceEnum * This,
    /* [out] */ IInstallReferenceItem **ppRefItem,
    /* [in] */ DWORD dwFlags,
    /* [in] */ LPVOID pvReserved);


void __RPC_STUB IInstallReferenceEnum_GetNextInstallReferenceItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IInstallReferenceEnum_INTERFACE_DEFINED__ */


/* interface __MIDL_itf_fusion_0098 */
/* [local] */ 

typedef 
enum _tagAssemblyComparisonResult
    {	ACR_Unknown	= 0,
	ACR_EquivalentFullMatch	= ACR_Unknown + 1,
	ACR_EquivalentWeakNamed	= ACR_EquivalentFullMatch + 1,
	ACR_EquivalentFXUnified	= ACR_EquivalentWeakNamed + 1,
	ACR_EquivalentUnified	= ACR_EquivalentFXUnified + 1,
	ACR_NonEquivalentVersion	= ACR_EquivalentUnified + 1,
	ACR_NonEquivalent	= ACR_NonEquivalentVersion + 1,
	ACR_EquivalentPartialMatch	= ACR_NonEquivalent + 1,
	ACR_EquivalentPartialWeakNamed	= ACR_EquivalentPartialMatch + 1,
	ACR_EquivalentPartialUnified	= ACR_EquivalentPartialWeakNamed + 1,
	ACR_EquivalentPartialFXUnified	= ACR_EquivalentPartialUnified + 1,
	ACR_NonEquivalentPartialVersion	= ACR_EquivalentPartialFXUnified + 1
    } 	AssemblyComparisonResult;

STDAPI CompareAssemblyIdentity(LPCWSTR pwzAssemblyIdentity1, BOOL fUnified1, LPCWSTR pwzAssemblyIdentity2, BOOL fUnified2, BOOL *pfEquivalent, AssemblyComparisonResult *pResult); 
STDAPI CreateInstallReferenceEnum(IInstallReferenceEnum **ppRefEnum, IAssemblyName *pName, DWORD dwFlags, LPVOID pvReserved);      
STDAPI CreateAssemblyEnum(IAssemblyEnum **pEnum, IUnknown *pUnkReserved, IAssemblyName *pName, DWORD dwFlags, LPVOID pvReserved);      
STDAPI CreateAssemblyNameObject(LPASSEMBLYNAME *ppAssemblyNameObj, LPCWSTR szAssemblyName, DWORD dwFlags, LPVOID pvReserved);             
STDAPI CreateAssemblyCache(IAssemblyCache **ppAsmCache, DWORD dwReserved); 
STDAPI GetCachePath(ASM_CACHE_FLAGS dwCacheFlags, LPWSTR pwzCachePath, PDWORD pcchPath); 
STDAPI GetAssemblyIdentityFromFile(LPCWSTR pwzFilePAth, REFIID riid, IUnknown **ppIdentity); 
STDAPI ClearDownloadCache();


extern RPC_IF_HANDLE __MIDL_itf_fusion_0098_v0_0_c_ifspec;
extern RPC_IF_HANDLE __MIDL_itf_fusion_0098_v0_0_s_ifspec;

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


