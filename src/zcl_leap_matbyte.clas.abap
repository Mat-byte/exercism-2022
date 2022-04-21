CLASS zcl_leap_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Leap</p>
    "!
    "! @parameter year | <p class="shorttext synchronized">Year</p>
    "! @parameter result | <p class="shorttext synchronized">Is leap year</p>
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.

ENDCLASS.


CLASS zcl_leap_matbyte IMPLEMENTATION.

  METHOD leap.

    IF year MOD 100 EQ 0.

      IF year MOD 400 EQ 0.

        result = abap_true.

        RETURN.

      ENDIF.

      result = abap_false.

    ELSEIF year MOD 4  EQ 0.

      result = abap_true.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
