module predictor(
    input wire request,
    input wire result,
    input wire clk,
    input wire taken,
    output reg prediction
);

reg [1:0] count;

always @(negedge clk) begin
    if (result) begin
        if (taken) begin
            if (count < 2'b11) begin
                count <= count + 1;
            end else begin
                count <= 2'b11;
            end
        end else begin
            if (count > 2'b00) begin
                count <= count - 1;
            end else begin
                count <= 2'b00;
            end
        end
    end
end

always @(negedge clk) begin
    if (request) begin
        if (count == 2'b11 || count == 2'b10) begin
            prediction <= 1'b1;
        end else begin
            prediction <= 1'b0;
        end
    end
end

endmodule
