CLASS zcl_exercism_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    "! <p class="shorttext synchronized">Reverse String</p>
    "!
    "! @parameter input | <p class="shorttext synchronized">Input</p>
    "! @parameter result | <p class="shorttext synchronized">Reverse Input</p>
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.

    "! <p class="shorttext synchronized">Scrabble Score</p>
    "!
    "! @parameter input | <p class="shorttext synchronized">Input</p>
    "! @parameter result | <p class="shorttext synchronized">Output based on input score</p>
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.

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

    "! <p class="shorttext synchronized">Beer Song</p>
    "!
    "! @parameter initial_bottles_count | <p class="shorttext synchronized">Initial Bottles</p>
    "! @parameter take_down_count | <p class="shorttext synchronized">End of bottles</p>
    "! @parameter result | <p class="shorttext synchronized">Final beer Song</p>
    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.


    "! <p class="shorttext synchronized" lang="en">Two Fer</p>
    "!
    "! @parameter input | <p class="shorttext synchronized" lang="en">Name</p>
    "! @parameter result | <p class="shorttext synchronized" lang="en">Text</p>
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.


    "! <p class="shorttext synchronized" lang="en">Resistor Color</p>
    "!
    "! @parameter color_code | <p class="shorttext synchronized" lang="en">Color</p>
    "! @parameter value | <p class="shorttext synchronized" lang="en">Value</p>
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.

ENDCLASS.


CLASS zcl_exercism_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "Example: out->write...

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
             value   TYPE i,

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

  METHOD recite.

    DATA lv_inittial_bottles_count LIKE initial_bottles_count.

    DATA lv_inittial_bottles_char TYPE c LENGTH 20.

    DATA lv_take_down_char TYPE c LENGTH 20.

    DATA lv_take_down_count LIKE take_down_count.

    DATA lv_beg1 LIKE LINE OF result VALUE '& # of beer on the wall, & # of beer.'.

    DATA lv_beg2 LIKE LINE OF result VALUE 'Take one down and pass it around, & # of beer on the wall.'.

    DATA lv_plural_or_singular TYPE c LENGTH 7.

    CONSTANTS lc_fin1 LIKE LINE OF result VALUE 'No more bottles of beer on the wall, no more bottles of beer.'.

    CONSTANTS lc_fin1_2 LIKE LINE OF result VALUE 'Take it down and pass it around, no more bottles of beer on the wall.'.

    CONSTANTS lc_initial LIKE LINE OF result VALUE IS INITIAL.

    DATA lc_fin2 LIKE LINE OF result VALUE 'Go to the store and buy some more, 99 bottles of beer on the wall.'.


    lv_inittial_bottles_count = initial_bottles_count.

    lv_take_down_count = take_down_count.

    DO take_down_count TIMES.

      IF sy-index > 1.

        APPEND lc_initial TO result.

      ENDIF.

      IF lv_inittial_bottles_count > 1.

        lv_plural_or_singular = 'bottles'.

      ELSE.

        lv_plural_or_singular = 'bottle'.

      ENDIF.

      CASE lv_inittial_bottles_count.

        WHEN 0.

          APPEND lc_fin1 TO result.

          lv_inittial_bottles_char  = initial_bottles_count.

          CONDENSE lv_inittial_bottles_char.

          REPLACE ALL OCCURRENCES OF '&' IN lc_fin2 WITH lv_inittial_bottles_char.

          REPLACE ALL OCCURRENCES OF '#' IN lc_fin2 WITH lv_plural_or_singular.

          APPEND lc_fin2 TO result.

          EXIT.

        WHEN 1.

          lv_inittial_bottles_char = lv_inittial_bottles_count.

          CONDENSE lv_inittial_bottles_char.

          REPLACE ALL OCCURRENCES OF '&' IN lv_beg1 WITH lv_inittial_bottles_char.

          REPLACE ALL OCCURRENCES OF '#' IN lv_beg1 WITH lv_plural_or_singular.

          APPEND lv_beg1 TO result.

          APPEND lc_fin1_2 TO result.

          lv_inittial_bottles_count = lv_inittial_bottles_count - 1.

        WHEN OTHERS.

          lv_inittial_bottles_char = lv_inittial_bottles_count.

          CONDENSE lv_inittial_bottles_char.

          DATA(lv_beg1_aux) = lv_beg1.

          REPLACE ALL OCCURRENCES OF '&' IN lv_beg1_aux WITH lv_inittial_bottles_char .

          REPLACE ALL OCCURRENCES OF '#' IN lv_beg1_aux WITH lv_plural_or_singular .

          APPEND lv_beg1_aux TO result.


          lv_inittial_bottles_count = lv_inittial_bottles_count - 1.

          IF lv_inittial_bottles_count > 1.

            lv_plural_or_singular = 'bottles'.

          ELSE.

            lv_plural_or_singular = 'bottle'.

          ENDIF.

          lv_inittial_bottles_char = lv_inittial_bottles_count.

          CONDENSE lv_inittial_bottles_char.

          DATA(lv_beg2_aux) = lv_beg2.

          REPLACE ALL OCCURRENCES OF '&' IN lv_beg2_aux WITH lv_inittial_bottles_char .

          REPLACE ALL OCCURRENCES OF '#' IN lv_beg2_aux WITH lv_plural_or_singular .

          APPEND lv_beg2_aux TO result.

      ENDCASE.

    ENDDO.

  ENDMETHOD.

  METHOD two_fer.

    IF input IS INITIAL.

      result = |One for you, one for me.|.

    ELSE.

      result = |One for { input }, one for me.|.

    ENDIF.

  ENDMETHOD.

  METHOD resistor_color.

    TYPES: BEGIN OF ty_colors_data,

             color TYPE string,
             value TYPE i,

           END OF ty_colors_data.

    DATA lt_colors TYPE STANDARD TABLE OF ty_colors_data
      WITH KEY color.

    DATA ls_color LIKE LINE OF lt_colors.

    "Fill colors database
    ls_color-color = 'BLACK'.
    ls_color-value = 0.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'BROWN'.
    ls_color-value = 1.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'RED'.
    ls_color-value = 2.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'ORANGE'.
    ls_color-value = 3.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'YELLOW'.
    ls_color-value = 4.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'GREEN'.
    ls_color-value = 5.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'BLUE'.
    ls_color-value = 6.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'VIOLET'.
    ls_color-value = 7.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'GREY'.
    ls_color-value = 8.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'WHITE'.
    ls_color-value = 9.
    APPEND ls_color TO lt_colors.


    "Find color value
    CLEAR ls_color.
    READ TABLE lt_colors INTO ls_color
      WITH KEY color = to_upper( color_code ).

    value = ls_color-value.

  ENDMETHOD.

ENDCLASS.
