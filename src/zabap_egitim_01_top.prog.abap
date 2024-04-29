*&---------------------------------------------------------------------*
*& Include          ZABAP_EGITIM_01_TOP
*&---------------------------------------------------------------------*

TABLES scarr.

TYPES: BEGIN OF gty_table,
         box TYPE char1.
         INCLUDE STRUCTURE scarr.
TYPES: END OF gty_table.

DATA: gt_scarr    TYPE TABLE OF gty_table,
      gs_scarr    TYPE gty_table,
      gs_layout   TYPE slis_layout_alv,
      gt_fieldcat TYPE slis_t_fieldcat_alv.
