# uart_transmitter
This is project based on UART protocol where signal is transmitted from FPGA to PC Terminal

# Overview

This project implements a UART (Universal Asynchronous Receiver-Transmitter) transmitter on an FPGA to establish serial communication between the FPGA board and a PC. A Python script running on the PC receives and displays the transmitted data through a serial terminal.

The project demonstrates the fundamentals of UART communication, including baud-rate generation, finite-state machine (FSM) design, parallel-to-serial data conversion, and asynchronous serial transmission.

# Features :-

UART transmitter implemented in Verilog HDL.

FPGA-to-PC serial communication.

Python-based serial terminal using pyserial.

Configurable baud rate.

FSM-based transmission control.

Serial data transmission using the standard UART frame format.

# Hardware Requirements :-

FPGA board: Digilent Basys 3

USB cable for FPGA programming and UART communication

PC running Windows

# Software Requirements :-

Xilinx Vivado Design Suite

Python 3

pyserial Python library

Visual Studio Code (optional)


# Key Learning Outcomes :-

Understanding asynchronous serial communication.

Designing an FSM-based UART transmitter in Verilog.

Implementing baud-rate timing using an FPGA clock.

Understanding start bits, data bits, stop bits, and LSB-first transmission.

Interfacing FPGA hardware with a PC using a USB-UART connection.

Using Python and pyserial for serial data reception.

# Future Improvements :-

Implement a UART receiver in Verilog.

Support transmission of user-defined strings.

Add a command-based interface between the PC and FPGA.

Extend the design to full-duplex UART communication.


# Author :-

Soumyadip Mallick

B.Tech, Electronics and Communication Engineering
Indian Institute of Technology Bhubaneswar
