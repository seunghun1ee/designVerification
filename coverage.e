
   Sample coverage.e file
   ----------------------
   This file provides a basic example of coverage collection for the calc1 
   testbench.

<'

extend instruction_s {

   event instruction_complete;

   cover instruction_complete is {
      item cmd_in;
      item resp;
      //item din1;
      //item din2;
      cross cmd_in, resp;
      //cross cmd_in, din1, din2;
   };

   event add_sub_response;

   cover add_sub_response is {
      item cmd_in using ignore = (cmd_in != ADD && cmd_in != SUB);
      item resp using ignore = (resp != 1 && resp != 2);
      cross cmd_in, resp;
   };

   event shift_response;

   cover shift_response is {
      item cmd_in using ignore = (cmd_in != SHL && cmd_in != SHR);
      item resp using ignore = (resp != 1);
      cross cmd_in, resp;
   };

   event invalid_opcode_response;

   cover invalid_opcode_response is {
      item cmd_in using ignore = (cmd_in == NOP || cmd_in == ADD || cmd_in == SUB || cmd_in == SHL || cmd_in == SHR);
      item resp using ignore = (resp != 2);
      cross cmd_in, resp;
   };

   event ADD_corner_cases;

   cover ADD_corner_cases is {
      item cmd_in using ranges = {range([ADD])};
      item din1 using ranges = {range([0..2])};
      item din2 using ranges = {range([0..2])};
      cross cmd_in, din1, din2;
   };



}; // extend instruction_s

extend driver_u {

   collect_response(ins : instruction_s) @clk is also {

      emit ins.instruction_complete;
      emit ins.add_sub_response;
      emit ins.shift_response;
      emit ins.invalid_opcode_response;
      emit ins.ADD_corner_cases;

   };

}; // extend driver_u

'>

