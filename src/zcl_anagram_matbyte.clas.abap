CLASS zcl_anagram_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

   INTERFACES if_oo_adt_classrun.

    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.

ENDCLASS.



CLASS zcl_anagram_matbyte IMPLEMENTATION.

  METHOD anagram.

    DATA lv_indx TYPE i.

    DATA lv_fail TYPE c.

    LOOP AT candidates INTO DATA(ls_candidate).

        CLEAR lv_indx.

        CLEAR lv_fail.

        CHECK strlen( ls_candidate ) = strlen( input ).

        CHECK to_upper( ls_candidate ) <> to_upper( input ).

        DO strlen( ls_candidate ) TIMES.

          DATA(lv_letter) = to_upper( ls_candidate+lv_indx(1) ).

          FIND lv_letter IN to_upper( input ).

          IF sy-subrc <> 0.

            lv_fail = 'X'.

            EXIT.

          ELSE.

            FIND ALL OCCURRENCES OF lv_letter IN to_upper( input ) MATCH COUNT DATA(lv_in_input).
            FIND ALL OCCURRENCES OF lv_letter IN to_upper( ls_candidate ) MATCH COUNT DATA(lv_in_candidate).

            IF lv_in_input <> lv_in_candidate.

              lv_fail = 'X'.

              EXIT.

            ENDIF.

          ENDIF.

          lv_indx = lv_indx + 1.

        ENDDO.

        IF lv_fail <> 'X'.

          APPEND ls_candidate TO result.

        ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

DATA(candidates) = VALUE string_table( ( |tset| ) ( |sett| ) ( |tesi| ) ( |tesit| ) ).
*    DATA(exp_result) = VALUE string_table( ( |tset| ) ( |sett| ) ).
DATA(lt_result) = me->anagram( input = 'test' candidates = candidates ).
LOOP AT lt_result INTO DATA(ls_result).
out->write( ls_result ).
ENDLOOP.
  ENDMETHOD.

ENDCLASS.
