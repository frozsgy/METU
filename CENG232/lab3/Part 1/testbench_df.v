`timescale 1ns / 1ps

module testbench_df;

	// Inputs
	reg d;
	reg f;
	reg clk;

	// Outputs
	wire q;

	// Instantiate the Unit Under Test (UUT)
	df uut (
		.d(d), 
		.f(f), 
		.clk(clk), 
		.q(q)
	);
    
    // At 5, 15, 25, .. clk will change 1->0 
    // At 10, 20, 30, .. clk will change 0->1
   initial clk = 1;
	always #5 clk = ~clk;

	initial begin
        // set monitor to inputs and outputs
		$monitor("Time=%t | d=%b f=%b | q=%b", $time, d, f, q);
        
		// Initialize Inputs
		d = 0;
		f = 0;

		// Wait 5 ns for global reset to finish
		#5;
        
		// Add stimulus here
        
      d = 1; f = 1;
		#10; // Wait for clock edge
		if (q != 0) $display("Value of q after d=1 f=1 is wrong");
		else $display("Successful");
		#10; // Wait for clock
		$finish;
        
	end
      
endmodule
