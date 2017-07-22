FUNCTION y2c_changedoc_read_headers .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(ARCHIVE_HANDLE) TYPE  SY-TABIX DEFAULT 0
*"     VALUE(DATE_OF_CHANGE) TYPE  CDHDR-UDATE DEFAULT '00000000'
*"     VALUE(OBJECTCLASS) TYPE  CDHDR-OBJECTCLAS
*"     VALUE(OBJECTID) TYPE  CDHDR-OBJECTID DEFAULT SPACE
*"     VALUE(TIME_OF_CHANGE) TYPE  CDHDR-UTIME DEFAULT '000000'
*"     VALUE(USERNAME) TYPE  CDHDR-USERNAME DEFAULT SY-UNAME
*"     VALUE(LOCAL_TIME) TYPE  CHAR200 DEFAULT SPACE
*"     VALUE(DATE_UNTIL) TYPE  CDHDR-UDATE DEFAULT '99991231'
*"     VALUE(TIME_UNTIL) TYPE  CDHDR-UTIME DEFAULT '235959'
*"     VALUE(NOPLUS_ASWILDCARD_INOBJID) TYPE  CHAR200 DEFAULT SPACE
*"     VALUE(READ_CHANGEDOCU) TYPE  CHAR200 DEFAULT SPACE
*"  TABLES
*"      I_CDHDR STRUCTURE  CDHDR
*"--------------------------------------------------------------------

  CALL FUNCTION 'CHANGEDOCUMENT_READ_HEADERS'
    EXPORTING
      archive_handle             = archive_handle
      date_of_change             = date_of_change
      objectclass                = objectclass
      objectid                   = objectid
      time_of_change             = time_of_change
      username                   = username
      local_time                 = local_time
      date_until                 = date_until
      time_until                 = time_until
      noplus_aswildcard_inobjid  = noplus_aswildcard_inobjid
      read_changedocu            = read_changedocu
    TABLES
      i_cdhdr                    = i_cdhdr
    EXCEPTIONS
      no_position_found          = 1
      wrong_access_to_archive    = 2
      time_zone_conversion_error = 3
      OTHERS                     = 4.

ENDFUNCTION.
