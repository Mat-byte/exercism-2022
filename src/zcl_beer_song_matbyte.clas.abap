CLASS zcl_beer_song_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

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

ENDCLASS.



CLASS zcl_beer_song_matbyte IMPLEMENTATION.

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

ENDCLASS.
