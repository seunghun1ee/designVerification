
   Sample test.e file
   ----------------------
   This file provides basic test-specific constraints for the calc1 
   testbench.

<'

extend instruction_s {
   keep cmd_in in [ ADD, SUB, INV, INV1, SHL, SHR, INV2, INV3, INV4, INV5, INV6, INV7, INV8, INV9, INV10 ];
   keep din1 <= MAX_UINT;
   keep din2 <= MAX_UINT;
}; // extend instruction_s


extend driver_u {
   // Randomised tests
   keep instructions_to_drive.size() == 50;

   // Test 3.1 ADD 0 0
   test_3_1 : instruction_s;
   keep test_3_1.cmd_in == (1).as_a(opcode_t);
   keep test_3_1.din1 == 0;
   keep test_3_1.din2 == 0;
   
   // Test 3.2a ADD x 0
   test_3_2a : list of instruction_s;
   keep test_3_2a.size() == 10;
   keep for each in test_3_2a {
      .cmd_in == (1).as_a(opcode_t);
      .din1 <= MAX_UINT;
      .din2 == 0;
   };
   
   // Test 3.2b ADD 0 x
   test_3_2b : list of instruction_s;
   keep test_3_2b.size() == 10;
   keep for each in test_3_2b {
      .cmd_in == (1).as_a(opcode_t);
      .din1 == 0;
      .din2 <= MAX_UINT;
   };

   // Test 3.3 Check carry for each bit
   test_3_3 : list of instruction_s;
   keep test_3_3.size() == 32;
   keep for each in test_3_3 {
      .cmd_in == (1).as_a(opcode_t);
      .din1 == (1 << index);
      .din2 == (1 << index);
   };

   // Test 3.4a
   test_3_4a : instruction_s;
   keep test_3_4a.cmd_in == (1).as_a(opcode_t);
   keep test_3_4a.din1 == 0b1010_1010_1010_1010_1010_1010_1010_1010;
   keep test_3_4a.din2 == 0b0101_0101_0101_0101_0101_0101_0101_0101;

   // Test 3.4b
   test_3_4b : instruction_s;
   keep test_3_4b.cmd_in == (1).as_a(opcode_t);
   keep test_3_4b.din1 == 0b0101_0101_0101_0101_0101_0101_0101_0101;
   keep test_3_4b.din2 == 0b1010_1010_1010_1010_1010_1010_1010_1010;

   // Test 3.5 check carry twice in a row
   test_3_5 : list of instruction_s;
   keep test_3_5.size() == 31;
   keep for each in test_3_5 {
      .cmd_in == (1).as_a(opcode_t);
      .din1 == (3 << index);
      .din2 == (1 << index);
   };

   // Test 3.6a
   test_3_6a : instruction_s;
   keep test_3_6a.cmd_in == (1).as_a(opcode_t);
   keep test_3_6a.din1 == MAX_UINT;
   keep test_3_6a.din2 == 1;

   // Test 3.6b
   test_3_6b : instruction_s;
   keep test_3_6b.cmd_in == (1).as_a(opcode_t);
   keep test_3_6b.din1 == 1;
   keep test_3_6b.din2 == MAX_UINT;

   // Test 4.1 SUB 0 0
   test_4_1 : instruction_s;
   keep test_4_1.cmd_in == (2).as_a(opcode_t);
   keep test_4_1.din1 == 0;
   keep test_4_1.din2 == 0;

   // Test 4.2 SUB x 0
   test_4_2 : instruction_s;
   keep test_4_2.cmd_in == (2).as_a(opcode_t);
   keep test_4_2.din1 <= MAX_UINT;
   keep test_4_2.din2 == 0;

   // Test 4.3 SUB MAX_UINT MAX_UINT
   test_4_3 : instruction_s;
   keep test_4_3.cmd_in == (2).as_a(opcode_t);
   keep test_4_3.din1 == MAX_UINT;
   keep test_4_3.din2 == MAX_UINT;

   // Test 4.4 SUB x x
   test_4_4 : list of instruction_s;
   keep test_4_4.size() == 10;
   keep for each in test_4_4 {
      .cmd_in == (2).as_a(opcode_t);
      .din1 <= MAX_UINT;
      .din2 == .din1;
   };

   // Test 4.7 SUB 0 1
   test_4_7 : instruction_s;
   keep test_4_7.cmd_in == (2).as_a(opcode_t);
   keep test_4_7.din1 == 0;
   keep test_4_7.din2 == 1;

 
}; // extend driver_u


'>

