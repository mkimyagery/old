*&---------------------------------------------------------------------*
*& Report ZABAP_EGITIM_36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_EGITIM_36.


TYPES: BEGIN OF gty_structure,
         manager_id      TYPE c LENGTH 6,
         calisan_isim    TYPE c LENGTH 30,
         calisan_soyisim TYPE c LENGTH 30,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE  SORTED TABLE  OF gty_structure WITH UNIQUE KEY manager_id.


START-OF-SELECTION.

  gs_structure-manager_id      = '100004'.
  gs_structure-calisan_isim    = 'Mehmet'.
  gs_structure-calisan_soyisim = 'Yilmat'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-manager_id      = '100002'.
  gs_structure-calisan_isim    = 'Ali'.
  gs_structure-calisan_soyisim = 'Cengiz'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-manager_id      = '100005'.
  gs_structure-calisan_isim    = 'Veli'.
  gs_structure-calisan_soyisim = 'Yilmaz'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.


  gs_structure-manager_id      = '100003'.
  gs_structure-calisan_isim    = 'Mustafa'.
  gs_structure-calisan_soyisim = 'Aydin'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.


  gs_structure-manager_id      = '100002'.
  gs_structure-calisan_isim    = 'Cemil'.
  gs_structure-calisan_soyisim = 'Cengiz'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-manager_id      = '100004'.
  gs_structure-calisan_isim    = 'Arslan'.
  gs_structure-calisan_soyisim = 'kazim'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-manager_id      = '100001'.
  gs_structure-calisan_isim    = 'Ahmet'.
  gs_structure-calisan_soyisim = 'Yilmaz'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.
