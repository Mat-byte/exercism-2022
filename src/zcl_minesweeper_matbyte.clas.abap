CLASS zcl_minesweeper_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS annotate
      IMPORTING
        !input        TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_minesweeper_matbyte IMPLEMENTATION.

  METHOD annotate.

    CONSTANTS lc_bomb TYPE c VALUE '*'.

    DATA lv_count TYPE n.

    DATA lv_index TYPE i.

    DATA lv_prev_line TYPE string.

    DATA lv_next_line TYPE string.

    DATA lv_pos TYPE i.

    DATA lv_prev_pos TYPE i.

    DATA lv_next_pos TYPE i.


    result = input.

    LOOP AT result ASSIGNING FIELD-SYMBOL(<line>).

      lv_index = sy-tabix.

      CLEAR: lv_prev_line, lv_next_line.

      " Read previous line
      IF lv_index > 1.
        READ TABLE result INTO lv_prev_line INDEX ( lv_index - 1 ).
      ENDIF.

      " Read next line
      IF lv_index LT lines( result ).
        READ TABLE result INTO lv_next_line INDEX ( lv_index + 1 ).
      ENDIF.

      lv_pos = 0.

      WHILE lv_pos LT strlen( <line> ).

        lv_count = 0.

        " Check if bomb
        IF <line>+lv_pos(1) EQ lc_bomb.

          ADD 1 TO lv_pos.

          CONTINUE.

        ENDIF.

        lv_prev_pos = lv_pos - 1. " Previous position

        lv_next_pos = lv_pos + 1. " Next position


        " Count bomb on previus position
        IF lv_prev_pos GT -1.

          IF lv_prev_line IS NOT INITIAL.

            IF lv_prev_line+lv_prev_pos(1) EQ lc_bomb.

              ADD 1 TO lv_count.

            ENDIF.
          ENDIF.

          IF <line>+lv_prev_pos(1) EQ lc_bomb.

            ADD 1 TO lv_count.

          ENDIF.

          IF lv_next_line IS NOT INITIAL.

            IF lv_next_line+lv_prev_pos(1) EQ lc_bomb.

              ADD 1 TO lv_count.

            ENDIF.

          ENDIF.

        ENDIF.


        " Count bomb on current position
        IF lv_prev_line IS NOT INITIAL.

          IF lv_prev_line+lv_pos(1) EQ lc_bomb.

            ADD 1 TO lv_count.

          ENDIF.

        ENDIF.

        IF <line>+lv_pos(1) EQ lc_bomb.

          ADD 1 TO lv_count.

        ENDIF.

        IF lv_next_line IS NOT INITIAL.

          IF lv_next_line+lv_pos(1) EQ lc_bomb.

            ADD 1 TO lv_count.

          ENDIF.

        ENDIF.


        " Count bomb on next position
        IF lv_next_pos LT strlen( <line> ).

          IF lv_prev_line IS NOT INITIAL.

            IF lv_prev_line+lv_next_pos(1) EQ lc_bomb.

              ADD 1 TO lv_count.

            ENDIF.

          ENDIF.

          IF <line>+lv_next_pos(1) EQ lc_bomb.

            ADD 1 TO lv_count.

          ENDIF.

          IF lv_next_line IS NOT INITIAL.

            IF lv_next_line+lv_next_pos(1) EQ lc_bomb.

              ADD 1 TO lv_count.

            ENDIF.

          ENDIF.

        ENDIF.

        IF lv_count GT 0.

          <line> = replace( val = <line> off = lv_pos len = 1 with = lv_count ).

        ENDIF.

        ADD 1 TO lv_pos.

      ENDWHILE.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
