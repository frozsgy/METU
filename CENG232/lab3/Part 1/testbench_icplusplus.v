`timescale 1ns / 1ps

module testbench_icplusplus;

	// Inputs
	reg d0;
	reg f0;
	reg d1;
	reg f1;
	reg clk;

	// Outputs
	wire q0;
	wire q1;
	wire y;

	// Instantiate the Unit Under Test (UUT)
	ic1500 uut (
		.d0(d0), 
		.f0(f0), 
		.d1(d1), 
		.f1(f1), 
		.clk(clk), 
		.q0(q0), 
		.q1(q1), 
		.y(y)
	);
    // At 5, 15, 25, .. clk will change 1->0 
    // At 10, 20, 30, .. clk will change 0->1
    initial clk = 1;
	always #5 clk = ~clk;
    
	initial begin
		// Initialize Inputs
		d0 = 0;
		f0 = 0;
		d1 = 0;
		f1 = 0;

		// Wait 5 ns for global reset to finish
		#5;
        
		// Add stimulus here
		
	end
      
endmodule


