*&---------------------------------------------------------------------*
*& Include          ZABAP_EGITIM_MY_38_FORM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  CLEAR gt_pers[].
  SELECT * FROM zabap_egtm_t_02 INTO CORRESPONDING FIELDS OF table gt_pers
                                WHERE silindi NE 'X'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fcat .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_layout .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_display
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_display .

ENDFORM.
