`timescale 1ns / 1ps 
module lab3_2(
            input[3:0] number,
            input CLK, 
            input selection,
            input mode,
            input clear,
            output reg [7:0] digit1,
            output reg [7:0] digit0,
            output reg [7:0] count1,
            output reg [7:0] count0,
            output reg warning
    );
   //Modify the lines below to implement your design .
    reg[7:0] count1p, count0p, count1n, count0n;
    initial begin
        digit1 = 8'b0;
        digit0 = 8'b0;
        count1 = 8'b0;
        count0 = 8'b0;
        warning = 1'b0;
        count0p = 8'b0;
        count1p = 8'b0;
        count0n = 8'b0;
        count1n = 8'b0;
    end
    always @(posedge CLK)
    begin
        if((clear))
        begin
            digit1 <= 8'b0;
            digit0 <= 8'b0;
            count1 <= 8'b0;
            count0 <= 8'b0;
            warning <= 1'b0;
            count0p <= 8'b0;
            count1p <= 8'b0;
            count0n <= 8'b0;
            count1n <= 8'b0;
        end
        else 
        begin
            //here is where we do stuff
            if(~(selection))
            begin
                //we got prime input
                if((number == 4'd2) || (number == 4'd3) || (number == 4'd5) || (number == 4'd7) || (number == 4'd11) || (number == 4'd13)) 
                begin
                    // good, we have a prime
                    warning = 0;
                    count1 = count1p;
                    count0 = count0p;
                    if(~(mode))
                    begin
                        //previous
                        digit0 <= number;
                        case (number)
                          4'd2 : digit1 <= 4'd13;
                          4'd3 : digit1 <= 4'd2;
                          4'd5 : digit1 <= 4'd3;
                          4'd7 : digit1 <= 4'd5;
                          4'd11 : digit1 <= 4'd7;
                          4'd13 : digit1 <= 4'd11;
                        endcase
                        count0p = (count0p + 1) % 10;
                        count0 <= count0p;
                    end
                    else
                    begin
                        //next
                        digit0 <= number;
                        case (number)
                          4'd2 : digit1 <= 4'd3;
                          4'd3 : digit1 <= 4'd5;
                          4'd5 : digit1 <= 4'd7;
                          4'd7 : digit1 <= 4'd11;
                          4'd11 : digit1 <= 4'd13;
                          4'd13 : digit1 <= 4'd2;
                        endcase
                        count1p = (count1p + 1) % 10;
                        count1 <= count1p;
                    end
                end
                else 
                begin
                    //we got a non prime, throw errors
                    warning <= 1;
                end
            end
            else
            begin
                //we got non prime input
                if((number != 4'd2) && (number != 4'd3) && (number != 4'd5) && (number != 4'd7) && (number != 4'd11) && (number != 4'd13)) 
                begin
                    // good, we have non prime
                    warning = 0;
                    count0 = count0n;
                    count1 = count1n;
                    if(~(mode))
                    begin
                        //shift right
                        digit0 <= number;
                        case (number)
                          4'd1 : digit1 <= 4'd0;
                          4'd4 : digit1 <= 4'd2;
                          4'd6 : digit1 <= 4'd3;
                          4'd8 : digit1 <= 4'd4;
                          4'd9 : digit1 <= 4'd4;
                          4'd10 : digit1 <= 4'd5;
                          4'd12 : digit1 <= 4'd6;
                          4'd14 : digit1 <= 4'd7;
                          4'd15 : digit1 <= 4'd7;
                        endcase
                        count0n = (count0n + 1) % 10;
                        count0 <= count0n;
                    end
                    else
                    begin
                        //shift left
                        digit0 <= number;
                        case (number)
                          4'd1 : digit1 <= 4'd2;
                          4'd4 : digit1 <= 4'd8;
                          4'd6 : digit1 <= 4'd12;
                          4'd8 : digit1 <= 4'd0;
                          4'd9 : digit1 <= 4'd2;
                          4'd10 : digit1 <= 4'd4;
                          4'd12 : digit1 <= 4'd8;
                          4'd14 : digit1 <= 4'd12;
                          4'd15 : digit1 <= 4'd14;
                        endcase
                        count1n = (count1n + 1) % 10;
                        count1 <= count1n;
                    end
                end
                else 
                begin
                    //we got a prime, throw errors
                    warning <= 1;
                end
                
            end
        end
    end
endmodule