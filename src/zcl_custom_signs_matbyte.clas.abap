CLASS zcl_custom_signs_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

     "! Build a sign that includes both of the parameters.
    METHODS build_sign IMPORTING occasion      TYPE string
                                 name          TYPE string
                       RETURNING VALUE(result) TYPE string.

    "! Build a birthday sign that conditionally formats the return string.
    METHODS build_birthday_sign IMPORTING age           TYPE i
                                RETURNING VALUE(result) TYPE string.

    "! Build a graduation sign that includes multiple lines
    METHODS graduation_for IMPORTING name          TYPE string
                                     year          TYPE i
                           RETURNING VALUE(result) TYPE string.

    "! Determine cost based on each character of sign parameter that builds
    "! the template string that includes the currency parameter.
    METHODS cost_of IMPORTING sign          TYPE string
                              currency      TYPE string
                    RETURNING VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_custom_signs_matbyte IMPLEMENTATION.

  METHOD build_birthday_sign.

    result = COND #(
                WHEN age >= 50
                  THEN |Happy Birthday! What a mature fellow you are.|
                  ELSE |Happy Birthday! What a young fellow you are.| ).

  ENDMETHOD.

  METHOD build_sign.

    result = |Happy { occasion } { name }!|.

  ENDMETHOD.

  METHOD cost_of.

    DATA(lv_cost) = 20 + ( strlen( sign ) * 2 ).

    result = |Your sign costs { lv_cost }.00 { currency }.|.

  ENDMETHOD.

  METHOD graduation_for.

    result = |Congratulations { name }!\nClass of { year }|.

  ENDMETHOD.

ENDCLASS.
