
   Sample coverage.e file
   ----------------------
   This file provides a basic example of coverage collection for the calc1 
   testbench.

<'

extend instruction_s {

   event instruction_complete;

   cover instruction_complete is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in;
      item resp;
      cross port_num, cmd_in, resp;
   };

   event add_sub_response;

   cover add_sub_response using when = (cmd_in == ADD || cmd_in == SUB) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != ADD && cmd_in != SUB);
      item resp using ignore = (resp != 1 && resp != 2);
      cross port_num, cmd_in, resp;
   };

   event shift_response;

   cover shift_response using when = (cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != SHL && cmd_in != SHR);
      item resp using ignore = (resp != 1);
      cross port_num, cmd_in, resp;
   };

   event invalid_opcode_response;

   cover invalid_opcode_response using when = !(cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR);
      item resp using ignore = (resp != 2);
      cross port_num, cmd_in, resp;
   };

   event add_corner_cases;

   cover add_corner_cases using when = (cmd_in == ADD) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != ADD);
      item din1 using ignore = !(din1 == 0 || din1 == 1 || din1 == 0x55555555 || din1 == 0xaaaaaaaa || din1 == MAX_UINT);
      item din2 using ignore = !(din2 == 0 || din2 == 1 || din2 == 0x55555555 || din2 == 0xaaaaaaaa || din2 == MAX_UINT);
      cross port_num, cmd_in, din1, din2;
   };

   event add_carry_check_low;

   cover add_carry_check_low using when = (cmd_in == ADD) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != ADD);
      item din1 using ignore = !(din1 == ipow(2,1) || din1 == ipow(2,2) || din1 == ipow(2,3) || din1 == ipow(2,4) || din1 == ipow(2,5) ||
                                 din1 == ipow(2,6) || din1 == ipow(2,7) || din1 == ipow(2,8) || din1 == ipow(2,9) || din1 == ipow(2,10) ||
                                 din1 == ipow(2,11) || din1 == ipow(2,12) || din1 == ipow(2,13) || din1 == ipow(2,14) || din1 == ipow(2,15) ||
                                 din1 == ipow(2,16));
      item din2 using ignore = !(din2 == ipow(2,1) || din2 == ipow(2,2) || din2 == ipow(2,3) || din2 == ipow(2,4) || din2 == ipow(2,5) ||
                                 din2 == ipow(2,6) || din2 == ipow(2,7) || din2 == ipow(2,8) || din2 == ipow(2,9) || din2 == ipow(2,10) ||
                                 din2 == ipow(2,11) || din2 == ipow(2,12) || din2 == ipow(2,13) || din2 == ipow(2,14) || din2 == ipow(2,15) ||
                                 din2 == ipow(2,16));
      cross port_num, cmd_in, din1, din2 using ignore = !(din1 == din2);
   };

   event add_carry_check_high;

   cover add_carry_check_high using when = (cmd_in == ADD) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != ADD);
      item din1 using ignore = !(din1 == ipow(2,17) || din1 == ipow(2,18) || din1 == ipow(2,19) || din1 == ipow(2,20) || din1 == ipow(2,21) ||
                                 din1 == ipow(2,22) || din1 == ipow(2,23) || din1 == ipow(2,24) || din1 == ipow(2,25) || din1 == ipow(2,26) ||
                                 din1 == ipow(2,27) || din1 == ipow(2,28) || din1 == ipow(2,29) || din1 == ipow(2,30) || din1 == ipow(2,31));
      item din2 using ignore = !(din2 == ipow(2,17) || din2 == ipow(2,18) || din2 == ipow(2,19) || din2 == ipow(2,20) || din2 == ipow(2,21) ||
                                 din2 == ipow(2,22) || din2 == ipow(2,23) || din2 == ipow(2,24) || din2 == ipow(2,25) || din2 == ipow(2,26) ||
                                 din2 == ipow(2,27) || din2 == ipow(2,28) || din2 == ipow(2,29) || din2 == ipow(2,30) || din2 == ipow(2,31));
      cross port_num, cmd_in, din1, din2 using ignore = !(din1 == din2);
   };

   event add_carry_twice_check_low;

   cover add_carry_twice_check_low using when = (cmd_in == ADD) is  {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != ADD);
      item din1 using ignore = !(din1 == 3 || din1 == 3 << 1 || din1 == 3 << 2 || din1 == 3 << 3 || din1 == 3 << 4 || din1 == 3 << 5 ||
                                 din1 == 3 << 6 || din1 == 3 << 7 || din1 == 3 << 8 || din1 == 3 << 9 || din1 == 3 << 10 ||
                                 din1 == 3 << 11 || din1 == 3 << 12 || din1 == 3 << 13 || din1 == 3 << 14 || din1 == 3 << 15);
      item din2 using ignore = !(din2 == 1 || din2 == 1 << 1 || din2 == 1 << 2 || din2 == 1 << 3 || din2 == 1 << 4 || din2 == 1 << 5 ||
                                 din2 == 1 << 6 || din2 == 1 << 7 || din2 == 1 << 8 || din2 == 1 << 9 || din2 == 1 << 10 ||
                                 din2 == 1 << 11 || din2 == 1 << 12 || din2 == 1 << 11 || din2 == 1 << 14 || din2 == 1 << 15);
      cross port_num, cmd_in, din1, din2 using ignore = !((din1 - 1 >> 1) == din2);
   };

   event add_carry_twice_check_high;

   cover add_carry_twice_check_high using when = (cmd_in == ADD) is  {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != ADD);
      item din1 using ignore = !(din1 == 3 << 16 || din1 == 3 << 17 || din1 == 3 << 18 || din1 == 3 << 19 || din1 == 3 << 20 ||
                                 din1 == 3 << 21 || din1 == 3 << 22 || din1 == 3 << 23 || din1 == 3 << 24 || din1 == 3 << 25 ||
                                 din1 == 3 << 26 || din1 == 3 << 27 || din1 == 3 << 28 || din1 == 3 << 29 || din1 == 3 << 30);
      item din2 using ignore = !(din2 == 1 << 16 || din2 == 1 << 17 || din2 == 1 << 18 || din2 == 1 << 19 || din2 == 1 << 20 ||
                                 din2 == 1 << 21 || din2 == 1 << 22 || din2 == 1 << 23 || din2 == 1 << 24 || din2 == 1 << 25 ||
                                 din2 == 1 << 26 || din2 == 1 << 27 || din2 == 1 << 28 || din2 == 1 << 29 || din2 == 1 << 30);
      cross port_num, cmd_in, din1, din2 using ignore = !((din1 - 1 >> 1) == din2);
   };

   event sub_corner_cases;

   cover sub_corner_cases using when = (cmd_in == SUB) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != SUB);
      item din1 using ignore = !(din1 == 0 || din1 == 1 || din1 == 0x55555555 || din1 == 0xaaaaaaaa || din1 == MAX_UINT || din1 == 0x80000000);
      item din2 using ignore = !(din2 == 0 || din2 == 1 || din2 == 0x55555555 || din2 == 0xaaaaaaaa || din2 == MAX_UINT);
      cross port_num, cmd_in, din1, din2;
   };

   event sub_borrow_check_low;

   cover sub_borrow_check_low using when = (cmd_in == SUB) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != SUB);
      item din1 using ignore = !(din1 == 2 || din1 == 2 << 1 || din1 == 2 << 2 || din1 == 2 << 3 || din1 == 2 << 4 || din1 == 2 << 5 ||
                                 din1 == 2 << 6 || din1 == 2 << 7 || din1 == 2 << 8 || din1 == 2 << 9 || din1 == 2 << 10 || din1 == 2 << 11 ||
                                 din1 == 2 << 12 || din1 == 2 << 13 || din1 == 2 << 14 || din1 == 2 << 15);
      item din2 using ignore = !(din2 == 1 || din2 == 1 << 1 || din2 == 1 << 2 || din2 == 1 << 3 || din2 == 1 << 4 || din2 == 1 << 5 ||
                                 din2 == 1 << 6 || din2 == 1 << 7 || din2 == 1 << 8 || din2 == 1 << 9 || din2 == 1 << 10 || din2 == 1 << 11 ||
                                 din2 == 1 << 12 || din2 == 1 << 13 || din2 == 1 << 14 || din2 == 1 << 15);
      cross port_num, cmd_in, din1, din2 using ignore = !((din1 >> 1) == din2);
   };

   event sub_borrow_check_high;

   cover sub_borrow_check_high using when = (cmd_in == SUB) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != SUB);
      item din1 using ignore = !(din1 == 2 << 16 || din1 == 2 << 17 || din1 == 2 << 18 || din1 == 2 << 19 || din1 == 2 << 20 || din1 == 2 << 21 ||
                                 din1 == 2 << 22 || din1 == 2 << 23 || din1 == 2 << 24 || din1 == 2 << 25 || din1 == 2 << 26 || din1 == 2 << 27 ||
                                 din1 == 2 << 28 || din1 == 2 << 29 || din1 == 2 << 30);
      item din2 using ignore = !(din2 == 1 << 16 || din2 == 1 << 17 || din2 == 1 << 18 || din2 == 1 << 19 || din2 == 1 << 20 || din2 == 1 << 21 ||
                                 din2 == 1 << 22 || din2 == 1 << 23 || din2 == 1 << 24 || din2 == 1 << 25 || din2 == 1 << 26 || din2 == 1 << 27 ||
                                 din2 == 1 << 28 || din2 == 1 << 29 || din2 == 1 << 30);
      cross port_num, cmd_in, din1, din2 using ignore = !((din1 >> 1) == din2);
   };

   event sub_borrow_twice_check_low;

   cover sub_borrow_twice_check_low using when = (cmd_in == SUB) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != SUB);
      item din1 using ignore = !(din1 == 4 || din1 == 4 << 1 || din1 == 4 << 2 || din1 == 4 << 3 || din1 == 4 << 4 || din1 == 4 << 5 ||
                                 din1 == 4 << 6 || din1 == 4 << 7 || din1 == 4 << 8 || din1 == 4 << 9 || din1 == 4 << 10 || din1 == 4 << 11 ||
                                 din1 == 4 << 12 || din1 == 4 << 13 || din1 == 4 << 14 || din1 == 4 << 15);
      item din2 using ignore = !(din2 == 1 || din2 == 1 << 1 || din2 == 1 << 2 || din2 == 1 << 3 || din2 == 1 << 4 || din2 == 1 << 5 ||
                                 din2 == 1 << 6 || din2 == 1 << 7 || din2 == 1 << 8 || din2 == 1 << 9 || din2 == 1 << 10 || din2 == 1 << 11 ||
                                 din2 == 1 << 12 || din2 == 1 << 13 || din2 == 1 << 14 || din2 == 1 << 15);
      cross port_num, cmd_in, din1, din2 using ignore = !((din1 >> 2) == din2);
   };

   event sub_borrow_twice_check_high;

   cover sub_borrow_twice_check_high using when = (cmd_in == SUB) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in != SUB);
      item din1 using ignore = !(din1 == 4 << 16 || din1 == 4 << 17 || din1 == 4 << 18 || din1 == 4 << 19 || din1 == 4 << 20 || din1 == 4 << 21 ||
                                 din1 == 4 << 22 || din1 == 4 << 23 || din1 == 4 << 24 || din1 == 4 << 25 || din1 == 4 << 26 || din1 == 4 << 27 ||
                                 din1 == 4 << 28 || din1 == 4 << 29);
      item din2 using ignore = !(din2 == 1 << 16 || din2 == 1 << 17 || din2 == 1 << 18 || din2 == 1 << 19 || din2 == 1 << 20 || din2 == 1 << 21 ||
                                 din2 == 1 << 22 || din2 == 1 << 23 || din2 == 1 << 24 || din2 == 1 << 25 || din2 == 1 << 26 || din2 == 1 << 27 ||
                                 din2 == 1 << 28 || din2 == 1 << 29);
      cross port_num, cmd_in, din1, din2 using ignore = !((din1 >> 2) == din2);
   };

   event shift_check_low;

   cover shift_check_low using when = (cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = !(cmd_in == SHL || cmd_in == SHR);
      item din1 using ignore = !(din1 == 1 || din1 == MAX_UINT);
      item din2 using ignore = !(din2 > 0 && din2 <= 16);
      cross port_num, cmd_in, din1, din2;
   };

   event shift_check_high;

   cover shift_check_high using when = (cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = !(cmd_in == SHL || cmd_in == SHR);
      item din1 using ignore = !(din1 == 1 || din1 == MAX_UINT);
      item din2 using ignore = !(din2 > 16 && din2 <= 31);
      cross port_num, cmd_in, din1, din2;
   };

   event shift_check_corner_cases;

   cover shift_check_corner_cases using when = (cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = !(cmd_in == SHL || cmd_in == SHR);
      item din1 using ignore = !(din1 == 1 || din1 == MAX_UINT);
      item din2 using ignore = !(din2 == 0 || din2 == 32 || din2 == MAX_UINT);
      cross port_num, cmd_in, din1, din2;
   };

   event range_of_uints;

   cover range_of_uints using when = (cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = !(cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR);
      item din1 using num_of_buckets = 16;
      item din2 using num_of_buckets = 16;
      cross port_num, cmd_in, din1, din2;
   };

   event range_of_uints_invalid_opcode;

   cover range_of_uints_invalid_opcode using when = !(cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR) is {
      item port_num using ignore = !(port_num > 0 && port_num <= 4);
      item cmd_in using ignore = (cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR);
      item din1 using num_of_buckets = 16;
      item din2 using num_of_buckets = 16;
      cross port_num, cmd_in, din1, din2;
   };



}; // extend instruction_s

extend driver_u {

   collect_response(ins : instruction_s) @clk is also {

      emit ins.instruction_complete;
      emit ins.add_sub_response;
      emit ins.shift_response;
      emit ins.invalid_opcode_response;

      emit ins.add_corner_cases;
      emit ins.add_carry_check_low;
      emit ins.add_carry_check_high;
      emit ins.add_carry_twice_check_low;
      emit ins.add_carry_twice_check_high;

      emit ins.sub_corner_cases;
      emit ins.sub_borrow_check_low;
      emit ins.sub_borrow_check_high;
      emit ins.sub_borrow_twice_check_low;
      emit ins.sub_borrow_twice_check_high;

      emit ins.shift_check_low;
      emit ins.shift_check_high;
      emit ins.shift_check_corner_cases;

      emit ins.range_of_uints;
      emit ins.range_of_uints_invalid_opcode;

   };

}; // extend driver_u

'>

