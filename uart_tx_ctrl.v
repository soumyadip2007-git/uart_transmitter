module uart_tx_ctrl #(
    parameter integer CLOCK_FREQ = 100_000_000,
    parameter integer BAUD       = 9600
) (
    input  clk,
    input  send,
    input [7:0] data,
    output ready,
    output uart_tx
);

    localparam integer BAUD_TIMER = CLOCK_FREQ / BAUD;
    localparam [1:0] RDY      = 2'b00,
                     LOAD_BIT = 2'b01,
                     SEND_BIT = 2'b10;

    reg [1:0] state = RDY;
    reg [31:0] timer = 0;          // It accomodates the timer control
    reg [9:0] txdata = 10'b1111111111; // it stores the signal with start and stop bit
    reg [3:0] bit_index = 0;      // It is used to pass the bits one by one by incrementing the index
    reg tx_bit = 1'b1;

    always @(posedge clk) begin
        case (state)
            RDY: begin
                timer     <= 0;
                bit_index <= 0;
                tx_bit    <= 1'b1;
                if (send) begin
                    // LSB is transmitted first: start, 8 data bits, stop.
                    txdata <= {1'b1, data, 1'b0};
                    state  <= LOAD_BIT;
                end
            end

            LOAD_BIT: begin
                tx_bit <= txdata[bit_index];
                timer  <= 0;
                state  <= SEND_BIT;
            end

            SEND_BIT: begin
                if (timer >= BAUD_TIMER - 1) begin
                    timer <= 0;
                    if (bit_index == 4'd9) begin
                        state <= RDY;
                    end
                    else begin
                        bit_index <= bit_index + 1'b1;
                        state <= LOAD_BIT;
                    end
                end
                else begin
                    timer <= timer + 1'b1;
                end
            end

            default: begin
                state <= RDY;
                tx_bit <= 1'b1;
                timer <= 0;
                bit_index <= 0;
            end
        endcase
    end

    assign uart_tx = tx_bit;
    assign ready   = (state == RDY);

endmodule
