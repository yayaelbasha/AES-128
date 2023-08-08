module Reg128(
	input clk, rst, en, 
	input [7:0] in [0:3] [0:3], 
	output reg [7:0] out [0:3] [0:3]
	);
	always@(posedge clk or negedge rst) begin
		if (!rst)
			for (int i = 0 ; i < 4 ; i = i + 1) 
			begin
				for (int j = 0 ; j < 4 ; j = j + 1) 
				begin
					out[i][j] <= 8'd0;
				end
			end
		else if (en)
			for (int i = 0 ; i < 4 ; i = i + 1) 
			begin
				for (int j = 0 ; j < 4 ; j = j + 1) 
				begin
					out[i][j] <= in[i][j];
				end
			end
	end	
endmodule