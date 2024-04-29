*&---------------------------------------------------------------------*
*& Report ZABAP_EGITIM_38
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_EGITIM_38.

PARAMETERS: gv_num1 TYPE i,
gv_num2 type i.

START-OF-SELECTION.

ENHANCEMENT-POINT ZENHACMENT_38 SPOTS ZES_38 .

ENHANCEMENT-SECTION ZENHANCMENT_SECTION_38 SPOTS ZES_38 .
gv_rest = gv_num1 / gv_num2.
write: / 'Result div', gv_rest.
END-ENHANCEMENT-SECTION.

gv_rest = gv_num1 + gv_num2.
write: / 'Result plus', gv_rest.
