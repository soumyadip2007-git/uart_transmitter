module debounce #(
    parameter integer DELAY_CYCLES = 1_000_000
) (
    input clk,
    input btn,
    output reg  btn_clr = 1'b0
);

    integer count = 0;
    reg xnew = 1'b0;

    always @(posedge clk) begin
        if (btn != xnew) begin
            xnew  <= btn;
            count <= 0;
        end
        else if (count < DELAY_CYCLES) begin
            count <= count + 1;
        end
        else begin
            btn_clr <= xnew;      // After the specific delay cycle the btn_clr gets updated
        end
    end

endmodule
