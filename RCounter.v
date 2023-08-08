module RCounter(
    input clk,        // Clock input
    input arst,      // Asynchronous active low reset
    input en,     // Enable input
    output flag,  // Output flag indicating count reaching 10
    output reg [3:0] count // Output count (4-bit counter)
);

always @(posedge clk or negedge arst) begin
    if (!arst) begin
        // Asynchronous reset
        count <= 4'b0001; // Reset the counter to 0
    end
    else if (en) begin
        // Increment the counter if enable signal is high and not at 10
        if (count < 4'b1010)
            count <= count + 1;
        else
            count <= 4'b0001; // Start Over
    end
end

    // Set the flag when count reaches 10
    assign flag = (count == 4'b1010);
endmodule
