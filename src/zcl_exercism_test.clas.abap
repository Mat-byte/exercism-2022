CLASS zcl_exercism_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.

    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.


CLASS zcl_exercism_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( me->score( input = 'cabbage' ) ).

  ENDMETHOD.

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

  METHOD score.

    TYPES: BEGIN OF ty_scores,

           letters TYPE c LENGTH 50,
           value TYPE i,

           END OF ty_scores.

    DATA lt_data TYPE TABLE OF ty_scores.

    DATA ls_data LIKE LINE OF lt_data.

    DATA lv_word TYPE c.

    CONSTANTS lc_d1 TYPE c LENGTH 50 VALUE 'A, E, I, O, U, L, N, R, S, T'.

    CONSTANTS lc_d2 TYPE c LENGTH 50 VALUE 'D, G'.

    CONSTANTS lc_d3 TYPE c LENGTH 50 VALUE 'B, C, M, P'.

    CONSTANTS lc_d4 TYPE c LENGTH 50 VALUE 'F, H, V, W, Y'.

    CONSTANTS lc_d5 TYPE c LENGTH 50 VALUE 'K'.

    CONSTANTS lc_d6 TYPE c LENGTH 50 VALUE 'J, X'.

    CONSTANTS lc_d7 TYPE c LENGTH 50 VALUE 'Q, Z'.

    ls_data-letters = lc_d1.
    ls_data-value = 1.
    APPEND ls_data TO lt_data.

    ls_data-letters = lc_d2.
    ls_data-value = 2.
    APPEND ls_data TO lt_data.

    ls_data-letters = lc_d3.
    ls_data-value = 3.
    APPEND ls_data TO lt_data.

    ls_data-letters = lc_d4.
    ls_data-value = 4.
    APPEND ls_data TO lt_data.

    ls_data-letters = lc_d5.
    ls_data-value = 5.
    APPEND ls_data TO lt_data.

    ls_data-letters = lc_d6.
    ls_data-value = 8.
    APPEND ls_data TO lt_data.

    ls_data-letters = lc_d7.
    ls_data-value = 10.
    APPEND ls_data TO lt_data.

    DATA(lv_len) = strlen( input ).

    DO lv_len TIMES.

      lv_len = lv_len + -1.

      lv_word = to_upper( input+lv_len(1) ).

    LOOP AT lt_data INTO ls_data.

      IF ls_data-letters CA lv_word .

        result = result + ls_data-value.

        EXIT.

      ENDIF.

    ENDLOOP.

    ENDDO.

  ENDMETHOD.

ENDCLASS.
