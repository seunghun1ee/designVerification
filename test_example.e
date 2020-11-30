
   Sample test.e file
   ----------------------
   This file provides basic test-specific constraints for the calc1 
   testbench.

<'

extend instruction_s {
   keep cmd_in in [ NOP, ADD, SUB, INV, INV1, SHL, SHR, INV2, INV3, INV4, INV5, INV6, INV7, INV8, INV9, INV10 ];
   keep din1 <= MAX_UINT;
   keep din2 <= MAX_UINT;
}; // extend instruction_s


extend driver_u {
   keep instructions_to_drive.size() == 100;
   // Test 3.1 ADD 0 0
   keep instructions_to_drive[0].cmd_in == (1).as_a(opcode_t);
   keep instructions_to_drive[0].din1 == 0;
   keep instructions_to_drive[0].din2 == 0;
   // Test 4.1 SUB 0 0
   keep instructions_to_drive[1].cmd_in == (2).as_a(opcode_t);
   keep instructions_to_drive[1].din1 == 0;
   keep instructions_to_drive[1].din2 == 0;
 
}; // extend driver_u


'>

