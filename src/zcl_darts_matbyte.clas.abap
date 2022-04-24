CLASS zcl_darts_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Score</p>
    "!
    "! @parameter x | <p class="shorttext synchronized">Coordinate X</p>
    "! @parameter y | <p class="shorttext synchronized">Coordinate Y</p>
    "! @parameter result | <p class="shorttext synchronized">Score</p>
    METHODS score
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(result) TYPE i.

  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Calculate radius</p>
    "!
    "! @parameter x | <p class="shorttext synchronized">Coordinate X</p>
    "! @parameter y | <p class="shorttext synchronized">Coordinate Y</p>
    "! @parameter radius | <p class="shorttext synchronized">Radius</p>
    METHODS calculate_radius
      IMPORTING
        x             TYPE f
        y             TYPE f
      RETURNING
        VALUE(radius) TYPE i.

ENDCLASS.



CLASS zcl_darts_matbyte IMPLEMENTATION.

  METHOD score.

    DATA(lv_radius) = me->calculate_radius(
                        x = x
                        y = y  ).

    result = COND #(
        WHEN lv_radius <= 1  THEN 10
        WHEN lv_radius <= 5  THEN 5
        WHEN lv_radius <= 10 THEN 1
        ELSE 0
         ).

  ENDMETHOD.

  METHOD calculate_radius.

    radius = sqrt( ( x * x ) + ( y * y ) ).

  ENDMETHOD.

ENDCLASS.
