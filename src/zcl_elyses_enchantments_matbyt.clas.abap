CLASS zcl_elyses_enchantments_matbyt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_stack TYPE STANDARD TABLE OF i WITH EMPTY KEY.


    "! <p class="shorttext synchronized">Get card at position</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter position | <p class="shorttext synchronized">Position</p>
    "! @parameter result | <p class="shorttext synchronized">Value's card</p>
    METHODS get_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
      RETURNING VALUE(result) TYPE i.


    "! <p class="shorttext synchronized">Replace card at position</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter position | <p class="shorttext synchronized">Position to replace</p>
    "! @parameter replacement | <p class="shorttext synchronized">Card value</p>
    "! @parameter result | <p class="shorttext synchronized">Stack with Changes</p>
    METHODS set_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
                replacement   TYPE i
      RETURNING VALUE(result) TYPE ty_stack.


    "! <p class="shorttext synchronized">Add card to stack</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter new_card | <p class="shorttext synchronized">New card</p>
    "! @parameter result | <p class="shorttext synchronized">Stack with new car</p>
    METHODS insert_item_at_top
      IMPORTING stack         TYPE ty_stack
                new_card      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.


    "! <p class="shorttext synchronized">Remove card at position</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter position | <p class="shorttext synchronized">Position to delete</p>
    "! @parameter result | <p class="shorttext synchronized">Stack without a card</p>
    METHODS remove_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.


    "! <p class="shorttext synchronized">Remove top card</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter result | <p class="shorttext synchronized">Stack without last row</p>
    METHODS remove_item_from_top
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE ty_stack.


    "! <p class="shorttext synchronized">Add card to bottom of stack</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter new_card | <p class="shorttext synchronized">New card</p>
    "! @parameter result | <p class="shorttext synchronized">Stack with new card</p>
    METHODS insert_item_at_bottom
      IMPORTING stack         TYPE ty_stack
                new_card      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.


    "! <p class="shorttext synchronized">Remove bottom card</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter result | <p class="shorttext synchronized">Stack without first row</p>
    METHODS remove_item_from_bottom
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE ty_stack.


    "! <p class="shorttext synchronized">Count cards</p>
    "!
    "! @parameter stack | <p class="shorttext synchronized">Stack</p>
    "! @parameter result | <p class="shorttext synchronized">Cards in the stack</p>
    METHODS get_size_of_stack
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_elyses_enchantments_matbyt IMPLEMENTATION.

  METHOD get_item.

    TRY.

        result = stack[ position ].

      CATCH cx_sy_itab_line_not_found.

        RETURN.

    ENDTRY.

  ENDMETHOD.

  METHOD get_size_of_stack.

    result = lines( stack ).

  ENDMETHOD.

  METHOD insert_item_at_bottom.

    result = stack.

    INSERT new_card INTO result INDEX 1.

  ENDMETHOD.

  METHOD insert_item_at_top.

    result = stack.

    APPEND new_card TO result.

  ENDMETHOD.

  METHOD remove_item.

    result = stack.

    DELETE result INDEX position.

  ENDMETHOD.

  METHOD remove_item_from_bottom.

    result = stack.

    DELETE result INDEX 1.

  ENDMETHOD.

  METHOD remove_item_from_top.

    DATA(lv_stack_lines) = lines( stack ).

    result = stack.

    DELETE result INDEX lv_stack_lines.

  ENDMETHOD.

  METHOD set_item.

    READ TABLE stack ASSIGNING FIELD-SYMBOL(<ls_cards>)
     INDEX position.

    CHECK sy-subrc = 0.

    <ls_cards> = replacement.

    APPEND LINES OF stack TO result.

  ENDMETHOD.

ENDCLASS.
