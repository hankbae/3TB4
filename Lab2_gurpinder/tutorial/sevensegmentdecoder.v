module sevensegmentdecoder(
     in,
     hex_LEDs
    );
     
     //Declare inputs,outputs and internal variables.
     input [3:0] in;
     output [6:0] hex_LEDs;
     reg [6:0] hex_LEDS;

//always block for converting bcd digit into 7 segment format
    always @(in)
    begin
        case (in) //case statement
            0 : hex_LEDS <= 7'b0000001;
            1 : hex_LEDS <= 7'b1001111;
            2 : hex_LEDS <= 7'b0010010;
            3 : hex_LEDS <= 7'b0000110;
            4 : hex_LEDS <= 7'b1001100;
            5 : hex_LEDS <= 7'b0100100;
            6 : hex_LEDS <= 7'b0100000;
            7 : hex_LEDS <= 7'b0001111;
            8 : hex_LEDS <= 7'b0000000;
            9 : hex_LEDS <= 7'b0000100;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : hex_LEDS = 7'b1111111; 
        endcase
    end
    
endmodule