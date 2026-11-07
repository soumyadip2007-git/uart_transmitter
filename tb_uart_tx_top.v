`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2026 16:10:42
// Design Name: 
// Module Name: tb_uart_tx_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_uart_tx_top;
reg clk,btnC;
wire RsTx;

uart_tx_top#(
        .CLOCK_FREQ(10),
        .BAUD(5),
        .DEBOUNCE_CYCLES(2)
) tx (
    .btnC(btnC),
    .clk(clk),
    .RsTx(RsTx)
);

always
#2 clk=~clk;

initial begin
    clk=0;
    btnC=0;
    #11 btnC=1;
    #17 btnC=0;
    #511 btnC=1;
    #18 btnC=0;
    #700 $finish;
end

initial begin
   $dumpfile("waveform.vcd");
   $dumpvars(0,tb_uart_tx_top);
end
endmodule