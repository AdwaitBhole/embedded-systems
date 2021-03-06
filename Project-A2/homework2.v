
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module homework2(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	LED,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// Accelerometer //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT 
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;

//////////// LED //////////
output		     [7:0]		LED;

//////////// KEY //////////
input 		     [1:0]		KEY;

//////////// SW //////////
input 		     [3:0]		SW;

//////////// Accelerometer //////////
output		          		G_SENSOR_CS_N;
input 		          		G_SENSOR_INT;
output		          		I2C_SCLK;
inout 		          		I2C_SDAT;


//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================
	hm2_1 u0 (
		.acc_external_connection_export       (G_SENSOR_INT),       //         acc_external_connection.export
		.button_external_connection_export    (KEY[1]),    //      button_external_connection.export
		.clk_clk                              (CLOCK_50),                              //                             clk.clk
		.my_custom_ip_0_conduit_end_export    (LED),    //      my_custom_ip_0_conduit_end.export
		.reset_reset_n                        (KEY[0]),                        //                           reset.reset_n
		.switches_external_connection_export  (SW),  //    switches_external_connection.export
		.terasic_spi_3wire_0_conduit_end_SDIO (I2C_SDAT), // terasic_spi_3wire_0_conduit_end.SDIO
		.terasic_spi_3wire_0_conduit_end_SCLK (I2C_SCLK), //                                .SCLK
		.terasic_spi_3wire_0_conduit_end_CS_n (G_SENSOR_CS_N) //                                .CS_n
	);
endmodule
