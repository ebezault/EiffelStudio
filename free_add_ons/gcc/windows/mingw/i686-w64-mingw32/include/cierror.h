/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _CIERROR_H_
#define _CIERROR_H_
#ifndef FACILITY_WINDOWS

#define FACILITY_WINDOWS 0x8
#define FACILITY_NULL 0x0
#define FACILITY_ITF 0x4

#define STATUS_SEVERITY_SUCCESS 0x0
#define STATUS_SEVERITY_COFAIL 0x3
#define STATUS_SEVERITY_COERROR 0x2

#define NOT_AN_ERROR1 ((HRESULT)0x00081600L)
#endif

#define QUERY_E_FAILED ((HRESULT)0x80041600L)
#define QUERY_E_INVALIDQUERY ((HRESULT)0x80041601L)
#define QUERY_E_INVALIDRESTRICTION ((HRESULT)0x80041602L)
#define QUERY_E_INVALIDSORT ((HRESULT)0x80041603L)
#define QUERY_E_INVALIDCATEGORIZE ((HRESULT)0x80041604L)
#define QUERY_E_ALLNOISE ((HRESULT)0x80041605L)
#define QUERY_E_TOOCOMPLEX ((HRESULT)0x80041606L)
#define QUERY_E_TIMEDOUT ((HRESULT)0x80041607L)
#define QUERY_E_DUPLICATE_OUTPUT_COLUMN ((HRESULT)0x80041608L)
#define QUERY_E_INVALID_OUTPUT_COLUMN ((HRESULT)0x80041609L)
#define QUERY_E_INVALID_DIRECTORY ((HRESULT)0x8004160AL)
#define QUERY_E_DIR_ON_REMOVABLE_DRIVE ((HRESULT)0x8004160BL)
#define QUERY_S_NO_QUERY ((HRESULT)0x8004160CL)
#define QPLIST_E_CANT_OPEN_FILE ((HRESULT)0x80041651L)
#define QPLIST_E_READ_ERROR ((HRESULT)0x80041652L)
#define QPLIST_E_EXPECTING_NAME ((HRESULT)0x80041653L)
#define QPLIST_E_EXPECTING_TYPE ((HRESULT)0x80041654L)
#define QPLIST_E_UNRECOGNIZED_TYPE ((HRESULT)0x80041655L)
#define QPLIST_E_EXPECTING_INTEGER ((HRESULT)0x80041656L)
#define QPLIST_E_EXPECTING_CLOSE_PAREN ((HRESULT)0x80041657L)
#define QPLIST_E_EXPECTING_GUID ((HRESULT)0x80041658L)
#define QPLIST_E_BAD_GUID ((HRESULT)0x80041659L)
#define QPLIST_E_EXPECTING_PROP_SPEC ((HRESULT)0x8004165AL)
#define QPLIST_E_CANT_SET_PROPERTY ((HRESULT)0x8004165BL)
#define QPLIST_E_DUPLICATE ((HRESULT)0x8004165CL)
#define QPLIST_E_VECTORBYREF_USED_ALONE ((HRESULT)0x8004165DL)
#define QPLIST_E_BYREF_USED_WITHOUT_PTRTYPE ((HRESULT)0x8004165EL)
#define QPARSE_E_UNEXPECTED_NOT ((HRESULT)0x80041660L)
#define QPARSE_E_EXPECTING_INTEGER ((HRESULT)0x80041661L)
#define QPARSE_E_EXPECTING_REAL ((HRESULT)0x80041662L)
#define QPARSE_E_EXPECTING_DATE ((HRESULT)0x80041663L)
#define QPARSE_E_EXPECTING_CURRENCY ((HRESULT)0x80041664L)
#define QPARSE_E_EXPECTING_GUID ((HRESULT)0x80041665L)
#define QPARSE_E_EXPECTING_BRACE ((HRESULT)0x80041666L)
#define QPARSE_E_EXPECTING_PAREN ((HRESULT)0x80041667L)
#define QPARSE_E_EXPECTING_PROPERTY ((HRESULT)0x80041668L)
#define QPARSE_E_NOT_YET_IMPLEMENTED ((HRESULT)0x80041669L)
#define QPARSE_E_EXPECTING_PHRASE ((HRESULT)0x8004166AL)
#define QPARSE_E_UNSUPPORTED_PROPERTY_TYPE ((HRESULT)0x8004166BL)
#define QPARSE_E_EXPECTING_REGEX ((HRESULT)0x8004166CL)
#define QPARSE_E_EXPECTING_REGEX_PROPERTY ((HRESULT)0x8004166DL)
#define QPARSE_E_INVALID_LITERAL ((HRESULT)0x8004166EL)
#define QPARSE_E_NO_SUCH_PROPERTY ((HRESULT)0x8004166FL)
#define QPARSE_E_EXPECTING_EOS ((HRESULT)0x80041670L)
#define QPARSE_E_EXPECTING_COMMA ((HRESULT)0x80041671L)
#define QPARSE_E_UNEXPECTED_EOS ((HRESULT)0x80041672L)
#define QPARSE_E_WEIGHT_OUT_OF_RANGE ((HRESULT)0x80041673L)
#define QPARSE_E_NO_SUCH_SORT_PROPERTY ((HRESULT)0x80041674L)
#define QPARSE_E_INVALID_SORT_ORDER ((HRESULT)0x80041675L)
#define QUTIL_E_CANT_CONVERT_VROOT ((HRESULT)0x80041676L)
#define QPARSE_E_INVALID_GROUPING ((HRESULT)0x80041677L)
#define QUTIL_E_INVALID_CODEPAGE ((HRESULT)0xC0041678L)
#define QPLIST_S_DUPLICATE ((HRESULT)0x00041679L)
#define QPARSE_E_INVALID_QUERY ((HRESULT)0x8004167AL)
#define QPARSE_E_INVALID_RANKMETHOD ((HRESULT)0x8004167BL)
#define FDAEMON_W_WORDLISTFULL ((HRESULT)0x00041680L)
#define FDAEMON_E_LOWRESOURCE ((HRESULT)0x80041681L)
#define FDAEMON_E_FATALERROR ((HRESULT)0x80041682L)
#define FDAEMON_E_PARTITIONDELETED ((HRESULT)0x80041683L)
#define FDAEMON_E_CHANGEUPDATEFAILED ((HRESULT)0x80041684L)
#define FDAEMON_W_EMPTYWORDLIST ((HRESULT)0x00041685L)
#define FDAEMON_E_WORDLISTCOMMITFAILED ((HRESULT)0x80041686L)
#define FDAEMON_E_NOWORDLIST ((HRESULT)0x80041687L)
#define FDAEMON_E_TOOMANYFILTEREDBLOCKS ((HRESULT)0x80041688L)
#define SEARCH_S_NOMOREHITS ((HRESULT)0x000416A0L)
#define SEARCH_E_NOMONIKER ((HRESULT)0x800416A1L)
#define SEARCH_E_NOREGION ((HRESULT)0x800416A2L)
#define FILTER_E_TOO_BIG ((HRESULT)0x80041730L)
#define FILTER_S_PARTIAL_CONTENTSCAN_IMMEDIATE ((HRESULT)0x00041731L)
#define FILTER_S_FULL_CONTENTSCAN_IMMEDIATE ((HRESULT)0x00041732L)
#define FILTER_S_CONTENTSCAN_DELAYED ((HRESULT)0x00041733L)
#define FILTER_E_CONTENTINDEXCORRUPT ((HRESULT)0xC0041734L)
#define FILTER_S_DISK_FULL ((HRESULT)0x00041735L)
#define FILTER_E_ALREADY_OPEN ((HRESULT)0x80041736L)
#define FILTER_E_UNREACHABLE ((HRESULT)0x80041737L)
#define FILTER_E_IN_USE ((HRESULT)0x80041738L)
#define FILTER_E_NOT_OPEN ((HRESULT)0x80041739L)
#define FILTER_S_NO_PROPSETS ((HRESULT)0x0004173AL)
#define FILTER_E_NO_SUCH_PROPERTY ((HRESULT)0x8004173BL)
#define FILTER_S_NO_SECURITY_DESCRIPTOR ((HRESULT)0x0004173CL)
#define FILTER_E_OFFLINE ((HRESULT)0x8004173DL)
#define FILTER_E_PARTIALLY_FILTERED ((HRESULT)0x8004173EL)
#define WBREAK_E_END_OF_TEXT ((HRESULT)0x80041780L)
#define LANGUAGE_S_LARGE_WORD ((HRESULT)0x00041781L)
#define WBREAK_E_QUERY_ONLY ((HRESULT)0x80041782L)
#define WBREAK_E_BUFFER_TOO_SMALL ((HRESULT)0x80041783L)
#define LANGUAGE_E_DATABASE_NOT_FOUND ((HRESULT)0x80041784L)
#define WBREAK_E_INIT_FAILED ((HRESULT)0x80041785L)
#define PSINK_E_QUERY_ONLY ((HRESULT)0x80041790L)
#define PSINK_E_INDEX_ONLY ((HRESULT)0x80041791L)
#define PSINK_E_LARGE_ATTACHMENT ((HRESULT)0x80041792L)
#define PSINK_S_LARGE_WORD ((HRESULT)0x00041793L)
#define CI_CORRUPT_DATABASE ((HRESULT)0xC0041800L)
#define CI_CORRUPT_CATALOG ((HRESULT)0xC0041801L)
#define CI_INVALID_PARTITION ((HRESULT)0xC0041802L)
#define CI_INVALID_PRIORITY ((HRESULT)0xC0041803L)
#define CI_NO_STARTING_KEY ((HRESULT)0xC0041804L)
#define CI_OUT_OF_INDEX_IDS ((HRESULT)0xC0041805L)
#define CI_NO_CATALOG ((HRESULT)0xC0041806L)
#define CI_CORRUPT_FILTER_BUFFER ((HRESULT)0xC0041807L)
#define CI_INVALID_INDEX ((HRESULT)0xC0041808L)
#define CI_PROPSTORE_INCONSISTENCY ((HRESULT)0xC0041809L)
#define CI_E_ALREADY_INITIALIZED ((HRESULT)0x8004180AL)
#define CI_E_NOT_INITIALIZED ((HRESULT)0x8004180BL)
#define CI_E_BUFFERTOOSMALL ((HRESULT)0x8004180CL)
#define CI_E_PROPERTY_NOT_CACHED ((HRESULT)0x8004180DL)
#define CI_S_WORKID_DELETED ((HRESULT)0x0004180EL)
#define CI_E_INVALID_STATE ((HRESULT)0x8004180FL)
#define CI_E_FILTERING_DISABLED ((HRESULT)0x80041810L)
#define CI_E_DISK_FULL ((HRESULT)0x80041811L)
#define CI_E_SHUTDOWN ((HRESULT)0x80041812L)
#define CI_E_WORKID_NOTVALID ((HRESULT)0x80041813L)
#define CI_S_END_OF_ENUMERATION ((HRESULT)0x00041814L)
#define CI_E_NOT_FOUND ((HRESULT)0x80041815L)
#define CI_E_USE_DEFAULT_PID ((HRESULT)0x80041816L)
#define CI_E_DUPLICATE_NOTIFICATION ((HRESULT)0x80041817L)
#define CI_E_UPDATES_DISABLED ((HRESULT)0x80041818L)
#define CI_E_INVALID_FLAGS_COMBINATION ((HRESULT)0x80041819L)
#define CI_E_OUTOFSEQ_INCREMENT_DATA ((HRESULT)0x8004181AL)
#define CI_E_SHARING_VIOLATION ((HRESULT)0x8004181BL)
#define CI_E_LOGON_FAILURE ((HRESULT)0x8004181CL)
#define CI_E_NO_CATALOG ((HRESULT)0x8004181DL)
#define CI_E_STRANGE_PAGEORSECTOR_SIZE ((HRESULT)0x8004181EL)
#define CI_E_TIMEOUT ((HRESULT)0x8004181FL)
#define CI_E_NOT_RUNNING ((HRESULT)0x80041820L)
#define CI_INCORRECT_VERSION ((HRESULT)0xC0041821L)
#define CI_E_ENUMERATION_STARTED ((HRESULT)0xC0041822L)
#define CI_E_PROPERTY_TOOLARGE ((HRESULT)0xC0041823L)
#define CI_E_CLIENT_FILTER_ABORT ((HRESULT)0xC0041824L)
#define CI_S_NO_DOCSTORE ((HRESULT)0x00041825L)
#define CI_S_CAT_STOPPED ((HRESULT)0x00041826L)
#define CI_E_CARDINALITY_MISMATCH ((HRESULT)0x80041827L)
#define CI_E_CONFIG_DISK_FULL ((HRESULT)0x80041828L)

#endif
