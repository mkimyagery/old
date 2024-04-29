*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZABAP_EGTM_T_02.................................*
DATA:  BEGIN OF STATUS_ZABAP_EGTM_T_02               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZABAP_EGTM_T_02               .
CONTROLS: TCTRL_ZABAP_EGTM_T_02
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZABAP_EGTM_T_02               .
TABLES: ZABAP_EGTM_T_02                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
