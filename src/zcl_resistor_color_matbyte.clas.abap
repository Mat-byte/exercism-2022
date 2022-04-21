CLASS zcl_resistor_color_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Resistor Color</p>
    "!
    "! @parameter color_code | <p class="shorttext synchronized">Color</p>
    "! @parameter value | <p class="shorttext synchronized">Value</p>
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.

    TYPES: BEGIN OF ty_colors_data,

             color TYPE string,
             value TYPE i,

           END OF ty_colors_data.

ENDCLASS.



CLASS zcl_resistor_color_matbyte IMPLEMENTATION.

  METHOD resistor_color.

    DATA lt_colors TYPE STANDARD TABLE OF me->ty_colors_data
      WITH KEY color.

    DATA ls_color LIKE LINE OF lt_colors.

    "Fill colors database
    ls_color-color = 'BLACK'.
    ls_color-value = 0.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'BROWN'.
    ls_color-value = 1.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'RED'.
    ls_color-value = 2.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'ORANGE'.
    ls_color-value = 3.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'YELLOW'.
    ls_color-value = 4.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'GREEN'.
    ls_color-value = 5.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'BLUE'.
    ls_color-value = 6.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'VIOLET'.
    ls_color-value = 7.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'GREY'.
    ls_color-value = 8.
    APPEND ls_color TO lt_colors.

    ls_color-color = 'WHITE'.
    ls_color-value = 9.
    APPEND ls_color TO lt_colors.


    "Find color value
    CLEAR ls_color.
    READ TABLE lt_colors INTO ls_color
      WITH KEY color = to_upper( color_code ).

    value = ls_color-value.

  ENDMETHOD.

ENDCLASS.
