*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZABAP_EGTM_T_03.................................*
DATA:  BEGIN OF STATUS_ZABAP_EGTM_T_03               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZABAP_EGTM_T_03               .
CONTROLS: TCTRL_ZABAP_EGTM_T_03
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZABAP_EGTM_T_03               .
TABLES: ZABAP_EGTM_T_03                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
