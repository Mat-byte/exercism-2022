CLASS zcl_matrix_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    METHODS matrix_row
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS matrix_column
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA gt_table TYPE TABLE OF string.

    METHODS split_string
      IMPORTING
        string        TYPE string
        index         TYPE i.


ENDCLASS.

CLASS zcl_matrix_matbyte IMPLEMENTATION.

  METHOD matrix_row.

    me->split_string( index = index string = string ).

    READ TABLE me->gt_table INTO DATA(ls_data)
      INDEX index.

    SPLIT ls_data AT space INTO TABLE DATA(lt_split).

    LOOP AT lt_split INTO DATA(ls_split).

      APPEND CONV i( ls_split ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD matrix_column.

    me->split_string( index = index string = string ).

    LOOP AT me->gt_table INTO DATA(ls_data) FROM 1 TO lines( me->gt_table ).

      SPLIT ls_data AT space INTO TABLE DATA(lt_split).

      READ TABLE lt_split INTO DATA(ls_split)
        INDEX index.

      APPEND CONV i( ls_split ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD split_string.

    SPLIT string AT '\n' INTO TABLE me->gt_table.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA(oe) = me->matrix_column(
        string = '1 2 3\n4 5 6\n7 8 9'
        index  = 3 ).

    LOOP AT oe INTO DATA(ls_table).

     out->write( ls_table ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
