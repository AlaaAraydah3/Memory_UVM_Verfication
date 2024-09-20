module mem (intf in1);         // Passing the interface to the module

  logic [31:0] memory [15:0];  // Memory array

  always @(posedge in1.clk ) begin
        if (in1.rst) begin
		
            in1.Valid_out <= 1'bx;
            in1.Data_out  <= 32'bx;
        
        end else if (in1.En && in1.Rr_en) begin
            // Read operation
            in1.Valid_out <= 1;
            in1.Data_out  <= memory[in1.Address];
       
        end else if (in1.En && in1.Rw_en) begin
            // Write operation
            memory[in1.Address]  <= in1.Data_in;
            in1.Valid_out        <= 0; 
        end
    end
endmodule
