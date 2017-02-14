//timescale
`timescale 1 ns / 1 ns

//module NAME #(parameters) (direction type size portname);
module up_down_counter #(parameter WIDTH=4)
(output reg [WIDTH-1:0] COUNT,
input EN,
input CLK,
input DIR,
input RST_N);


//Behavioral
always_ff @(posedge CLK, negedge RST_N) begin
	if (!RST_N)
		COUNT <= '0;
	else if (EN)
		//if (DIR && COUNT < 2**WIDTH-1) COUNT <= COUNT + 1;
		if (DIR && !(&COUNT)) COUNT <= COUNT + 1;
		else if (!DIR && COUNT > 0) COUNT <= COUNT - 1;
	else
		COUNT <= COUNT;
end

endmodule
