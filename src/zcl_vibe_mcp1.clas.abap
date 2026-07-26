CLASS zcl_vibe_mcp1 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.
CLASS zcl_vibe_mcp1 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( |Hello from VSP MCP - hands-free write works!| ).
  ENDMETHOD.
ENDCLASS.
