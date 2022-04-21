CLASS zcl_high_scores_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores_matbyte IMPLEMENTATION.

  METHOD constructor.

    me->scores_list = scores.

  ENDMETHOD.

  METHOD list_scores.

    result = me->scores_list.

  ENDMETHOD.

  METHOD latest.

    DATA(lv_table_lines) = lines( me->scores_list ).

    READ TABLE me->scores_list INTO DATA(ls_score)
     INDEX lv_table_lines.

    result = ls_score.

  ENDMETHOD.

  METHOD personalbest.

    DATA(lt_scores_list) = me->scores_list.

    SORT lt_scores_list BY table_line DESCENDING.

    READ TABLE lt_scores_list INTO DATA(ls_score)
     INDEX 1.

    result = ls_score.

  ENDMETHOD.

  METHOD personaltopthree.

    DATA(lt_scores_list) = me->scores_list.

    SORT lt_scores_list BY table_line DESCENDING.

    LOOP AT lt_scores_list INTO DATA(ls_score).

      IF sy-tabix > 3.

        EXIT.

      ENDIF.

      APPEND ls_score TO result.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
