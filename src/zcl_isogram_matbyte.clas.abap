CLASS zcl_isogram_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS is_isogram
      IMPORTING
        VALUE(phrase) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.

ENDCLASS.



CLASS zcl_isogram_matbyte IMPLEMENTATION.

  METHOD is_isogram.

    DATA lv_offset TYPE i.

    DATA lt_letters TYPE TABLE OF string.

    DATA ls_letter LIKE LINE OF lt_letters.

    phrase = to_upper( phrase ).

    WHILE lv_offset < strlen( phrase ).

      DATA(lv_letter) = phrase+lv_offset(1).

      IF lv_letter <> ' ' AND lv_letter <> '-'.

        READ TABLE lt_letters INTO ls_letter
          WITH KEY table_line = lv_letter.

        IF sy-subrc = 0.

          result = abap_false.

          RETURN.

        ELSE.

          ls_letter = lv_letter.

          APPEND ls_letter TO lt_letters.

        ENDIF.

      ENDIF.

      lv_offset = lv_offset + 1.

    ENDWHILE.

    result = abap_true.

  ENDMETHOD.

ENDCLASS.
