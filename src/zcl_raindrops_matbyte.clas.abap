CLASS zcl_raindrops_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS raindrops
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE string.


ENDCLASS.


CLASS zcl_raindrops_matbyte IMPLEMENTATION.

  METHOD raindrops.

    IF input MOD 3 = 0.
      result = |{ result }Pling|.
    ENDIF.

    IF input MOD 5 = 0.
      result = |{ result }Plang|.
    ENDIF.

    IF input MOD 7 = 0.
      result = |{ result }Plong|.
    ENDIF.

    IF result IS INITIAL.
      result = |{ input }|.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
