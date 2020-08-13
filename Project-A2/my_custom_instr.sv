// new_component.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module my_custom_instr (
		input  wire [31:0] ncs_cis0_dataa,  // ncs_cis0.dataa
		output wire [31:0] ncs_cis0_result  //         .result
	);

	// TODO: Auto-generated HDL template
	
	logic [7:0] led;
     //on fonction de l'inclinaison on va allumer une led ou une autre 
	  always_comb begin 
		 if     (ncs_cis0_dataa < 32'd66)  led <= 8'b10000000;
		 else if(ncs_cis0_dataa < 32'd132) led <= 8'b01000000;
		 else if(ncs_cis0_dataa < 32'd198) led <= 8'b00100000;
		 else if(ncs_cis0_dataa < 32'd264) led <= 8'b00010000;
		 else if(ncs_cis0_dataa < 32'd330) led <= 8'b00001000;
		 else if(ncs_cis0_dataa < 32'd396) led <= 8'b00000100;
		 else if(ncs_cis0_dataa < 32'd462) led <= 8'b00000010;
		 else                              led <= 8'b00000001;
		end
		
	assign ncs_cis0_result = {24'b0,led}; // on envoie la led a allumer dans le output les valeur des led se trouve dans les 8 dernier bits

endmodule
