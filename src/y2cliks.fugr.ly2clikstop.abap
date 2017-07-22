FUNCTION-POOL y2cliks.                      "MESSAGE-ID ..

* INCLUDE LY2CLIKSD...                       " Local class definition

CONSTANTS: c_cookie_id TYPE string VALUE '2-Cliks'.

TYPES: BEGIN OF wi_buffer_type,
        wi_id	        TYPE sww_wiid,
        wi_aagent	    TYPE sww_aagent,
        wi_stat	      TYPE sww_wistat,
        email	        TYPE ad_smtpadr,
        creation_date	TYPE datum,
        creation_time	TYPE uzeit,
      END OF wi_buffer_type.
