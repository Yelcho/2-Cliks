FUNCTION y2c_user_get_detail.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(USERNAME) TYPE  BAPIBNAME-BAPIBNAME
*"     VALUE(CACHE_RESULTS) TYPE  FLAG_X DEFAULT 'X'
*"  EXPORTING
*"     VALUE(LOGONDATA) TYPE  BAPILOGOND
*"     VALUE(DEFAULTS) TYPE  BAPIDEFAUL
*"     VALUE(ADDRESS) TYPE  BAPIADDR3
*"     VALUE(COMPANY) TYPE  BAPIUSCOMP
*"     VALUE(SNC) TYPE  BAPISNCU
*"     VALUE(REF_USER) TYPE  BAPIREFUS
*"     VALUE(ALIAS) TYPE  BAPIALIAS
*"     VALUE(UCLASS) TYPE  BAPIUCLASS
*"     VALUE(LASTMODIFIED) TYPE  BAPIMODDAT
*"     VALUE(ISLOCKED) TYPE  BAPISLOCKD
*"  TABLES
*"      PARAMETER STRUCTURE  BAPIPARAM OPTIONAL
*"      PROFILES STRUCTURE  BAPIPROF OPTIONAL
*"      ACTIVITYGROUPS STRUCTURE  BAPIAGR OPTIONAL
*"      RETURN STRUCTURE  BAPIRET2 OPTIONAL
*"      ADDTEL STRUCTURE  BAPIADTEL OPTIONAL
*"      ADDFAX STRUCTURE  BAPIADFAX OPTIONAL
*"      ADDTTX STRUCTURE  BAPIADTTX OPTIONAL
*"      ADDTLX STRUCTURE  BAPIADTLX OPTIONAL
*"      ADDSMTP STRUCTURE  BAPIADSMTP OPTIONAL
*"      ADDRML STRUCTURE  BAPIADRML OPTIONAL
*"      ADDX400 STRUCTURE  BAPIADX400 OPTIONAL
*"      ADDRFC STRUCTURE  BAPIADRFC OPTIONAL
*"      ADDPRT STRUCTURE  BAPIADPRT OPTIONAL
*"      ADDSSF STRUCTURE  BAPIADSSF OPTIONAL
*"      ADDURI STRUCTURE  BAPIADURI OPTIONAL
*"      ADDPAG STRUCTURE  BAPIADPAG OPTIONAL
*"      ADDCOMREM STRUCTURE  BAPICOMREM OPTIONAL
*"      PARAMETER1 STRUCTURE  BAPIPARAM1 OPTIONAL
*"      GROUPS STRUCTURE  BAPIGROUPS OPTIONAL
*"      UCLASSSYS STRUCTURE  BAPIUCLASSSYS OPTIONAL
*"      EXTIDHEAD STRUCTURE  BAPIUSEXTIDHEAD OPTIONAL
*"      EXTIDPART STRUCTURE  BAPIUSEXTIDPART OPTIONAL
*"      SYSTEMS STRUCTURE  BAPIRCVSYS OPTIONAL
*"--------------------------------------------------------------------

  CALL FUNCTION 'BAPI_USER_GET_DETAIL'
    EXPORTING
      username  = username
      "cache_results  = cache_results
    IMPORTING
      logondata = logondata
      defaults  = defaults
      address   = address
      company   = company
      "snc            = snc
      "ref_user       = ref_user
      "alias          = alias
      "uclass         = uclass
      "lastmodified   = lastmodified
      islocked  = islocked
    TABLES      "parameter      = parameter
      "profiles       = profiles
      "activitygroups = activitygroups
      return    = return
      "addtel         = addtel
      "addfax         = addfax
      "addttx         = addttx
      "addtlx         = addtlx
      addsmtp   = addsmtp
      "addrml         = addrml
      "addx400        = addx400
      "addrfc         = addrfc
      "addprt         = addprt
      "addssf         = addssf
      "adduri         = adduri
      "addpag         = addpag
      "addcomrem      = addcomrem
      "parameter1     = parameter1
      "groups         = groups
      "uclasssys      = uclasssys
      "extidhead      = extidhead
      "extidpart      = extidpart
    .      "systems        = systems

ENDFUNCTION.
