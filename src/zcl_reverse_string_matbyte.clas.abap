CLASS zcl_reverse_string_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Reverse String</p>
    "!
    "! @parameter input | <p class="shorttext synchronized">Input</p>
    "! @parameter result | <p class="shorttext synchronized">Reverse Input</p>
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_reverse_string_matbyte IMPLEMENTATION.

  METHOD reverse_string.

    DATA lv_len TYPE i.

    DATA lv_out TYPE string.

    DATA lv_word TYPE c.

    lv_len = strlen( input ).

    WHILE lv_len > 0.

      lv_len = lv_len - 1.

      lv_word = input+lv_len(1).

      CONCATENATE result lv_word INTO result.

    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
