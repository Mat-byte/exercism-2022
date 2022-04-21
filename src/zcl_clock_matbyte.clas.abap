CLASS zcl_clock_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Clock</p>
    "!
    "! @parameter hours | <p class="shorttext synchronized">Hours</p>
    "! @parameter minutes | <p class="shorttext synchronized">Minutes</p>
    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.

    METHODS get
      RETURNING
        VALUE(result) TYPE string.

    METHODS add
      IMPORTING
        !minutes TYPE i.

    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.

    DATA gv_time TYPE t.

ENDCLASS.


CLASS zcl_clock_matbyte IMPLEMENTATION.


  METHOD add.

    DATA(lv_min_to_sec) = minutes * 60.

    me->gv_time = me->gv_time + lv_min_to_sec.

  ENDMETHOD.

  METHOD get.

    result = |{ me->gv_time+0(2) }:{ me->gv_time+2(2) }|.

  ENDMETHOD.

  METHOD sub.

    DATA(lv_min_to_sec) = minutes * 60.

    me->gv_time = me->gv_time - lv_min_to_sec.

  ENDMETHOD.

  METHOD constructor.

    TYPES ty_numc TYPE n LENGTH 2.

    DATA(lv_hours) = CONV ty_numc( hours ).

    DATA(lv_minutes) = CONV ty_numc( minutes ).

    me->gv_time = |{ lv_hours }{ lv_minutes }00|.

  ENDMETHOD.

ENDCLASS.
