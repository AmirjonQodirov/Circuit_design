`timescale 1ns / 1ps

module test;

reg reset_reg, clk_reg;
wire clk, reset;

reg [15:0] sw;
wire busy;
wire [10:0] y_bo;

main main(
	.clk_i(clk_reg),
	.rst_i(reset),
	.sw_i(sw),
	.busy_out(busy),
	.y_out(y_bo)
);

assign reset = reset_reg;
assign clk = clk_reg;

initial begin
	clk_reg = 1;
	forever
		#10 clk_reg = ~clk_reg;
end

initial begin
	sw <= 65530;
	reset_reg <= 1;
end

always @(posedge clk_reg) begin
	if (reset_reg) begin
		reset_reg = 0;
	end

	if (!busy) begin
		$display("3*%d + 2*cbrt(%d) = %d", sw[15:8], sw[7:0], y_bo);
		
		if (!reset_reg) begin
			sw <= sw + 1;
			reset_reg <= 1;
		end
	end
end

endmodule