//`timescale 1 ps / 1 ps
module my_custom_ip(
		output reg [7:0]  LED,            
		input  wire        clock,                  
		input  wire        reset,                  
		input  wire [7:0]  address,   
		input  wire        read,      
		output reg [31:0] readdata,  
		input  wire        write,     
		input  wire [31:0] writedata  
	);
	
	logic 			enable; 
	logic [3:0]		duty_cycle; 
	logic [31:0] 	period; 
	logic [31:0]	compteur;

   always_ff @(posedge clock) 
	begin
		if (write) begin //data recovery
			if 		(address == 8'd0) enable      <= writedata[0];	
			else if 	(address == 8'd1) duty_cycle	<= writedata[3:0];
			else if	(address == 8'd2) period		<= writedata[31:0];
		end
	end		
	
	always_ff @(posedge clock) //send a duty_cycle which will allow us to read it
	if(read) readdata <= {28'b0, duty_cycle};
	else     readdata <= 32'b0;
	
	always_ff @(posedge clock)
	begin
		if(!reset) begin //reset to 0 when key is pressed [0]
			LED	   <= 8'b0;
			compteur	<= 32'b0;
		end
		
		else begin
		
			if (enable) begin // when KEY [1] release then we apply the duty_cycle on the led
				if (compteur <= period) compteur <= compteur + 1;
				else compteur <= 32'b0;
				if (compteur <= duty_cycle*period/15) LED <= 8'b11111111;
				else LED <= 8'b0;
			end
			
			else LED <= 8'b0; //otherwise the leds are out
			
		end
	end
	

endmodule
	