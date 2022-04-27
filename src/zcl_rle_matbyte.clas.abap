CLASS zcl_rle_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_letters,

             letter   TYPE c LENGTH 1,
             quantity TYPE i,

           END OF ty_letters.

    METHODS encode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_rle_matbyte IMPLEMENTATION.

  METHOD decode.

    DATA lv_indx TYPE i.

    DATA lv_times TYPE i.

    IF input CN '0123456789'.

      result = input.

      RETURN.

    ENDIF.

    DO strlen( input ) TIMES.

      DATA(lv_character) = input+lv_indx(1).

      IF lv_character CO '0123456789'.

        lv_times = lv_character.

      ELSEIF lv_times IS INITIAL.

        result = |{ result }{ lv_character }|.

      ELSE.

        DO lv_times TIMES.

          result = |{ result }{ lv_character }|.

        ENDDO.

        CLEAR lv_times.

      ENDIF.

      lv_indx = lv_indx + 1.

    ENDDO.

  ENDMETHOD.

  METHOD encode.

    DATA lt_letters TYPE STANDARD TABLE OF me->ty_letters.

    DATA ls_letter LIKE LINE OF lt_letters.

    DATA lv_indx TYPE i.

    DATA lv_count TYPE i.

    DATA lv_char TYPE c LENGTH 1.

    IF input IS INITIAL.

      RETURN.

    ENDIF.

    lv_char = input+0(1).

    DO strlen( input ) TIMES.

      IF input+lv_indx(1) = lv_char.

        lv_count = lv_count + 1.

      ELSE.

        ls_letter-letter = lv_char.

        ls_letter-quantity = lv_count.

        APPEND ls_letter TO lt_letters.

        lv_char = input+lv_indx(1).

        lv_count = 1.

      ENDIF.

      lv_indx = lv_indx + 1.

    ENDDO.

    ls_letter-letter = lv_char.

    ls_letter-quantity = lv_count.

    APPEND ls_letter TO lt_letters.


    LOOP AT lt_letters INTO ls_letter.

      result = |{ result }{ ls_letter-quantity }{ ls_letter-letter }|.

    ENDLOOP.

    REPLACE ALL OCCURRENCES OF '1' IN result WITH ''.

  ENDMETHOD.

ENDCLASS.
