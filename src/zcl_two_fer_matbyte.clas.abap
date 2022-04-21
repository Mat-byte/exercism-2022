CLASS zcl_two_fer_matbyte DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Two Fer</p>
    "!
    "! @parameter input | <p class="shorttext synchronized">Name</p>
    "! @parameter result | <p class="shorttext synchronized">Text</p>
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.


CLASS zcl_two_fer_matbyte IMPLEMENTATION.

  METHOD two_fer.

    IF input IS INITIAL.

      result = |One for you, one for me.|.

    ELSE.

      result = |One for { input }, one for me.|.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
