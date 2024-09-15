module mem (
    input logic clk, rst, En,
    input logic [3:0] Address,
    input logic [31:0] Data_in,
    input logic Rw_en,
    input logic Rr_en,
    output logic [31:0] Data_out,
    output logic Valid_out
    );
    
    logic [31:0] memory [15:0];

  always @( posedge clk  ) begin
        if (rst) begin
            Valid_out <= 1'bx ;
            Data_out  <= 32'bx;
		
        end else if (En && Rr_en) begin
            // Read operation
            Valid_out <= 1'b1;
            Data_out  <= memory[Address];
		
        end else if (En && Rw_en) begin
            // Write operation
            memory[Address] <= Data_in;
            Valid_out       <= 1'b0   ; 
        end 
    end
endmodule
