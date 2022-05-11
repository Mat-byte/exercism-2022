CLASS zcl_atbash_cipher_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_equivalents,

             letter TYPE c LENGTH 1,
             equivl TYPE c LENGTH 1,

           END OF ty_equivalents.

    METHODS decode
      IMPORTING
        cipher_text       TYPE string
      RETURNING
        VALUE(plain_text) TYPE string .

    METHODS encode
      IMPORTING
        plain_text         TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .

  PRIVATE SECTION.

    DATA lc_plain TYPE string VALUE 'abcdefghijklmnopqrstuvwxyz'.

    DATA lt_equivalents TYPE STANDARD TABLE OF ty_equivalents.

    METHODS build_equivalents.

ENDCLASS.



CLASS zcl_atbash_cipher_matbyte IMPLEMENTATION.

  METHOD decode.

    DATA lv_indx TYPE i.

    DATA lv_character TYPE c LENGTH 1.

    DATA(lv_cipher_text) = cipher_text .

    CONDENSE lv_cipher_text NO-GAPS.

    me->build_equivalents( ).

    DO strlen( lv_cipher_text ) TIMES .

      lv_character = lv_cipher_text+lv_indx(1).

      TRANSLATE lv_character TO LOWER CASE.

      READ TABLE me->lt_equivalents INTO DATA(ls_equivalent)
        WITH KEY equivl = lv_character.

      IF sy-subrc = 0.

        plain_text = |{ plain_text }{ ls_equivalent-letter }|.

      ELSE.

        plain_text = |{ plain_text }{ lv_character }|.

      ENDIF.

      lv_indx = lv_indx + 1.

    ENDDO.

  ENDMETHOD.

  METHOD encode.

    DATA lv_indx TYPE i.

    DATA lv_count TYPE i.

    DATA lv_character TYPE c LENGTH 1.

    DATA(lv_plain_text) = plain_text.

    me->build_equivalents( ).

    REPLACE ALL OCCURRENCES OF REGEX '[,\.]' IN lv_plain_text WITH ''.

    CONDENSE lv_plain_text NO-GAPS.

    DO strlen( lv_plain_text ) TIMES.

      lv_count = lv_count + 1.

      lv_character = lv_plain_text+lv_indx(1).

      TRANSLATE lv_character TO LOWER CASE.

      READ TABLE me->lt_equivalents INTO DATA(ls_equivalent)
        WITH KEY letter = lv_character.

      IF sy-subrc = 0.

        cipher_text = |{ cipher_text }{ ls_equivalent-equivl }|.

      ELSE.

        cipher_text = |{ cipher_text }{ lv_character }|.

      ENDIF.

      lv_indx = lv_indx + 1.

      IF  lv_count = 5.

        cipher_text = |{ cipher_text } |.

        lv_count = 0.

      ENDIF.

    ENDDO.

  ENDMETHOD.

  METHOD build_equivalents.

    DATA lv_count TYPE i.

    DATA lv_uncount TYPE i.

    DATA ls_equivalent LIKE LINE OF me->lt_equivalents.


    DATA(lv_lenght) = strlen( me->lc_plain ).

    lv_uncount = lv_lenght - 1.


    DO strlen( me->lc_plain ) TIMES.

      DATA(lv_equivalent) = lc_plain+lv_uncount(1).

      DATA(lv_letter) = lc_plain+lv_count(1).

      ls_equivalent-letter = lv_letter.

      ls_equivalent-equivl = lv_equivalent.

      APPEND ls_equivalent TO me->lt_equivalents.


      lv_count = lv_count + 1.

      lv_uncount = lv_uncount - 1.

    ENDDO.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA(cifrado) = me->encode( plain_text = 'mindblowingly' ).
*    DATA(cifrado) = me->decode( cipher_text = 'vc vix    r hn' ).

    out->write( cifrado ).


  ENDMETHOD.

ENDCLASS.
