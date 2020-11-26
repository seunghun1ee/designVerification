
   Sample test.e file
   ----------------------
   This file provides basic test-specific constraints for the calc1 
   testbench.

<'

extend instruction_s {
   keep cmd_in in [ ADD, SUB, INV, INV1, SHL, SHR, INV2, INV3, INV4, INV5, INV6, INV7, INV8, INV9, INV10 ] ;
   keep din1 <= MAX_UINT;
   keep din2 <= MAX_UINT;
}; // extend instruction_s


extend driver_u {
   keep instructions_to_drive.size() == 500;
}; // extend driver_u


'>

