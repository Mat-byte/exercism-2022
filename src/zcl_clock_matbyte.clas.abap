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

    DATA gv_clock TYPE t.

ENDCLASS.


CLASS zcl_clock_matbyte IMPLEMENTATION.


  METHOD add.

    gv_clock = gv_clock + minutes * 60.

  ENDMETHOD.

  METHOD constructor.

    " Clock is number of seconds
    gv_clock = hours * 60 * 60 + minutes * 60.

  ENDMETHOD.

  METHOD get.

    " hh:mm:ss
    result = |{ gv_clock TIME = ISO }|.

    " return only hh:mm
    result = result(5).

  ENDMETHOD.

  METHOD sub.

    gv_clock = gv_clock - minutes * 60.

  ENDMETHOD.

ENDCLASS.
