
   Sample calc1_sn_env.e file
   --------------------------
   This file provides the basic structure for the calc1 
   testbench environment.

   It extends sys by the unit driver, and extends the default setup and run
   methods. It also extends the dut_error_struct.

<'

import instruction;       //  pull in instruction data structure definitions
import driver;            //  pull in driver definitions
import test_example;      //  pull in current test data
import coverage;          //  pull in coverage metric and collection events

extend sys {

   drivers : list of driver_u is instance;
   keep drivers.size() == 4;
   keep for each in drivers {
		.port_num == index + 1;
      .finished == FALSE;
      .req_cmd_in_p.hdl_path() == appendf("~/calc1_sn/req%d_cmd_in",index + 1);
      .req_data_in_p.hdl_path() == appendf("~/calc1_sn/req%d_data_in",index + 1);
      .out_resp_p.hdl_path() == appendf("~/calc1_sn/out_resp%d",index + 1);
      .out_data_p.hdl_path() == appendf("~/calc1_sn/out_data%d",index + 1);
   };



   setup() is also {

      set_check("...", ERROR_CONTINUE);   // don't quit the simulation on error

   };

   post_generate() is also {
		for each in drivers {
         .instructions_to_drive.add(.test_3_1);
			.instructions_to_drive.add(.test_3_2a);
         .instructions_to_drive.add(.test_3_2b);
         .instructions_to_drive.add(.test_3_3);
         .instructions_to_drive.add(.test_3_4a);
         .instructions_to_drive.add(.test_3_4b);
         .instructions_to_drive.add(.test_3_5);
         .instructions_to_drive.add(.test_3_6a);
         .instructions_to_drive.add(.test_3_6b);

         .instructions_to_drive.add(.test_4_1);
         .instructions_to_drive.add(.test_4_2);
         .instructions_to_drive.add(.test_4_3);
         .instructions_to_drive.add(.test_4_4);
         .instructions_to_drive.add(.test_4_5);
         .instructions_to_drive.add(.test_4_6);
         .instructions_to_drive.add(.test_4_7);
         .instructions_to_drive.add(.test_4_8a);
         .instructions_to_drive.add(.test_4_8b);
         .instructions_to_drive.add(.test_4_9);

         .instructions_to_drive.add(.test_5_1);
         .instructions_to_drive.add(.test_5_1a);
         .instructions_to_drive.add(.test_5_2);
         .instructions_to_drive.add(.test_5_2a);
         .instructions_to_drive.add(.test_5_3);
         .instructions_to_drive.add(.test_5_3a);
         .instructions_to_drive.add(.test_5_4);
         .instructions_to_drive.add(.test_5_4a);
		}
   };


   run() is also {

     simulator_command("probe -create -shm -all -depth all"); 

   };


}; // extend sys

// extend the error handling struct

extend dut_error_struct {
   write() is only {
      out("DUT error at time ", sys.time);
      out(message);
   }; // write() is only
}; // extend dut_error

'>

