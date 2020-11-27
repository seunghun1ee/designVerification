
   Sample instruction.e file
   -------------------------
   This file provides the basic structure for the calc1 design instructions
   and also an example response checker for ADD instructions.

<'

type opcode_t : [ NOP, ADD, SUB, INV, INV1, SHL, SHR, INV2, INV3, INV4, INV5, INV6, INV7, INV8, INV9, INV10 ] (bits:4);


struct instruction_s {

   %cmd_in : opcode_t;
   %din1   : uint (bits:32);
   %din2   : uint (bits:32);

   !resp   : uint (bits:2);
   !dout   : uint (bits:32);

   check_response(ins : instruction_s) is empty;

}; // struct instruction_s


extend instruction_s {

   //No op checking
   when NOP'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 00 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %d %d,\n \
                          expected response 0,\n \
                          received response %d.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %d %d,\n \
                          expected 0,\n \
                          received %032.32b \t %d.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

   // example check for correct addition
   when ADD'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

      if ins.din1 + ins.din2 < ins.din1 || ins.din1 + ins.din2 < ins.din2 then {  //If overflow
        check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));
      } else { 
       check that ins.resp == 01 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 1,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));
      }; // if overflow else
       check that ins.dout == (ins.din1 + ins.din2) else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected %032.32b \t %u,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          (ins.din1 + ins.din2),
                          (ins.din1 + ins.din2), 
                          ins.dout,ins.dout));



     }; // check_response

   }; // when 

   // Subtraction check
   when SUB'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       if ins.din1 - ins.din2 > ins.din1 then { //if underflow
        check that ins.resp == 02 else
        dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                           Instruction %s %u %u,\n \
                           expected response 2,\n \
                           received response %u.\n", 
                           ins.cmd_in, ins.din1, ins.din2, 
                           ins.resp));
       } else {
       check that ins.resp == 01 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %d %d,\n \
                          expected response 1,\n \
                          received response %d.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));
       }; // if underflow else
       check that ins.dout == (ins.din1 - ins.din2) else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected %032.32b \t %u,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          (ins.din1 - ins.din2),
                          (ins.din1 - ins.din2), 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

   // Shift left check
   when SHL'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 01 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 1,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

        if ins.din2 <= 32 then {
        check that ins.dout == (ins.din1 << ins.din2) else
        dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                            Instruction %s %032.32b (%u) %u,\n \
                            expected %032.32b \t %u,\n \
                            received %032.32b \t %u.\n", 
                            ins.cmd_in, ins.din1, ins.din1, ins.din2, 
                            (ins.din1 << ins.din2),
                            (ins.din1 << ins.din2), 
                            ins.dout,ins.dout));
        } else {
          check that ins.dout == 0 else
          dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                              Instruction %s %032.32b (%u) %u,\n \
                              expected %032.32b \t %u,\n \
                              received %032.32b \t %u.\n", 
                              ins.cmd_in, ins.din1, ins.din1, ins.din2, 
                              0,
                              0, 
                              ins.dout,ins.dout));
        }; // if ins.din2 <= 32 else

     }; // check_response

   }; // when

   // Shift right check
   when SHR'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 01 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 1,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));
      if ins.din2 <= 32 then {
       check that ins.dout == (ins.din1 >> ins.din2) else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %032.32b (%u) %u,\n \
                          expected %032.32b \t %u,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din1, ins.din2, 
                          (ins.din1 >> ins.din2),
                          (ins.din1 >> ins.din2), 
                          ins.dout,ins.dout));
      } else {
        check that ins.dout == 0 else
        dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                            Instruction %s %032.32b (%u) %u,\n \
                            expected %032.32b \t %u,\n \
                            received %032.32b \t %u.\n", 
                            ins.cmd_in, ins.din1, ins.din1, ins.din2, 
                            0,
                            0, 
                            ins.dout,ins.dout));
      }; // if ins.din2 <= 32 else

     }; // check_response

   }; // when

   //Invalid command check
   when INV'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

   //Invalid command check
   when INV1'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV2'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV3'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV4'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV5'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV6'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV7'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV8'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV9'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when

	//Invalid command check
   when INV10'cmd_in instruction_s { 

     check_response(ins : instruction_s) is only {

       check that ins.resp == 02 else
       dut_error(appendf("[R==>Port 1 invalid response output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected response 2,\n \
                          received response %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.resp));

       check that ins.dout == 0 else
       dut_error(appendf("[R==>Port 1 invalid data output.<==R]\n \
                          Instruction %s %u %u,\n \
                          expected 0,\n \
                          received %032.32b \t %u.\n", 
                          ins.cmd_in, ins.din1, ins.din2, 
                          ins.dout,ins.dout));

     }; // check_response

   }; // when


}; // extend instruction_s


'>

