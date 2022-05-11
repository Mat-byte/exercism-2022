CLASS zcl_rle_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_letters,

             letter   TYPE c LENGTH 1,
             quantity TYPE i,

           END OF ty_letters.

    METHODS encode IMPORTING VALUE(input)         TYPE string
                   RETURNING VALUE(result) TYPE string.

    METHODS decode IMPORTING input         TYPE string
                   RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA gt_letters TYPE STANDARD TABLE OF ty_letters.

    CONSTANTS gc_abcde TYPE c LENGTH 55 VALUE 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz'.

ENDCLASS.



CLASS zcl_rle_matbyte IMPLEMENTATION.

  METHOD decode.

    DATA lv_indx TYPE i.

    DATA lv_times TYPE i.

    IF input NA '0123456789'.

      result = input.

      RETURN.

    ENDIF.

    DO strlen( input ) TIMES.

      DATA(lv_character) = input+lv_indx(1).

      IF lv_character CA '0123456789'.

        lv_times = |{ lv_times }{ lv_character }|.

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

*    TYPES ty_char30 TYPE c LENGTH 30.
*
*    DATA lt_letters TYPE STANDARD TABLE OF ty_letters.
*
*    DATA ls_letter LIKE LINE OF lt_letters.
*
*    DATA lv_indx TYPE i.
*
*    DATA lv_count TYPE i.
*
*    DATA lv_char TYPE c LENGTH 1.
*
*    IF input IS INITIAL.
*
*      RETURN.
*
*    ENDIF.
*
*    REPLACE ALL OCCURRENCES OF space IN input WITH '&'.
*
*    lv_char = input+0(1).
*
*    DO strlen( input ) TIMES.
*
*      IF input+lv_indx(1) = lv_char.
*
*        lv_count = lv_count + 1.
*
*      ELSE.
*
*        ls_letter-letter = lv_char.
*
*        ls_letter-quantity = lv_count.
*
*        APPEND ls_letter TO lt_letters.
*
*        lv_char = input+lv_indx(1).
*
*        lv_count = 1.
*
*      ENDIF.
*
*      lv_indx = lv_indx + 1.
*
*    ENDDO.
*
*    ls_letter-letter = lv_char.
*
*    ls_letter-quantity = lv_count.
*
*    APPEND ls_letter TO lt_letters.
*
*
*    LOOP AT lt_letters INTO ls_letter.
*
*      DATA(lv_value) = COND ty_char30(
*            WHEN ls_letter-quantity = 1
*                THEN ''
*            ELSE ls_letter-quantity ).
*
*      result = |{ result }{ lv_value }{ ls_letter-letter }|.
*
*    ENDLOOP.
*
*    REPLACE ALL OCCURRENCES OF '&' IN result WITH space .
*
*    gt_letters = lt_letters.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA(lv_string) = me->decode( input = '12WB12W3B24WB' ).
*
    out->write( lv_string ).

*     LOOP AT gt_letters INTO DATA(ls_let).
*
*      out->write( |{ ls_let-letter }-{ ls_let-quantity }| ).
*
*     ENDLOOP.
**
*     out->write( lines( gt_letters ) ).

  ENDMETHOD.

ENDCLASS.
