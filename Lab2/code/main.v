`timescale 1ns / 1ps

module main(
	input rst_i,
	input clk_i,
	input [7 : 0] a_in,
	input [7 : 0] b_in,
	output busy_out,
	output reg [15 : 0] y_out
);

    reg [7 : 0] a, b, x;
    reg [1 : 0] state, state_next;

    localparam IDLE = 3'b000;
    localparam WORK1 = 3'b001;
    localparam WORK2 = 3'b010;
    localparam WORK3 = 3'b011;
    localparam WORK4 = 3'b100;

    wire [2:0] cbrt1_out;
    reg cbrt1_reset;
    wire cbrt1_busy;

    cbrt cbrt1(
        .clk_i(clk_i),
        .rst_i(cbrt1_reset),
        .a_bi(b),
        .busy_o(cbrt1_busy),
        .y_bo(cbrt1_out)
    );

    wire [15:0] mult1_out;
    reg mult1_reset;
    wire mult1_busy;

    mult mult1(
    	.clk_i(clk_i),
    	.rst_i(mult1_reset),
    	.a_bi(3),
    	.b_bi(a),
    	.busy_o(mult1_busy),
    	.y_bo(mult1_out)
    );
    wire [15:0] mult2_out;
    reg mult2_reset;
    wire mult2_busy;

    mult mult2(
    	.clk_i(clk_i),
    	.rst_i(mult2_reset),
    	.a_bi(2),
    	.b_bi(x),
    	.busy_o(mult2_busy),
    	.y_bo(mult2_out)
    );
    
 

    assign busy_out = rst_i | (state != 0);

    always @(posedge clk_i) 
        if (rst_i) begin
            state <= WORK1;
        end else begin
            state <= state_next;
        end
        
    always @* begin
        case(state)
            IDLE: state_next = IDLE;
            WORK1: state_next = WORK2 ;
            WORK2: state_next = (mult1_busy | cbrt1_busy | mult2_busy) ? WORK2 : WORK3;
            WORK3: state_next = IDLE;
        endcase
    end

    always @(posedge rst_i) begin
    end

    always @(posedge clk_i) begin
        if (rst_i) begin
            a <= a_in;
            b <= b_in;
            x <= cbrt1_out;
            y_out <= 0;
            mult1_reset <= 0;
            mult2_reset <= 0;
            cbrt1_reset <= 0;
        end else begin
            case (state)
                IDLE:
                    begin
                        y_out <= mult2_out + mult1_out;
                    end
                WORK1:
                    begin
                        mult1_reset <= 1;
                        mult2_reset <= 1;
                        cbrt1_reset <= 1;
                    end
                WORK2:
             
                    begin
                        if (cbrt1_busy) begin
                            cbrt1_reset <= 0;
                        end
                        if (mult1_busy) begin
                            mult1_reset <= 0;
                        end
                        if (mult2_busy) begin
                            mult2_reset <= 0;
                        end
                    end
                WORK3:
                    begin
                        y_out <= mult1_out + mult2_out;
                    end
              
            endcase
        end
    end

endmodule