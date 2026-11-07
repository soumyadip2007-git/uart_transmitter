module uart_tx_top #(
    parameter integer CLOCK_FREQ      = 100_000_000,
    parameter integer BAUD            = 9600,
    parameter integer DEBOUNCE_CYCLES = 1_000_000
) (
    input btnC,
    input clk,
    output RsTx
);

    localparam [1:0] TX_WAIT_BTN  = 2'b00, // Used to define a state when button is not pressed
                     TX_SEND_CHAR = 2'b01,  // State when button has been pressed
                     TX_SEND_WAIT = 2'b10; // Waiting period after the button press

    reg [1:0] state = TX_WAIT_BTN;
    wire uart_ready;
    reg uart_send = 1'b0;
    reg [7:0] uart_data = 8'd0;
    reg [7:0] next_char = 8'd65; // ASCII 'A'

    wire btn_debounced;
    reg btn_prev = 1'b0;

    uart_tx_ctrl #(
        .CLOCK_FREQ(CLOCK_FREQ),
        .BAUD(BAUD)
    ) TX (
        .clk(clk),
        .send(uart_send),
        .data(uart_data),
        .ready(uart_ready),
        .uart_tx(RsTx)
    );

    debounce #(
        .DELAY_CYCLES(DEBOUNCE_CYCLES)
    ) dbc (
        .clk(clk),
        .btn(btnC),
        .btn_clr(btn_debounced)
    );

    always @(posedge clk) begin
        btn_prev <= btn_debounced;

        case (state)
            TX_WAIT_BTN: begin
                uart_send <= 1'b0;
                if (!btn_prev && btn_debounced) begin // Button has been pressed
                    uart_data <= next_char;
                    next_char <= next_char + 1'b1;
                    state <= TX_SEND_CHAR;
                end
            end

            TX_SEND_CHAR: begin
                uart_send <= 1'b1;
                state <= TX_SEND_WAIT;
            end

            TX_SEND_WAIT: begin
                if (!uart_ready)
                    uart_send <= 1'b0; // if the FSM is not in IDLE state, uart_send will be 0

                if (uart_ready && !uart_send)
                    state <= TX_WAIT_BTN;  // It is the waiting phase for next button press
            end

            default: begin
                state <= TX_WAIT_BTN;
                uart_send <= 1'b0;
            end
        endcase
    end

endmodule
