//timescale
`timescale 10 ns / 1 ns
`define CLK_PERIOD 2
`define NUM_BITS 7
module tb_up_down_counter();
parameter WIDTH = `NUM_BITS;
parameter CLOSE_TO_MAX = (2**`NUM_BITS) - 3;
parameter MAX = (2**`NUM_BITS)-1;
reg [WIDTH-1:0] COUNT;
reg  EN;
reg CLK;
reg DIR;
reg RST_N;

up_down_counter #(.WIDTH(WIDTH)) UUT (COUNT,EN,CLK,DIR,RST_N);


initial CLK = 1'b1;
always #(`CLK_PERIOD/2) CLK = ~CLK;
initial $monitor("%d COUNT = %d CLK = %b DIR = %b EN = %b RST_N = %b", $time, COUNT,CLK,DIR,EN,RST_N);

initial begin
	$vcdpluson();
	#(`CLK_PERIOD/2)
			RST_N = 1'b0;
			EN = 1'b1;
			DIR = 1'b1;
	#`CLK_PERIOD
			RST_N = 1'b1;
	#(`CLK_PERIOD*4)
			force UUT.COUNT = CLOSE_TO_MAX;
			$write("\t\tForce");
			$display("%0d to get to max (%0d) saturation quicker", CLOSE_TO_MAX, MAX);
	#(`CLK_PERIOD/2)		
			release UUT.COUNT;
	#(`CLK_PERIOD*`NUM_BITS+2) 	
			DIR = 1'b0;
	#(`CLK_PERIOD*2)
			force UUT.COUNT = 3;
			$display("\t\tForce 3 to get to min saturation quicker");
	#(`CLK_PERIOD/2)
			release UUT.COUNT;
	#(`CLK_PERIOD*5)
			$finish;
end

endmodule
