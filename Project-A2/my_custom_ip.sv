`timescale 1 ps / 1 ps
module my_custom_ip(
		output reg [7:0]   LED,            
		input  wire        clock,                  
		input  wire        reset,                  
		input  wire [7:0]  address,   
		input  wire        read,      
		output reg [31:0]  readdata,  
		input  wire        write,     
		input  wire [31:0] writedata  
	);
	
	logic			enable ; 
	logic [31:0]	duty_cycle; // new 31 byte 
	logic [31:0] 	period; 	 // new 31 byte 
	logic [31:0]	compteur;	 
	logic [31:0]	led;		// new 31 byte 
	

   always_ff @(posedge clock) 
	begin
		if (write) begin //data recovery	
				 if 	   (address == 8'd0) enable	   <= writedata[0];
		    else if 	   (address == 8'd1) duty_cycle	   <= writedata[31:0];
			else if	(address == 8'd2) period		<= writedata[31:0];
			else if	(address == 8'd3) led		   <= writedata[31:0];
		end
	end		
	
	always_ff @(posedge clock) // send a duty_cycle which will allow us to read it
	if(read) readdata <= {28'b0, duty_cycle};
	else     readdata <= 32'b0;
	
	always_ff @(posedge clock)
	begin
		if(!reset) begin //reset to 0 when key is pressed [0]
			LED	   <= 8'b0;
			compteur	<= 32'b0;
		end
		
		if ( enable == 1'b1 )

			begin
		
				if (compteur <= period) 
				begin
					compteur <= compteur + 1;
				end
				
				else 
				begin
				compteur <= 32'b0;
				end
				
				
				if (compteur <= duty_cycle*period/15)  
				begin
				LED <= led[7:0];// we apply the pwm on the led concerned
				end
				
			   else LED <= 8'b0;
			end
			
	end
	

endmodule
	