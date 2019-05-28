`timescale 1ns / 1ps

module df(
    input d,
    input f,
    input clk,
    output reg q
    );
    
    initial begin
        q = 0;
    end
    
    // write your code here

    always @(posedge clk)
    begin
        if((~d) && (~f)) q <= 1;
        else if((~d) && (f)) q <= q;
        else if((d) && (~f)) q <= 0;
        else  q <= ~q;
    end


endmodule


module icplusplus(
    input d0,
    input f0,
    input d1,
    input f1,
    input clk,
    output q0,
    output q1,
    output y
    );
    
    df dfa(d0, f0, clk, q0);
    df dfb(d1, f1, clk, q1);
    assign y = ~(q0 ^ q1);
    
    
endmodule
