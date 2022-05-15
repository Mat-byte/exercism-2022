CLASS zcl_hamming_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_hamming_matbyte IMPLEMENTATION.

  METHOD hamming_distance.

    DATA lv_indx TYPE i.

    IF strlen( first_strand ) = 0 AND strlen( second_strand ) = 0.

     result = 0.

     RETURN.

    ELSEIF strlen( first_strand ) <> strlen( second_strand ).

      RAISE EXCEPTION TYPE cx_parameter_invalid.

    ENDIF.


    DO strlen( first_strand ) TIMES.

      IF first_strand+lv_indx(1) <> second_strand+lv_indx(1).

        result = result + 1.

      ENDIF.

      lv_indx = lv_indx + 1.

    ENDDO.

  ENDMETHOD.

ENDCLASS.
