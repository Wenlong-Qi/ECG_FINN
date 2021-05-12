// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "block" *) module StreamingFCLayer_Batch_1_StreamingFCLayer_eOg_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 36;
parameter AWIDTH = 9;
parameter MEM_SIZE = 512;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_1_q80qszbp/project_StreamingFCLayer_Batch_1/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_eOg_rom.dat", ram);
end



always @(posedge clk)  
begin 
    if (ce0) 
    begin
        q0 <= ram[addr0];
    end
end



endmodule

`timescale 1 ns / 1 ps
module StreamingFCLayer_Batch_1_StreamingFCLayer_eOg(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd36;
parameter AddressRange = 32'd512;
parameter AddressWidth = 32'd9;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_1_StreamingFCLayer_eOg_rom StreamingFCLayer_Batch_1_StreamingFCLayer_eOg_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

