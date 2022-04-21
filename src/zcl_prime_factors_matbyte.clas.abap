CLASS zcl_prime_factors_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    "! <p class="shorttext synchronized">Prime Factors</p>
    "!
    "! @parameter input | <p class="shorttext synchronized">Natural Number</p>
    "! @parameter result | <p class="shorttext synchronized">Prime factors of the input</p>
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.

ENDCLASS.


CLASS zcl_prime_factors_matbyte IMPLEMENTATION.

  METHOD factors.

    DATA lv_div TYPE i VALUE 1.

    DATA lv_number TYPE i.

    DATA ls_factor LIKE LINE OF result.


    lv_number = input.

    WHILE lv_number <> lv_div.

      lv_div = lv_div + 1.

      IF lv_number MOD lv_div = 0.

        lv_number = lv_number / lv_div.

        ls_factor = lv_div.

        APPEND ls_factor TO result.

        lv_div = 1.

      ENDIF.

    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
