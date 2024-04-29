*&---------------------------------------------------------------------*
*& Include          ZABAP_EGITIM_01_FORM
*&---------------------------------------------------------------------*
PERFORM layout.

CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
  EXPORTING
    i_structure_name       = 'SCARR'
  CHANGING
    ct_fieldcat            = gt_fieldcat
  EXCEPTIONS
    inconsistent_interface = 1
    program_error          = 2
    OTHERS                 = 3.
IF sy-subrc <> 0.
  LEAVE PROGRAM.
ENDIF.



CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program = sy-repid
    is_layout          = gs_layout
    it_fieldcat        = gt_fieldcat
  TABLES
    t_outtab           = gt_scarr
  EXCEPTIONS
    program_error      = 1
    OTHERS             = 2.
IF sy-subrc <> 0.
  LEAVE PROGRAM.
ENDIF.
*&---------------------------------------------------------------------*
*& Form layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM layout .

  gs_layout-zebra = 'X'.
  gs_layout-colwidth_optimize = 'X'.
  gs_layout-box_fieldname = 'BOX'.


ENDFORM.
