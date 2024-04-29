*&---------------------------------------------------------------------*
*& Report ZABAP_EGITIM_34
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_egitim_34.


DATA : BEGIN OF gt_excel OCCURS 0 ,
         carrid   TYPE  s_carr_id,
         carrname TYPE  s_carrname,
         currcode TYPE  s_currcode,
         url      TYPE  s_carrurl,
       END OF gt_excel .
PARAMETERS : p_path LIKE rlgrap-filename OBLIGATORY .

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_path .
  PERFORM get_file_path .

START-OF-SELECTION .
  PERFORM upload_file .
*&---------------------------------------------------------------------*
*& Form GET_FILE_PATH
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM get_file_path .
  DATA : lt_path  TYPE filetable,
         lv_subrc TYPE sy-subrc.
  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title            = 'Dosyayı seçiniz'
      default_filename        = '*XLS'
      multiselection          = ' '
    CHANGING
      file_table              = lt_path
      rc                      = lv_subrc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.
  READ TABLE lt_path INTO p_path INDEX 1 .
ENDFORM .
*&---------------------------------------------------------------------*
*& Form UPLOAD_FILE
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM upload_file .
  DATA : lt_raw TYPE truxs_t_text_data .
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
      i_field_seperator    = 'X'
*     I_LINE_HEADER        =
      i_tab_raw_data       = lt_raw
      i_filename           = p_path
    TABLES
      i_tab_converted_data = gt_excel[]
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc NE 0 .
    MESSAGE 'Excel yüklenemedi! Dosya açık olabilir!' TYPE 'E' .
  ENDIF .
  LOOP AT gt_excel .
    WRITE : / , gt_excel-carrid , gt_excel-carrname , gt_excel-currcode , gt_excel-url .
  ENDLOOP .
ENDFORM .
