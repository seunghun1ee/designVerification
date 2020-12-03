
   Sample driver.e file
   --------------------
   This file provides the basic structure for the calc1 testbench 
   driver. 

   The driver interacts directly with the DUV by driving test data into
   the DUV and collecting the response from the DUV. It also invokes the
   instruction specific response checker. 

<'


unit driver_u {
	
	port_num : int;

   clk_p : inout simple_port of bit is instance; // can be driven or read by sn
   keep clk_p.hdl_path() == "~/calc1_sn/c_clk";

   reset_p : out simple_port of uint(bits:7) is instance; // driven by sn
   keep reset_p.hdl_path() == "~/calc1_sn/reset";

   req_cmd_in_p : out simple_port of uint(bits:4) is instance; // driven by sn

   req_data_in_p : out simple_port of uint(bits:32) is instance; // driven by sn

   out_resp_p : in simple_port of uint(bits:2) is instance; // read by sn

   out_data_p : in simple_port of uint(bits:32) is instance; // read by sn
  

   instructions_to_drive : list of instruction_s;


   event clk is fall(clk_p$)@sim;
   event resp is change(out_resp_p$)@sim;


   drive_reset() @clk is {
      var i : int;

      for { i=0; i<=8; i+=1 } do {

         reset_p$ = 1111111;
         wait cycle;

      }; // for

      reset_p$ = 0000000;

   }; // drive_reset


   drive_instruction(ins : instruction_s, i : int) @clk is {

      // display generated command and data
      outf("Command %s at port %d = %s\n", i, port_num, ins.cmd_in);
      out("Op1     = ", ins.din1);
      out("Op2     = ", ins.din2);
      out();

      // drive data into calculator port 1
      req_cmd_in_p$  = pack(NULL, ins.cmd_in);
      req_data_in_p$ = pack(NULL, ins.din1);
         
      wait cycle;

      req_cmd_in_p$  = 0000;  
      req_data_in_p$ = pack(NULL, ins.din2);
         
   }; // drive_instruction


   collect_response(ins : instruction_s) @clk is {

      wait @resp; -- wait for the response
         
      ins.resp = out_resp_p$;
      ins.dout = out_data_p$;

   }; // collect_response


   drive() @clk is {

      drive_reset();

      for each (ins) in instructions_to_drive do {
       
         drive_instruction(ins, index);
			if ins.cmd_in == (0).as_a(opcode_t) {
            //For NOP, throw error if there's any response in 4 cycles
				first of {
					{collect_response(ins); ins.check_response(ins, port_num)};
					{wait [4] * cycle}
				}; //first of
			} else {
            //For all other opcodes, throw error after 16 cycles without response
            first of {
               {wait [16] * cycle;
                  dut_error(appendf("[R==>Port %d no response for.<==R]\n \
                          Instruction %s %u %u,\n",
								  port_num, 
                          ins.cmd_in, ins.din1, ins.din2))};
               {collect_response(ins); ins.check_response(ins, port_num)}
            }; //first of
		      wait cycle;
			}; //if ins.cmd_in == NOP

      }; // for each instruction

      wait [10] * cycle;
      stop_run();

   }; // drive


   run() is also {
      start drive();        // spawn
   }; // run

}; // unit driver_u


'>

