*&---------------------------------------------------------------------*
*& Report ZABAP_EGITIM_32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_EGITIM_32.



SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_file   TYPE rlgrap-filename OBLIGATORY,
              p_table  TYPE tabname OBLIGATORY,
              p_header AS CHECKBOX,
              p_mandt  AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK a1.

TYPES: BEGIN OF gty_table,
         row TYPE n LENGTH 4,
       END OF gty_table.

DATA: gv_file_name           TYPE dbmsgora-filename,
      gv_file_type           TYPE sdbad-funct,
      gt_excel_itab_pre_conv TYPE STANDARD TABLE OF alsmex_tabline,
      gt_row                 TYPE TABLE OF gty_table,
      gt_fcat                TYPE lvc_t_fcat,
      gs_layout              TYPE lvc_s_layo,
      gr_data                TYPE REF TO data.

FIELD-SYMBOLS: <fs_table> TYPE STANDARD TABLE.

"Kullanicidan dosya adi al.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'
    IMPORTING
      file_name = p_file.

START-OF-SELECTION.

  "Girilen dosyanin uzantisini bul.
  gv_file_name = p_file.

  CALL FUNCTION 'SPLIT_FILENAME'
    EXPORTING
      long_filename  = gv_file_name
    IMPORTING
      pure_extension = gv_file_type.

  TRANSLATE gv_file_type TO UPPER CASE.

  "XLS ya da XLSX olup olmadigini kontrol et.
  CHECK gv_file_type = 'XLS'  OR gv_file_type = 'XLSX' .

  "Excelden veriyi oku.
  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename                = p_file
      i_begin_col             = 1
      i_begin_row             = 1
      i_end_col               = COND #( WHEN gv_file_type = 'XLS'  THEN 256
                                        WHEN gv_file_type = 'XLSX' THEN 16834 )
      i_end_row               = COND #( WHEN gv_file_type = 'XLS'  THEN 65536
                                        WHEN gv_file_type = 'XLSX' THEN 1048576 )
    TABLES
      intern                  = gt_excel_itab_pre_conv
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

  "Excel dosyasinda kolon basliklari varsa bu hücreleri sil.
  IF p_header = abap_true.
    DELETE gt_excel_itab_pre_conv WHERE row = 1.

    LOOP AT gt_excel_itab_pre_conv ASSIGNING FIELD-SYMBOL(<gs_line>).
      <gs_line>-row = <gs_line>-row - 1.
    ENDLOOP.
  ENDIF.

  "Excel dosyasinda mandt yoksa manuel olarak ekle.
  IF p_mandt IS INITIAL.
    LOOP AT gt_excel_itab_pre_conv ASSIGNING FIELD-SYMBOL(<fs_line>).
      <fs_line>-col = <fs_line>-col + 1.
    ENDLOOP.

    gt_row = VALUE #( FOR gs_line IN gt_excel_itab_pre_conv ( row = gs_line-row ) ).
    SORT gt_row.
    DELETE ADJACENT DUPLICATES FROM gt_row.

    LOOP AT gt_row INTO DATA(gs_row).
      APPEND INITIAL LINE TO gt_excel_itab_pre_conv ASSIGNING <fs_line>.
      <fs_line>-row   = gs_row-row.
      <fs_line>-col   = '0001'.
      <fs_line>-value = sy-mandt.
    ENDLOOP.
    SORT gt_excel_itab_pre_conv BY row col.
  ENDIF.

  "Girilen tablo tipinde bir data referansi olustur.
  CREATE DATA gr_data TYPE STANDARD TABLE OF (p_table).

  "Bu data referansinin icindeki tabloyu field sembole assign et.
  ASSIGN gr_data->* TO <fs_table>.

  "Excel dosyasindan gelen veriyi kullanarak tabloyu doldur.
  LOOP AT gt_excel_itab_pre_conv ASSIGNING <gs_line> GROUP BY ( row = <gs_line>-row )
                                                     INTO DATA(gt_group).

    APPEND INITIAL LINE TO <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).

    LOOP AT GROUP gt_group INTO DATA(gs_group).
      ASSIGN COMPONENT gs_group-col OF STRUCTURE <fs_str> TO  FIELD-SYMBOL(<fs_hucre>).
      IF sy-subrc IS INITIAL.
        <fs_hucre> = gs_group-value.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  "Field Catalog hazirla.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = p_table
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  LOOP AT gt_fcat ASSIGNING FIELD-SYMBOL(<fs_fcat>).
    IF <fs_fcat>-fieldname NE 'MANDT'.
      <fs_fcat>-edit = abap_true.
    ENDIF.
  ENDLOOP.

  "Layout hazirla.
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  "ALV'yi ekranda göster.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fcat
    TABLES
      t_outtab           = <fs_table>
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
