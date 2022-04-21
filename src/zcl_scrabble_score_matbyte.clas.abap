CLASS zcl_scrabble_score_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Scrabble Score</p>
    "!
    "! @parameter input | <p class="shorttext synchronized">Input</p>
    "! @parameter result | <p class="shorttext synchronized">Output based on input score</p>
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.

    TYPES: BEGIN OF ty_scores,

             letters TYPE c LENGTH 50,
             value   TYPE i,

           END OF ty_scores.

ENDCLASS.



CLASS zcl_scrabble_score_matbyte IMPLEMENTATION.

  METHOD score.

    DATA lt_data TYPE TABLE OF me->ty_scores.

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
