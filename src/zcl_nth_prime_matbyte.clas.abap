CLASS zcl_nth_prime_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA gt TYPE STANDARD TABLE OF i.

ENDCLASS.


CLASS zcl_nth_prime_matbyte IMPLEMENTATION.

  METHOD prime.

    DATA lv_found TYPE abap_bool.

    DATA lv_number_to_test TYPE i VALUE 1.

    DATA lv_divisor TYPE i.

    DATA lt_prime_numbers TYPE STANDARD TABLE OF i WITH DEFAULT KEY.

    IF input = 0.

      RAISE EXCEPTION TYPE cx_parameter_invalid.

    ENDIF.

    WHILE lines( lt_prime_numbers ) < input.

      lv_number_to_test = lv_number_to_test + 1.

      lv_divisor = 2.

      lv_found = abap_false.

      WHILE lv_divisor <= lv_number_to_test.

        IF lv_number_to_test MOD lv_divisor EQ 0 AND lv_number_to_test <> lv_divisor.

          lv_found = abap_true.

          EXIT.

        ENDIF.

        lv_divisor = lv_divisor + 1.

      ENDWHILE.

      IF lv_found EQ abap_false.

        APPEND lv_number_to_test TO lt_prime_numbers.

      ENDIF.

    ENDWHILE.

    result = lt_prime_numbers[ input ].

  ENDMETHOD.

ENDCLASS.
