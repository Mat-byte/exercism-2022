CLASS zcl_phone_number_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_phone_number_matbyte IMPLEMENTATION.

  METHOD clean.

    result = replace( val   = number
                      regex = |[^0-9]|
                      with  = ``
                      occ   = 0 ).
    IF strlen( result ) = 11 AND result+0(1) = '1'.
      result = result+1.
    ENDIF.
    IF strlen( result ) <> 10.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    IF result+0(1) <= '1' OR result+3(1) <= '1'.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
