//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2c1/hdl/verilog/regslice_core.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module regslice_both
#(parameter 
    DataWidth=32
)(
    input ap_clk ,
    input ap_rst,

    input [DataWidth-1:0] data_in , 
    input vld_in , 
    output ack_in ,
    output [DataWidth-1:0] data_out, 
    output vld_out,
    input ack_out,
    output apdone_blk
);
 
localparam W = DataWidth+1;

wire [W-1:0] cdata;
wire cstop;
wire [W-1:0] idata;
wire istop;
wire [W-1:0] odata;
wire ostop;

reg [1:0] count;

ibuf #(
  .W(W)
)
ibuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .idata(idata),
  .istop(istop),
  .cdata(cdata),
  .cstop(cstop)
);
 
 
obuf #(
  .W(W)
)
obuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .cdata(cdata),
  .cstop(cstop),
  .odata(odata),
  .ostop(ostop)
);

assign idata = {vld_in, data_in};
assign ack_in = ~istop;

assign vld_out = odata[W-1];
assign data_out = odata[W-2:0];
assign ostop = ~ack_out;

// count, indicate how many data in the regslice.
// 00 - null
// 10 - 0
// 11 - 1
// 01 - 2
always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        count <= 2'd0;
    end else begin
        if ((((2'd2 == count) & (1'b0 == vld_in)) | ((2'd3 == count) & (1'b0 == vld_in) & (1'b1 == ack_out)))) begin
            count <= 2'd2;
        end else if ((((2'd1 == count) & (1'b0 == ack_out)) | ((2'd3 == count) & (1'b0 == ack_out) & (1'b1 == vld_in)))) begin
            count <= 2'd1;
        end else if (((~((1'b0 == vld_in) & (1'b1 == ack_out)) & ~((1'b0 == ack_out) & (1'b1 == vld_in)) & (2'd3 == count)) | ((2'd1 == count) & (1'b1 == ack_out)) | ((2'd2 == count) & (1'b1 == vld_in)))) begin
            count <= 2'd3;
        end else begin
            count <= 2'd2;
        end
    end
end

assign apdone_blk = ((count == 2'd3 && ack_out == 1'b0) | (count == 2'd1));

endmodule // both


module regslice_forward 
#(parameter 
    DataWidth=32
)(
    input ap_clk ,
    input ap_rst,

    input [DataWidth-1:0] data_in , 
    input vld_in , 
    output ack_in ,
    output [DataWidth-1:0] data_out, 
    output vld_out,
    input ack_out,
    output apdone_blk
);
 
localparam W = DataWidth+1;

wire [W-1:0] cdata;
wire cstop;
wire [W-1:0] idata;
wire istop;
wire [W-1:0] odata;
wire ostop;

obuf #(
  .W(W)
)
obuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .cdata(idata),
  .cstop(istop),
  .odata(odata),
  .ostop(ostop)
);

assign idata = {vld_in, data_in};
assign ack_in = ~istop;

assign vld_out = odata[W-1];
assign data_out = odata[W-2:0];
assign ostop = ~ack_out;

assign apdone_blk = ((ap_rst == 1'b0)&(1'b0 == ack_out)&(1'b1 == vld_out));

endmodule //forward


module regslice_reverse 
#(parameter 
    DataWidth=32
)(
    input ap_clk ,
    input ap_rst,

    input [DataWidth-1:0] data_in , 
    input vld_in , 
    output ack_in ,
    output [DataWidth-1:0] data_out, 
    output vld_out,
    input ack_out,
    output apdone_blk
);
 
localparam W = DataWidth+1;

wire [W-1:0] cdata;
wire cstop;
wire [W-1:0] idata;
wire istop;
wire [W-1:0] odata;
wire ostop;

ibuf #(
  .W(W)
)
ibuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .idata(idata),
  .istop(istop),
  .cdata(odata),
  .cstop(ostop)
);
 
assign idata = {vld_in, data_in};
assign ack_in = ~istop;

assign vld_out = odata[W-1];
assign data_out = odata[W-2:0];
assign ostop = ~ack_out;

assign apdone_blk = ((ap_rst == 1'b0)&(ack_in == 1'b0));

endmodule //reverse

module regslice_both_w1 
#(parameter 
    DataWidth=32
)(
    input ap_clk ,
    input ap_rst,

    input data_in , 
    input vld_in , 
    output ack_in ,
    output data_out, 
    output vld_out,
    input ack_out,
    output apdone_blk
);
 
localparam W = 2;

wire [W-1:0] cdata;
wire cstop;
wire [W-1:0] idata;
wire istop;
wire [W-1:0] odata;
wire ostop;

reg [1:0] count;

ibuf #(
  .W(W)
)
ibuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .idata(idata),
  .istop(istop),
  .cdata(cdata),
  .cstop(cstop)
);
 
 
obuf #(
  .W(W)
)
obuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .cdata(cdata),
  .cstop(cstop),
  .odata(odata),
  .ostop(ostop)
);

assign idata = {vld_in, data_in};
assign ack_in = ~istop;

assign vld_out = odata[W-1];
assign data_out = odata[W-2:0];
assign ostop = ~ack_out;
// count, indicate how many data in the regslice.
// 00 - null
// 10 - 0
// 11 - 1
// 01 - 2
always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        count <= 2'd0;
    end else begin
        if ((((2'd2 == count) & (1'b0 == vld_in)) | ((2'd3 == count) & (1'b0 == vld_in) & (1'b1 == ack_out)))) begin
            count <= 2'd2;
        end else if ((((2'd1 == count) & (1'b0 == ack_out)) | ((2'd3 == count) & (1'b0 == ack_out) & (1'b1 == vld_in)))) begin
            count <= 2'd1;
        end else if (((~((1'b0 == vld_in) & (1'b1 == ack_out)) & ~((1'b0 == ack_out) & (1'b1 == vld_in)) & (2'd3 == count)) | ((2'd1 == count) & (1'b1 == ack_out)) | ((2'd2 == count) & (1'b1 == vld_in)))) begin
            count <= 2'd3;
        end else begin
            count <= 2'd2;
        end
    end
end

assign apdone_blk = ((count == 2'd3 && ack_out == 1'b0) | (count == 2'd1));

endmodule // both


module regslice_forward_w1 
#(parameter 
    DataWidth=1
)(
    input ap_clk ,
    input ap_rst,

    input data_in , 
    input vld_in , 
    output ack_in ,
    output data_out, 
    output vld_out,
    input ack_out,
    output apdone_blk
);
 
localparam W = 2;

wire [W-1:0] cdata;
wire cstop;
wire [W-1:0] idata;
wire istop;
wire [W-1:0] odata;
wire ostop;

obuf #(
  .W(W)
)
obuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .cdata(idata),
  .cstop(istop),
  .odata(odata),
  .ostop(ostop)
);

assign idata = {vld_in, data_in};
assign ack_in = ~istop;

assign vld_out = odata[W-1];
assign data_out = odata[W-2:0];
assign ostop = ~ack_out;

assign apdone_blk = ((ap_rst == 1'b0)&(1'b0 == ack_out)&(1'b1 == vld_out));

endmodule //forward


module regslice_reverse_w1 
#(parameter 
    DataWidth=1
)(
    input ap_clk ,
    input ap_rst,

    input data_in , 
    input vld_in , 
    output ack_in ,
    output data_out, 
    output vld_out,
    input ack_out,
    output apdone_blk
);
 
localparam W = 2;

wire [W-1:0] cdata;
wire cstop;
wire [W-1:0] idata;
wire istop;
wire [W-1:0] odata;
wire ostop;

ibuf #(
  .W(W)
)
ibuf_inst(
  .clk(ap_clk),
  .reset(ap_rst),
  .idata(idata),
  .istop(istop),
  .cdata(odata),
  .cstop(ostop)
);
 
assign idata = {vld_in, data_in};
assign ack_in = ~istop;

assign vld_out = odata[W-1];
assign data_out = odata[W-2:0];
assign ostop = ~ack_out;

assign apdone_blk = ((ap_rst == 1'b0)&(ack_in == 1'b0));

endmodule //reverse


module ibuf 
#(
    parameter W=32
)(
    input clk ,
    input reset,
    input [W-1:0] idata, 
    output istop ,
    output [W-1:0] cdata, 
    input cstop 
);
 
reg [W-1:0] ireg = {1'b0, {{W-1}{1'b0}}}; // Empty
 
assign istop = reset ? 1'b1 : ireg[W-1]; // Stop if buffering
assign cdata = istop ? ireg : idata ; // Send buffered
 
always @(posedge clk)
    if(reset)
        ireg <= {1'b0, {{W-1}{1'b0}}}; // Empty 
    else begin
        if (!cstop && ireg [W-1]) // Will core consume?
            ireg <= {1'b0, {{W-1}{1'b0}}}; // Yes: empty buffer
        else if ( cstop && !ireg[W-1]) // Core stop, empty?
            ireg <= idata; // Yes: load buffer
    end
 
endmodule

// Forward mode
module obuf 
#(
    parameter W=32
)(
    input clk ,
    input reset,
    input [W-1:0] cdata ,
    output cstop ,
    output reg [W-1:0] odata,
    input ostop 
);

// Stop the core when buffer full and output not ready
assign cstop = reset? 1'b1 : (odata[W-1] & ostop);
 
always @(posedge clk)
    if(reset)
        odata <= {1'b0, {{W-1}{1'b0}}};
    else
        if (!cstop) begin// Can we accept more data?
            odata <= cdata; // Yes: load the buffer
        end

endmodule

    
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/82df/StreamingFIFO_1.v


module StreamingFIFO_1(
ap_clk,
ap_rst_n,
count,
in0_V_V_TDATA,
in0_V_V_TVALID,
in0_V_V_TREADY,
out_V_V_TDATA,
out_V_V_TVALID,
out_V_V_TREADY
);

input   ap_clk;
input   ap_rst_n;
output [4:0] count;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

Q_srl #(
.depth(32),
.width(8)
)
StreamingFIFO_1_StreamingFIFO_1
(
 .clock(ap_clk),
 .reset(!ap_rst_n),
 .count(count),
 .i_d(in0_V_V_TDATA),
 .i_v(in0_V_V_TVALID),
 .i_r(in0_V_V_TREADY),
 .o_d(out_V_V_TDATA),
 .o_v(out_V_V_TVALID),
 .o_r(out_V_V_TREADY)
);

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2b8/hdl/verilog/ConvolutionInputGenerator_1_ConvolutionInputGfYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module ConvolutionInputGenerator_1_ConvolutionInputGfYi #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [3 : 0]     din0,
    input  [3 : 0]     din1,
    input  [3 : 0]     din2,
    input  [3 : 0]     din3,
    input  [1 : 0]    din4,
    output [3 : 0]   dout);

// puts internal signals
wire [1 : 0]     sel;
// level 1 signals
wire [3 : 0]         mux_1_0;
wire [3 : 0]         mux_1_1;
// level 2 signals
wire [3 : 0]         mux_2_0;

assign sel = din4;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;

// Generate level 2 logic
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;

// output logic
assign dout = mux_2_0;

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_bkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module StreamingFCLayer_Batch_1_StreamingFCLayer_bkb #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH       = 32,
    din5_WIDTH       = 32,
    din6_WIDTH       = 32,
    din7_WIDTH       = 32,
    din8_WIDTH       = 32,
    din9_WIDTH       = 32,
    din10_WIDTH       = 32,
    din11_WIDTH       = 32,
    din12_WIDTH       = 32,
    din13_WIDTH       = 32,
    din14_WIDTH       = 32,
    din15_WIDTH       = 32,
    din16_WIDTH       = 32,
    din17_WIDTH       = 32,
    din18_WIDTH       = 32,
    din19_WIDTH       = 32,
    din20_WIDTH       = 32,
    din21_WIDTH       = 32,
    din22_WIDTH       = 32,
    din23_WIDTH       = 32,
    din24_WIDTH       = 32,
    din25_WIDTH       = 32,
    din26_WIDTH       = 32,
    din27_WIDTH       = 32,
    din28_WIDTH       = 32,
    din29_WIDTH       = 32,
    din30_WIDTH       = 32,
    din31_WIDTH       = 32,
    din32_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [35 : 0]     din0,
    input  [35 : 0]     din1,
    input  [35 : 0]     din2,
    input  [35 : 0]     din3,
    input  [35 : 0]     din4,
    input  [35 : 0]     din5,
    input  [35 : 0]     din6,
    input  [35 : 0]     din7,
    input  [35 : 0]     din8,
    input  [35 : 0]     din9,
    input  [35 : 0]     din10,
    input  [35 : 0]     din11,
    input  [35 : 0]     din12,
    input  [35 : 0]     din13,
    input  [35 : 0]     din14,
    input  [35 : 0]     din15,
    input  [35 : 0]     din16,
    input  [35 : 0]     din17,
    input  [35 : 0]     din18,
    input  [35 : 0]     din19,
    input  [35 : 0]     din20,
    input  [35 : 0]     din21,
    input  [35 : 0]     din22,
    input  [35 : 0]     din23,
    input  [35 : 0]     din24,
    input  [35 : 0]     din25,
    input  [35 : 0]     din26,
    input  [35 : 0]     din27,
    input  [35 : 0]     din28,
    input  [35 : 0]     din29,
    input  [35 : 0]     din30,
    input  [35 : 0]     din31,
    input  [4 : 0]    din32,
    output [35 : 0]   dout);

// puts internal signals
wire [4 : 0]     sel;
// level 1 signals
wire [35 : 0]         mux_1_0;
wire [35 : 0]         mux_1_1;
wire [35 : 0]         mux_1_2;
wire [35 : 0]         mux_1_3;
wire [35 : 0]         mux_1_4;
wire [35 : 0]         mux_1_5;
wire [35 : 0]         mux_1_6;
wire [35 : 0]         mux_1_7;
wire [35 : 0]         mux_1_8;
wire [35 : 0]         mux_1_9;
wire [35 : 0]         mux_1_10;
wire [35 : 0]         mux_1_11;
wire [35 : 0]         mux_1_12;
wire [35 : 0]         mux_1_13;
wire [35 : 0]         mux_1_14;
wire [35 : 0]         mux_1_15;
// level 2 signals
wire [35 : 0]         mux_2_0;
wire [35 : 0]         mux_2_1;
wire [35 : 0]         mux_2_2;
wire [35 : 0]         mux_2_3;
wire [35 : 0]         mux_2_4;
wire [35 : 0]         mux_2_5;
wire [35 : 0]         mux_2_6;
wire [35 : 0]         mux_2_7;
// level 3 signals
wire [35 : 0]         mux_3_0;
wire [35 : 0]         mux_3_1;
wire [35 : 0]         mux_3_2;
wire [35 : 0]         mux_3_3;
// level 4 signals
wire [35 : 0]         mux_4_0;
wire [35 : 0]         mux_4_1;
// level 5 signals
wire [35 : 0]         mux_5_0;

assign sel = din32;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;
assign mux_1_2 = (sel[0] == 0)? din4 : din5;
assign mux_1_3 = (sel[0] == 0)? din6 : din7;
assign mux_1_4 = (sel[0] == 0)? din8 : din9;
assign mux_1_5 = (sel[0] == 0)? din10 : din11;
assign mux_1_6 = (sel[0] == 0)? din12 : din13;
assign mux_1_7 = (sel[0] == 0)? din14 : din15;
assign mux_1_8 = (sel[0] == 0)? din16 : din17;
assign mux_1_9 = (sel[0] == 0)? din18 : din19;
assign mux_1_10 = (sel[0] == 0)? din20 : din21;
assign mux_1_11 = (sel[0] == 0)? din22 : din23;
assign mux_1_12 = (sel[0] == 0)? din24 : din25;
assign mux_1_13 = (sel[0] == 0)? din26 : din27;
assign mux_1_14 = (sel[0] == 0)? din28 : din29;
assign mux_1_15 = (sel[0] == 0)? din30 : din31;

// Generate level 2 logic
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;
assign mux_2_1 = (sel[1] == 0)? mux_1_2 : mux_1_3;
assign mux_2_2 = (sel[1] == 0)? mux_1_4 : mux_1_5;
assign mux_2_3 = (sel[1] == 0)? mux_1_6 : mux_1_7;
assign mux_2_4 = (sel[1] == 0)? mux_1_8 : mux_1_9;
assign mux_2_5 = (sel[1] == 0)? mux_1_10 : mux_1_11;
assign mux_2_6 = (sel[1] == 0)? mux_1_12 : mux_1_13;
assign mux_2_7 = (sel[1] == 0)? mux_1_14 : mux_1_15;

// Generate level 3 logic
assign mux_3_0 = (sel[2] == 0)? mux_2_0 : mux_2_1;
assign mux_3_1 = (sel[2] == 0)? mux_2_2 : mux_2_3;
assign mux_3_2 = (sel[2] == 0)? mux_2_4 : mux_2_5;
assign mux_3_3 = (sel[2] == 0)? mux_2_6 : mux_2_7;

// Generate level 4 logic
assign mux_4_0 = (sel[3] == 0)? mux_3_0 : mux_3_1;
assign mux_4_1 = (sel[3] == 0)? mux_3_2 : mux_3_3;

// Generate level 5 logic
assign mux_5_0 = (sel[4] == 0)? mux_4_0 : mux_4_1;

// output logic
assign dout = mux_5_0;

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 3;
parameter AWIDTH = 3;
parameter MEM_SIZE = 6;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_3_vpqar3vc/project_StreamingFCLayer_Batch_3/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb_rom.dat", ram);
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
module StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd3;
parameter AddressRange = 32'd6;
parameter AddressWidth = 32'd3;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb_rom StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 8;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd8;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb_rom StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingFCLayer_Batch_0_0/synth/finn_design_StreamingFCLayer_Batch_0_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingFCLayer_Batch_0:1.0
// IP Revision: 2105101211

(* X_CORE_INFO = "StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingFCLayer_Batch_0_0,StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingFCLayer_Batch_0_0,StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingFCLayer_Batch_0,x_ipVersion=1.0,x_ipCoreRevision=2105101211,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingFCLayer_Batch_0_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 9, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [71 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/fab4/hdl/verilog/ConvolutionInputGenerator_0_ConvolutionInputGbkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module ConvolutionInputGenerator_0_ConvolutionInputGbkb_ram (addr0, ce0, q0, addr1, ce1, d1, we1,  clk);

parameter DWIDTH = 8;
parameter AWIDTH = 4;
parameter MEM_SIZE = 12;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input[AWIDTH-1:0] addr1;
input ce1;
input[DWIDTH-1:0] d1;
input we1;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];




always @(posedge clk)  
begin 
    if (ce0) begin
        q0 <= ram[addr0];
    end
end


always @(posedge clk)  
begin 
    if (ce1) begin
        if (we1) 
            ram[addr1] <= d1; 
    end
end


endmodule

`timescale 1 ns / 1 ps
module ConvolutionInputGenerator_0_ConvolutionInputGbkb(
    reset,
    clk,
    address0,
    ce0,
    q0,
    address1,
    ce1,
    we1,
    d1);

parameter DataWidth = 32'd8;
parameter AddressRange = 32'd12;
parameter AddressWidth = 32'd4;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;
input[AddressWidth - 1:0] address1;
input ce1;
input we1;
input[DataWidth - 1:0] d1;



ConvolutionInputGenerator_0_ConvolutionInputGbkb_ram ConvolutionInputGenerator_0_ConvolutionInputGbkb_ram_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ),
    .addr1( address1 ),
    .ce1( ce1 ),
    .we1( we1 ),
    .d1( d1 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/e745/hdl/verilog/StreamingDataWidthConverter_Batch_1_StreamingDataWidthCo_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingDataWidthConverter_Batch_1_StreamingDataWidthCo_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [127:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln508_fu_96_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln517_reg_179;
reg   [123:0] r_V_reg_69;
reg   [11:0] t_0_reg_80;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [11:0] t_fu_102_p2;
wire   [127:0] p_Result_s_fu_115_p3;
reg   [127:0] p_Result_s_reg_174;
wire   [0:0] icmp_ln517_fu_129_p2;
wire   [123:0] trunc_ln_fu_150_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg   [31:0] i_1_fu_52;
wire   [31:0] i_fu_123_p2;
reg    ap_block_pp0_stage0_01001;
wire   [3:0] tmp_V_fu_111_p1;
wire   [119:0] tmp_1_fu_140_p4;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_129_p2 == 1'd0) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_1_fu_52 <= i_fu_123_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_129_p2 == 1'd1) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        i_1_fu_52 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        r_V_reg_69 <= trunc_ln_fu_150_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        r_V_reg_69 <= 124'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t_0_reg_80 <= t_fu_102_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        t_0_reg_80 <= 12'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln517_reg_179 <= icmp_ln517_fu_129_p2;
        p_Result_s_reg_174 <= p_Result_s_fu_115_p3;
    end
end

always @ (*) begin
    if ((icmp_ln508_fu_96_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln508_fu_96_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln517_reg_179 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_reg_179 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_96_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_96_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln517_reg_179 == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign i_fu_123_p2 = (32'd1 + i_1_fu_52);

assign icmp_ln508_fu_96_p2 = ((t_0_reg_80 == 12'd3200) ? 1'b1 : 1'b0);

assign icmp_ln517_fu_129_p2 = ((i_fu_123_p2 == 32'd32) ? 1'b1 : 1'b0);

assign out_V_V_TDATA = p_Result_s_reg_174;

assign p_Result_s_fu_115_p3 = {{tmp_V_fu_111_p1}, {r_V_reg_69}};

assign t_fu_102_p2 = (t_0_reg_80 + 12'd1);

assign tmp_1_fu_140_p4 = {{r_V_reg_69[123:4]}};

assign tmp_V_fu_111_p1 = in_V_V_TDATA[3:0];

assign trunc_ln_fu_150_p3 = {{tmp_V_fu_111_p1}, {tmp_1_fu_140_p4}};

endmodule //StreamingDataWidthConverter_Batch_1_StreamingDataWidthCo_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/0d80/hdl/verilog/StreamingDataWidthConverter_Batch_4_StreamingDataWidthCo_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingDataWidthConverter_Batch_4_StreamingDataWidthCo_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [63:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [15:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln476_fu_104_p2;
wire   [0:0] icmp_ln479_fu_116_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln476_reg_162;
reg   [47:0] p_025_0_reg_61;
reg   [31:0] o_0_reg_73;
reg   [9:0] t_0_reg_84;
reg    ap_predicate_op16_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [9:0] t_fu_110_p2;
reg   [0:0] icmp_ln479_reg_171;
wire   [31:0] select_ln490_fu_134_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg   [63:0] ap_phi_mux_p_Val2_s_phi_fu_98_p4;
wire   [63:0] ap_phi_reg_pp0_iter0_p_Val2_s_reg_95;
reg   [63:0] ap_phi_reg_pp0_iter1_p_Val2_s_reg_95;
wire   [63:0] zext_ln476_fu_142_p1;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] o_fu_122_p2;
wire   [0:0] icmp_ln490_fu_128_p2;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_86;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_86)) begin
        if (((icmp_ln479_fu_116_p2 == 1'd1) & (icmp_ln476_fu_104_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_p_Val2_s_reg_95 <= in_V_V_TDATA;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_p_Val2_s_reg_95 <= ap_phi_reg_pp0_iter0_p_Val2_s_reg_95;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_fu_104_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        o_0_reg_73 <= select_ln490_fu_134_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        o_0_reg_73 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_reg_162 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_025_0_reg_61 <= {{ap_phi_mux_p_Val2_s_phi_fu_98_p4[63:16]}};
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        p_025_0_reg_61 <= 48'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_fu_104_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t_0_reg_84 <= t_fu_110_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        t_0_reg_84 <= 10'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln476_reg_162 <= icmp_ln476_fu_104_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_fu_104_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln479_reg_171 <= icmp_ln479_fu_116_p2;
    end
end

always @ (*) begin
    if ((icmp_ln476_fu_104_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln479_reg_171 == 1'd0) & (icmp_ln476_reg_162 == 1'd0))) begin
        ap_phi_mux_p_Val2_s_phi_fu_98_p4 = zext_ln476_fu_142_p1;
    end else begin
        ap_phi_mux_p_Val2_s_phi_fu_98_p4 = ap_phi_reg_pp0_iter1_p_Val2_s_reg_95;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln479_fu_116_p2 == 1'd1) & (icmp_ln476_fu_104_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op16_read_state2 == 1'b1))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln476_reg_162 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_reg_162 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln476_fu_104_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln476_fu_104_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op16_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op16_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op16_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((in_V_V_TVALID == 1'b0) & (ap_predicate_op16_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln476_reg_162 == 1'd0) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_86 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_reg_pp0_iter0_p_Val2_s_reg_95 = 'bx;

always @ (*) begin
    ap_predicate_op16_read_state2 = ((icmp_ln479_fu_116_p2 == 1'd1) & (icmp_ln476_fu_104_p2 == 1'd0));
end

assign icmp_ln476_fu_104_p2 = ((t_0_reg_84 == 10'd576) ? 1'b1 : 1'b0);

assign icmp_ln479_fu_116_p2 = ((o_0_reg_73 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln490_fu_128_p2 = ((o_fu_122_p2 == 32'd4) ? 1'b1 : 1'b0);

assign o_fu_122_p2 = (32'd1 + o_0_reg_73);

assign out_V_V_TDATA = ap_phi_mux_p_Val2_s_phi_fu_98_p4[15:0];

assign select_ln490_fu_134_p3 = ((icmp_ln490_fu_128_p2[0:0] === 1'b1) ? 32'd0 : o_fu_122_p2);

assign t_fu_110_p2 = (t_0_reg_84 + 10'd1);

assign zext_ln476_fu_142_p1 = p_025_0_reg_61;

endmodule //StreamingDataWidthConverter_Batch_4_StreamingDataWidthCo_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 10;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd10;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j_rom StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingDataWidthConverter_Batch_4_0/synth/finn_design_StreamingDataWidthConverter_Batch_4_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingDataWidthConverter_Batch_4:1.0
// IP Revision: 2105101204

(* X_CORE_INFO = "StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingDataWidthConverter_Batch_4_0,StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingDataWidthConverter_Batch_4_0,StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingDataWidthConverter_Batch_4,x_ipVersion=1.0,x_ipCoreRevision=2105101204,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingDataWidthConverter_Batch_4_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 8, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [63 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 2, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [15 : 0] out_V_V_TDATA;

  StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 9;
parameter AWIDTH = 6;
parameter MEM_SIZE = 64;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_2_j8ke1nb0/project_StreamingFCLayer_Batch_2/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe_rom.dat", ram);
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
module StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd9;
parameter AddressRange = 32'd64;
parameter AddressWidth = 32'd6;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe_rom StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2c1/hdl/verilog/LabelSelect_Batch_0_LabelSelect_Batch_0.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="LabelSelect_Batch_0_LabelSelect_Batch_0,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=1.384000,HLS_SYN_LAT=11,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=21,HLS_SYN_LUT=144,HLS_VERSION=2020_1}" *)

module LabelSelect_Batch_0_LabelSelect_Batch_0 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_LabelSelect_Batch_fu_26_ap_start;
wire    grp_LabelSelect_Batch_fu_26_ap_done;
wire    grp_LabelSelect_Batch_fu_26_ap_idle;
wire    grp_LabelSelect_Batch_fu_26_ap_ready;
wire    grp_LabelSelect_Batch_fu_26_in_V_V_TREADY;
wire   [7:0] grp_LabelSelect_Batch_fu_26_out_V_V_TDATA;
wire    grp_LabelSelect_Batch_fu_26_out_V_V_TVALID;
wire    grp_LabelSelect_Batch_fu_26_out_V_V_TREADY;
reg    grp_LabelSelect_Batch_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_LabelSelect_Batch_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

LabelSelect_Batch_0_LabelSelect_Batch grp_LabelSelect_Batch_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_LabelSelect_Batch_fu_26_ap_start),
    .ap_done(grp_LabelSelect_Batch_fu_26_ap_done),
    .ap_idle(grp_LabelSelect_Batch_fu_26_ap_idle),
    .ap_ready(grp_LabelSelect_Batch_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_LabelSelect_Batch_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_LabelSelect_Batch_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_LabelSelect_Batch_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_LabelSelect_Batch_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_LabelSelect_Batch_fu_26_out_V_V_TDATA),
    .vld_in(grp_LabelSelect_Batch_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_LabelSelect_Batch_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_LabelSelect_Batch_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_LabelSelect_Batch_fu_26_ap_ready == 1'b1)) begin
            grp_LabelSelect_Batch_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_LabelSelect_Batch_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_LabelSelect_Batch_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_LabelSelect_Batch_fu_26_ap_start = grp_LabelSelect_Batch_fu_26_ap_start_reg;

assign grp_LabelSelect_Batch_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //LabelSelect_Batch_0_LabelSelect_Batch_0
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_cud.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

(* use_dsp = "no" *) module StreamingFCLayer_Batch_1_StreamingFCLayer_cud_Mul_LUT_0(a, b, p);
input[2 - 1 : 0] a; 
input[2 - 1 : 0] b; 
output[4 - 1 : 0] p;

assign p = $signed({1'b0, a}) * $signed(b);
endmodule
`timescale 1 ns / 1 ps
module StreamingFCLayer_Batch_1_StreamingFCLayer_cud(
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



StreamingFCLayer_Batch_1_StreamingFCLayer_cud_Mul_LUT_0 StreamingFCLayer_Batch_1_StreamingFCLayer_cud_Mul_LUT_0_U(
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/fab4/hdl/verilog/ConvolutionInputGenerator_0_ConvolutionInputGfYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module ConvolutionInputGenerator_0_ConvolutionInputGfYi #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [7 : 0]     din0,
    input  [7 : 0]     din1,
    input  [7 : 0]     din2,
    input  [7 : 0]     din3,
    input  [1 : 0]    din4,
    output [7 : 0]   dout);

// puts internal signals
wire [1 : 0]     sel;
// level 1 signals
wire [7 : 0]         mux_1_0;
wire [7 : 0]         mux_1_1;
// level 2 signals
wire [7 : 0]         mux_2_0;

assign sel = din4;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;

// Generate level 2 logic
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;

// output logic
assign dout = mux_2_0;

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_Activa.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingFCLayer_Batch_3_Matrix_Vector_Activa (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY,
        weights_m_weights_V_address0,
        weights_m_weights_V_ce0,
        weights_m_weights_V_q0
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;
output  [8:0] weights_m_weights_V_address0;
output   weights_m_weights_V_ce0;
input  [1:0] weights_m_weights_V_q0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;
reg weights_m_weights_V_ce0;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [2:0] threshs_m_thresholds_2_address0;
reg    threshs_m_thresholds_2_ce0;
wire   [2:0] threshs_m_thresholds_2_q0;
wire   [2:0] threshs_m_thresholds_1_address0;
reg    threshs_m_thresholds_1_ce0;
wire   [3:0] threshs_m_thresholds_1_q0;
wire   [2:0] threshs_m_thresholds_address0;
reg    threshs_m_thresholds_ce0;
wire   [0:0] threshs_m_thresholds_q0;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln122_fu_690_p2;
wire   [0:0] icmp_ln125_fu_705_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln160_reg_2099;
reg   [8:0] i_0_reg_529;
reg    ap_predicate_op157_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [8:0] i_fu_696_p2;
wire   [1:0] inElem_V_1_fu_910_p66;
wire   [1:0] inputBuf_0_V_fu_1044_p1;
wire   [5:0] trunc_ln321_fu_1048_p1;
wire   [0:0] icmp_ln137_fu_1378_p2;
reg   [0:0] icmp_ln137_reg_2089;
wire   [0:0] icmp_ln160_fu_1401_p2;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [1:0] ap_phi_reg_pp0_iter0_p_Val2_s_reg_540;
reg   [1:0] ap_phi_reg_pp0_iter1_p_Val2_s_reg_540;
wire   [63:0] zext_ln137_fu_1384_p1;
wire   [63:0] zext_ln186_fu_1420_p1;
reg   [8:0] accu_V_0_0_0_fu_192;
wire   [8:0] add_ln700_1_fu_1493_p2;
reg   [31:0] tile_assign_fu_196;
wire   [31:0] tile_fu_1389_p2;
wire   [31:0] tile_1_fu_1447_p3;
reg   [31:0] sf_1_fu_200;
wire   [31:0] sf_fu_1395_p2;
reg   [1:0] inputBuf_63_V_fu_204;
reg   [1:0] inputBuf_63_V_1_fu_208;
reg   [1:0] inputBuf_63_V_2_fu_212;
reg   [1:0] inputBuf_63_V_3_fu_216;
reg   [1:0] inputBuf_63_V_4_fu_220;
reg   [1:0] inputBuf_63_V_5_fu_224;
reg   [1:0] inputBuf_63_V_6_fu_228;
reg   [1:0] inputBuf_63_V_7_fu_232;
reg   [1:0] inputBuf_63_V_8_fu_236;
reg   [1:0] inputBuf_63_V_9_fu_240;
reg   [1:0] inputBuf_63_V_10_fu_244;
reg   [1:0] inputBuf_63_V_11_fu_248;
reg   [1:0] inputBuf_63_V_12_fu_252;
reg   [1:0] inputBuf_63_V_13_fu_256;
reg   [1:0] inputBuf_63_V_14_fu_260;
reg   [1:0] inputBuf_63_V_15_fu_264;
reg   [1:0] inputBuf_63_V_16_fu_268;
reg   [1:0] inputBuf_63_V_17_fu_272;
reg   [1:0] inputBuf_63_V_18_fu_276;
reg   [1:0] inputBuf_63_V_19_fu_280;
reg   [1:0] inputBuf_63_V_20_fu_284;
reg   [1:0] inputBuf_63_V_21_fu_288;
reg   [1:0] inputBuf_63_V_22_fu_292;
reg   [1:0] inputBuf_63_V_23_fu_296;
reg   [1:0] inputBuf_63_V_24_fu_300;
reg   [1:0] inputBuf_63_V_25_fu_304;
reg   [1:0] inputBuf_63_V_26_fu_308;
reg   [1:0] inputBuf_63_V_27_fu_312;
reg   [1:0] inputBuf_63_V_28_fu_316;
reg   [1:0] inputBuf_63_V_29_fu_320;
reg   [1:0] inputBuf_63_V_30_fu_324;
reg   [1:0] inputBuf_63_V_31_fu_328;
reg   [1:0] inputBuf_63_V_32_fu_332;
reg   [1:0] inputBuf_63_V_33_fu_336;
reg   [1:0] inputBuf_63_V_34_fu_340;
reg   [1:0] inputBuf_63_V_35_fu_344;
reg   [1:0] inputBuf_63_V_36_fu_348;
reg   [1:0] inputBuf_63_V_37_fu_352;
reg   [1:0] inputBuf_63_V_38_fu_356;
reg   [1:0] inputBuf_63_V_39_fu_360;
reg   [1:0] inputBuf_63_V_40_fu_364;
reg   [1:0] inputBuf_63_V_41_fu_368;
reg   [1:0] inputBuf_63_V_42_fu_372;
reg   [1:0] inputBuf_63_V_43_fu_376;
reg   [1:0] inputBuf_63_V_44_fu_380;
reg   [1:0] inputBuf_63_V_45_fu_384;
reg   [1:0] inputBuf_63_V_46_fu_388;
reg   [1:0] inputBuf_63_V_47_fu_392;
reg   [1:0] inputBuf_63_V_48_fu_396;
reg   [1:0] inputBuf_63_V_49_fu_400;
reg   [1:0] inputBuf_63_V_50_fu_404;
reg   [1:0] inputBuf_63_V_51_fu_408;
reg   [1:0] inputBuf_63_V_52_fu_412;
reg   [1:0] inputBuf_63_V_53_fu_416;
reg   [1:0] inputBuf_63_V_54_fu_420;
reg   [1:0] inputBuf_63_V_55_fu_424;
reg   [1:0] inputBuf_63_V_56_fu_428;
reg   [1:0] inputBuf_63_V_57_fu_432;
reg   [1:0] inputBuf_63_V_58_fu_436;
reg   [1:0] inputBuf_63_V_59_fu_440;
reg   [1:0] inputBuf_63_V_60_fu_444;
reg   [1:0] inputBuf_63_V_61_fu_448;
reg   [1:0] inputBuf_63_V_62_fu_452;
reg   [1:0] inputBuf_63_V_63_fu_456;
reg   [31:0] nf_assign_fu_460;
wire   [31:0] nf_1_fu_1439_p3;
reg    ap_block_pp0_stage0_01001;
wire   [5:0] inElem_V_1_fu_910_p65;
wire   [31:0] nf_fu_1427_p2;
wire   [0:0] icmp_ln173_fu_1433_p2;
wire   [1:0] ret_V_fu_1483_p0;
wire  signed [3:0] ret_V_fu_1483_p2;
wire   [8:0] select_ln137_fu_1468_p3;
wire  signed [8:0] sext_ln700_fu_1489_p1;
wire   [8:0] zext_ln186_1_fu_1504_p1;
wire   [0:0] icmp_ln899_fu_1508_p2;
wire   [0:0] xor_ln899_fu_1514_p2;
wire   [8:0] zext_ln186_2_fu_1524_p1;
wire   [0:0] icmp_ln899_1_fu_1528_p2;
wire   [0:0] xor_ln899_1_fu_1534_p2;
wire   [8:0] select_ln186_fu_1544_p3;
wire   [0:0] icmp_ln899_2_fu_1552_p2;
wire   [0:0] xor_ln899_2_fu_1558_p2;
wire   [1:0] zext_ln700_1_fu_1540_p1;
wire   [1:0] zext_ln700_2_fu_1564_p1;
wire   [1:0] add_ln700_fu_1568_p2;
wire   [1:0] zext_ln700_fu_1520_p1;
wire   [1:0] tmp_V_fu_1574_p2;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [3:0] ret_V_fu_1483_p00;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

StreamingFCLayer_Batch_3_Matrix_Vector_Actbkb #(
    .DataWidth( 3 ),
    .AddressRange( 6 ),
    .AddressWidth( 3 ))
threshs_m_thresholds_2_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_2_address0),
    .ce0(threshs_m_thresholds_2_ce0),
    .q0(threshs_m_thresholds_2_q0)
);

StreamingFCLayer_Batch_3_Matrix_Vector_Actcud #(
    .DataWidth( 4 ),
    .AddressRange( 6 ),
    .AddressWidth( 3 ))
threshs_m_thresholds_1_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_1_address0),
    .ce0(threshs_m_thresholds_1_ce0),
    .q0(threshs_m_thresholds_1_q0)
);

StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe #(
    .DataWidth( 1 ),
    .AddressRange( 6 ),
    .AddressWidth( 3 ))
threshs_m_thresholds_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_address0),
    .ce0(threshs_m_thresholds_ce0),
    .q0(threshs_m_thresholds_q0)
);

StreamingFCLayer_Batch_3_StreamingFCLayer_eOg #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .din2_WIDTH( 2 ),
    .din3_WIDTH( 2 ),
    .din4_WIDTH( 2 ),
    .din5_WIDTH( 2 ),
    .din6_WIDTH( 2 ),
    .din7_WIDTH( 2 ),
    .din8_WIDTH( 2 ),
    .din9_WIDTH( 2 ),
    .din10_WIDTH( 2 ),
    .din11_WIDTH( 2 ),
    .din12_WIDTH( 2 ),
    .din13_WIDTH( 2 ),
    .din14_WIDTH( 2 ),
    .din15_WIDTH( 2 ),
    .din16_WIDTH( 2 ),
    .din17_WIDTH( 2 ),
    .din18_WIDTH( 2 ),
    .din19_WIDTH( 2 ),
    .din20_WIDTH( 2 ),
    .din21_WIDTH( 2 ),
    .din22_WIDTH( 2 ),
    .din23_WIDTH( 2 ),
    .din24_WIDTH( 2 ),
    .din25_WIDTH( 2 ),
    .din26_WIDTH( 2 ),
    .din27_WIDTH( 2 ),
    .din28_WIDTH( 2 ),
    .din29_WIDTH( 2 ),
    .din30_WIDTH( 2 ),
    .din31_WIDTH( 2 ),
    .din32_WIDTH( 2 ),
    .din33_WIDTH( 2 ),
    .din34_WIDTH( 2 ),
    .din35_WIDTH( 2 ),
    .din36_WIDTH( 2 ),
    .din37_WIDTH( 2 ),
    .din38_WIDTH( 2 ),
    .din39_WIDTH( 2 ),
    .din40_WIDTH( 2 ),
    .din41_WIDTH( 2 ),
    .din42_WIDTH( 2 ),
    .din43_WIDTH( 2 ),
    .din44_WIDTH( 2 ),
    .din45_WIDTH( 2 ),
    .din46_WIDTH( 2 ),
    .din47_WIDTH( 2 ),
    .din48_WIDTH( 2 ),
    .din49_WIDTH( 2 ),
    .din50_WIDTH( 2 ),
    .din51_WIDTH( 2 ),
    .din52_WIDTH( 2 ),
    .din53_WIDTH( 2 ),
    .din54_WIDTH( 2 ),
    .din55_WIDTH( 2 ),
    .din56_WIDTH( 2 ),
    .din57_WIDTH( 2 ),
    .din58_WIDTH( 2 ),
    .din59_WIDTH( 2 ),
    .din60_WIDTH( 2 ),
    .din61_WIDTH( 2 ),
    .din62_WIDTH( 2 ),
    .din63_WIDTH( 2 ),
    .din64_WIDTH( 6 ),
    .dout_WIDTH( 2 ))
StreamingFCLayer_eOg_U1(
    .din0(inputBuf_63_V_fu_204),
    .din1(inputBuf_63_V_1_fu_208),
    .din2(inputBuf_63_V_2_fu_212),
    .din3(inputBuf_63_V_3_fu_216),
    .din4(inputBuf_63_V_4_fu_220),
    .din5(inputBuf_63_V_5_fu_224),
    .din6(inputBuf_63_V_6_fu_228),
    .din7(inputBuf_63_V_7_fu_232),
    .din8(inputBuf_63_V_8_fu_236),
    .din9(inputBuf_63_V_9_fu_240),
    .din10(inputBuf_63_V_10_fu_244),
    .din11(inputBuf_63_V_11_fu_248),
    .din12(inputBuf_63_V_12_fu_252),
    .din13(inputBuf_63_V_13_fu_256),
    .din14(inputBuf_63_V_14_fu_260),
    .din15(inputBuf_63_V_15_fu_264),
    .din16(inputBuf_63_V_16_fu_268),
    .din17(inputBuf_63_V_17_fu_272),
    .din18(inputBuf_63_V_18_fu_276),
    .din19(inputBuf_63_V_19_fu_280),
    .din20(inputBuf_63_V_20_fu_284),
    .din21(inputBuf_63_V_21_fu_288),
    .din22(inputBuf_63_V_22_fu_292),
    .din23(inputBuf_63_V_23_fu_296),
    .din24(inputBuf_63_V_24_fu_300),
    .din25(inputBuf_63_V_25_fu_304),
    .din26(inputBuf_63_V_26_fu_308),
    .din27(inputBuf_63_V_27_fu_312),
    .din28(inputBuf_63_V_28_fu_316),
    .din29(inputBuf_63_V_29_fu_320),
    .din30(inputBuf_63_V_30_fu_324),
    .din31(inputBuf_63_V_31_fu_328),
    .din32(inputBuf_63_V_32_fu_332),
    .din33(inputBuf_63_V_33_fu_336),
    .din34(inputBuf_63_V_34_fu_340),
    .din35(inputBuf_63_V_35_fu_344),
    .din36(inputBuf_63_V_36_fu_348),
    .din37(inputBuf_63_V_37_fu_352),
    .din38(inputBuf_63_V_38_fu_356),
    .din39(inputBuf_63_V_39_fu_360),
    .din40(inputBuf_63_V_40_fu_364),
    .din41(inputBuf_63_V_41_fu_368),
    .din42(inputBuf_63_V_42_fu_372),
    .din43(inputBuf_63_V_43_fu_376),
    .din44(inputBuf_63_V_44_fu_380),
    .din45(inputBuf_63_V_45_fu_384),
    .din46(inputBuf_63_V_46_fu_388),
    .din47(inputBuf_63_V_47_fu_392),
    .din48(inputBuf_63_V_48_fu_396),
    .din49(inputBuf_63_V_49_fu_400),
    .din50(inputBuf_63_V_50_fu_404),
    .din51(inputBuf_63_V_51_fu_408),
    .din52(inputBuf_63_V_52_fu_412),
    .din53(inputBuf_63_V_53_fu_416),
    .din54(inputBuf_63_V_54_fu_420),
    .din55(inputBuf_63_V_55_fu_424),
    .din56(inputBuf_63_V_56_fu_428),
    .din57(inputBuf_63_V_57_fu_432),
    .din58(inputBuf_63_V_58_fu_436),
    .din59(inputBuf_63_V_59_fu_440),
    .din60(inputBuf_63_V_60_fu_444),
    .din61(inputBuf_63_V_61_fu_448),
    .din62(inputBuf_63_V_62_fu_452),
    .din63(inputBuf_63_V_63_fu_456),
    .din64(inElem_V_1_fu_910_p65),
    .dout(inElem_V_1_fu_910_p66)
);

StreamingFCLayer_Batch_3_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_fYi_U2(
    .din0(ret_V_fu_1483_p0),
    .din1(weights_m_weights_V_q0),
    .dout(ret_V_fu_1483_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd0) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_phi_reg_pp0_iter1_p_Val2_s_reg_540 <= inElem_V_1_fu_910_p66;
    end else if ((((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd2) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd3) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd4) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd5) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd6) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd7) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd8) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd9) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd10) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd11) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd12) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd13) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd14) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd15) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd16) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd17) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd18) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd19) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd20) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd21) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd22) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd23) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd24) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd25) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd26) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd27) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd28) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd29) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd30) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd31) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd32) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd33) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd34) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd35) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd36) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd37) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd38) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd39) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd40) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd41) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd42) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd43) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd44) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd45) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd46) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd47) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd48) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd49) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd50) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd51) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd52) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd53) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd54) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd55) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd56) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd57) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd58) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd59) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd60) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd61) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd62) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd63) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        ap_phi_reg_pp0_iter1_p_Val2_s_reg_540 <= inputBuf_0_V_fu_1044_p1;
    end else if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_phi_reg_pp0_iter1_p_Val2_s_reg_540 <= ap_phi_reg_pp0_iter0_p_Val2_s_reg_540;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        i_0_reg_529 <= i_fu_696_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_reg_529 <= 9'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_1401_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        nf_assign_fu_460 <= nf_1_fu_1439_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        nf_assign_fu_460 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_1401_p2 == 1'd0) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sf_1_fu_200 <= sf_fu_1395_p2;
    end else if ((((icmp_ln160_fu_1401_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        sf_1_fu_200 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_1401_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_196 <= tile_1_fu_1447_p3;
    end else if (((icmp_ln160_fu_1401_p2 == 1'd0) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_196 <= tile_fu_1389_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        tile_assign_fu_196 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accu_V_0_0_0_fu_192 <= add_ln700_1_fu_1493_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_690_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln137_reg_2089 <= icmp_ln137_fu_1378_p2;
        icmp_ln160_reg_2099 <= icmp_ln160_fu_1401_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd10) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_10_fu_244 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd11) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_11_fu_248 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd12) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_12_fu_252 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd13) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_13_fu_256 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd14) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_14_fu_260 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd15) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_15_fu_264 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd16) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_16_fu_268 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd17) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_17_fu_272 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd18) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_18_fu_276 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd19) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_19_fu_280 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_1_fu_208 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd20) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_20_fu_284 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd21) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_21_fu_288 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd22) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_22_fu_292 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd23) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_23_fu_296 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd24) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_24_fu_300 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd25) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_25_fu_304 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd26) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_26_fu_308 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd27) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_27_fu_312 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd28) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_28_fu_316 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd29) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_29_fu_320 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd2) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_2_fu_212 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd30) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_30_fu_324 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd31) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_31_fu_328 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd32) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_32_fu_332 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd33) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_33_fu_336 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd34) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_34_fu_340 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd35) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_35_fu_344 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd36) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_36_fu_348 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd37) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_37_fu_352 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd38) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_38_fu_356 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd39) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_39_fu_360 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd3) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_3_fu_216 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd40) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_40_fu_364 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd41) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_41_fu_368 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd42) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_42_fu_372 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd43) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_43_fu_376 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd44) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_44_fu_380 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd45) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_45_fu_384 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd46) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_46_fu_388 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd47) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_47_fu_392 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd48) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_48_fu_396 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd49) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_49_fu_400 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd4) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_4_fu_220 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd50) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_50_fu_404 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd51) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_51_fu_408 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd52) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_52_fu_412 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd53) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_53_fu_416 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd54) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_54_fu_420 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd55) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_55_fu_424 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd56) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_56_fu_428 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd57) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_57_fu_432 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd58) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_58_fu_436 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd59) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_59_fu_440 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd5) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_5_fu_224 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd60) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_60_fu_444 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd61) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_61_fu_448 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd62) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_62_fu_452 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd63) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_63_fu_456 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd6) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_6_fu_228 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd7) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_7_fu_232 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd8) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_8_fu_236 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd9) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_9_fu_240 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_1048_p1 == 6'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_63_V_fu_204 <= inputBuf_0_V_fu_1044_p1;
    end
end

always @ (*) begin
    if ((icmp_ln122_fu_690_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op157_read_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln160_reg_2099 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((icmp_ln160_reg_2099 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_1_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_2_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_2_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln122_fu_690_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln122_fu_690_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln700_1_fu_1493_p2 = ($signed(select_ln137_fu_1468_p3) + $signed(sext_ln700_fu_1489_p1));

assign add_ln700_fu_1568_p2 = (zext_ln700_1_fu_1540_p1 + zext_ln700_2_fu_1564_p1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op157_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op157_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op157_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((in_V_V_TVALID == 1'b0) & (ap_predicate_op157_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln160_reg_2099 == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_reg_pp0_iter0_p_Val2_s_reg_540 = 'bx;

always @ (*) begin
    ap_predicate_op157_read_state2 = ((icmp_ln125_fu_705_p2 == 1'd1) & (icmp_ln122_fu_690_p2 == 1'd0));
end

assign i_fu_696_p2 = (i_0_reg_529 + 9'd1);

assign icmp_ln122_fu_690_p2 = ((i_0_reg_529 == 9'd384) ? 1'b1 : 1'b0);

assign icmp_ln125_fu_705_p2 = ((nf_assign_fu_460 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln137_fu_1378_p2 = ((sf_1_fu_200 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln160_fu_1401_p2 = ((sf_fu_1395_p2 == 32'd64) ? 1'b1 : 1'b0);

assign icmp_ln173_fu_1433_p2 = ((nf_fu_1427_p2 == 32'd6) ? 1'b1 : 1'b0);

assign icmp_ln899_1_fu_1528_p2 = (($signed(add_ln700_1_fu_1493_p2) < $signed(zext_ln186_2_fu_1524_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_2_fu_1552_p2 = (($signed(add_ln700_1_fu_1493_p2) < $signed(select_ln186_fu_1544_p3)) ? 1'b1 : 1'b0);

assign icmp_ln899_fu_1508_p2 = (($signed(add_ln700_1_fu_1493_p2) < $signed(zext_ln186_1_fu_1504_p1)) ? 1'b1 : 1'b0);

assign inElem_V_1_fu_910_p65 = sf_1_fu_200[5:0];

assign inputBuf_0_V_fu_1044_p1 = in_V_V_TDATA[1:0];

assign nf_1_fu_1439_p3 = ((icmp_ln173_fu_1433_p2[0:0] === 1'b1) ? 32'd0 : nf_fu_1427_p2);

assign nf_fu_1427_p2 = (nf_assign_fu_460 + 32'd1);

assign out_V_V_TDATA = tmp_V_fu_1574_p2;

assign ret_V_fu_1483_p0 = ret_V_fu_1483_p00;

assign ret_V_fu_1483_p00 = ap_phi_reg_pp0_iter1_p_Val2_s_reg_540;

assign select_ln137_fu_1468_p3 = ((icmp_ln137_reg_2089[0:0] === 1'b1) ? 9'd0 : accu_V_0_0_0_fu_192);

assign select_ln186_fu_1544_p3 = ((threshs_m_thresholds_q0[0:0] === 1'b1) ? 9'd15 : 9'd0);

assign sext_ln700_fu_1489_p1 = ret_V_fu_1483_p2;

assign sf_fu_1395_p2 = (sf_1_fu_200 + 32'd1);

assign threshs_m_thresholds_1_address0 = zext_ln186_fu_1420_p1;

assign threshs_m_thresholds_2_address0 = zext_ln186_fu_1420_p1;

assign threshs_m_thresholds_address0 = zext_ln186_fu_1420_p1;

assign tile_1_fu_1447_p3 = ((icmp_ln173_fu_1433_p2[0:0] === 1'b1) ? 32'd0 : tile_fu_1389_p2);

assign tile_fu_1389_p2 = (tile_assign_fu_196 + 32'd1);

assign tmp_V_fu_1574_p2 = (add_ln700_fu_1568_p2 + zext_ln700_fu_1520_p1);

assign trunc_ln321_fu_1048_p1 = sf_1_fu_200[5:0];

assign weights_m_weights_V_address0 = zext_ln137_fu_1384_p1;

assign xor_ln899_1_fu_1534_p2 = (icmp_ln899_1_fu_1528_p2 ^ 1'd1);

assign xor_ln899_2_fu_1558_p2 = (icmp_ln899_2_fu_1552_p2 ^ 1'd1);

assign xor_ln899_fu_1514_p2 = (icmp_ln899_fu_1508_p2 ^ 1'd1);

assign zext_ln137_fu_1384_p1 = tile_assign_fu_196;

assign zext_ln186_1_fu_1504_p1 = threshs_m_thresholds_2_q0;

assign zext_ln186_2_fu_1524_p1 = threshs_m_thresholds_1_q0;

assign zext_ln186_fu_1420_p1 = nf_assign_fu_460;

assign zext_ln700_1_fu_1540_p1 = xor_ln899_1_fu_1534_p2;

assign zext_ln700_2_fu_1564_p1 = xor_ln899_2_fu_1558_p2;

assign zext_ln700_fu_1520_p1 = xor_ln899_fu_1514_p2;

endmodule //StreamingFCLayer_Batch_3_Matrix_Vector_Activa
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_StreamingFCLayer_eOg.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module StreamingFCLayer_Batch_3_StreamingFCLayer_eOg #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH       = 32,
    din5_WIDTH       = 32,
    din6_WIDTH       = 32,
    din7_WIDTH       = 32,
    din8_WIDTH       = 32,
    din9_WIDTH       = 32,
    din10_WIDTH       = 32,
    din11_WIDTH       = 32,
    din12_WIDTH       = 32,
    din13_WIDTH       = 32,
    din14_WIDTH       = 32,
    din15_WIDTH       = 32,
    din16_WIDTH       = 32,
    din17_WIDTH       = 32,
    din18_WIDTH       = 32,
    din19_WIDTH       = 32,
    din20_WIDTH       = 32,
    din21_WIDTH       = 32,
    din22_WIDTH       = 32,
    din23_WIDTH       = 32,
    din24_WIDTH       = 32,
    din25_WIDTH       = 32,
    din26_WIDTH       = 32,
    din27_WIDTH       = 32,
    din28_WIDTH       = 32,
    din29_WIDTH       = 32,
    din30_WIDTH       = 32,
    din31_WIDTH       = 32,
    din32_WIDTH       = 32,
    din33_WIDTH       = 32,
    din34_WIDTH       = 32,
    din35_WIDTH       = 32,
    din36_WIDTH       = 32,
    din37_WIDTH       = 32,
    din38_WIDTH       = 32,
    din39_WIDTH       = 32,
    din40_WIDTH       = 32,
    din41_WIDTH       = 32,
    din42_WIDTH       = 32,
    din43_WIDTH       = 32,
    din44_WIDTH       = 32,
    din45_WIDTH       = 32,
    din46_WIDTH       = 32,
    din47_WIDTH       = 32,
    din48_WIDTH       = 32,
    din49_WIDTH       = 32,
    din50_WIDTH       = 32,
    din51_WIDTH       = 32,
    din52_WIDTH       = 32,
    din53_WIDTH       = 32,
    din54_WIDTH       = 32,
    din55_WIDTH       = 32,
    din56_WIDTH       = 32,
    din57_WIDTH       = 32,
    din58_WIDTH       = 32,
    din59_WIDTH       = 32,
    din60_WIDTH       = 32,
    din61_WIDTH       = 32,
    din62_WIDTH       = 32,
    din63_WIDTH       = 32,
    din64_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [1 : 0]     din0,
    input  [1 : 0]     din1,
    input  [1 : 0]     din2,
    input  [1 : 0]     din3,
    input  [1 : 0]     din4,
    input  [1 : 0]     din5,
    input  [1 : 0]     din6,
    input  [1 : 0]     din7,
    input  [1 : 0]     din8,
    input  [1 : 0]     din9,
    input  [1 : 0]     din10,
    input  [1 : 0]     din11,
    input  [1 : 0]     din12,
    input  [1 : 0]     din13,
    input  [1 : 0]     din14,
    input  [1 : 0]     din15,
    input  [1 : 0]     din16,
    input  [1 : 0]     din17,
    input  [1 : 0]     din18,
    input  [1 : 0]     din19,
    input  [1 : 0]     din20,
    input  [1 : 0]     din21,
    input  [1 : 0]     din22,
    input  [1 : 0]     din23,
    input  [1 : 0]     din24,
    input  [1 : 0]     din25,
    input  [1 : 0]     din26,
    input  [1 : 0]     din27,
    input  [1 : 0]     din28,
    input  [1 : 0]     din29,
    input  [1 : 0]     din30,
    input  [1 : 0]     din31,
    input  [1 : 0]     din32,
    input  [1 : 0]     din33,
    input  [1 : 0]     din34,
    input  [1 : 0]     din35,
    input  [1 : 0]     din36,
    input  [1 : 0]     din37,
    input  [1 : 0]     din38,
    input  [1 : 0]     din39,
    input  [1 : 0]     din40,
    input  [1 : 0]     din41,
    input  [1 : 0]     din42,
    input  [1 : 0]     din43,
    input  [1 : 0]     din44,
    input  [1 : 0]     din45,
    input  [1 : 0]     din46,
    input  [1 : 0]     din47,
    input  [1 : 0]     din48,
    input  [1 : 0]     din49,
    input  [1 : 0]     din50,
    input  [1 : 0]     din51,
    input  [1 : 0]     din52,
    input  [1 : 0]     din53,
    input  [1 : 0]     din54,
    input  [1 : 0]     din55,
    input  [1 : 0]     din56,
    input  [1 : 0]     din57,
    input  [1 : 0]     din58,
    input  [1 : 0]     din59,
    input  [1 : 0]     din60,
    input  [1 : 0]     din61,
    input  [1 : 0]     din62,
    input  [1 : 0]     din63,
    input  [5 : 0]    din64,
    output [1 : 0]   dout);

// puts internal signals
wire [5 : 0]     sel;
// level 1 signals
wire [1 : 0]         mux_1_0;
wire [1 : 0]         mux_1_1;
wire [1 : 0]         mux_1_2;
wire [1 : 0]         mux_1_3;
wire [1 : 0]         mux_1_4;
wire [1 : 0]         mux_1_5;
wire [1 : 0]         mux_1_6;
wire [1 : 0]         mux_1_7;
wire [1 : 0]         mux_1_8;
wire [1 : 0]         mux_1_9;
wire [1 : 0]         mux_1_10;
wire [1 : 0]         mux_1_11;
wire [1 : 0]         mux_1_12;
wire [1 : 0]         mux_1_13;
wire [1 : 0]         mux_1_14;
wire [1 : 0]         mux_1_15;
wire [1 : 0]         mux_1_16;
wire [1 : 0]         mux_1_17;
wire [1 : 0]         mux_1_18;
wire [1 : 0]         mux_1_19;
wire [1 : 0]         mux_1_20;
wire [1 : 0]         mux_1_21;
wire [1 : 0]         mux_1_22;
wire [1 : 0]         mux_1_23;
wire [1 : 0]         mux_1_24;
wire [1 : 0]         mux_1_25;
wire [1 : 0]         mux_1_26;
wire [1 : 0]         mux_1_27;
wire [1 : 0]         mux_1_28;
wire [1 : 0]         mux_1_29;
wire [1 : 0]         mux_1_30;
wire [1 : 0]         mux_1_31;
// level 2 signals
wire [1 : 0]         mux_2_0;
wire [1 : 0]         mux_2_1;
wire [1 : 0]         mux_2_2;
wire [1 : 0]         mux_2_3;
wire [1 : 0]         mux_2_4;
wire [1 : 0]         mux_2_5;
wire [1 : 0]         mux_2_6;
wire [1 : 0]         mux_2_7;
wire [1 : 0]         mux_2_8;
wire [1 : 0]         mux_2_9;
wire [1 : 0]         mux_2_10;
wire [1 : 0]         mux_2_11;
wire [1 : 0]         mux_2_12;
wire [1 : 0]         mux_2_13;
wire [1 : 0]         mux_2_14;
wire [1 : 0]         mux_2_15;
// level 3 signals
wire [1 : 0]         mux_3_0;
wire [1 : 0]         mux_3_1;
wire [1 : 0]         mux_3_2;
wire [1 : 0]         mux_3_3;
wire [1 : 0]         mux_3_4;
wire [1 : 0]         mux_3_5;
wire [1 : 0]         mux_3_6;
wire [1 : 0]         mux_3_7;
// level 4 signals
wire [1 : 0]         mux_4_0;
wire [1 : 0]         mux_4_1;
wire [1 : 0]         mux_4_2;
wire [1 : 0]         mux_4_3;
// level 5 signals
wire [1 : 0]         mux_5_0;
wire [1 : 0]         mux_5_1;
// level 6 signals
wire [1 : 0]         mux_6_0;

assign sel = din64;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;
assign mux_1_2 = (sel[0] == 0)? din4 : din5;
assign mux_1_3 = (sel[0] == 0)? din6 : din7;
assign mux_1_4 = (sel[0] == 0)? din8 : din9;
assign mux_1_5 = (sel[0] == 0)? din10 : din11;
assign mux_1_6 = (sel[0] == 0)? din12 : din13;
assign mux_1_7 = (sel[0] == 0)? din14 : din15;
assign mux_1_8 = (sel[0] == 0)? din16 : din17;
assign mux_1_9 = (sel[0] == 0)? din18 : din19;
assign mux_1_10 = (sel[0] == 0)? din20 : din21;
assign mux_1_11 = (sel[0] == 0)? din22 : din23;
assign mux_1_12 = (sel[0] == 0)? din24 : din25;
assign mux_1_13 = (sel[0] == 0)? din26 : din27;
assign mux_1_14 = (sel[0] == 0)? din28 : din29;
assign mux_1_15 = (sel[0] == 0)? din30 : din31;
assign mux_1_16 = (sel[0] == 0)? din32 : din33;
assign mux_1_17 = (sel[0] == 0)? din34 : din35;
assign mux_1_18 = (sel[0] == 0)? din36 : din37;
assign mux_1_19 = (sel[0] == 0)? din38 : din39;
assign mux_1_20 = (sel[0] == 0)? din40 : din41;
assign mux_1_21 = (sel[0] == 0)? din42 : din43;
assign mux_1_22 = (sel[0] == 0)? din44 : din45;
assign mux_1_23 = (sel[0] == 0)? din46 : din47;
assign mux_1_24 = (sel[0] == 0)? din48 : din49;
assign mux_1_25 = (sel[0] == 0)? din50 : din51;
assign mux_1_26 = (sel[0] == 0)? din52 : din53;
assign mux_1_27 = (sel[0] == 0)? din54 : din55;
assign mux_1_28 = (sel[0] == 0)? din56 : din57;
assign mux_1_29 = (sel[0] == 0)? din58 : din59;
assign mux_1_30 = (sel[0] == 0)? din60 : din61;
assign mux_1_31 = (sel[0] == 0)? din62 : din63;

// Generate level 2 logic
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;
assign mux_2_1 = (sel[1] == 0)? mux_1_2 : mux_1_3;
assign mux_2_2 = (sel[1] == 0)? mux_1_4 : mux_1_5;
assign mux_2_3 = (sel[1] == 0)? mux_1_6 : mux_1_7;
assign mux_2_4 = (sel[1] == 0)? mux_1_8 : mux_1_9;
assign mux_2_5 = (sel[1] == 0)? mux_1_10 : mux_1_11;
assign mux_2_6 = (sel[1] == 0)? mux_1_12 : mux_1_13;
assign mux_2_7 = (sel[1] == 0)? mux_1_14 : mux_1_15;
assign mux_2_8 = (sel[1] == 0)? mux_1_16 : mux_1_17;
assign mux_2_9 = (sel[1] == 0)? mux_1_18 : mux_1_19;
assign mux_2_10 = (sel[1] == 0)? mux_1_20 : mux_1_21;
assign mux_2_11 = (sel[1] == 0)? mux_1_22 : mux_1_23;
assign mux_2_12 = (sel[1] == 0)? mux_1_24 : mux_1_25;
assign mux_2_13 = (sel[1] == 0)? mux_1_26 : mux_1_27;
assign mux_2_14 = (sel[1] == 0)? mux_1_28 : mux_1_29;
assign mux_2_15 = (sel[1] == 0)? mux_1_30 : mux_1_31;

// Generate level 3 logic
assign mux_3_0 = (sel[2] == 0)? mux_2_0 : mux_2_1;
assign mux_3_1 = (sel[2] == 0)? mux_2_2 : mux_2_3;
assign mux_3_2 = (sel[2] == 0)? mux_2_4 : mux_2_5;
assign mux_3_3 = (sel[2] == 0)? mux_2_6 : mux_2_7;
assign mux_3_4 = (sel[2] == 0)? mux_2_8 : mux_2_9;
assign mux_3_5 = (sel[2] == 0)? mux_2_10 : mux_2_11;
assign mux_3_6 = (sel[2] == 0)? mux_2_12 : mux_2_13;
assign mux_3_7 = (sel[2] == 0)? mux_2_14 : mux_2_15;

// Generate level 4 logic
assign mux_4_0 = (sel[3] == 0)? mux_3_0 : mux_3_1;
assign mux_4_1 = (sel[3] == 0)? mux_3_2 : mux_3_3;
assign mux_4_2 = (sel[3] == 0)? mux_3_4 : mux_3_5;
assign mux_4_3 = (sel[3] == 0)? mux_3_6 : mux_3_7;

// Generate level 5 logic
assign mux_5_0 = (sel[4] == 0)? mux_4_0 : mux_4_1;
assign mux_5_1 = (sel[4] == 0)? mux_4_2 : mux_4_3;

// Generate level 6 logic
assign mux_6_0 = (sel[5] == 0)? mux_5_0 : mux_5_1;

// output logic
assign dout = mux_6_0;

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f1ac/hdl/verilog/StreamingDataWidthConverter_Batch_0_StreamingDataWidthCo_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingDataWidthConverter_Batch_0_StreamingDataWidthCo_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [71:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln508_fu_96_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln517_reg_175;
reg   [63:0] r_V_reg_69;
reg   [9:0] t_0_reg_80;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [9:0] t_fu_102_p2;
wire   [71:0] p_Result_s_fu_111_p3;
reg   [71:0] p_Result_s_reg_170;
wire   [0:0] icmp_ln517_fu_125_p2;
wire   [63:0] trunc_ln_fu_146_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg   [31:0] i_1_fu_52;
wire   [31:0] i_fu_119_p2;
reg    ap_block_pp0_stage0_01001;
wire   [55:0] tmp_1_fu_136_p4;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_125_p2 == 1'd0) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_1_fu_52 <= i_fu_119_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_125_p2 == 1'd1) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        i_1_fu_52 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        r_V_reg_69 <= trunc_ln_fu_146_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        r_V_reg_69 <= 64'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t_0_reg_80 <= t_fu_102_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        t_0_reg_80 <= 10'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln517_reg_175 <= icmp_ln517_fu_125_p2;
        p_Result_s_reg_170 <= p_Result_s_fu_111_p3;
    end
end

always @ (*) begin
    if ((icmp_ln508_fu_96_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln508_fu_96_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln517_reg_175 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_reg_175 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_96_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_96_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln517_reg_175 == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign i_fu_119_p2 = (i_1_fu_52 + 32'd1);

assign icmp_ln508_fu_96_p2 = ((t_0_reg_80 == 10'd900) ? 1'b1 : 1'b0);

assign icmp_ln517_fu_125_p2 = ((i_fu_119_p2 == 32'd9) ? 1'b1 : 1'b0);

assign out_V_V_TDATA = p_Result_s_reg_170;

assign p_Result_s_fu_111_p3 = {{in_V_V_TDATA}, {r_V_reg_69}};

assign t_fu_102_p2 = (t_0_reg_80 + 10'd1);

assign tmp_1_fu_136_p4 = {{r_V_reg_69[63:8]}};

assign trunc_ln_fu_146_p3 = {{in_V_V_TDATA}, {tmp_1_fu_136_p4}};

endmodule //StreamingDataWidthConverter_Batch_0_StreamingDataWidthCo_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2b8/hdl/verilog/ConvolutionInputGenerator_1_ConvolutionInputGenerator_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="ConvolutionInputGenerator_1_ConvolutionInputGenerator_1,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=6.141188,HLS_SYN_LAT=3077,HLS_SYN_TPT=none,HLS_SYN_MEM=4,HLS_SYN_DSP=0,HLS_SYN_FF=346,HLS_SYN_LUT=1551,HLS_VERSION=2020_1}" *)

module ConvolutionInputGenerator_1_ConvolutionInputGenerator_1 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_ConvolutionInputGene_1_fu_26_ap_start;
wire    grp_ConvolutionInputGene_1_fu_26_ap_done;
wire    grp_ConvolutionInputGene_1_fu_26_ap_idle;
wire    grp_ConvolutionInputGene_1_fu_26_ap_ready;
wire    grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY;
wire   [7:0] grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA;
wire    grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID;
wire    grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY;
reg    grp_ConvolutionInputGene_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_ConvolutionInputGene_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

ConvolutionInputGenerator_1_ConvolutionInputGene_1 grp_ConvolutionInputGene_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_ConvolutionInputGene_1_fu_26_ap_start),
    .ap_done(grp_ConvolutionInputGene_1_fu_26_ap_done),
    .ap_idle(grp_ConvolutionInputGene_1_fu_26_ap_idle),
    .ap_ready(grp_ConvolutionInputGene_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_ConvolutionInputGene_1_fu_26_ap_ready == 1'b1)) begin
            grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_ConvolutionInputGene_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_ConvolutionInputGene_1_fu_26_ap_start = grp_ConvolutionInputGene_1_fu_26_ap_start_reg;

assign grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //ConvolutionInputGenerator_1_ConvolutionInputGenerator_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_LabelSelect_Batch_0_0/synth/finn_design_LabelSelect_Batch_0_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:LabelSelect_Batch_0:1.0
// IP Revision: 2105101148

(* X_CORE_INFO = "LabelSelect_Batch_0_LabelSelect_Batch_0,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_LabelSelect_Batch_0_0,LabelSelect_Batch_0_LabelSelect_Batch_0,{}" *)
(* CORE_GENERATION_INFO = "finn_design_LabelSelect_Batch_0_0,LabelSelect_Batch_0_LabelSelect_Batch_0,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=LabelSelect_Batch_0,x_ipVersion=1.0,x_ipCoreRevision=2105101148,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_LabelSelect_Batch_0_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  LabelSelect_Batch_0_LabelSelect_Batch_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/2003/hdl/verilog/StreamingDataWidthConverter_Batch_2_StreamingDataWidthCo_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingDataWidthConverter_Batch_2_StreamingDataWidthCo_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [127:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln476_fu_104_p2;
wire   [0:0] icmp_ln479_fu_116_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln476_reg_166;
reg   [123:0] p_025_0_reg_61;
reg   [31:0] o_0_reg_73;
reg   [9:0] t_0_reg_84;
reg    ap_predicate_op16_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [9:0] t_fu_110_p2;
reg   [0:0] icmp_ln479_reg_175;
wire   [31:0] select_ln490_fu_134_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg   [127:0] ap_phi_mux_p_Val2_s_phi_fu_98_p4;
wire   [127:0] ap_phi_reg_pp0_iter0_p_Val2_s_reg_95;
reg   [127:0] ap_phi_reg_pp0_iter1_p_Val2_s_reg_95;
wire   [127:0] zext_ln476_fu_142_p1;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] o_fu_122_p2;
wire   [0:0] icmp_ln490_fu_128_p2;
wire   [3:0] eo_V_fu_147_p1;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_86;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_86)) begin
        if (((icmp_ln479_fu_116_p2 == 1'd1) & (icmp_ln476_fu_104_p2 == 1'd0))) begin
            ap_phi_reg_pp0_iter1_p_Val2_s_reg_95 <= in_V_V_TDATA;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_p_Val2_s_reg_95 <= ap_phi_reg_pp0_iter0_p_Val2_s_reg_95;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_fu_104_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        o_0_reg_73 <= select_ln490_fu_134_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        o_0_reg_73 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_reg_166 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_025_0_reg_61 <= {{ap_phi_mux_p_Val2_s_phi_fu_98_p4[127:4]}};
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        p_025_0_reg_61 <= 124'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_fu_104_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t_0_reg_84 <= t_fu_110_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        t_0_reg_84 <= 10'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln476_reg_166 <= icmp_ln476_fu_104_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_fu_104_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln479_reg_175 <= icmp_ln479_fu_116_p2;
    end
end

always @ (*) begin
    if ((icmp_ln476_fu_104_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln479_reg_175 == 1'd0) & (icmp_ln476_reg_166 == 1'd0))) begin
        ap_phi_mux_p_Val2_s_phi_fu_98_p4 = zext_ln476_fu_142_p1;
    end else begin
        ap_phi_mux_p_Val2_s_phi_fu_98_p4 = ap_phi_reg_pp0_iter1_p_Val2_s_reg_95;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln479_fu_116_p2 == 1'd1) & (icmp_ln476_fu_104_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op16_read_state2 == 1'b1))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln476_reg_166 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln476_reg_166 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln476_fu_104_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln476_fu_104_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op16_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op16_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op16_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((in_V_V_TVALID == 1'b0) & (ap_predicate_op16_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln476_reg_166 == 1'd0) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_86 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_reg_pp0_iter0_p_Val2_s_reg_95 = 'bx;

always @ (*) begin
    ap_predicate_op16_read_state2 = ((icmp_ln479_fu_116_p2 == 1'd1) & (icmp_ln476_fu_104_p2 == 1'd0));
end

assign eo_V_fu_147_p1 = ap_phi_mux_p_Val2_s_phi_fu_98_p4[3:0];

assign icmp_ln476_fu_104_p2 = ((t_0_reg_84 == 10'd800) ? 1'b1 : 1'b0);

assign icmp_ln479_fu_116_p2 = ((o_0_reg_73 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln490_fu_128_p2 = ((o_fu_122_p2 == 32'd32) ? 1'b1 : 1'b0);

assign o_fu_122_p2 = (32'd1 + o_0_reg_73);

assign out_V_V_TDATA = eo_V_fu_147_p1;

assign select_ln490_fu_134_p3 = ((icmp_ln490_fu_128_p2[0:0] === 1'b1) ? 32'd0 : o_fu_122_p2);

assign t_fu_110_p2 = (t_0_reg_84 + 10'd1);

assign zext_ln476_fu_142_p1 = p_025_0_reg_61;

endmodule //StreamingDataWidthConverter_Batch_2_StreamingDataWidthCo_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 4;
parameter AWIDTH = 6;
parameter MEM_SIZE = 64;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_2_j8ke1nb0/project_StreamingFCLayer_Batch_2/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb_rom.dat", ram);
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
module StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd4;
parameter AddressRange = 32'd64;
parameter AddressWidth = 32'd6;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb_rom StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=16.988187,HLS_SYN_LAT=4614,HLS_SYN_TPT=none,HLS_SYN_MEM=8,HLS_SYN_DSP=0,HLS_SYN_FF=9727,HLS_SYN_LUT=3342,HLS_VERSION=2020_1}" *)

module StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [127:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire   [15:0] weights_m_weights_0_q0;
wire    grp_Matrix_Vector_Activa_fu_34_ap_start;
wire    grp_Matrix_Vector_Activa_fu_34_ap_done;
wire    grp_Matrix_Vector_Activa_fu_34_ap_idle;
wire    grp_Matrix_Vector_Activa_fu_34_ap_ready;
wire    grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY;
wire   [7:0] grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA;
wire    grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID;
wire    grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY;
wire   [12:0] grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_address0;
wire    grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_ce0;
reg    grp_Matrix_Vector_Activa_fu_34_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [127:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_Matrix_Vector_Activa_fu_34_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingFCLayer_Batch_2_StreamingFCLayer_g8j #(
    .DataWidth( 16 ),
    .AddressRange( 4608 ),
    .AddressWidth( 13 ))
weights_m_weights_0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_ce0),
    .q0(weights_m_weights_0_q0)
);

StreamingFCLayer_Batch_2_Matrix_Vector_Activa grp_Matrix_Vector_Activa_fu_34(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_Matrix_Vector_Activa_fu_34_ap_start),
    .ap_done(grp_Matrix_Vector_Activa_fu_34_ap_done),
    .ap_idle(grp_Matrix_Vector_Activa_fu_34_ap_idle),
    .ap_ready(grp_Matrix_Vector_Activa_fu_34_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY),
    .out_V_V_TDATA(grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA),
    .out_V_V_TVALID(grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID),
    .out_V_V_TREADY(grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY),
    .weights_m_weights_V_address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_address0),
    .weights_m_weights_V_ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_ce0),
    .weights_m_weights_V_q0(weights_m_weights_0_q0)
);

regslice_both #(
    .DataWidth( 128 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA),
    .vld_in(grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b1;
        end else if ((grp_Matrix_Vector_Activa_fu_34_ap_ready == 1'b1)) begin
            grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((in0_V_V_TVALID == 1'b1) & (regslice_both_in0_V_V_U_ack_in == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_Matrix_Vector_Activa_fu_34_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_out_V_V_U_apdone_blk == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_Matrix_Vector_Activa_fu_34_ap_start = grp_Matrix_Vector_Activa_fu_34_ap_start_reg;

assign grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingDataWidthConverter_Batch_3_0/synth/finn_design_StreamingDataWidthConverter_Batch_3_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingDataWidthConverter_Batch_3:1.0
// IP Revision: 2105101207

(* X_CORE_INFO = "StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingDataWidthConverter_Batch_3_0,StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingDataWidthConverter_Batch_3_0,StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingDataWidthConverter_Batch_3,x_ipVersion=1.0,x_ipCoreRevision=2105101207,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingDataWidthConverter_Batch_3_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 5, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [39 : 0] out_V_V_TDATA;

  StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingFCLayer_Batch_2_0/synth/finn_design_StreamingFCLayer_Batch_2_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingFCLayer_Batch_2:1.0
// IP Revision: 2105101200

(* X_CORE_INFO = "StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingFCLayer_Batch_2_0,StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingFCLayer_Batch_2_0,StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingFCLayer_Batch_2,x_ipVersion=1.0,x_ipCoreRevision=2105101200,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingFCLayer_Batch_2_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 16, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [127 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  StreamingFCLayer_Batch_2_StreamingFCLayer_Batch_2 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ae85/hdl/verilog/StreamingDataWidthConverter_Batch_5_StreamingDataWidthCo_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingDataWidthConverter_Batch_5_StreamingDataWidthCo_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [15:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [127:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln508_fu_96_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln517_reg_175;
reg   [111:0] r_V_reg_69;
reg   [9:0] t_0_reg_80;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [9:0] t_fu_102_p2;
wire   [127:0] p_Result_s_fu_111_p3;
reg   [127:0] p_Result_s_reg_170;
wire   [0:0] icmp_ln517_fu_125_p2;
wire   [111:0] trunc_ln_fu_146_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg   [31:0] i_1_fu_52;
wire   [31:0] i_fu_119_p2;
reg    ap_block_pp0_stage0_01001;
wire   [95:0] tmp_1_fu_136_p4;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_125_p2 == 1'd0) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_1_fu_52 <= i_fu_119_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_125_p2 == 1'd1) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        i_1_fu_52 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        r_V_reg_69 <= trunc_ln_fu_146_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        r_V_reg_69 <= 112'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t_0_reg_80 <= t_fu_102_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        t_0_reg_80 <= 10'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln517_reg_175 <= icmp_ln517_fu_125_p2;
        p_Result_s_reg_170 <= p_Result_s_fu_111_p3;
    end
end

always @ (*) begin
    if ((icmp_ln508_fu_96_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln508_fu_96_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_96_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln517_reg_175 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_reg_175 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_96_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_96_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((icmp_ln508_fu_96_p2 == 1'd0) & (in_V_V_TVALID == 1'b0));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln517_reg_175 == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign i_fu_119_p2 = (i_1_fu_52 + 32'd1);

assign icmp_ln508_fu_96_p2 = ((t_0_reg_80 == 10'd576) ? 1'b1 : 1'b0);

assign icmp_ln517_fu_125_p2 = ((i_fu_119_p2 == 32'd8) ? 1'b1 : 1'b0);

assign out_V_V_TDATA = p_Result_s_reg_170;

assign p_Result_s_fu_111_p3 = {{in_V_V_TDATA}, {r_V_reg_69}};

assign t_fu_102_p2 = (t_0_reg_80 + 10'd1);

assign tmp_1_fu_136_p4 = {{r_V_reg_69[111:16]}};

assign trunc_ln_fu_146_p3 = {{in_V_V_TDATA}, {tmp_1_fu_136_p4}};

endmodule //StreamingDataWidthConverter_Batch_5_StreamingDataWidthCo_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_StreamingFCLayer_eOg.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module StreamingFCLayer_Batch_2_StreamingFCLayer_eOg #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH       = 32,
    din5_WIDTH       = 32,
    din6_WIDTH       = 32,
    din7_WIDTH       = 32,
    din8_WIDTH       = 32,
    din9_WIDTH       = 32,
    din10_WIDTH       = 32,
    din11_WIDTH       = 32,
    din12_WIDTH       = 32,
    din13_WIDTH       = 32,
    din14_WIDTH       = 32,
    din15_WIDTH       = 32,
    din16_WIDTH       = 32,
    din17_WIDTH       = 32,
    din18_WIDTH       = 32,
    din19_WIDTH       = 32,
    din20_WIDTH       = 32,
    din21_WIDTH       = 32,
    din22_WIDTH       = 32,
    din23_WIDTH       = 32,
    din24_WIDTH       = 32,
    din25_WIDTH       = 32,
    din26_WIDTH       = 32,
    din27_WIDTH       = 32,
    din28_WIDTH       = 32,
    din29_WIDTH       = 32,
    din30_WIDTH       = 32,
    din31_WIDTH       = 32,
    din32_WIDTH       = 32,
    din33_WIDTH       = 32,
    din34_WIDTH       = 32,
    din35_WIDTH       = 32,
    din36_WIDTH       = 32,
    din37_WIDTH       = 32,
    din38_WIDTH       = 32,
    din39_WIDTH       = 32,
    din40_WIDTH       = 32,
    din41_WIDTH       = 32,
    din42_WIDTH       = 32,
    din43_WIDTH       = 32,
    din44_WIDTH       = 32,
    din45_WIDTH       = 32,
    din46_WIDTH       = 32,
    din47_WIDTH       = 32,
    din48_WIDTH       = 32,
    din49_WIDTH       = 32,
    din50_WIDTH       = 32,
    din51_WIDTH       = 32,
    din52_WIDTH       = 32,
    din53_WIDTH       = 32,
    din54_WIDTH       = 32,
    din55_WIDTH       = 32,
    din56_WIDTH       = 32,
    din57_WIDTH       = 32,
    din58_WIDTH       = 32,
    din59_WIDTH       = 32,
    din60_WIDTH       = 32,
    din61_WIDTH       = 32,
    din62_WIDTH       = 32,
    din63_WIDTH       = 32,
    din64_WIDTH       = 32,
    din65_WIDTH       = 32,
    din66_WIDTH       = 32,
    din67_WIDTH       = 32,
    din68_WIDTH       = 32,
    din69_WIDTH       = 32,
    din70_WIDTH       = 32,
    din71_WIDTH       = 32,
    din72_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [127 : 0]     din0,
    input  [127 : 0]     din1,
    input  [127 : 0]     din2,
    input  [127 : 0]     din3,
    input  [127 : 0]     din4,
    input  [127 : 0]     din5,
    input  [127 : 0]     din6,
    input  [127 : 0]     din7,
    input  [127 : 0]     din8,
    input  [127 : 0]     din9,
    input  [127 : 0]     din10,
    input  [127 : 0]     din11,
    input  [127 : 0]     din12,
    input  [127 : 0]     din13,
    input  [127 : 0]     din14,
    input  [127 : 0]     din15,
    input  [127 : 0]     din16,
    input  [127 : 0]     din17,
    input  [127 : 0]     din18,
    input  [127 : 0]     din19,
    input  [127 : 0]     din20,
    input  [127 : 0]     din21,
    input  [127 : 0]     din22,
    input  [127 : 0]     din23,
    input  [127 : 0]     din24,
    input  [127 : 0]     din25,
    input  [127 : 0]     din26,
    input  [127 : 0]     din27,
    input  [127 : 0]     din28,
    input  [127 : 0]     din29,
    input  [127 : 0]     din30,
    input  [127 : 0]     din31,
    input  [127 : 0]     din32,
    input  [127 : 0]     din33,
    input  [127 : 0]     din34,
    input  [127 : 0]     din35,
    input  [127 : 0]     din36,
    input  [127 : 0]     din37,
    input  [127 : 0]     din38,
    input  [127 : 0]     din39,
    input  [127 : 0]     din40,
    input  [127 : 0]     din41,
    input  [127 : 0]     din42,
    input  [127 : 0]     din43,
    input  [127 : 0]     din44,
    input  [127 : 0]     din45,
    input  [127 : 0]     din46,
    input  [127 : 0]     din47,
    input  [127 : 0]     din48,
    input  [127 : 0]     din49,
    input  [127 : 0]     din50,
    input  [127 : 0]     din51,
    input  [127 : 0]     din52,
    input  [127 : 0]     din53,
    input  [127 : 0]     din54,
    input  [127 : 0]     din55,
    input  [127 : 0]     din56,
    input  [127 : 0]     din57,
    input  [127 : 0]     din58,
    input  [127 : 0]     din59,
    input  [127 : 0]     din60,
    input  [127 : 0]     din61,
    input  [127 : 0]     din62,
    input  [127 : 0]     din63,
    input  [127 : 0]     din64,
    input  [127 : 0]     din65,
    input  [127 : 0]     din66,
    input  [127 : 0]     din67,
    input  [127 : 0]     din68,
    input  [127 : 0]     din69,
    input  [127 : 0]     din70,
    input  [127 : 0]     din71,
    input  [6 : 0]    din72,
    output [127 : 0]   dout);

// puts internal signals
wire [6 : 0]     sel;
// level 1 signals
wire [127 : 0]         mux_1_0;
wire [127 : 0]         mux_1_1;
wire [127 : 0]         mux_1_2;
wire [127 : 0]         mux_1_3;
wire [127 : 0]         mux_1_4;
wire [127 : 0]         mux_1_5;
wire [127 : 0]         mux_1_6;
wire [127 : 0]         mux_1_7;
wire [127 : 0]         mux_1_8;
wire [127 : 0]         mux_1_9;
wire [127 : 0]         mux_1_10;
wire [127 : 0]         mux_1_11;
wire [127 : 0]         mux_1_12;
wire [127 : 0]         mux_1_13;
wire [127 : 0]         mux_1_14;
wire [127 : 0]         mux_1_15;
wire [127 : 0]         mux_1_16;
wire [127 : 0]         mux_1_17;
wire [127 : 0]         mux_1_18;
wire [127 : 0]         mux_1_19;
wire [127 : 0]         mux_1_20;
wire [127 : 0]         mux_1_21;
wire [127 : 0]         mux_1_22;
wire [127 : 0]         mux_1_23;
wire [127 : 0]         mux_1_24;
wire [127 : 0]         mux_1_25;
wire [127 : 0]         mux_1_26;
wire [127 : 0]         mux_1_27;
wire [127 : 0]         mux_1_28;
wire [127 : 0]         mux_1_29;
wire [127 : 0]         mux_1_30;
wire [127 : 0]         mux_1_31;
wire [127 : 0]         mux_1_32;
wire [127 : 0]         mux_1_33;
wire [127 : 0]         mux_1_34;
wire [127 : 0]         mux_1_35;
// level 2 signals
wire [127 : 0]         mux_2_0;
wire [127 : 0]         mux_2_1;
wire [127 : 0]         mux_2_2;
wire [127 : 0]         mux_2_3;
wire [127 : 0]         mux_2_4;
wire [127 : 0]         mux_2_5;
wire [127 : 0]         mux_2_6;
wire [127 : 0]         mux_2_7;
wire [127 : 0]         mux_2_8;
wire [127 : 0]         mux_2_9;
wire [127 : 0]         mux_2_10;
wire [127 : 0]         mux_2_11;
wire [127 : 0]         mux_2_12;
wire [127 : 0]         mux_2_13;
wire [127 : 0]         mux_2_14;
wire [127 : 0]         mux_2_15;
wire [127 : 0]         mux_2_16;
wire [127 : 0]         mux_2_17;
// level 3 signals
wire [127 : 0]         mux_3_0;
wire [127 : 0]         mux_3_1;
wire [127 : 0]         mux_3_2;
wire [127 : 0]         mux_3_3;
wire [127 : 0]         mux_3_4;
wire [127 : 0]         mux_3_5;
wire [127 : 0]         mux_3_6;
wire [127 : 0]         mux_3_7;
wire [127 : 0]         mux_3_8;
// level 4 signals
wire [127 : 0]         mux_4_0;
wire [127 : 0]         mux_4_1;
wire [127 : 0]         mux_4_2;
wire [127 : 0]         mux_4_3;
wire [127 : 0]         mux_4_4;
// level 5 signals
wire [127 : 0]         mux_5_0;
wire [127 : 0]         mux_5_1;
wire [127 : 0]         mux_5_2;
// level 6 signals
wire [127 : 0]         mux_6_0;
wire [127 : 0]         mux_6_1;
// level 7 signals
wire [127 : 0]         mux_7_0;

assign sel = din72;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;
assign mux_1_2 = (sel[0] == 0)? din4 : din5;
assign mux_1_3 = (sel[0] == 0)? din6 : din7;
assign mux_1_4 = (sel[0] == 0)? din8 : din9;
assign mux_1_5 = (sel[0] == 0)? din10 : din11;
assign mux_1_6 = (sel[0] == 0)? din12 : din13;
assign mux_1_7 = (sel[0] == 0)? din14 : din15;
assign mux_1_8 = (sel[0] == 0)? din16 : din17;
assign mux_1_9 = (sel[0] == 0)? din18 : din19;
assign mux_1_10 = (sel[0] == 0)? din20 : din21;
assign mux_1_11 = (sel[0] == 0)? din22 : din23;
assign mux_1_12 = (sel[0] == 0)? din24 : din25;
assign mux_1_13 = (sel[0] == 0)? din26 : din27;
assign mux_1_14 = (sel[0] == 0)? din28 : din29;
assign mux_1_15 = (sel[0] == 0)? din30 : din31;
assign mux_1_16 = (sel[0] == 0)? din32 : din33;
assign mux_1_17 = (sel[0] == 0)? din34 : din35;
assign mux_1_18 = (sel[0] == 0)? din36 : din37;
assign mux_1_19 = (sel[0] == 0)? din38 : din39;
assign mux_1_20 = (sel[0] == 0)? din40 : din41;
assign mux_1_21 = (sel[0] == 0)? din42 : din43;
assign mux_1_22 = (sel[0] == 0)? din44 : din45;
assign mux_1_23 = (sel[0] == 0)? din46 : din47;
assign mux_1_24 = (sel[0] == 0)? din48 : din49;
assign mux_1_25 = (sel[0] == 0)? din50 : din51;
assign mux_1_26 = (sel[0] == 0)? din52 : din53;
assign mux_1_27 = (sel[0] == 0)? din54 : din55;
assign mux_1_28 = (sel[0] == 0)? din56 : din57;
assign mux_1_29 = (sel[0] == 0)? din58 : din59;
assign mux_1_30 = (sel[0] == 0)? din60 : din61;
assign mux_1_31 = (sel[0] == 0)? din62 : din63;
assign mux_1_32 = (sel[0] == 0)? din64 : din65;
assign mux_1_33 = (sel[0] == 0)? din66 : din67;
assign mux_1_34 = (sel[0] == 0)? din68 : din69;
assign mux_1_35 = (sel[0] == 0)? din70 : din71;

// Generate level 2 logic
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;
assign mux_2_1 = (sel[1] == 0)? mux_1_2 : mux_1_3;
assign mux_2_2 = (sel[1] == 0)? mux_1_4 : mux_1_5;
assign mux_2_3 = (sel[1] == 0)? mux_1_6 : mux_1_7;
assign mux_2_4 = (sel[1] == 0)? mux_1_8 : mux_1_9;
assign mux_2_5 = (sel[1] == 0)? mux_1_10 : mux_1_11;
assign mux_2_6 = (sel[1] == 0)? mux_1_12 : mux_1_13;
assign mux_2_7 = (sel[1] == 0)? mux_1_14 : mux_1_15;
assign mux_2_8 = (sel[1] == 0)? mux_1_16 : mux_1_17;
assign mux_2_9 = (sel[1] == 0)? mux_1_18 : mux_1_19;
assign mux_2_10 = (sel[1] == 0)? mux_1_20 : mux_1_21;
assign mux_2_11 = (sel[1] == 0)? mux_1_22 : mux_1_23;
assign mux_2_12 = (sel[1] == 0)? mux_1_24 : mux_1_25;
assign mux_2_13 = (sel[1] == 0)? mux_1_26 : mux_1_27;
assign mux_2_14 = (sel[1] == 0)? mux_1_28 : mux_1_29;
assign mux_2_15 = (sel[1] == 0)? mux_1_30 : mux_1_31;
assign mux_2_16 = (sel[1] == 0)? mux_1_32 : mux_1_33;
assign mux_2_17 = (sel[1] == 0)? mux_1_34 : mux_1_35;

// Generate level 3 logic
assign mux_3_0 = (sel[2] == 0)? mux_2_0 : mux_2_1;
assign mux_3_1 = (sel[2] == 0)? mux_2_2 : mux_2_3;
assign mux_3_2 = (sel[2] == 0)? mux_2_4 : mux_2_5;
assign mux_3_3 = (sel[2] == 0)? mux_2_6 : mux_2_7;
assign mux_3_4 = (sel[2] == 0)? mux_2_8 : mux_2_9;
assign mux_3_5 = (sel[2] == 0)? mux_2_10 : mux_2_11;
assign mux_3_6 = (sel[2] == 0)? mux_2_12 : mux_2_13;
assign mux_3_7 = (sel[2] == 0)? mux_2_14 : mux_2_15;
assign mux_3_8 = (sel[2] == 0)? mux_2_16 : mux_2_17;

// Generate level 4 logic
assign mux_4_0 = (sel[3] == 0)? mux_3_0 : mux_3_1;
assign mux_4_1 = (sel[3] == 0)? mux_3_2 : mux_3_3;
assign mux_4_2 = (sel[3] == 0)? mux_3_4 : mux_3_5;
assign mux_4_3 = (sel[3] == 0)? mux_3_6 : mux_3_7;
assign mux_4_4 = mux_3_8;

// Generate level 5 logic
assign mux_5_0 = (sel[4] == 0)? mux_4_0 : mux_4_1;
assign mux_5_1 = (sel[4] == 0)? mux_4_2 : mux_4_3;
assign mux_5_2 = mux_4_4;

// Generate level 6 logic
assign mux_6_0 = (sel[5] == 0)? mux_5_0 : mux_5_1;
assign mux_6_1 = mux_5_2;

// Generate level 7 logic
assign mux_7_0 = (sel[6] == 0)? mux_6_0 : mux_6_1;

// output logic
assign dout = mux_7_0;

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 10;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd10;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe_rom StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_dEe.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "block" *) module StreamingFCLayer_Batch_1_StreamingFCLayer_dEe_rom (
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
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_1_q80qszbp/project_StreamingFCLayer_Batch_1/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_dEe_rom.dat", ram);
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
module StreamingFCLayer_Batch_1_StreamingFCLayer_dEe(
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



StreamingFCLayer_Batch_1_StreamingFCLayer_dEe_rom StreamingFCLayer_Batch_1_StreamingFCLayer_dEe_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=16.801250,HLS_SYN_LAT=3205,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=341,HLS_SYN_LUT=1955,HLS_VERSION=2020_1}" *)

module StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [71:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire   [17:0] weights_m_weights_0_q0;
wire   [17:0] weights_m_weights_1_q0;
wire    grp_Matrix_Vector_Activa_fu_42_ap_start;
wire    grp_Matrix_Vector_Activa_fu_42_ap_done;
wire    grp_Matrix_Vector_Activa_fu_42_ap_idle;
wire    grp_Matrix_Vector_Activa_fu_42_ap_ready;
wire    grp_Matrix_Vector_Activa_fu_42_in_V_V_TREADY;
wire   [7:0] grp_Matrix_Vector_Activa_fu_42_out_V_V_TDATA;
wire    grp_Matrix_Vector_Activa_fu_42_out_V_V_TVALID;
wire    grp_Matrix_Vector_Activa_fu_42_out_V_V_TREADY;
wire   [4:0] grp_Matrix_Vector_Activa_fu_42_weights_m_weights_0_V_address0;
wire    grp_Matrix_Vector_Activa_fu_42_weights_m_weights_0_V_ce0;
wire   [4:0] grp_Matrix_Vector_Activa_fu_42_weights_m_weights_1_V_address0;
wire    grp_Matrix_Vector_Activa_fu_42_weights_m_weights_1_V_ce0;
reg    grp_Matrix_Vector_Activa_fu_42_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [71:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_Matrix_Vector_Activa_fu_42_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingFCLayer_Batch_0_StreamingFCLayer_ibs #(
    .DataWidth( 18 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
weights_m_weights_0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_0_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_0_V_ce0),
    .q0(weights_m_weights_0_q0)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_jbC #(
    .DataWidth( 18 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
weights_m_weights_1_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_1_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_1_V_ce0),
    .q0(weights_m_weights_1_q0)
);

StreamingFCLayer_Batch_0_Matrix_Vector_Activa grp_Matrix_Vector_Activa_fu_42(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_Matrix_Vector_Activa_fu_42_ap_start),
    .ap_done(grp_Matrix_Vector_Activa_fu_42_ap_done),
    .ap_idle(grp_Matrix_Vector_Activa_fu_42_ap_idle),
    .ap_ready(grp_Matrix_Vector_Activa_fu_42_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_Matrix_Vector_Activa_fu_42_in_V_V_TREADY),
    .out_V_V_TDATA(grp_Matrix_Vector_Activa_fu_42_out_V_V_TDATA),
    .out_V_V_TVALID(grp_Matrix_Vector_Activa_fu_42_out_V_V_TVALID),
    .out_V_V_TREADY(grp_Matrix_Vector_Activa_fu_42_out_V_V_TREADY),
    .weights_m_weights_0_V_address0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_0_V_address0),
    .weights_m_weights_0_V_ce0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_0_V_ce0),
    .weights_m_weights_0_V_q0(weights_m_weights_0_q0),
    .weights_m_weights_1_V_address0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_1_V_address0),
    .weights_m_weights_1_V_ce0(grp_Matrix_Vector_Activa_fu_42_weights_m_weights_1_V_ce0),
    .weights_m_weights_1_V_q0(weights_m_weights_1_q0)
);

regslice_both #(
    .DataWidth( 72 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_Matrix_Vector_Activa_fu_42_out_V_V_TDATA),
    .vld_in(grp_Matrix_Vector_Activa_fu_42_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_Matrix_Vector_Activa_fu_42_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_Matrix_Vector_Activa_fu_42_ap_start_reg <= 1'b1;
        end else if ((grp_Matrix_Vector_Activa_fu_42_ap_ready == 1'b1)) begin
            grp_Matrix_Vector_Activa_fu_42_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_Matrix_Vector_Activa_fu_42_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_Matrix_Vector_Activa_fu_42_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_out_V_V_U_apdone_blk == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_Matrix_Vector_Activa_fu_42_ap_start = grp_Matrix_Vector_Activa_fu_42_ap_start_reg;

assign grp_Matrix_Vector_Activa_fu_42_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingFCLayer_Batch_0_StreamingFCLayer_Batch_0
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/fab4/hdl/verilog/ConvolutionInputGenerator_0_ConvolutionInputGene_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module ConvolutionInputGenerator_0_ConvolutionInputGene_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln196_fu_366_p2;
wire   [0:0] icmp_ln198_fu_388_p2;
wire   [0:0] and_ln244_fu_582_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln198_reg_869;
reg   [0:0] icmp_ln214_reg_873;
reg   [9:0] i_0_0_reg_269;
reg    ap_predicate_op116_read_state2;
reg    ap_predicate_op159_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_predicate_op202_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [9:0] add_ln196_fu_372_p2;
wire   [0:0] icmp_ln214_fu_397_p2;
wire   [1:0] add_ln220_fu_455_p2;
reg   [1:0] add_ln220_reg_877;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [3:0] inputBuf_0_V_address0;
reg    inputBuf_0_V_ce0;
wire   [7:0] inputBuf_0_V_q0;
reg   [3:0] inputBuf_0_V_address1;
reg    inputBuf_0_V_ce1;
reg    inputBuf_0_V_we1;
wire   [3:0] inputBuf_1_V_address0;
reg    inputBuf_1_V_ce0;
wire   [7:0] inputBuf_1_V_q0;
reg   [3:0] inputBuf_1_V_address1;
reg    inputBuf_1_V_ce1;
reg    inputBuf_1_V_we1;
wire   [3:0] inputBuf_2_V_address0;
reg    inputBuf_2_V_ce0;
wire   [7:0] inputBuf_2_V_q0;
reg   [3:0] inputBuf_2_V_address1;
reg    inputBuf_2_V_ce1;
reg    inputBuf_2_V_we1;
wire   [3:0] inputBuf_3_V_address0;
reg    inputBuf_3_V_ce0;
wire   [7:0] inputBuf_3_V_q0;
reg   [3:0] inputBuf_3_V_address1;
reg    inputBuf_3_V_ce1;
reg    inputBuf_3_V_we1;
wire   [63:0] zext_ln220_fu_441_p1;
wire   [63:0] zext_ln247_fu_588_p1;
wire   [63:0] zext_ln201_fu_700_p1;
reg   [31:0] ofm_y_1_0_fu_76;
wire   [31:0] select_ln235_1_fu_549_p3;
wire   [0:0] icmp_ln223_fu_467_p2;
wire   [0:0] icmp_ln226_fu_484_p2;
wire   [0:0] icmp_ln229_fu_495_p2;
wire   [0:0] icmp_ln232_fu_515_p2;
reg   [31:0] ofm_x_1_0_fu_80;
wire   [31:0] add_ln231_fu_509_p2;
reg   [31:0] k_y_1_0_fu_84;
wire   [31:0] add_ln215_fu_419_p2;
reg   [31:0] inp_15_0_fu_88;
wire   [31:0] select_ln235_fu_541_p3;
wire   [31:0] add_ln203_fu_712_p2;
reg   [31:0] k_x_1_0_fu_92;
wire   [31:0] add_ln225_fu_478_p2;
reg   [31:0] count_simd_1_0_fu_96;
wire   [31:0] add_ln222_fu_461_p2;
reg   [31:0] read_block_1_0_fu_100;
wire   [31:0] zext_ln251_fu_653_p1;
wire   [31:0] add_ln210_fu_748_p2;
wire   [0:0] icmp_ln204_fu_340_p2;
reg   [31:0] current_block_write_s_fu_104;
wire   [31:0] select_ln251_fu_629_p3;
wire   [31:0] select_ln207_fu_740_p3;
reg   [31:0] current_line_1_0_fu_108;
wire   [31:0] select_ln251_1_fu_637_p3;
wire   [31:0] grp_fu_328_p2;
reg   [31:0] counter_internal_blo_fu_112;
wire   [31:0] select_ln263_fu_687_p3;
wire   [7:0] tmp_V_1_fu_764_p6;
reg    ap_block_pp0_stage0_01001;
wire   [1:0] trunc_ln321_1_fu_596_p1;
wire   [1:0] trunc_ln321_fu_708_p1;
wire   [31:0] add_ln219_fu_429_p2;
wire   [31:0] add_ln219_1_fu_435_p2;
wire   [1:0] trunc_ln215_1_fu_425_p1;
wire   [1:0] add_ln220_1_fu_449_p2;
wire   [1:0] trunc_ln215_fu_415_p1;
wire   [31:0] add_ln234_fu_529_p2;
wire   [0:0] icmp_ln235_fu_535_p2;
wire   [0:0] icmp_ln244_fu_570_p2;
wire   [0:0] icmp_ln244_1_fu_576_p2;
wire   [3:0] trunc_ln196_fu_384_p1;
wire   [31:0] add_ln255_fu_609_p2;
wire   [0:0] icmp_ln256_fu_615_p2;
wire   [0:0] icmp_ln251_fu_334_p2;
wire   [31:0] select_ln256_fu_621_p3;
wire   [3:0] add_ln255_1_fu_603_p2;
wire   [3:0] select_ln251_2_fu_645_p3;
wire   [31:0] add_ln262_fu_675_p2;
wire   [0:0] icmp_ln263_fu_681_p2;
wire   [31:0] add_ln206_fu_728_p2;
wire   [0:0] icmp_ln207_fu_734_p2;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_block_pp0;
reg    ap_predicate_op124_store_state2;
reg    ap_enable_operation_124;
reg    ap_enable_state2_pp0_iter0_stage0;
reg    ap_predicate_op66_load_state2;
reg    ap_enable_operation_66;
reg    ap_predicate_op199_load_state3;
reg    ap_enable_operation_199;
reg    ap_enable_state3_pp0_iter1_stage0;
reg    ap_predicate_op167_store_state2;
reg    ap_enable_operation_167;
reg    ap_predicate_op126_store_state2;
reg    ap_enable_operation_126;
reg    ap_predicate_op64_load_state2;
reg    ap_enable_operation_64;
reg    ap_predicate_op198_load_state3;
reg    ap_enable_operation_198;
reg    ap_predicate_op169_store_state2;
reg    ap_enable_operation_169;
reg    ap_predicate_op128_store_state2;
reg    ap_enable_operation_128;
reg    ap_predicate_op62_load_state2;
reg    ap_enable_operation_62;
reg    ap_predicate_op197_load_state3;
reg    ap_enable_operation_197;
reg    ap_predicate_op171_store_state2;
reg    ap_enable_operation_171;
reg    ap_predicate_op130_store_state2;
reg    ap_enable_operation_130;
reg    ap_predicate_op68_load_state2;
reg    ap_enable_operation_68;
reg    ap_predicate_op200_load_state3;
reg    ap_enable_operation_200;
reg    ap_predicate_op173_store_state2;
reg    ap_enable_operation_173;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_647;
reg    ap_condition_230;
reg    ap_condition_653;
reg    ap_condition_657;
reg    ap_condition_661;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

ConvolutionInputGenerator_0_ConvolutionInputGbkb #(
    .DataWidth( 8 ),
    .AddressRange( 12 ),
    .AddressWidth( 4 ))
inputBuf_0_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_0_V_address0),
    .ce0(inputBuf_0_V_ce0),
    .q0(inputBuf_0_V_q0),
    .address1(inputBuf_0_V_address1),
    .ce1(inputBuf_0_V_ce1),
    .we1(inputBuf_0_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_0_ConvolutionInputGbkb #(
    .DataWidth( 8 ),
    .AddressRange( 12 ),
    .AddressWidth( 4 ))
inputBuf_1_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_1_V_address0),
    .ce0(inputBuf_1_V_ce0),
    .q0(inputBuf_1_V_q0),
    .address1(inputBuf_1_V_address1),
    .ce1(inputBuf_1_V_ce1),
    .we1(inputBuf_1_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_0_ConvolutionInputGbkb #(
    .DataWidth( 8 ),
    .AddressRange( 12 ),
    .AddressWidth( 4 ))
inputBuf_2_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_2_V_address0),
    .ce0(inputBuf_2_V_ce0),
    .q0(inputBuf_2_V_q0),
    .address1(inputBuf_2_V_address1),
    .ce1(inputBuf_2_V_ce1),
    .we1(inputBuf_2_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_0_ConvolutionInputGbkb #(
    .DataWidth( 8 ),
    .AddressRange( 12 ),
    .AddressWidth( 4 ))
inputBuf_3_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_3_V_address0),
    .ce0(inputBuf_3_V_ce0),
    .q0(inputBuf_3_V_q0),
    .address1(inputBuf_3_V_address1),
    .ce1(inputBuf_3_V_ce1),
    .we1(inputBuf_3_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_0_ConvolutionInputGfYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 8 ),
    .din2_WIDTH( 8 ),
    .din3_WIDTH( 8 ),
    .din4_WIDTH( 2 ),
    .dout_WIDTH( 8 ))
ConvolutionInputGfYi_U1(
    .din0(inputBuf_0_V_q0),
    .din1(inputBuf_1_V_q0),
    .din2(inputBuf_2_V_q0),
    .din3(inputBuf_3_V_q0),
    .din4(add_ln220_reg_877),
    .dout(tmp_V_1_fu_764_p6)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln223_fu_467_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        count_simd_1_0_fu_96 <= add_ln222_fu_461_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln226_fu_484_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln229_fu_495_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln232_fu_515_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln232_fu_515_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        count_simd_1_0_fu_96 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        counter_internal_blo_fu_112 <= select_ln263_fu_687_p3;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_340_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        counter_internal_blo_fu_112 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_340_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_block_write_s_fu_104 <= select_ln207_fu_740_p3;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_block_write_s_fu_104 <= select_ln251_fu_629_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        current_block_write_s_fu_104 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln204_fu_340_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_line_1_0_fu_108 <= grp_fu_328_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_line_1_0_fu_108 <= select_ln251_1_fu_637_p3;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_340_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        current_line_1_0_fu_108 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_0_reg_269 <= 10'd0;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_0_0_reg_269 <= add_ln196_fu_372_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inp_15_0_fu_88 <= add_ln203_fu_712_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln232_fu_515_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inp_15_0_fu_88 <= select_ln235_fu_541_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        inp_15_0_fu_88 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln226_fu_484_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        k_x_1_0_fu_92 <= add_ln225_fu_478_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln229_fu_495_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln232_fu_515_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln232_fu_515_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        k_x_1_0_fu_92 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln229_fu_495_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        k_y_1_0_fu_84 <= add_ln215_fu_419_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        k_y_1_0_fu_84 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln232_fu_515_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ofm_x_1_0_fu_80 <= add_ln231_fu_509_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln232_fu_515_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        ofm_x_1_0_fu_80 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln232_fu_515_p2 == 1'd1) & (icmp_ln229_fu_495_p2 == 1'd1) & (icmp_ln226_fu_484_p2 == 1'd1) & (icmp_ln223_fu_467_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ofm_y_1_0_fu_76 <= select_ln235_1_fu_549_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ofm_y_1_0_fu_76 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_340_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        read_block_1_0_fu_100 <= add_ln210_fu_748_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        read_block_1_0_fu_100 <= zext_ln251_fu_653_p1;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        read_block_1_0_fu_100 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        add_ln220_reg_877 <= add_ln220_fu_455_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln196_fu_366_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln198_reg_869 <= icmp_ln198_fu_388_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln214_reg_873 <= icmp_ln214_fu_397_p2;
    end
end

always @ (*) begin
    if ((icmp_ln196_fu_366_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op159_read_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op116_read_state2 == 1'b1)))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_388_p2 == 1'd1) & (trunc_ln321_fu_708_p1 == 2'd0))) begin
            inputBuf_0_V_address1 = zext_ln201_fu_700_p1;
        end else if ((1'b1 == ap_condition_647)) begin
            inputBuf_0_V_address1 = zext_ln247_fu_588_p1;
        end else begin
            inputBuf_0_V_address1 = 'bx;
        end
    end else begin
        inputBuf_0_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_0_V_ce0 = 1'b1;
    end else begin
        inputBuf_0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_0_V_ce1 = 1'b1;
    end else begin
        inputBuf_0_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_0_V_we1 = 1'b1;
    end else begin
        inputBuf_0_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_388_p2 == 1'd1) & (trunc_ln321_fu_708_p1 == 2'd1))) begin
            inputBuf_1_V_address1 = zext_ln201_fu_700_p1;
        end else if ((1'b1 == ap_condition_653)) begin
            inputBuf_1_V_address1 = zext_ln247_fu_588_p1;
        end else begin
            inputBuf_1_V_address1 = 'bx;
        end
    end else begin
        inputBuf_1_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_1_V_ce0 = 1'b1;
    end else begin
        inputBuf_1_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_1_V_ce1 = 1'b1;
    end else begin
        inputBuf_1_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_1_V_we1 = 1'b1;
    end else begin
        inputBuf_1_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_388_p2 == 1'd1) & (trunc_ln321_fu_708_p1 == 2'd2))) begin
            inputBuf_2_V_address1 = zext_ln201_fu_700_p1;
        end else if ((1'b1 == ap_condition_657)) begin
            inputBuf_2_V_address1 = zext_ln247_fu_588_p1;
        end else begin
            inputBuf_2_V_address1 = 'bx;
        end
    end else begin
        inputBuf_2_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_2_V_ce0 = 1'b1;
    end else begin
        inputBuf_2_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_2_V_ce1 = 1'b1;
    end else begin
        inputBuf_2_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_2_V_we1 = 1'b1;
    end else begin
        inputBuf_2_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_388_p2 == 1'd1) & (trunc_ln321_fu_708_p1 == 2'd3))) begin
            inputBuf_3_V_address1 = zext_ln201_fu_700_p1;
        end else if ((1'b1 == ap_condition_661)) begin
            inputBuf_3_V_address1 = zext_ln247_fu_588_p1;
        end else begin
            inputBuf_3_V_address1 = 'bx;
        end
    end else begin
        inputBuf_3_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_3_V_ce0 = 1'b1;
    end else begin
        inputBuf_3_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_3_V_ce1 = 1'b1;
    end else begin
        inputBuf_3_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_3_V_we1 = 1'b1;
    end else begin
        inputBuf_3_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln214_reg_873 == 1'd1) & (icmp_ln198_reg_869 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op202_write_state3 == 1'b1))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln196_fu_366_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln196_fu_366_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln196_fu_372_p2 = (i_0_0_reg_269 + 10'd1);

assign add_ln203_fu_712_p2 = (inp_15_0_fu_88 + 32'd1);

assign add_ln206_fu_728_p2 = (current_block_write_s_fu_104 + 32'd1);

assign add_ln210_fu_748_p2 = (read_block_1_0_fu_100 + 32'd1);

assign add_ln215_fu_419_p2 = (32'd1 + k_y_1_0_fu_84);

assign add_ln219_1_fu_435_p2 = (add_ln219_fu_429_p2 + k_x_1_0_fu_92);

assign add_ln219_fu_429_p2 = (ofm_x_1_0_fu_80 + count_simd_1_0_fu_96);

assign add_ln220_1_fu_449_p2 = (2'd1 + trunc_ln215_1_fu_425_p1);

assign add_ln220_fu_455_p2 = (add_ln220_1_fu_449_p2 + trunc_ln215_fu_415_p1);

assign add_ln222_fu_461_p2 = (32'd1 + count_simd_1_0_fu_96);

assign add_ln225_fu_478_p2 = (k_x_1_0_fu_92 + 32'd1);

assign add_ln231_fu_509_p2 = (ofm_x_1_0_fu_80 + 32'd1);

assign add_ln234_fu_529_p2 = (ofm_y_1_0_fu_76 + 32'd1);

assign add_ln255_1_fu_603_p2 = (trunc_ln196_fu_384_p1 + 4'd1);

assign add_ln255_fu_609_p2 = (current_block_write_s_fu_104 + 32'd1);

assign add_ln262_fu_675_p2 = (counter_internal_blo_fu_112 + 32'd1);

assign and_ln244_fu_582_p2 = (icmp_ln244_fu_570_p2 & icmp_ln244_1_fu_576_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_pp0 = ((ap_ST_fsm_pp0_stage0 == ap_CS_fsm) & (1'b1 == ap_block_pp0_stage0_subdone));
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op159_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op116_read_state2 == 1'b1))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op159_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op116_read_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op159_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op116_read_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = (((in_V_V_TVALID == 1'b0) & (ap_predicate_op159_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op116_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_io = ((out_V_V_TREADY == 1'b0) & (ap_predicate_op202_write_state3 == 1'b1));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_230 = ((icmp_ln196_fu_366_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_647 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd0));
end

always @ (*) begin
    ap_condition_653 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd1));
end

always @ (*) begin
    ap_condition_657 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd2));
end

always @ (*) begin
    ap_condition_661 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd3));
end

always @ (*) begin
    ap_enable_operation_124 = (ap_predicate_op124_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_126 = (ap_predicate_op126_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_128 = (ap_predicate_op128_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_130 = (ap_predicate_op130_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_167 = (ap_predicate_op167_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_169 = (ap_predicate_op169_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_171 = (ap_predicate_op171_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_173 = (ap_predicate_op173_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_197 = (ap_predicate_op197_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_198 = (ap_predicate_op198_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_199 = (ap_predicate_op199_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_200 = (ap_predicate_op200_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_62 = (ap_predicate_op62_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_64 = (ap_predicate_op64_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_66 = (ap_predicate_op66_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_68 = (ap_predicate_op68_load_state2 == 1'b1);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_enable_state2_pp0_iter0_stage0 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state3_pp0_iter1_stage0 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_predicate_op116_read_state2 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op124_store_state2 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd2));
end

always @ (*) begin
    ap_predicate_op126_store_state2 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd1));
end

always @ (*) begin
    ap_predicate_op128_store_state2 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd0));
end

always @ (*) begin
    ap_predicate_op130_store_state2 = ((1'd1 == and_ln244_fu_582_p2) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_1_fu_596_p1 == 2'd3));
end

always @ (*) begin
    ap_predicate_op159_read_state2 = ((icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op167_store_state2 = ((icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd2));
end

always @ (*) begin
    ap_predicate_op169_store_state2 = ((icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd1));
end

always @ (*) begin
    ap_predicate_op171_store_state2 = ((icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd0));
end

always @ (*) begin
    ap_predicate_op173_store_state2 = ((icmp_ln198_fu_388_p2 == 1'd1) & (icmp_ln196_fu_366_p2 == 1'd0) & (trunc_ln321_fu_708_p1 == 2'd3));
end

always @ (*) begin
    ap_predicate_op197_load_state3 = ((icmp_ln214_reg_873 == 1'd1) & (icmp_ln198_reg_869 == 1'd0));
end

always @ (*) begin
    ap_predicate_op198_load_state3 = ((icmp_ln214_reg_873 == 1'd1) & (icmp_ln198_reg_869 == 1'd0));
end

always @ (*) begin
    ap_predicate_op199_load_state3 = ((icmp_ln214_reg_873 == 1'd1) & (icmp_ln198_reg_869 == 1'd0));
end

always @ (*) begin
    ap_predicate_op200_load_state3 = ((icmp_ln214_reg_873 == 1'd1) & (icmp_ln198_reg_869 == 1'd0));
end

always @ (*) begin
    ap_predicate_op202_write_state3 = ((icmp_ln214_reg_873 == 1'd1) & (icmp_ln198_reg_869 == 1'd0));
end

always @ (*) begin
    ap_predicate_op62_load_state2 = ((icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op64_load_state2 = ((icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op66_load_state2 = ((icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op68_load_state2 = ((icmp_ln214_fu_397_p2 == 1'd1) & (icmp_ln198_fu_388_p2 == 1'd0) & (icmp_ln196_fu_366_p2 == 1'd0));
end

assign grp_fu_328_p2 = (current_line_1_0_fu_108 + 32'd1);

assign icmp_ln196_fu_366_p2 = ((i_0_0_reg_269 == 10'd936) ? 1'b1 : 1'b0);

assign icmp_ln198_fu_388_p2 = ((inp_15_0_fu_88 < 32'd36) ? 1'b1 : 1'b0);

assign icmp_ln204_fu_340_p2 = ((grp_fu_328_p2 == 32'd12) ? 1'b1 : 1'b0);

assign icmp_ln207_fu_734_p2 = ((add_ln206_fu_728_p2 == 32'd4) ? 1'b1 : 1'b0);

assign icmp_ln214_fu_397_p2 = ((counter_internal_blo_fu_112 < 32'd89) ? 1'b1 : 1'b0);

assign icmp_ln223_fu_467_p2 = ((count_simd_1_0_fu_96 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln226_fu_484_p2 = ((add_ln225_fu_478_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln229_fu_495_p2 = ((add_ln215_fu_419_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln232_fu_515_p2 = ((add_ln231_fu_509_p2 == 32'd10) ? 1'b1 : 1'b0);

assign icmp_ln235_fu_535_p2 = ((add_ln234_fu_529_p2 == 32'd10) ? 1'b1 : 1'b0);

assign icmp_ln244_1_fu_576_p2 = ((read_block_1_0_fu_100 < 32'd12) ? 1'b1 : 1'b0);

assign icmp_ln244_fu_570_p2 = ((counter_internal_blo_fu_112 < 32'd11) ? 1'b1 : 1'b0);

assign icmp_ln251_fu_334_p2 = ((grp_fu_328_p2 == 32'd12) ? 1'b1 : 1'b0);

assign icmp_ln256_fu_615_p2 = ((add_ln255_fu_609_p2 == 32'd4) ? 1'b1 : 1'b0);

assign icmp_ln263_fu_681_p2 = ((add_ln262_fu_675_p2 == 32'd89) ? 1'b1 : 1'b0);

assign inputBuf_0_V_address0 = zext_ln220_fu_441_p1;

assign inputBuf_1_V_address0 = zext_ln220_fu_441_p1;

assign inputBuf_2_V_address0 = zext_ln220_fu_441_p1;

assign inputBuf_3_V_address0 = zext_ln220_fu_441_p1;

assign out_V_V_TDATA = tmp_V_1_fu_764_p6;

assign select_ln207_fu_740_p3 = ((icmp_ln207_fu_734_p2[0:0] === 1'b1) ? 32'd0 : add_ln206_fu_728_p2);

assign select_ln235_1_fu_549_p3 = ((icmp_ln235_fu_535_p2[0:0] === 1'b1) ? 32'd0 : add_ln234_fu_529_p2);

assign select_ln235_fu_541_p3 = ((icmp_ln235_fu_535_p2[0:0] === 1'b1) ? 32'd0 : inp_15_0_fu_88);

assign select_ln251_1_fu_637_p3 = ((icmp_ln251_fu_334_p2[0:0] === 1'b1) ? 32'd0 : grp_fu_328_p2);

assign select_ln251_2_fu_645_p3 = ((icmp_ln251_fu_334_p2[0:0] === 1'b1) ? add_ln255_1_fu_603_p2 : trunc_ln196_fu_384_p1);

assign select_ln251_fu_629_p3 = ((icmp_ln251_fu_334_p2[0:0] === 1'b1) ? select_ln256_fu_621_p3 : current_block_write_s_fu_104);

assign select_ln256_fu_621_p3 = ((icmp_ln256_fu_615_p2[0:0] === 1'b1) ? 32'd0 : add_ln255_fu_609_p2);

assign select_ln263_fu_687_p3 = ((icmp_ln263_fu_681_p2[0:0] === 1'b1) ? 32'd0 : add_ln262_fu_675_p2);

assign trunc_ln196_fu_384_p1 = read_block_1_0_fu_100[3:0];

assign trunc_ln215_1_fu_425_p1 = current_block_write_s_fu_104[1:0];

assign trunc_ln215_fu_415_p1 = k_y_1_0_fu_84[1:0];

assign trunc_ln321_1_fu_596_p1 = current_block_write_s_fu_104[1:0];

assign trunc_ln321_fu_708_p1 = current_block_write_s_fu_104[1:0];

assign zext_ln201_fu_700_p1 = current_line_1_0_fu_108;

assign zext_ln220_fu_441_p1 = add_ln219_1_fu_435_p2;

assign zext_ln247_fu_588_p1 = current_line_1_0_fu_108;

assign zext_ln251_fu_653_p1 = select_ln251_2_fu_645_p3;

endmodule //ConvolutionInputGenerator_0_ConvolutionInputGene_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/51d1/hdl/verilog/ConvolutionInputGenerator_2_ConvolutionInputGbkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module ConvolutionInputGenerator_2_ConvolutionInputGbkb_ram (addr0, ce0, q0, addr1, ce1, d1, we1,  clk);

parameter DWIDTH = 16;
parameter AWIDTH = 8;
parameter MEM_SIZE = 192;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input[AWIDTH-1:0] addr1;
input ce1;
input[DWIDTH-1:0] d1;
input we1;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];




always @(posedge clk)  
begin 
    if (ce0) begin
        q0 <= ram[addr0];
    end
end


always @(posedge clk)  
begin 
    if (ce1) begin
        if (we1) 
            ram[addr1] <= d1; 
    end
end


endmodule

`timescale 1 ns / 1 ps
module ConvolutionInputGenerator_2_ConvolutionInputGbkb(
    reset,
    clk,
    address0,
    ce0,
    q0,
    address1,
    ce1,
    we1,
    d1);

parameter DataWidth = 32'd16;
parameter AddressRange = 32'd192;
parameter AddressWidth = 32'd8;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;
input[AddressWidth - 1:0] address1;
input ce1;
input we1;
input[DataWidth - 1:0] d1;



ConvolutionInputGenerator_2_ConvolutionInputGbkb_ram ConvolutionInputGenerator_2_ConvolutionInputGbkb_ram_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ),
    .addr1( address1 ),
    .ce1( ce1 ),
    .we1( we1 ),
    .d1( d1 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/68cd/hdl/verilog/StreamingMaxPool_Batch_0_StreamingMaxPool_bkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module StreamingMaxPool_Batch_0_StreamingMaxPool_bkb_ram (addr0, ce0, d0, we0, q0,  clk);

parameter DWIDTH = 2;
parameter AWIDTH = 3;
parameter MEM_SIZE = 5;

input[AWIDTH-1:0] addr0;
input ce0;
input[DWIDTH-1:0] d0;
input we0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];




always @(posedge clk)  
begin 
    if (ce0) begin
        if (we0) 
            ram[addr0] <= d0; 
        q0 <= ram[addr0];
    end
end


endmodule

`timescale 1 ns / 1 ps
module StreamingMaxPool_Batch_0_StreamingMaxPool_bkb(
    reset,
    clk,
    address0,
    ce0,
    we0,
    d0,
    q0);

parameter DataWidth = 32'd2;
parameter AddressRange = 32'd5;
parameter AddressWidth = 32'd3;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
input we0;
input[DataWidth - 1:0] d0;
output[DataWidth - 1:0] q0;



StreamingMaxPool_Batch_0_StreamingMaxPool_bkb_ram StreamingMaxPool_Batch_0_StreamingMaxPool_bkb_ram_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .we0( we0 ),
    .d0( d0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_Actcud.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_2_Matrix_Vector_Actcud_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 8;
parameter AWIDTH = 6;
parameter MEM_SIZE = 64;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_2_j8ke1nb0/project_StreamingFCLayer_Batch_2/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_Actcud_rom.dat", ram);
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
module StreamingFCLayer_Batch_2_Matrix_Vector_Actcud(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd8;
parameter AddressRange = 32'd64;
parameter AddressWidth = 32'd6;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_2_Matrix_Vector_Actcud_rom StreamingFCLayer_Batch_2_Matrix_Vector_Actcud_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingFCLayer_Batch_3_0/synth/finn_design_StreamingFCLayer_Batch_3_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingFCLayer_Batch_3:1.0
// IP Revision: 2105101148

(* X_CORE_INFO = "StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingFCLayer_Batch_3_0,StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingFCLayer_Batch_3_0,StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingFCLayer_Batch_3,x_ipVersion=1.0,x_ipCoreRevision=2105101148,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingFCLayer_Batch_3_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2b8/hdl/verilog/ConvolutionInputGenerator_1_ConvolutionInputGene_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module ConvolutionInputGenerator_1_ConvolutionInputGene_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln196_fu_368_p2;
wire   [0:0] icmp_ln198_fu_390_p2;
wire   [0:0] and_ln244_fu_600_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln198_reg_907;
reg   [0:0] icmp_ln214_reg_911;
reg   [11:0] i_0_0_reg_271;
reg    ap_predicate_op119_read_state2;
reg    ap_predicate_op163_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_predicate_op208_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [11:0] add_ln196_fu_374_p2;
wire   [0:0] icmp_ln214_fu_399_p2;
wire   [1:0] add_ln220_fu_473_p2;
reg   [1:0] add_ln220_reg_915;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [7:0] inputBuf_0_V_address0;
reg    inputBuf_0_V_ce0;
wire   [3:0] inputBuf_0_V_q0;
reg   [7:0] inputBuf_0_V_address1;
reg    inputBuf_0_V_ce1;
reg    inputBuf_0_V_we1;
reg   [3:0] inputBuf_0_V_d1;
wire   [7:0] inputBuf_1_V_address0;
reg    inputBuf_1_V_ce0;
wire   [3:0] inputBuf_1_V_q0;
reg   [7:0] inputBuf_1_V_address1;
reg    inputBuf_1_V_ce1;
reg    inputBuf_1_V_we1;
reg   [3:0] inputBuf_1_V_d1;
wire   [7:0] inputBuf_2_V_address0;
reg    inputBuf_2_V_ce0;
wire   [3:0] inputBuf_2_V_q0;
reg   [7:0] inputBuf_2_V_address1;
reg    inputBuf_2_V_ce1;
reg    inputBuf_2_V_we1;
reg   [3:0] inputBuf_2_V_d1;
wire   [7:0] inputBuf_3_V_address0;
reg    inputBuf_3_V_ce0;
wire   [3:0] inputBuf_3_V_q0;
reg   [7:0] inputBuf_3_V_address1;
reg    inputBuf_3_V_ce1;
reg    inputBuf_3_V_we1;
reg   [3:0] inputBuf_3_V_d1;
wire   [63:0] zext_ln220_fu_459_p1;
wire   [63:0] zext_ln247_fu_614_p1;
wire   [63:0] zext_ln201_fu_734_p1;
reg   [31:0] ofm_y_1_0_fu_82;
wire   [31:0] select_ln235_1_fu_567_p3;
wire   [0:0] icmp_ln223_fu_485_p2;
wire   [0:0] icmp_ln226_fu_502_p2;
wire   [0:0] icmp_ln229_fu_513_p2;
wire   [0:0] icmp_ln232_fu_533_p2;
reg   [31:0] ofm_x_1_0_fu_86;
wire   [31:0] add_ln231_fu_527_p2;
reg   [31:0] k_y_1_0_fu_90;
wire   [31:0] add_ln215_fu_421_p2;
reg   [31:0] inp_15_0_fu_94;
wire   [31:0] select_ln235_fu_559_p3;
wire   [31:0] add_ln203_fu_746_p2;
reg   [31:0] k_x_1_0_fu_98;
wire   [31:0] add_ln225_fu_496_p2;
reg   [31:0] count_simd_1_0_fu_102;
wire   [31:0] add_ln222_fu_479_p2;
reg   [31:0] read_block_1_0_fu_106;
wire   [31:0] zext_ln251_fu_679_p1;
wire   [31:0] add_ln210_fu_782_p2;
wire   [0:0] icmp_ln204_fu_342_p2;
reg   [31:0] current_block_write_s_fu_110;
wire   [31:0] select_ln251_fu_655_p3;
wire   [31:0] select_ln207_fu_774_p3;
reg   [31:0] current_line_1_0_fu_114;
wire   [31:0] select_ln251_1_fu_663_p3;
wire   [31:0] grp_fu_330_p2;
reg   [31:0] counter_internal_blo_fu_118;
wire   [31:0] select_ln263_fu_713_p3;
reg    ap_block_pp0_stage0_01001;
wire   [1:0] trunc_ln321_1_fu_622_p1;
wire   [3:0] tmp_V_2_fu_606_p1;
wire   [1:0] trunc_ln321_fu_742_p1;
wire   [3:0] tmp_V_fu_726_p1;
wire   [26:0] trunc_ln219_1_fu_435_p1;
wire   [26:0] trunc_ln219_fu_431_p1;
wire   [26:0] add_ln219_fu_439_p2;
wire   [31:0] shl_ln_fu_445_p3;
wire   [31:0] add_ln219_1_fu_453_p2;
wire   [1:0] trunc_ln215_1_fu_427_p1;
wire   [1:0] add_ln220_1_fu_467_p2;
wire   [1:0] trunc_ln215_fu_417_p1;
wire   [31:0] add_ln234_fu_547_p2;
wire   [0:0] icmp_ln235_fu_553_p2;
wire   [0:0] icmp_ln244_fu_588_p2;
wire   [0:0] icmp_ln244_1_fu_594_p2;
wire   [2:0] trunc_ln196_fu_386_p1;
wire   [31:0] add_ln255_fu_635_p2;
wire   [0:0] icmp_ln256_fu_641_p2;
wire   [0:0] icmp_ln251_fu_336_p2;
wire   [31:0] select_ln256_fu_647_p3;
wire   [2:0] add_ln255_1_fu_629_p2;
wire   [2:0] select_ln251_2_fu_671_p3;
wire   [31:0] add_ln262_fu_701_p2;
wire   [0:0] icmp_ln263_fu_707_p2;
wire   [31:0] add_ln206_fu_762_p2;
wire   [0:0] icmp_ln207_fu_768_p2;
wire   [3:0] tmp_V_1_fu_798_p6;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_block_pp0;
reg    ap_predicate_op128_store_state2;
reg    ap_enable_operation_128;
reg    ap_enable_state2_pp0_iter0_stage0;
reg    ap_predicate_op69_load_state2;
reg    ap_enable_operation_69;
reg    ap_predicate_op204_load_state3;
reg    ap_enable_operation_204;
reg    ap_enable_state3_pp0_iter1_stage0;
reg    ap_predicate_op172_store_state2;
reg    ap_enable_operation_172;
reg    ap_predicate_op130_store_state2;
reg    ap_enable_operation_130;
reg    ap_predicate_op67_load_state2;
reg    ap_enable_operation_67;
reg    ap_predicate_op203_load_state3;
reg    ap_enable_operation_203;
reg    ap_predicate_op174_store_state2;
reg    ap_enable_operation_174;
reg    ap_predicate_op132_store_state2;
reg    ap_enable_operation_132;
reg    ap_predicate_op65_load_state2;
reg    ap_enable_operation_65;
reg    ap_predicate_op202_load_state3;
reg    ap_enable_operation_202;
reg    ap_predicate_op176_store_state2;
reg    ap_enable_operation_176;
reg    ap_predicate_op134_store_state2;
reg    ap_enable_operation_134;
reg    ap_predicate_op71_load_state2;
reg    ap_enable_operation_71;
reg    ap_predicate_op205_load_state3;
reg    ap_enable_operation_205;
reg    ap_predicate_op178_store_state2;
reg    ap_enable_operation_178;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_664;
reg    ap_condition_230;
reg    ap_condition_670;
reg    ap_condition_674;
reg    ap_condition_678;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

ConvolutionInputGenerator_1_ConvolutionInputGbkb #(
    .DataWidth( 4 ),
    .AddressRange( 160 ),
    .AddressWidth( 8 ))
inputBuf_0_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_0_V_address0),
    .ce0(inputBuf_0_V_ce0),
    .q0(inputBuf_0_V_q0),
    .address1(inputBuf_0_V_address1),
    .ce1(inputBuf_0_V_ce1),
    .we1(inputBuf_0_V_we1),
    .d1(inputBuf_0_V_d1)
);

ConvolutionInputGenerator_1_ConvolutionInputGbkb #(
    .DataWidth( 4 ),
    .AddressRange( 160 ),
    .AddressWidth( 8 ))
inputBuf_1_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_1_V_address0),
    .ce0(inputBuf_1_V_ce0),
    .q0(inputBuf_1_V_q0),
    .address1(inputBuf_1_V_address1),
    .ce1(inputBuf_1_V_ce1),
    .we1(inputBuf_1_V_we1),
    .d1(inputBuf_1_V_d1)
);

ConvolutionInputGenerator_1_ConvolutionInputGbkb #(
    .DataWidth( 4 ),
    .AddressRange( 160 ),
    .AddressWidth( 8 ))
inputBuf_2_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_2_V_address0),
    .ce0(inputBuf_2_V_ce0),
    .q0(inputBuf_2_V_q0),
    .address1(inputBuf_2_V_address1),
    .ce1(inputBuf_2_V_ce1),
    .we1(inputBuf_2_V_we1),
    .d1(inputBuf_2_V_d1)
);

ConvolutionInputGenerator_1_ConvolutionInputGbkb #(
    .DataWidth( 4 ),
    .AddressRange( 160 ),
    .AddressWidth( 8 ))
inputBuf_3_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_3_V_address0),
    .ce0(inputBuf_3_V_ce0),
    .q0(inputBuf_3_V_q0),
    .address1(inputBuf_3_V_address1),
    .ce1(inputBuf_3_V_ce1),
    .we1(inputBuf_3_V_we1),
    .d1(inputBuf_3_V_d1)
);

ConvolutionInputGenerator_1_ConvolutionInputGfYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 4 ),
    .din1_WIDTH( 4 ),
    .din2_WIDTH( 4 ),
    .din3_WIDTH( 4 ),
    .din4_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
ConvolutionInputGfYi_U1(
    .din0(inputBuf_0_V_q0),
    .din1(inputBuf_1_V_q0),
    .din2(inputBuf_2_V_q0),
    .din3(inputBuf_3_V_q0),
    .din4(add_ln220_reg_915),
    .dout(tmp_V_1_fu_798_p6)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln223_fu_485_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        count_simd_1_0_fu_102 <= add_ln222_fu_479_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln226_fu_502_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln229_fu_513_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln232_fu_533_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        count_simd_1_0_fu_102 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        counter_internal_blo_fu_118 <= select_ln263_fu_713_p3;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        counter_internal_blo_fu_118 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_block_write_s_fu_110 <= select_ln207_fu_774_p3;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_block_write_s_fu_110 <= select_ln251_fu_655_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        current_block_write_s_fu_110 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln204_fu_342_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_line_1_0_fu_114 <= grp_fu_330_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_line_1_0_fu_114 <= select_ln251_1_fu_663_p3;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        current_line_1_0_fu_114 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_0_reg_271 <= 12'd0;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_0_0_reg_271 <= add_ln196_fu_374_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inp_15_0_fu_94 <= add_ln203_fu_746_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inp_15_0_fu_94 <= select_ln235_fu_559_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        inp_15_0_fu_94 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln226_fu_502_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        k_x_1_0_fu_98 <= add_ln225_fu_496_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln229_fu_513_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln232_fu_533_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        k_x_1_0_fu_98 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln229_fu_513_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        k_y_1_0_fu_90 <= add_ln215_fu_421_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        k_y_1_0_fu_90 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln232_fu_533_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ofm_x_1_0_fu_86 <= add_ln231_fu_527_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        ofm_x_1_0_fu_86 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ofm_y_1_0_fu_82 <= select_ln235_1_fu_567_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ofm_y_1_0_fu_82 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        read_block_1_0_fu_106 <= add_ln210_fu_782_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        read_block_1_0_fu_106 <= zext_ln251_fu_679_p1;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        read_block_1_0_fu_106 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        add_ln220_reg_915 <= add_ln220_fu_473_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln198_reg_907 <= icmp_ln198_fu_390_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln214_reg_911 <= icmp_ln214_fu_399_p2;
    end
end

always @ (*) begin
    if ((icmp_ln196_fu_368_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op163_read_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op119_read_state2 == 1'b1)))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd0))) begin
            inputBuf_0_V_address1 = zext_ln201_fu_734_p1;
        end else if ((1'b1 == ap_condition_664)) begin
            inputBuf_0_V_address1 = zext_ln247_fu_614_p1;
        end else begin
            inputBuf_0_V_address1 = 'bx;
        end
    end else begin
        inputBuf_0_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_0_V_ce0 = 1'b1;
    end else begin
        inputBuf_0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_0_V_ce1 = 1'b1;
    end else begin
        inputBuf_0_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd0))) begin
            inputBuf_0_V_d1 = tmp_V_fu_726_p1;
        end else if ((1'b1 == ap_condition_664)) begin
            inputBuf_0_V_d1 = tmp_V_2_fu_606_p1;
        end else begin
            inputBuf_0_V_d1 = 'bx;
        end
    end else begin
        inputBuf_0_V_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_0_V_we1 = 1'b1;
    end else begin
        inputBuf_0_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd1))) begin
            inputBuf_1_V_address1 = zext_ln201_fu_734_p1;
        end else if ((1'b1 == ap_condition_670)) begin
            inputBuf_1_V_address1 = zext_ln247_fu_614_p1;
        end else begin
            inputBuf_1_V_address1 = 'bx;
        end
    end else begin
        inputBuf_1_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_1_V_ce0 = 1'b1;
    end else begin
        inputBuf_1_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_1_V_ce1 = 1'b1;
    end else begin
        inputBuf_1_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd1))) begin
            inputBuf_1_V_d1 = tmp_V_fu_726_p1;
        end else if ((1'b1 == ap_condition_670)) begin
            inputBuf_1_V_d1 = tmp_V_2_fu_606_p1;
        end else begin
            inputBuf_1_V_d1 = 'bx;
        end
    end else begin
        inputBuf_1_V_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_1_V_we1 = 1'b1;
    end else begin
        inputBuf_1_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd2))) begin
            inputBuf_2_V_address1 = zext_ln201_fu_734_p1;
        end else if ((1'b1 == ap_condition_674)) begin
            inputBuf_2_V_address1 = zext_ln247_fu_614_p1;
        end else begin
            inputBuf_2_V_address1 = 'bx;
        end
    end else begin
        inputBuf_2_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_2_V_ce0 = 1'b1;
    end else begin
        inputBuf_2_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_2_V_ce1 = 1'b1;
    end else begin
        inputBuf_2_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd2))) begin
            inputBuf_2_V_d1 = tmp_V_fu_726_p1;
        end else if ((1'b1 == ap_condition_674)) begin
            inputBuf_2_V_d1 = tmp_V_2_fu_606_p1;
        end else begin
            inputBuf_2_V_d1 = 'bx;
        end
    end else begin
        inputBuf_2_V_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_2_V_we1 = 1'b1;
    end else begin
        inputBuf_2_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd3))) begin
            inputBuf_3_V_address1 = zext_ln201_fu_734_p1;
        end else if ((1'b1 == ap_condition_678)) begin
            inputBuf_3_V_address1 = zext_ln247_fu_614_p1;
        end else begin
            inputBuf_3_V_address1 = 'bx;
        end
    end else begin
        inputBuf_3_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_3_V_ce0 = 1'b1;
    end else begin
        inputBuf_3_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_3_V_ce1 = 1'b1;
    end else begin
        inputBuf_3_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_742_p1 == 2'd3))) begin
            inputBuf_3_V_d1 = tmp_V_fu_726_p1;
        end else if ((1'b1 == ap_condition_678)) begin
            inputBuf_3_V_d1 = tmp_V_2_fu_606_p1;
        end else begin
            inputBuf_3_V_d1 = 'bx;
        end
    end else begin
        inputBuf_3_V_d1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_3_V_we1 = 1'b1;
    end else begin
        inputBuf_3_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln214_reg_911 == 1'd1) & (icmp_ln198_reg_907 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op208_write_state3 == 1'b1))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln196_fu_368_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln196_fu_368_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln196_fu_374_p2 = (i_0_0_reg_271 + 12'd1);

assign add_ln203_fu_746_p2 = (inp_15_0_fu_94 + 32'd1);

assign add_ln206_fu_762_p2 = (current_block_write_s_fu_110 + 32'd1);

assign add_ln210_fu_782_p2 = (read_block_1_0_fu_106 + 32'd1);

assign add_ln215_fu_421_p2 = (32'd1 + k_y_1_0_fu_90);

assign add_ln219_1_fu_453_p2 = (shl_ln_fu_445_p3 + count_simd_1_0_fu_102);

assign add_ln219_fu_439_p2 = (trunc_ln219_1_fu_435_p1 + trunc_ln219_fu_431_p1);

assign add_ln220_1_fu_467_p2 = (2'd1 + trunc_ln215_1_fu_427_p1);

assign add_ln220_fu_473_p2 = (add_ln220_1_fu_467_p2 + trunc_ln215_fu_417_p1);

assign add_ln222_fu_479_p2 = (32'd1 + count_simd_1_0_fu_102);

assign add_ln225_fu_496_p2 = (k_x_1_0_fu_98 + 32'd1);

assign add_ln231_fu_527_p2 = (ofm_x_1_0_fu_86 + 32'd1);

assign add_ln234_fu_547_p2 = (ofm_y_1_0_fu_82 + 32'd1);

assign add_ln255_1_fu_629_p2 = (trunc_ln196_fu_386_p1 + 3'd1);

assign add_ln255_fu_635_p2 = (current_block_write_s_fu_110 + 32'd1);

assign add_ln262_fu_701_p2 = (counter_internal_blo_fu_118 + 32'd1);

assign and_ln244_fu_600_p2 = (icmp_ln244_fu_588_p2 & icmp_ln244_1_fu_594_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_pp0 = ((ap_ST_fsm_pp0_stage0 == ap_CS_fsm) & (1'b1 == ap_block_pp0_stage0_subdone));
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op163_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op163_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op163_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = (((in_V_V_TVALID == 1'b0) & (ap_predicate_op163_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_io = ((out_V_V_TREADY == 1'b0) & (ap_predicate_op208_write_state3 == 1'b1));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_230 = ((icmp_ln196_fu_368_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_664 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd0));
end

always @ (*) begin
    ap_condition_670 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd1));
end

always @ (*) begin
    ap_condition_674 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd2));
end

always @ (*) begin
    ap_condition_678 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd3));
end

always @ (*) begin
    ap_enable_operation_128 = (ap_predicate_op128_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_130 = (ap_predicate_op130_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_132 = (ap_predicate_op132_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_134 = (ap_predicate_op134_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_172 = (ap_predicate_op172_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_174 = (ap_predicate_op174_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_176 = (ap_predicate_op176_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_178 = (ap_predicate_op178_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_202 = (ap_predicate_op202_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_203 = (ap_predicate_op203_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_204 = (ap_predicate_op204_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_205 = (ap_predicate_op205_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_65 = (ap_predicate_op65_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_67 = (ap_predicate_op67_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_69 = (ap_predicate_op69_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_71 = (ap_predicate_op71_load_state2 == 1'b1);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_enable_state2_pp0_iter0_stage0 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state3_pp0_iter1_stage0 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_predicate_op119_read_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op128_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd2));
end

always @ (*) begin
    ap_predicate_op130_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd1));
end

always @ (*) begin
    ap_predicate_op132_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd0));
end

always @ (*) begin
    ap_predicate_op134_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_622_p1 == 2'd3));
end

always @ (*) begin
    ap_predicate_op163_read_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op172_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd2));
end

always @ (*) begin
    ap_predicate_op174_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd1));
end

always @ (*) begin
    ap_predicate_op176_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd0));
end

always @ (*) begin
    ap_predicate_op178_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_742_p1 == 2'd3));
end

always @ (*) begin
    ap_predicate_op202_load_state3 = ((icmp_ln214_reg_911 == 1'd1) & (icmp_ln198_reg_907 == 1'd0));
end

always @ (*) begin
    ap_predicate_op203_load_state3 = ((icmp_ln214_reg_911 == 1'd1) & (icmp_ln198_reg_907 == 1'd0));
end

always @ (*) begin
    ap_predicate_op204_load_state3 = ((icmp_ln214_reg_911 == 1'd1) & (icmp_ln198_reg_907 == 1'd0));
end

always @ (*) begin
    ap_predicate_op205_load_state3 = ((icmp_ln214_reg_911 == 1'd1) & (icmp_ln198_reg_907 == 1'd0));
end

always @ (*) begin
    ap_predicate_op208_write_state3 = ((icmp_ln214_reg_911 == 1'd1) & (icmp_ln198_reg_907 == 1'd0));
end

always @ (*) begin
    ap_predicate_op65_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op67_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op69_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op71_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

assign grp_fu_330_p2 = (current_line_1_0_fu_114 + 32'd1);

assign icmp_ln196_fu_368_p2 = ((i_0_0_reg_271 == 12'd3072) ? 1'b1 : 1'b0);

assign icmp_ln198_fu_390_p2 = ((inp_15_0_fu_94 < 32'd480) ? 1'b1 : 1'b0);

assign icmp_ln204_fu_342_p2 = ((grp_fu_330_p2 == 32'd160) ? 1'b1 : 1'b0);

assign icmp_ln207_fu_768_p2 = ((add_ln206_fu_762_p2 == 32'd4) ? 1'b1 : 1'b0);

assign icmp_ln214_fu_399_p2 = ((counter_internal_blo_fu_118 < 32'd863) ? 1'b1 : 1'b0);

assign icmp_ln223_fu_485_p2 = ((add_ln222_fu_479_p2 == 32'd32) ? 1'b1 : 1'b0);

assign icmp_ln226_fu_502_p2 = ((add_ln225_fu_496_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln229_fu_513_p2 = ((add_ln215_fu_421_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln232_fu_533_p2 = ((add_ln231_fu_527_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln235_fu_553_p2 = ((add_ln234_fu_547_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln244_1_fu_594_p2 = ((read_block_1_0_fu_106 < 32'd5) ? 1'b1 : 1'b0);

assign icmp_ln244_fu_588_p2 = ((counter_internal_blo_fu_118 < 32'd159) ? 1'b1 : 1'b0);

assign icmp_ln251_fu_336_p2 = ((grp_fu_330_p2 == 32'd160) ? 1'b1 : 1'b0);

assign icmp_ln256_fu_641_p2 = ((add_ln255_fu_635_p2 == 32'd4) ? 1'b1 : 1'b0);

assign icmp_ln263_fu_707_p2 = ((add_ln262_fu_701_p2 == 32'd863) ? 1'b1 : 1'b0);

assign inputBuf_0_V_address0 = zext_ln220_fu_459_p1;

assign inputBuf_1_V_address0 = zext_ln220_fu_459_p1;

assign inputBuf_2_V_address0 = zext_ln220_fu_459_p1;

assign inputBuf_3_V_address0 = zext_ln220_fu_459_p1;

assign out_V_V_TDATA = tmp_V_1_fu_798_p6;

assign select_ln207_fu_774_p3 = ((icmp_ln207_fu_768_p2[0:0] === 1'b1) ? 32'd0 : add_ln206_fu_762_p2);

assign select_ln235_1_fu_567_p3 = ((icmp_ln235_fu_553_p2[0:0] === 1'b1) ? 32'd0 : add_ln234_fu_547_p2);

assign select_ln235_fu_559_p3 = ((icmp_ln235_fu_553_p2[0:0] === 1'b1) ? 32'd0 : inp_15_0_fu_94);

assign select_ln251_1_fu_663_p3 = ((icmp_ln251_fu_336_p2[0:0] === 1'b1) ? 32'd0 : grp_fu_330_p2);

assign select_ln251_2_fu_671_p3 = ((icmp_ln251_fu_336_p2[0:0] === 1'b1) ? add_ln255_1_fu_629_p2 : trunc_ln196_fu_386_p1);

assign select_ln251_fu_655_p3 = ((icmp_ln251_fu_336_p2[0:0] === 1'b1) ? select_ln256_fu_647_p3 : current_block_write_s_fu_110);

assign select_ln256_fu_647_p3 = ((icmp_ln256_fu_641_p2[0:0] === 1'b1) ? 32'd0 : add_ln255_fu_635_p2);

assign select_ln263_fu_713_p3 = ((icmp_ln263_fu_707_p2[0:0] === 1'b1) ? 32'd0 : add_ln262_fu_701_p2);

assign shl_ln_fu_445_p3 = {{add_ln219_fu_439_p2}, {5'd0}};

assign tmp_V_2_fu_606_p1 = in_V_V_TDATA[3:0];

assign tmp_V_fu_726_p1 = in_V_V_TDATA[3:0];

assign trunc_ln196_fu_386_p1 = read_block_1_0_fu_106[2:0];

assign trunc_ln215_1_fu_427_p1 = current_block_write_s_fu_110[1:0];

assign trunc_ln215_fu_417_p1 = k_y_1_0_fu_90[1:0];

assign trunc_ln219_1_fu_435_p1 = ofm_x_1_0_fu_86[26:0];

assign trunc_ln219_fu_431_p1 = k_x_1_0_fu_98[26:0];

assign trunc_ln321_1_fu_622_p1 = current_block_write_s_fu_110[1:0];

assign trunc_ln321_fu_742_p1 = current_block_write_s_fu_110[1:0];

assign zext_ln201_fu_734_p1 = current_line_1_0_fu_114;

assign zext_ln220_fu_459_p1 = add_ln219_1_fu_453_p2;

assign zext_ln247_fu_614_p1 = current_line_1_0_fu_114;

assign zext_ln251_fu_679_p1 = select_ln251_2_fu_671_p3;

endmodule //ConvolutionInputGenerator_1_ConvolutionInputGene_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_g8j.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "block" *) module StreamingFCLayer_Batch_1_StreamingFCLayer_g8j_rom (
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
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_1_q80qszbp/project_StreamingFCLayer_Batch_1/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_g8j_rom.dat", ram);
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
module StreamingFCLayer_Batch_1_StreamingFCLayer_g8j(
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



StreamingFCLayer_Batch_1_StreamingFCLayer_g8j_rom StreamingFCLayer_Batch_1_StreamingFCLayer_g8j_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingFCLayer_Batch_1_0/synth/finn_design_StreamingFCLayer_Batch_1_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingFCLayer_Batch_1:1.0
// IP Revision: 2105101207

(* X_CORE_INFO = "StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingFCLayer_Batch_1_0,StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingFCLayer_Batch_1_0,StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingFCLayer_Batch_1,x_ipVersion=1.0,x_ipCoreRevision=2105101207,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingFCLayer_Batch_1_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 5, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [39 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 8, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [63 : 0] out_V_V_TDATA;

  StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/51d1/hdl/verilog/ConvolutionInputGenerator_2_ConvolutionInputGfYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module ConvolutionInputGenerator_2_ConvolutionInputGfYi #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [15 : 0]     din0,
    input  [15 : 0]     din1,
    input  [15 : 0]     din2,
    input  [15 : 0]     din3,
    input  [1 : 0]    din4,
    output [15 : 0]   dout);

// puts internal signals
wire [1 : 0]     sel;
// level 1 signals
wire [15 : 0]         mux_1_0;
wire [15 : 0]         mux_1_1;
// level 2 signals
wire [15 : 0]         mux_2_0;

assign sel = din4;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;

// Generate level 2 logic
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;

// output logic
assign dout = mux_2_0;

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_ConvolutionInputGenerator_2_0/synth/finn_design_ConvolutionInputGenerator_2_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:ConvolutionInputGenerator_2:1.0
// IP Revision: 2105101203

(* X_CORE_INFO = "ConvolutionInputGenerator_2_ConvolutionInputGenerator_2,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_ConvolutionInputGenerator_2_0,ConvolutionInputGenerator_2_ConvolutionInputGenerator_2,{}" *)
(* CORE_GENERATION_INFO = "finn_design_ConvolutionInputGenerator_2_0,ConvolutionInputGenerator_2_ConvolutionInputGenerator_2,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=ConvolutionInputGenerator_2,x_ipVersion=1.0,x_ipCoreRevision=2105101203,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_ConvolutionInputGenerator_2_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 2, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [15 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 2, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [15 : 0] out_V_V_TDATA;

  ConvolutionInputGenerator_2_ConvolutionInputGenerator_2 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/c5b2/StreamingFIFO_0.v


module StreamingFIFO_0(
ap_clk,
ap_rst_n,
count,
in0_V_V_TDATA,
in0_V_V_TVALID,
in0_V_V_TREADY,
out_V_V_TDATA,
out_V_V_TVALID,
out_V_V_TREADY
);

input   ap_clk;
input   ap_rst_n;
output [4:0] count;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

Q_srl #(
.depth(32),
.width(8)
)
StreamingFIFO_0_StreamingFIFO_0
(
 .clock(ap_clk),
 .reset(!ap_rst_n),
 .count(count),
 .i_d(in0_V_V_TDATA),
 .i_v(in0_V_V_TVALID),
 .i_r(in0_V_V_TREADY),
 .o_d(out_V_V_TDATA),
 .o_v(out_V_V_TVALID),
 .o_r(out_V_V_TREADY)
);

endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingDataWidthConverter_Batch_2_0/synth/finn_design_StreamingDataWidthConverter_Batch_2_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingDataWidthConverter_Batch_2:1.0
// IP Revision: 2105101209

(* X_CORE_INFO = "StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingDataWidthConverter_Batch_2_0,StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingDataWidthConverter_Batch_2_0,StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingDataWidthConverter_Batch_2,x_ipVersion=1.0,x_ipCoreRevision=2105101209,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingDataWidthConverter_Batch_2_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 16, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [127 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/e745/hdl/verilog/StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.331000,HLS_SYN_LAT=3205,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=307,HLS_SYN_LUT=248,HLS_VERSION=2020_1}" *)

module StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [127:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_start;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_done;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_idle;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_ready;
wire    grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
wire   [127:0] grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY;
reg    grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_StreamingDataWidthCo_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingDataWidthConverter_Batch_1_StreamingDataWidthCo_1 grp_StreamingDataWidthCo_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingDataWidthCo_1_fu_26_ap_start),
    .ap_done(grp_StreamingDataWidthCo_1_fu_26_ap_done),
    .ap_idle(grp_StreamingDataWidthCo_1_fu_26_ap_idle),
    .ap_ready(grp_StreamingDataWidthCo_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 128 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingDataWidthCo_1_fu_26_ap_ready == 1'b1)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingDataWidthCo_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingDataWidthCo_1_fu_26_ap_start = grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;

assign grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_StreamingFCLayer_jbC.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_StreamingFCLayer_jbC_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 18;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_StreamingFCLayer_jbC_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_StreamingFCLayer_jbC(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd18;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_StreamingFCLayer_jbC_rom StreamingFCLayer_Batch_0_StreamingFCLayer_jbC_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f1ac/hdl/verilog/StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.331000,HLS_SYN_LAT=905,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=189,HLS_SYN_LUT=246,HLS_VERSION=2020_1}" *)

module StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [71:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_start;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_done;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_idle;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_ready;
wire    grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
wire   [71:0] grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY;
reg    grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_StreamingDataWidthCo_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingDataWidthConverter_Batch_0_StreamingDataWidthCo_1 grp_StreamingDataWidthCo_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingDataWidthCo_1_fu_26_ap_start),
    .ap_done(grp_StreamingDataWidthCo_1_fu_26_ap_done),
    .ap_idle(grp_StreamingDataWidthCo_1_fu_26_ap_idle),
    .ap_ready(grp_StreamingDataWidthCo_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 72 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingDataWidthCo_1_fu_26_ap_ready == 1'b1)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingDataWidthCo_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingDataWidthCo_1_fu_26_ap_start = grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;

assign grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=7.632250,HLS_SYN_LAT=389,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=268,HLS_SYN_LUT=858,HLS_VERSION=2020_1}" *)

module StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire   [1:0] weights_m_weights_0_q0;
wire    grp_Matrix_Vector_Activa_fu_34_ap_start;
wire    grp_Matrix_Vector_Activa_fu_34_ap_done;
wire    grp_Matrix_Vector_Activa_fu_34_ap_idle;
wire    grp_Matrix_Vector_Activa_fu_34_ap_ready;
wire    grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY;
wire   [7:0] grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA;
wire    grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID;
wire    grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY;
wire   [8:0] grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_address0;
wire    grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_ce0;
reg    grp_Matrix_Vector_Activa_fu_34_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_Matrix_Vector_Activa_fu_34_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingFCLayer_Batch_3_StreamingFCLayer_g8j #(
    .DataWidth( 2 ),
    .AddressRange( 384 ),
    .AddressWidth( 9 ))
weights_m_weights_0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_ce0),
    .q0(weights_m_weights_0_q0)
);

StreamingFCLayer_Batch_3_Matrix_Vector_Activa grp_Matrix_Vector_Activa_fu_34(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_Matrix_Vector_Activa_fu_34_ap_start),
    .ap_done(grp_Matrix_Vector_Activa_fu_34_ap_done),
    .ap_idle(grp_Matrix_Vector_Activa_fu_34_ap_idle),
    .ap_ready(grp_Matrix_Vector_Activa_fu_34_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY),
    .out_V_V_TDATA(grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA),
    .out_V_V_TVALID(grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID),
    .out_V_V_TREADY(grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY),
    .weights_m_weights_V_address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_address0),
    .weights_m_weights_V_ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_V_ce0),
    .weights_m_weights_V_q0(weights_m_weights_0_q0)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA),
    .vld_in(grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b1;
        end else if ((grp_Matrix_Vector_Activa_fu_34_ap_ready == 1'b1)) begin
            grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((in0_V_V_TVALID == 1'b1) & (regslice_both_in0_V_V_U_ack_in == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_Matrix_Vector_Activa_fu_34_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_out_V_V_U_apdone_blk == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_Matrix_Vector_Activa_fu_34_ap_start = grp_Matrix_Vector_Activa_fu_34_ap_start_reg;

assign grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingFCLayer_Batch_3_StreamingFCLayer_Batch_3
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_Matrix_Vector_Activa.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingFCLayer_Batch_2_Matrix_Vector_Activa (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY,
        weights_m_weights_V_address0,
        weights_m_weights_V_ce0,
        weights_m_weights_V_q0
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state5 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [127:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;
output  [12:0] weights_m_weights_V_address0;
output   weights_m_weights_V_ce0;
input  [15:0] weights_m_weights_V_q0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;
reg weights_m_weights_V_ce0;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [5:0] threshs_m_thresholds_2_address0;
reg    threshs_m_thresholds_2_ce0;
wire   [3:0] threshs_m_thresholds_2_q0;
wire   [5:0] threshs_m_thresholds_1_address0;
reg    threshs_m_thresholds_1_ce0;
wire   [7:0] threshs_m_thresholds_1_q0;
wire   [5:0] threshs_m_thresholds_address0;
reg    threshs_m_thresholds_ce0;
wire   [8:0] threshs_m_thresholds_q0;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln122_fu_810_p2;
wire   [0:0] icmp_ln125_fu_825_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter2;
reg   [0:0] icmp_ln160_reg_2671;
reg   [0:0] icmp_ln160_reg_2671_pp0_iter1_reg;
reg   [12:0] i_0_reg_633;
reg   [0:0] icmp_ln122_reg_2563;
reg    ap_predicate_op100_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
wire    ap_block_state4_pp0_stage0_iter2;
reg    ap_block_state4_io;
reg    ap_block_pp0_stage0_11001;
wire   [12:0] i_fu_816_p2;
reg   [0:0] icmp_ln125_reg_2572;
wire   [6:0] trunc_ln321_1_fu_834_p1;
reg   [6:0] trunc_ln321_1_reg_2576;
wire   [6:0] trunc_ln321_fu_838_p1;
wire   [0:0] icmp_ln137_fu_1208_p2;
reg   [0:0] icmp_ln137_reg_2661;
reg   [0:0] icmp_ln137_reg_2661_pp0_iter1_reg;
wire   [0:0] icmp_ln160_fu_1231_p2;
wire   [127:0] inElem_V_1_fu_1511_p74;
wire   [1:0] trunc_ln647_fu_1660_p1;
reg  signed [1:0] trunc_ln647_reg_2695;
reg  signed [1:0] p_Result_s_reg_2700;
reg  signed [1:0] p_Result_2_reg_2705;
reg  signed [1:0] p_Result_3_reg_2710;
reg  signed [1:0] p_Result_4_reg_2715;
reg  signed [1:0] p_Result_5_reg_2720;
reg  signed [1:0] p_Result_6_reg_2725;
reg  signed [1:0] p_Result_7_reg_2730;
reg   [3:0] threshs_m_thresholds_4_reg_2735;
reg   [7:0] threshs_m_thresholds_6_reg_2740;
reg   [8:0] threshs_m_thresholds_8_reg_2745;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg    ap_enable_reg_pp0_iter1;
wire   [127:0] ap_phi_reg_pp0_iter0_act_m_val_V_reg_644;
reg   [127:0] ap_phi_reg_pp0_iter1_act_m_val_V_reg_644;
reg   [127:0] ap_phi_reg_pp0_iter2_act_m_val_V_reg_644;
wire   [63:0] zext_ln137_fu_1214_p1;
wire   [63:0] zext_ln186_fu_1250_p1;
reg   [63:0] accu_V_0_0_0_fu_264;
wire   [63:0] add_ln700_7_fu_2012_p2;
reg   [31:0] tile_assign_fu_268;
wire   [31:0] tile_fu_1219_p2;
wire   [31:0] tile_1_fu_1277_p3;
reg   [31:0] sf_1_fu_272;
wire   [31:0] sf_fu_1225_p2;
reg   [127:0] tmp_V_fu_276;
reg   [127:0] tmp_V_2_fu_280;
reg   [127:0] tmp_V_3_fu_284;
reg   [127:0] tmp_V_4_fu_288;
reg   [127:0] tmp_V_5_fu_292;
reg   [127:0] tmp_V_6_fu_296;
reg   [127:0] tmp_V_7_fu_300;
reg   [127:0] tmp_V_8_fu_304;
reg   [127:0] tmp_V_9_fu_308;
reg   [127:0] tmp_V_10_fu_312;
reg   [127:0] tmp_V_11_fu_316;
reg   [127:0] tmp_V_12_fu_320;
reg   [127:0] tmp_V_13_fu_324;
reg   [127:0] tmp_V_14_fu_328;
reg   [127:0] tmp_V_15_fu_332;
reg   [127:0] tmp_V_16_fu_336;
reg   [127:0] tmp_V_17_fu_340;
reg   [127:0] tmp_V_18_fu_344;
reg   [127:0] tmp_V_19_fu_348;
reg   [127:0] tmp_V_20_fu_352;
reg   [127:0] tmp_V_21_fu_356;
reg   [127:0] tmp_V_22_fu_360;
reg   [127:0] tmp_V_23_fu_364;
reg   [127:0] tmp_V_24_fu_368;
reg   [127:0] tmp_V_25_fu_372;
reg   [127:0] tmp_V_26_fu_376;
reg   [127:0] tmp_V_27_fu_380;
reg   [127:0] tmp_V_28_fu_384;
reg   [127:0] tmp_V_29_fu_388;
reg   [127:0] tmp_V_30_fu_392;
reg   [127:0] tmp_V_31_fu_396;
reg   [127:0] tmp_V_32_fu_400;
reg   [127:0] tmp_V_33_fu_404;
reg   [127:0] tmp_V_34_fu_408;
reg   [127:0] tmp_V_35_fu_412;
reg   [127:0] tmp_V_36_fu_416;
reg   [127:0] tmp_V_37_fu_420;
reg   [127:0] tmp_V_38_fu_424;
reg   [127:0] tmp_V_39_fu_428;
reg   [127:0] tmp_V_40_fu_432;
reg   [127:0] tmp_V_41_fu_436;
reg   [127:0] tmp_V_42_fu_440;
reg   [127:0] tmp_V_43_fu_444;
reg   [127:0] tmp_V_44_fu_448;
reg   [127:0] tmp_V_45_fu_452;
reg   [127:0] tmp_V_46_fu_456;
reg   [127:0] tmp_V_47_fu_460;
reg   [127:0] tmp_V_48_fu_464;
reg   [127:0] tmp_V_49_fu_468;
reg   [127:0] tmp_V_50_fu_472;
reg   [127:0] tmp_V_51_fu_476;
reg   [127:0] tmp_V_52_fu_480;
reg   [127:0] tmp_V_53_fu_484;
reg   [127:0] tmp_V_54_fu_488;
reg   [127:0] tmp_V_55_fu_492;
reg   [127:0] tmp_V_56_fu_496;
reg   [127:0] tmp_V_57_fu_500;
reg   [127:0] tmp_V_58_fu_504;
reg   [127:0] tmp_V_59_fu_508;
reg   [127:0] tmp_V_60_fu_512;
reg   [127:0] tmp_V_61_fu_516;
reg   [127:0] tmp_V_62_fu_520;
reg   [127:0] tmp_V_63_fu_524;
reg   [127:0] tmp_V_64_fu_528;
reg   [127:0] tmp_V_65_fu_532;
reg   [127:0] tmp_V_66_fu_536;
reg   [127:0] tmp_V_67_fu_540;
reg   [127:0] tmp_V_68_fu_544;
reg   [127:0] tmp_V_69_fu_548;
reg   [127:0] tmp_V_70_fu_552;
reg   [127:0] tmp_V_71_fu_556;
reg   [127:0] tmp_V_72_fu_560;
reg   [31:0] nf_assign_fu_564;
wire   [31:0] nf_1_fu_1269_p3;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] nf_fu_1257_p2;
wire   [0:0] icmp_ln173_fu_1263_p2;
wire  signed [15:0] trunc_ln647_1_fu_1744_p1;
wire  signed [17:0] mul_ln1352_fu_1755_p2;
wire  signed [15:0] arg_V_read_assign_1_fu_1765_p4;
wire  signed [17:0] mul_ln1352_1_fu_1782_p2;
wire  signed [15:0] arg_V_read_assign_2_fu_1792_p4;
wire  signed [17:0] mul_ln1352_2_fu_1809_p2;
wire  signed [15:0] arg_V_read_assign_3_fu_1819_p4;
wire  signed [17:0] mul_ln1352_3_fu_1836_p2;
wire  signed [15:0] arg_V_read_assign_4_fu_1846_p4;
wire  signed [17:0] mul_ln1352_4_fu_1863_p2;
wire  signed [15:0] arg_V_read_assign_5_fu_1873_p4;
wire  signed [17:0] mul_ln1352_5_fu_1890_p2;
wire  signed [15:0] arg_V_read_assign_6_fu_1900_p4;
wire  signed [17:0] mul_ln1352_6_fu_1917_p2;
wire  signed [15:0] arg_V_read_assign_7_fu_1927_p4;
wire  signed [17:0] mul_ln1352_7_fu_1944_p2;
wire  signed [63:0] sext_ln700_fu_1896_p1;
wire   [63:0] res_V_fu_1737_p3;
wire  signed [18:0] sext_ln170_4_fu_1869_p1;
wire  signed [18:0] sext_ln170_5_fu_1923_p1;
wire   [18:0] add_ln700_1_fu_1960_p2;
wire   [63:0] add_ln700_fu_1954_p2;
wire  signed [63:0] sext_ln700_2_fu_1966_p1;
wire  signed [18:0] sext_ln170_fu_1761_p1;
wire  signed [18:0] sext_ln170_3_fu_1842_p1;
wire   [18:0] add_ln700_3_fu_1976_p2;
wire  signed [18:0] sext_ln700_1_fu_1950_p1;
wire  signed [18:0] sext_ln170_1_fu_1788_p1;
wire  signed [18:0] sext_ln170_2_fu_1815_p1;
wire   [18:0] add_ln700_4_fu_1986_p2;
wire   [18:0] add_ln700_5_fu_1992_p2;
wire  signed [19:0] sext_ln700_3_fu_1982_p1;
wire  signed [19:0] sext_ln700_4_fu_1998_p1;
wire   [19:0] add_ln700_6_fu_2002_p2;
wire   [63:0] add_ln700_2_fu_1970_p2;
wire  signed [63:0] sext_ln700_5_fu_2008_p1;
wire  signed [5:0] sext_ln186_fu_2023_p1;
wire   [63:0] zext_ln186_1_fu_2026_p1;
wire   [0:0] icmp_ln899_fu_2030_p2;
wire   [0:0] xor_ln899_fu_2036_p2;
wire   [63:0] zext_ln186_2_fu_2046_p1;
wire   [0:0] icmp_ln899_1_fu_2049_p2;
wire   [0:0] xor_ln899_1_fu_2055_p2;
wire   [63:0] zext_ln186_3_fu_2065_p1;
wire   [0:0] icmp_ln899_2_fu_2068_p2;
wire   [0:0] xor_ln899_2_fu_2074_p2;
wire   [1:0] zext_ln700_1_fu_2061_p1;
wire   [1:0] zext_ln700_2_fu_2080_p1;
wire   [1:0] add_ln700_8_fu_2084_p2;
wire   [1:0] zext_ln700_fu_2042_p1;
wire   [1:0] tmp_V_74_fu_2090_p2;
wire    ap_CS_fsm_state5;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_197;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

StreamingFCLayer_Batch_2_Matrix_Vector_Actbkb #(
    .DataWidth( 4 ),
    .AddressRange( 64 ),
    .AddressWidth( 6 ))
threshs_m_thresholds_2_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_2_address0),
    .ce0(threshs_m_thresholds_2_ce0),
    .q0(threshs_m_thresholds_2_q0)
);

StreamingFCLayer_Batch_2_Matrix_Vector_Actcud #(
    .DataWidth( 8 ),
    .AddressRange( 64 ),
    .AddressWidth( 6 ))
threshs_m_thresholds_1_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_1_address0),
    .ce0(threshs_m_thresholds_1_ce0),
    .q0(threshs_m_thresholds_1_q0)
);

StreamingFCLayer_Batch_2_Matrix_Vector_ActdEe #(
    .DataWidth( 9 ),
    .AddressRange( 64 ),
    .AddressWidth( 6 ))
threshs_m_thresholds_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_address0),
    .ce0(threshs_m_thresholds_ce0),
    .q0(threshs_m_thresholds_q0)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_eOg #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 128 ),
    .din1_WIDTH( 128 ),
    .din2_WIDTH( 128 ),
    .din3_WIDTH( 128 ),
    .din4_WIDTH( 128 ),
    .din5_WIDTH( 128 ),
    .din6_WIDTH( 128 ),
    .din7_WIDTH( 128 ),
    .din8_WIDTH( 128 ),
    .din9_WIDTH( 128 ),
    .din10_WIDTH( 128 ),
    .din11_WIDTH( 128 ),
    .din12_WIDTH( 128 ),
    .din13_WIDTH( 128 ),
    .din14_WIDTH( 128 ),
    .din15_WIDTH( 128 ),
    .din16_WIDTH( 128 ),
    .din17_WIDTH( 128 ),
    .din18_WIDTH( 128 ),
    .din19_WIDTH( 128 ),
    .din20_WIDTH( 128 ),
    .din21_WIDTH( 128 ),
    .din22_WIDTH( 128 ),
    .din23_WIDTH( 128 ),
    .din24_WIDTH( 128 ),
    .din25_WIDTH( 128 ),
    .din26_WIDTH( 128 ),
    .din27_WIDTH( 128 ),
    .din28_WIDTH( 128 ),
    .din29_WIDTH( 128 ),
    .din30_WIDTH( 128 ),
    .din31_WIDTH( 128 ),
    .din32_WIDTH( 128 ),
    .din33_WIDTH( 128 ),
    .din34_WIDTH( 128 ),
    .din35_WIDTH( 128 ),
    .din36_WIDTH( 128 ),
    .din37_WIDTH( 128 ),
    .din38_WIDTH( 128 ),
    .din39_WIDTH( 128 ),
    .din40_WIDTH( 128 ),
    .din41_WIDTH( 128 ),
    .din42_WIDTH( 128 ),
    .din43_WIDTH( 128 ),
    .din44_WIDTH( 128 ),
    .din45_WIDTH( 128 ),
    .din46_WIDTH( 128 ),
    .din47_WIDTH( 128 ),
    .din48_WIDTH( 128 ),
    .din49_WIDTH( 128 ),
    .din50_WIDTH( 128 ),
    .din51_WIDTH( 128 ),
    .din52_WIDTH( 128 ),
    .din53_WIDTH( 128 ),
    .din54_WIDTH( 128 ),
    .din55_WIDTH( 128 ),
    .din56_WIDTH( 128 ),
    .din57_WIDTH( 128 ),
    .din58_WIDTH( 128 ),
    .din59_WIDTH( 128 ),
    .din60_WIDTH( 128 ),
    .din61_WIDTH( 128 ),
    .din62_WIDTH( 128 ),
    .din63_WIDTH( 128 ),
    .din64_WIDTH( 128 ),
    .din65_WIDTH( 128 ),
    .din66_WIDTH( 128 ),
    .din67_WIDTH( 128 ),
    .din68_WIDTH( 128 ),
    .din69_WIDTH( 128 ),
    .din70_WIDTH( 128 ),
    .din71_WIDTH( 128 ),
    .din72_WIDTH( 7 ),
    .dout_WIDTH( 128 ))
StreamingFCLayer_eOg_U1(
    .din0(tmp_V_fu_276),
    .din1(tmp_V_2_fu_280),
    .din2(tmp_V_3_fu_284),
    .din3(tmp_V_4_fu_288),
    .din4(tmp_V_5_fu_292),
    .din5(tmp_V_6_fu_296),
    .din6(tmp_V_7_fu_300),
    .din7(tmp_V_8_fu_304),
    .din8(tmp_V_9_fu_308),
    .din9(tmp_V_10_fu_312),
    .din10(tmp_V_11_fu_316),
    .din11(tmp_V_12_fu_320),
    .din12(tmp_V_13_fu_324),
    .din13(tmp_V_14_fu_328),
    .din14(tmp_V_15_fu_332),
    .din15(tmp_V_16_fu_336),
    .din16(tmp_V_17_fu_340),
    .din17(tmp_V_18_fu_344),
    .din18(tmp_V_19_fu_348),
    .din19(tmp_V_20_fu_352),
    .din20(tmp_V_21_fu_356),
    .din21(tmp_V_22_fu_360),
    .din22(tmp_V_23_fu_364),
    .din23(tmp_V_24_fu_368),
    .din24(tmp_V_25_fu_372),
    .din25(tmp_V_26_fu_376),
    .din26(tmp_V_27_fu_380),
    .din27(tmp_V_28_fu_384),
    .din28(tmp_V_29_fu_388),
    .din29(tmp_V_30_fu_392),
    .din30(tmp_V_31_fu_396),
    .din31(tmp_V_32_fu_400),
    .din32(tmp_V_33_fu_404),
    .din33(tmp_V_34_fu_408),
    .din34(tmp_V_35_fu_412),
    .din35(tmp_V_36_fu_416),
    .din36(tmp_V_37_fu_420),
    .din37(tmp_V_38_fu_424),
    .din38(tmp_V_39_fu_428),
    .din39(tmp_V_40_fu_432),
    .din40(tmp_V_41_fu_436),
    .din41(tmp_V_42_fu_440),
    .din42(tmp_V_43_fu_444),
    .din43(tmp_V_44_fu_448),
    .din44(tmp_V_45_fu_452),
    .din45(tmp_V_46_fu_456),
    .din46(tmp_V_47_fu_460),
    .din47(tmp_V_48_fu_464),
    .din48(tmp_V_49_fu_468),
    .din49(tmp_V_50_fu_472),
    .din50(tmp_V_51_fu_476),
    .din51(tmp_V_52_fu_480),
    .din52(tmp_V_53_fu_484),
    .din53(tmp_V_54_fu_488),
    .din54(tmp_V_55_fu_492),
    .din55(tmp_V_56_fu_496),
    .din56(tmp_V_57_fu_500),
    .din57(tmp_V_58_fu_504),
    .din58(tmp_V_59_fu_508),
    .din59(tmp_V_60_fu_512),
    .din60(tmp_V_61_fu_516),
    .din61(tmp_V_62_fu_520),
    .din62(tmp_V_63_fu_524),
    .din63(tmp_V_64_fu_528),
    .din64(tmp_V_65_fu_532),
    .din65(tmp_V_66_fu_536),
    .din66(tmp_V_67_fu_540),
    .din67(tmp_V_68_fu_544),
    .din68(tmp_V_69_fu_548),
    .din69(tmp_V_70_fu_552),
    .din70(tmp_V_71_fu_556),
    .din71(tmp_V_72_fu_560),
    .din72(trunc_ln321_1_reg_2576),
    .dout(inElem_V_1_fu_1511_p74)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U2(
    .din0(trunc_ln647_1_fu_1744_p1),
    .din1(trunc_ln647_reg_2695),
    .dout(mul_ln1352_fu_1755_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U3(
    .din0(arg_V_read_assign_1_fu_1765_p4),
    .din1(p_Result_s_reg_2700),
    .dout(mul_ln1352_1_fu_1782_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U4(
    .din0(arg_V_read_assign_2_fu_1792_p4),
    .din1(p_Result_2_reg_2705),
    .dout(mul_ln1352_2_fu_1809_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U5(
    .din0(arg_V_read_assign_3_fu_1819_p4),
    .din1(p_Result_3_reg_2710),
    .dout(mul_ln1352_3_fu_1836_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U6(
    .din0(arg_V_read_assign_4_fu_1846_p4),
    .din1(p_Result_4_reg_2715),
    .dout(mul_ln1352_4_fu_1863_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U7(
    .din0(arg_V_read_assign_5_fu_1873_p4),
    .din1(p_Result_5_reg_2720),
    .dout(mul_ln1352_5_fu_1890_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U8(
    .din0(arg_V_read_assign_6_fu_1900_p4),
    .din1(p_Result_6_reg_2725),
    .dout(mul_ln1352_6_fu_1917_p2)
);

StreamingFCLayer_Batch_2_StreamingFCLayer_fYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 18 ))
StreamingFCLayer_fYi_U9(
    .din0(arg_V_read_assign_7_fu_1927_p4),
    .din1(p_Result_7_reg_2730),
    .dout(mul_ln1352_7_fu_1944_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            if ((1'b1 == ap_condition_pp0_exit_iter0_state2)) begin
                ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
            end else if ((1'b1 == 1'b1)) begin
                ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
            end
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd70) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd69) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd68) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd67) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd66) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd65) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd64) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd63) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd62) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd61) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd60) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd59) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd58) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd57) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd56) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd55) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd54) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd53) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd52) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd51) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd50) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd49) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd48) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd47) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd46) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd45) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd44) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd43) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd42) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd41) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd40) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd39) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd38) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd37) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd36) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd35) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd34) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd33) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd32) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd31) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd30) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd29) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd28) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd27) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd26) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd25) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd24) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd23) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd22) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd21) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd20) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd19) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd18) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd17) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd16) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd15) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd14) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd13) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd12) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd11) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd10) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd9) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd8) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd7) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd6) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd5) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd4) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd3) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd2) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd1) & (1'b0 == ap_block_pp0_stage0_11001)) | (~(trunc_ln321_fu_838_p1 == 7'd70) & ~(trunc_ln321_fu_838_p1 == 7'd69) & ~(trunc_ln321_fu_838_p1 == 7'd68) & ~(trunc_ln321_fu_838_p1 == 7'd67) & ~(trunc_ln321_fu_838_p1 == 7'd66) & ~(trunc_ln321_fu_838_p1 == 7'd65) & ~(trunc_ln321_fu_838_p1 == 7'd64) & ~(trunc_ln321_fu_838_p1 == 7'd63) & ~(trunc_ln321_fu_838_p1 == 7'd62) & ~(trunc_ln321_fu_838_p1 == 7'd61) & ~(trunc_ln321_fu_838_p1 == 7'd60) & ~(trunc_ln321_fu_838_p1 == 7'd59) & ~(trunc_ln321_fu_838_p1 == 7'd58) & ~(trunc_ln321_fu_838_p1 == 7'd57) & ~(trunc_ln321_fu_838_p1 == 7'd56) & ~(trunc_ln321_fu_838_p1 == 7'd55) & ~(trunc_ln321_fu_838_p1 == 7'd54) & ~(trunc_ln321_fu_838_p1 == 7'd53) & ~(trunc_ln321_fu_838_p1 == 7'd52) & ~(trunc_ln321_fu_838_p1 == 7'd51) & ~(trunc_ln321_fu_838_p1 == 7'd50) & ~(trunc_ln321_fu_838_p1 == 7'd49) & ~(trunc_ln321_fu_838_p1 == 7'd48) & ~(trunc_ln321_fu_838_p1 == 7'd47) & ~(trunc_ln321_fu_838_p1 == 7'd46) & ~(trunc_ln321_fu_838_p1 == 7'd45) & ~(trunc_ln321_fu_838_p1 == 7'd44) & ~(trunc_ln321_fu_838_p1 == 7'd43) & ~(trunc_ln321_fu_838_p1 == 7'd42) & ~(trunc_ln321_fu_838_p1 == 7'd41) & ~(trunc_ln321_fu_838_p1 == 7'd40) & ~(trunc_ln321_fu_838_p1 == 7'd39) & ~(trunc_ln321_fu_838_p1 == 7'd38) & ~(trunc_ln321_fu_838_p1 == 7'd37) & ~(trunc_ln321_fu_838_p1 == 7'd36) & ~(trunc_ln321_fu_838_p1 == 7'd35) & ~(trunc_ln321_fu_838_p1 == 7'd34) & ~(trunc_ln321_fu_838_p1 == 7'd33) & ~(trunc_ln321_fu_838_p1 == 7'd32) & ~(trunc_ln321_fu_838_p1 == 7'd31) & ~(trunc_ln321_fu_838_p1 == 7'd30) & ~(trunc_ln321_fu_838_p1 == 7'd29) & ~(trunc_ln321_fu_838_p1 == 7'd28) & ~(trunc_ln321_fu_838_p1 == 7'd27) & ~(trunc_ln321_fu_838_p1 == 7'd26) & ~(trunc_ln321_fu_838_p1 == 7'd25) & ~(trunc_ln321_fu_838_p1 == 7'd24) & ~(trunc_ln321_fu_838_p1 == 7'd23) & ~(trunc_ln321_fu_838_p1 == 7'd22) & ~(trunc_ln321_fu_838_p1 == 7'd21) & ~(trunc_ln321_fu_838_p1 == 7'd20) & ~(trunc_ln321_fu_838_p1 == 7'd19) & ~(trunc_ln321_fu_838_p1 == 7'd18) & ~(trunc_ln321_fu_838_p1 == 7'd17) & ~(trunc_ln321_fu_838_p1 == 7'd16) & ~(trunc_ln321_fu_838_p1 == 7'd15) & ~(trunc_ln321_fu_838_p1 == 7'd14) & ~(trunc_ln321_fu_838_p1 == 7'd13) & ~(trunc_ln321_fu_838_p1 == 7'd12) & ~(trunc_ln321_fu_838_p1 == 7'd11) & ~(trunc_ln321_fu_838_p1 == 7'd10) & ~(trunc_ln321_fu_838_p1 == 7'd9) & ~(trunc_ln321_fu_838_p1 == 7'd8) & ~(trunc_ln321_fu_838_p1 == 7'd7) & ~(trunc_ln321_fu_838_p1 == 7'd6) & ~(trunc_ln321_fu_838_p1 == 7'd5) & ~(trunc_ln321_fu_838_p1 == 7'd4) & ~(trunc_ln321_fu_838_p1 == 7'd3) & ~(trunc_ln321_fu_838_p1 == 7'd2) & ~(trunc_ln321_fu_838_p1 == 7'd1) & ~(trunc_ln321_fu_838_p1 == 7'd0) & (icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        ap_phi_reg_pp0_iter1_act_m_val_V_reg_644 <= in_V_V_TDATA;
    end else if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_phi_reg_pp0_iter1_act_m_val_V_reg_644 <= ap_phi_reg_pp0_iter0_act_m_val_V_reg_644;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_197)) begin
        if (((icmp_ln122_reg_2563 == 1'd0) & (icmp_ln125_reg_2572 == 1'd0))) begin
            ap_phi_reg_pp0_iter2_act_m_val_V_reg_644 <= inElem_V_1_fu_1511_p74;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter2_act_m_val_V_reg_644 <= ap_phi_reg_pp0_iter1_act_m_val_V_reg_644;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        i_0_reg_633 <= i_fu_816_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_reg_633 <= 13'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_1231_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        nf_assign_fu_564 <= nf_1_fu_1269_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        nf_assign_fu_564 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_1231_p2 == 1'd0) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sf_1_fu_272 <= sf_fu_1225_p2;
    end else if ((((icmp_ln160_fu_1231_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        sf_1_fu_272 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_1231_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_268 <= tile_1_fu_1277_p3;
    end else if (((icmp_ln160_fu_1231_p2 == 1'd0) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_268 <= tile_fu_1219_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        tile_assign_fu_268 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accu_V_0_0_0_fu_264 <= add_ln700_7_fu_2012_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln122_reg_2563 <= icmp_ln122_fu_810_p2;
        icmp_ln137_reg_2661_pp0_iter1_reg <= icmp_ln137_reg_2661;
        icmp_ln160_reg_2671_pp0_iter1_reg <= icmp_ln160_reg_2671;
        p_Result_2_reg_2705 <= {{weights_m_weights_V_q0[5:4]}};
        p_Result_3_reg_2710 <= {{weights_m_weights_V_q0[7:6]}};
        p_Result_4_reg_2715 <= {{weights_m_weights_V_q0[9:8]}};
        p_Result_5_reg_2720 <= {{weights_m_weights_V_q0[11:10]}};
        p_Result_6_reg_2725 <= {{weights_m_weights_V_q0[13:12]}};
        p_Result_7_reg_2730 <= {{weights_m_weights_V_q0[15:14]}};
        p_Result_s_reg_2700 <= {{weights_m_weights_V_q0[3:2]}};
        trunc_ln647_reg_2695 <= trunc_ln647_fu_1660_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_810_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln125_reg_2572 <= icmp_ln125_fu_825_p2;
        icmp_ln137_reg_2661 <= icmp_ln137_fu_1208_p2;
        icmp_ln160_reg_2671 <= icmp_ln160_fu_1231_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_reg_2671 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_4_reg_2735 <= threshs_m_thresholds_2_q0;
        threshs_m_thresholds_6_reg_2740 <= threshs_m_thresholds_1_q0;
        threshs_m_thresholds_8_reg_2745 <= threshs_m_thresholds_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd9) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_10_fu_312 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd10) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_11_fu_316 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd11) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_12_fu_320 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd12) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_13_fu_324 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd13) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_14_fu_328 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd14) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_15_fu_332 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd15) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_16_fu_336 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd16) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_17_fu_340 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd17) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_18_fu_344 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd18) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_19_fu_348 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd19) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_20_fu_352 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd20) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_21_fu_356 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd21) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_22_fu_360 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd22) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_23_fu_364 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd23) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_24_fu_368 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd24) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_25_fu_372 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd25) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_26_fu_376 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd26) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_27_fu_380 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd27) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_28_fu_384 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd28) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_29_fu_388 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_2_fu_280 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd29) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_30_fu_392 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd30) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_31_fu_396 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd31) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_32_fu_400 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd32) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_33_fu_404 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd33) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_34_fu_408 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd34) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_35_fu_412 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd35) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_36_fu_416 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd36) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_37_fu_420 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd37) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_38_fu_424 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd38) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_39_fu_428 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd2) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_3_fu_284 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd39) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_40_fu_432 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd40) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_41_fu_436 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd41) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_42_fu_440 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd42) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_43_fu_444 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd43) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_44_fu_448 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd44) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_45_fu_452 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd45) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_46_fu_456 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd46) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_47_fu_460 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd47) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_48_fu_464 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd48) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_49_fu_468 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd3) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_4_fu_288 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd49) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_50_fu_472 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd50) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_51_fu_476 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd51) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_52_fu_480 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd52) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_53_fu_484 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd53) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_54_fu_488 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd54) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_55_fu_492 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd55) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_56_fu_496 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd56) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_57_fu_500 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd57) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_58_fu_504 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd58) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_59_fu_508 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd4) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_5_fu_292 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd59) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_60_fu_512 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd60) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_61_fu_516 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd61) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_62_fu_520 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd62) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_63_fu_524 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd63) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_64_fu_528 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd64) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_65_fu_532 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd65) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_66_fu_536 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd66) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_67_fu_540 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd67) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_68_fu_544 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd68) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_69_fu_548 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd5) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_6_fu_296 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd69) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_70_fu_552 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd70) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_71_fu_556 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if ((~(trunc_ln321_fu_838_p1 == 7'd70) & ~(trunc_ln321_fu_838_p1 == 7'd69) & ~(trunc_ln321_fu_838_p1 == 7'd68) & ~(trunc_ln321_fu_838_p1 == 7'd67) & ~(trunc_ln321_fu_838_p1 == 7'd66) & ~(trunc_ln321_fu_838_p1 == 7'd65) & ~(trunc_ln321_fu_838_p1 == 7'd64) & ~(trunc_ln321_fu_838_p1 == 7'd63) & ~(trunc_ln321_fu_838_p1 == 7'd62) & ~(trunc_ln321_fu_838_p1 == 7'd61) & ~(trunc_ln321_fu_838_p1 == 7'd60) & ~(trunc_ln321_fu_838_p1 == 7'd59) & ~(trunc_ln321_fu_838_p1 == 7'd58) & ~(trunc_ln321_fu_838_p1 == 7'd57) & ~(trunc_ln321_fu_838_p1 == 7'd56) & ~(trunc_ln321_fu_838_p1 == 7'd55) & ~(trunc_ln321_fu_838_p1 == 7'd54) & ~(trunc_ln321_fu_838_p1 == 7'd53) & ~(trunc_ln321_fu_838_p1 == 7'd52) & ~(trunc_ln321_fu_838_p1 == 7'd51) & ~(trunc_ln321_fu_838_p1 == 7'd50) & ~(trunc_ln321_fu_838_p1 == 7'd49) & ~(trunc_ln321_fu_838_p1 == 7'd48) & ~(trunc_ln321_fu_838_p1 == 7'd47) & ~(trunc_ln321_fu_838_p1 == 7'd46) & ~(trunc_ln321_fu_838_p1 == 7'd45) & ~(trunc_ln321_fu_838_p1 == 7'd44) & ~(trunc_ln321_fu_838_p1 == 7'd43) & ~(trunc_ln321_fu_838_p1 == 7'd42) & ~(trunc_ln321_fu_838_p1 == 7'd41) & ~(trunc_ln321_fu_838_p1 == 7'd40) & ~(trunc_ln321_fu_838_p1 == 7'd39) & ~(trunc_ln321_fu_838_p1 == 7'd38) & ~(trunc_ln321_fu_838_p1 == 7'd37) & ~(trunc_ln321_fu_838_p1 == 7'd36) & ~(trunc_ln321_fu_838_p1 == 7'd35) & ~(trunc_ln321_fu_838_p1 == 7'd34) & ~(trunc_ln321_fu_838_p1 == 7'd33) & ~(trunc_ln321_fu_838_p1 == 7'd32) & ~(trunc_ln321_fu_838_p1 == 7'd31) & ~(trunc_ln321_fu_838_p1 == 7'd30) & ~(trunc_ln321_fu_838_p1 == 7'd29) & ~(trunc_ln321_fu_838_p1 == 7'd28) & ~(trunc_ln321_fu_838_p1 == 7'd27) & ~(trunc_ln321_fu_838_p1 == 7'd26) & ~(trunc_ln321_fu_838_p1 == 7'd25) & ~(trunc_ln321_fu_838_p1 == 7'd24) & ~(trunc_ln321_fu_838_p1 == 7'd23) & ~(trunc_ln321_fu_838_p1 == 7'd22) & ~(trunc_ln321_fu_838_p1 == 7'd21) & ~(trunc_ln321_fu_838_p1 == 7'd20) & ~(trunc_ln321_fu_838_p1 == 7'd19) & ~(trunc_ln321_fu_838_p1 == 7'd18) & ~(trunc_ln321_fu_838_p1 == 7'd17) & ~(trunc_ln321_fu_838_p1 == 7'd16) & ~(trunc_ln321_fu_838_p1 == 7'd15) & ~(trunc_ln321_fu_838_p1 == 7'd14) & ~(trunc_ln321_fu_838_p1 == 7'd13) & ~(trunc_ln321_fu_838_p1 == 7'd12) & ~(trunc_ln321_fu_838_p1 == 7'd11) & ~(trunc_ln321_fu_838_p1 == 7'd10) & ~(trunc_ln321_fu_838_p1 == 7'd9) & ~(trunc_ln321_fu_838_p1 == 7'd8) & ~(trunc_ln321_fu_838_p1 == 7'd7) & ~(trunc_ln321_fu_838_p1 == 7'd6) & ~(trunc_ln321_fu_838_p1 == 7'd5) & ~(trunc_ln321_fu_838_p1 == 7'd4) & ~(trunc_ln321_fu_838_p1 == 7'd3) & ~(trunc_ln321_fu_838_p1 == 7'd2) & ~(trunc_ln321_fu_838_p1 == 7'd1) & ~(trunc_ln321_fu_838_p1 == 7'd0) & (icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_72_fu_560 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd6) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_7_fu_300 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd7) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_8_fu_304 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd8) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_9_fu_308 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_838_p1 == 7'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_fu_276 <= in_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_825_p2 == 1'd0) & (icmp_ln122_fu_810_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        trunc_ln321_1_reg_2576 <= trunc_ln321_1_fu_834_p1;
    end
end

always @ (*) begin
    if ((icmp_ln122_fu_810_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op100_read_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln160_reg_2671_pp0_iter1_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((icmp_ln160_reg_2671_pp0_iter1_reg == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_1_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_2_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_2_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((icmp_ln122_fu_810_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone)) & ~((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone)))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone)) | ((icmp_ln122_fu_810_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone)))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln700_1_fu_1960_p2 = ($signed(sext_ln170_4_fu_1869_p1) + $signed(sext_ln170_5_fu_1923_p1));

assign add_ln700_2_fu_1970_p2 = ($signed(add_ln700_fu_1954_p2) + $signed(sext_ln700_2_fu_1966_p1));

assign add_ln700_3_fu_1976_p2 = ($signed(sext_ln170_fu_1761_p1) + $signed(sext_ln170_3_fu_1842_p1));

assign add_ln700_4_fu_1986_p2 = ($signed(sext_ln700_1_fu_1950_p1) + $signed(sext_ln170_1_fu_1788_p1));

assign add_ln700_5_fu_1992_p2 = ($signed(sext_ln170_2_fu_1815_p1) + $signed(add_ln700_4_fu_1986_p2));

assign add_ln700_6_fu_2002_p2 = ($signed(sext_ln700_3_fu_1982_p1) + $signed(sext_ln700_4_fu_1998_p1));

assign add_ln700_7_fu_2012_p2 = ($signed(add_ln700_2_fu_1970_p2) + $signed(sext_ln700_5_fu_2008_p1));

assign add_ln700_8_fu_2084_p2 = (zext_ln700_1_fu_2061_p1 + zext_ln700_2_fu_2080_p1);

assign add_ln700_fu_1954_p2 = ($signed(sext_ln700_fu_1896_p1) + $signed(res_V_fu_1737_p3));

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op100_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_block_state4_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op100_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_block_state4_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op100_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((in_V_V_TVALID == 1'b0) & (ap_predicate_op100_read_state2 == 1'b1));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state4_io = ((icmp_ln160_reg_2671_pp0_iter1_reg == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state4_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_197 = ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_reg_pp0_iter0_act_m_val_V_reg_644 = 'bx;

always @ (*) begin
    ap_predicate_op100_read_state2 = ((icmp_ln125_fu_825_p2 == 1'd1) & (icmp_ln122_fu_810_p2 == 1'd0));
end

assign arg_V_read_assign_1_fu_1765_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[31:16]}};

assign arg_V_read_assign_2_fu_1792_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[47:32]}};

assign arg_V_read_assign_3_fu_1819_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[63:48]}};

assign arg_V_read_assign_4_fu_1846_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[79:64]}};

assign arg_V_read_assign_5_fu_1873_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[95:80]}};

assign arg_V_read_assign_6_fu_1900_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[111:96]}};

assign arg_V_read_assign_7_fu_1927_p4 = {{ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[127:112]}};

assign i_fu_816_p2 = (i_0_reg_633 + 13'd1);

assign icmp_ln122_fu_810_p2 = ((i_0_reg_633 == 13'd4608) ? 1'b1 : 1'b0);

assign icmp_ln125_fu_825_p2 = ((nf_assign_fu_564 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln137_fu_1208_p2 = ((sf_1_fu_272 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln160_fu_1231_p2 = ((sf_fu_1225_p2 == 32'd72) ? 1'b1 : 1'b0);

assign icmp_ln173_fu_1263_p2 = ((nf_fu_1257_p2 == 32'd64) ? 1'b1 : 1'b0);

assign icmp_ln899_1_fu_2049_p2 = (($signed(add_ln700_7_fu_2012_p2) < $signed(zext_ln186_2_fu_2046_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_2_fu_2068_p2 = (($signed(add_ln700_7_fu_2012_p2) < $signed(zext_ln186_3_fu_2065_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_fu_2030_p2 = (($signed(add_ln700_7_fu_2012_p2) < $signed(zext_ln186_1_fu_2026_p1)) ? 1'b1 : 1'b0);

assign nf_1_fu_1269_p3 = ((icmp_ln173_fu_1263_p2[0:0] === 1'b1) ? 32'd0 : nf_fu_1257_p2);

assign nf_fu_1257_p2 = (nf_assign_fu_564 + 32'd1);

assign out_V_V_TDATA = tmp_V_74_fu_2090_p2;

assign res_V_fu_1737_p3 = ((icmp_ln137_reg_2661_pp0_iter1_reg[0:0] === 1'b1) ? 64'd0 : accu_V_0_0_0_fu_264);

assign sext_ln170_1_fu_1788_p1 = mul_ln1352_1_fu_1782_p2;

assign sext_ln170_2_fu_1815_p1 = mul_ln1352_2_fu_1809_p2;

assign sext_ln170_3_fu_1842_p1 = mul_ln1352_3_fu_1836_p2;

assign sext_ln170_4_fu_1869_p1 = mul_ln1352_4_fu_1863_p2;

assign sext_ln170_5_fu_1923_p1 = mul_ln1352_6_fu_1917_p2;

assign sext_ln170_fu_1761_p1 = mul_ln1352_fu_1755_p2;

assign sext_ln186_fu_2023_p1 = $signed(threshs_m_thresholds_4_reg_2735);

assign sext_ln700_1_fu_1950_p1 = mul_ln1352_7_fu_1944_p2;

assign sext_ln700_2_fu_1966_p1 = $signed(add_ln700_1_fu_1960_p2);

assign sext_ln700_3_fu_1982_p1 = $signed(add_ln700_3_fu_1976_p2);

assign sext_ln700_4_fu_1998_p1 = $signed(add_ln700_5_fu_1992_p2);

assign sext_ln700_5_fu_2008_p1 = $signed(add_ln700_6_fu_2002_p2);

assign sext_ln700_fu_1896_p1 = mul_ln1352_5_fu_1890_p2;

assign sf_fu_1225_p2 = (32'd1 + sf_1_fu_272);

assign threshs_m_thresholds_1_address0 = zext_ln186_fu_1250_p1;

assign threshs_m_thresholds_2_address0 = zext_ln186_fu_1250_p1;

assign threshs_m_thresholds_address0 = zext_ln186_fu_1250_p1;

assign tile_1_fu_1277_p3 = ((icmp_ln173_fu_1263_p2[0:0] === 1'b1) ? 32'd0 : tile_fu_1219_p2);

assign tile_fu_1219_p2 = (32'd1 + tile_assign_fu_268);

assign tmp_V_74_fu_2090_p2 = (add_ln700_8_fu_2084_p2 + zext_ln700_fu_2042_p1);

assign trunc_ln321_1_fu_834_p1 = sf_1_fu_272[6:0];

assign trunc_ln321_fu_838_p1 = sf_1_fu_272[6:0];

assign trunc_ln647_1_fu_1744_p1 = ap_phi_reg_pp0_iter2_act_m_val_V_reg_644[15:0];

assign trunc_ln647_fu_1660_p1 = weights_m_weights_V_q0[1:0];

assign weights_m_weights_V_address0 = zext_ln137_fu_1214_p1;

assign xor_ln899_1_fu_2055_p2 = (icmp_ln899_1_fu_2049_p2 ^ 1'd1);

assign xor_ln899_2_fu_2074_p2 = (icmp_ln899_2_fu_2068_p2 ^ 1'd1);

assign xor_ln899_fu_2036_p2 = (icmp_ln899_fu_2030_p2 ^ 1'd1);

assign zext_ln137_fu_1214_p1 = tile_assign_fu_268;

assign zext_ln186_1_fu_2026_p1 = $unsigned(sext_ln186_fu_2023_p1);

assign zext_ln186_2_fu_2046_p1 = threshs_m_thresholds_6_reg_2740;

assign zext_ln186_3_fu_2065_p1 = threshs_m_thresholds_8_reg_2745;

assign zext_ln186_fu_1250_p1 = nf_assign_fu_564;

assign zext_ln700_1_fu_2061_p1 = xor_ln899_1_fu_2055_p2;

assign zext_ln700_2_fu_2080_p1 = xor_ln899_2_fu_2074_p2;

assign zext_ln700_fu_2042_p1 = xor_ln899_fu_2036_p2;

endmodule //StreamingFCLayer_Batch_2_Matrix_Vector_Activa
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Activa.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingFCLayer_Batch_0_Matrix_Vector_Activa (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY,
        weights_m_weights_0_V_address0,
        weights_m_weights_0_V_ce0,
        weights_m_weights_0_V_q0,
        weights_m_weights_1_V_address0,
        weights_m_weights_1_V_ce0,
        weights_m_weights_1_V_q0
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [71:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;
output  [4:0] weights_m_weights_0_V_address0;
output   weights_m_weights_0_V_ce0;
input  [17:0] weights_m_weights_0_V_q0;
output  [4:0] weights_m_weights_1_V_address0;
output   weights_m_weights_1_V_ce0;
input  [17:0] weights_m_weights_1_V_q0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;
reg weights_m_weights_0_V_ce0;
reg weights_m_weights_1_V_ce0;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [4:0] threshs_m_thresholds_5_address0;
reg    threshs_m_thresholds_5_ce0;
wire   [7:0] threshs_m_thresholds_5_q0;
wire   [4:0] threshs_m_thresholds_4_address0;
reg    threshs_m_thresholds_4_ce0;
wire   [7:0] threshs_m_thresholds_4_q0;
wire   [4:0] threshs_m_thresholds_3_address0;
reg    threshs_m_thresholds_3_ce0;
wire   [9:0] threshs_m_thresholds_3_q0;
wire   [4:0] threshs_m_thresholds_2_address0;
reg    threshs_m_thresholds_2_ce0;
wire   [7:0] threshs_m_thresholds_2_q0;
wire   [4:0] threshs_m_thresholds_1_address0;
reg    threshs_m_thresholds_1_ce0;
wire   [7:0] threshs_m_thresholds_1_q0;
wire   [4:0] threshs_m_thresholds_address0;
reg    threshs_m_thresholds_ce0;
wire   [9:0] threshs_m_thresholds_q0;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln122_fu_299_p2;
wire   [0:0] icmp_ln125_fu_314_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln137_reg_1355;
reg   [11:0] i_0_reg_273;
reg    ap_predicate_op27_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [11:0] i_fu_305_p2;
wire   [0:0] icmp_ln137_fu_331_p2;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [63:0] zext_ln137_fu_337_p1;
wire   [63:0] zext_ln186_fu_368_p1;
reg   [12:0] accu_V_0_0_0_fu_132;
wire   [12:0] accu_0_0_V_fu_837_p2;
reg   [12:0] accu_V_0_1_0_fu_136;
wire   [12:0] accu_0_1_V_fu_1121_p2;
reg   [31:0] tile_assign_fu_140;
wire   [31:0] tile_fu_343_p2;
wire   [31:0] select_ln173_1_fu_398_p3;
reg   [31:0] sf_1_fu_144;
wire   [31:0] sf_fu_349_p2;
reg   [31:0] nf_assign_fu_148;
wire   [31:0] select_ln173_fu_390_p3;
reg   [71:0] inElem_V_fu_152;
reg    ap_block_pp0_stage0_01001;
wire   [31:0] nf_fu_378_p2;
wire   [0:0] icmp_ln173_fu_384_p2;
wire  signed [1:0] wgt_M_instance_0_V_fu_439_p1;
wire   [7:0] trunc_ln647_fu_523_p1;
wire   [7:0] mul_ln1352_fu_535_p0;
wire   [9:0] zext_ln215_fu_531_p1;
wire  signed [9:0] mul_ln1352_fu_535_p2;
wire  signed [1:0] wgt_M_instance_1_V_fu_443_p4;
wire   [7:0] arg_V_read_assign_1_fu_545_p4;
wire   [7:0] mul_ln1352_1_fu_563_p0;
wire   [9:0] zext_ln215_1_fu_559_p1;
wire  signed [9:0] mul_ln1352_1_fu_563_p2;
wire  signed [1:0] wgt_M_instance_2_V_fu_453_p4;
wire   [7:0] arg_V_read_assign_2_fu_573_p4;
wire   [7:0] mul_ln1352_2_fu_591_p0;
wire   [9:0] zext_ln215_2_fu_587_p1;
wire  signed [9:0] mul_ln1352_2_fu_591_p2;
wire  signed [1:0] wgt_M_instance_3_V_fu_463_p4;
wire   [7:0] arg_V_read_assign_3_fu_601_p4;
wire   [7:0] mul_ln1352_3_fu_619_p0;
wire   [9:0] zext_ln215_3_fu_615_p1;
wire  signed [9:0] mul_ln1352_3_fu_619_p2;
wire  signed [1:0] wgt_M_instance_4_V_fu_473_p4;
wire   [7:0] arg_V_read_assign_4_fu_629_p4;
wire   [7:0] mul_ln1352_4_fu_647_p0;
wire   [9:0] zext_ln215_4_fu_643_p1;
wire  signed [9:0] mul_ln1352_4_fu_647_p2;
wire  signed [1:0] wgt_M_instance_5_V_fu_483_p4;
wire   [7:0] arg_V_read_assign_5_fu_657_p4;
wire   [7:0] mul_ln1352_5_fu_675_p0;
wire   [9:0] zext_ln215_5_fu_671_p1;
wire  signed [9:0] mul_ln1352_5_fu_675_p2;
wire  signed [1:0] p_Result_0_6_fu_493_p4;
wire   [7:0] arg_V_read_assign_6_fu_685_p4;
wire   [7:0] mul_ln1352_6_fu_703_p0;
wire   [9:0] zext_ln215_6_fu_699_p1;
wire  signed [9:0] mul_ln1352_6_fu_703_p2;
wire  signed [1:0] p_Result_0_7_fu_503_p4;
wire   [7:0] arg_V_read_assign_7_fu_713_p4;
wire   [7:0] mul_ln1352_7_fu_731_p0;
wire   [9:0] zext_ln215_7_fu_727_p1;
wire  signed [9:0] mul_ln1352_7_fu_731_p2;
wire  signed [1:0] p_Result_0_8_fu_513_p4;
wire   [7:0] arg_V_read_assign_8_fu_741_p4;
wire   [7:0] mul_ln1352_8_fu_759_p0;
wire   [9:0] zext_ln215_8_fu_755_p1;
wire  signed [9:0] mul_ln1352_8_fu_759_p2;
wire  signed [12:0] sext_ln700_fu_709_p1;
wire   [12:0] select_ln137_1_fu_432_p3;
wire  signed [10:0] sext_ln170_4_fu_653_p1;
wire  signed [10:0] sext_ln170_5_fu_681_p1;
wire   [10:0] add_ln700_1_fu_775_p2;
wire  signed [11:0] sext_ln170_6_fu_737_p1;
wire  signed [11:0] sext_ln700_2_fu_781_p1;
wire   [11:0] add_ln700_2_fu_785_p2;
wire   [12:0] add_ln700_fu_769_p2;
wire  signed [12:0] sext_ln700_3_fu_791_p1;
wire  signed [10:0] sext_ln170_fu_541_p1;
wire  signed [10:0] sext_ln170_3_fu_625_p1;
wire   [10:0] add_ln700_4_fu_801_p2;
wire  signed [10:0] sext_ln700_1_fu_765_p1;
wire  signed [10:0] sext_ln170_1_fu_569_p1;
wire   [10:0] add_ln700_5_fu_811_p2;
wire  signed [11:0] sext_ln170_2_fu_597_p1;
wire  signed [11:0] sext_ln700_5_fu_817_p1;
wire   [11:0] add_ln700_6_fu_821_p2;
wire  signed [12:0] sext_ln700_4_fu_807_p1;
wire  signed [12:0] sext_ln700_6_fu_827_p1;
wire   [12:0] add_ln700_3_fu_795_p2;
wire   [12:0] add_ln700_7_fu_831_p2;
wire  signed [1:0] wgt_M_instance_0_V_1_fu_843_p1;
wire   [7:0] mul_ln1352_9_fu_931_p0;
wire  signed [9:0] mul_ln1352_9_fu_931_p2;
wire  signed [1:0] wgt_M_instance_1_V_1_fu_847_p4;
wire   [7:0] mul_ln1352_10_fu_945_p0;
wire  signed [9:0] mul_ln1352_10_fu_945_p2;
wire  signed [1:0] wgt_M_instance_2_V_1_fu_857_p4;
wire   [7:0] mul_ln1352_11_fu_959_p0;
wire  signed [9:0] mul_ln1352_11_fu_959_p2;
wire  signed [1:0] wgt_M_instance_3_V_1_fu_867_p4;
wire   [7:0] mul_ln1352_12_fu_973_p0;
wire  signed [9:0] mul_ln1352_12_fu_973_p2;
wire  signed [1:0] wgt_M_instance_4_V_1_fu_877_p4;
wire   [7:0] mul_ln1352_13_fu_987_p0;
wire  signed [9:0] mul_ln1352_13_fu_987_p2;
wire  signed [1:0] wgt_M_instance_5_V_1_fu_887_p4;
wire   [7:0] mul_ln1352_14_fu_1001_p0;
wire  signed [9:0] mul_ln1352_14_fu_1001_p2;
wire  signed [1:0] p_Result_116_6_fu_897_p4;
wire   [7:0] mul_ln1352_15_fu_1015_p0;
wire  signed [9:0] mul_ln1352_15_fu_1015_p2;
wire  signed [1:0] p_Result_116_7_fu_907_p4;
wire   [7:0] mul_ln1352_16_fu_1029_p0;
wire  signed [9:0] mul_ln1352_16_fu_1029_p2;
wire  signed [1:0] p_Result_116_8_fu_917_p4;
wire   [7:0] mul_ln1352_17_fu_1043_p0;
wire  signed [9:0] mul_ln1352_17_fu_1043_p2;
wire  signed [12:0] sext_ln700_7_fu_1021_p1;
wire   [12:0] select_ln137_fu_425_p3;
wire  signed [10:0] sext_ln170_11_fu_993_p1;
wire  signed [10:0] sext_ln170_12_fu_1007_p1;
wire   [10:0] add_ln700_10_fu_1059_p2;
wire  signed [11:0] sext_ln170_13_fu_1035_p1;
wire  signed [11:0] sext_ln700_9_fu_1065_p1;
wire   [11:0] add_ln700_11_fu_1069_p2;
wire   [12:0] add_ln700_9_fu_1053_p2;
wire  signed [12:0] sext_ln700_10_fu_1075_p1;
wire  signed [10:0] sext_ln170_7_fu_937_p1;
wire  signed [10:0] sext_ln170_10_fu_979_p1;
wire   [10:0] add_ln700_13_fu_1085_p2;
wire  signed [10:0] sext_ln700_8_fu_1049_p1;
wire  signed [10:0] sext_ln170_8_fu_951_p1;
wire   [10:0] add_ln700_14_fu_1095_p2;
wire  signed [11:0] sext_ln170_9_fu_965_p1;
wire  signed [11:0] sext_ln700_12_fu_1101_p1;
wire   [11:0] add_ln700_15_fu_1105_p2;
wire  signed [12:0] sext_ln700_11_fu_1091_p1;
wire  signed [12:0] sext_ln700_13_fu_1111_p1;
wire   [12:0] add_ln700_12_fu_1079_p2;
wire   [12:0] add_ln700_16_fu_1115_p2;
wire   [12:0] zext_ln186_1_fu_1137_p1;
wire   [0:0] icmp_ln899_fu_1141_p2;
wire   [0:0] xor_ln899_fu_1147_p2;
wire  signed [8:0] sext_ln186_fu_1157_p1;
wire   [12:0] zext_ln186_2_fu_1161_p1;
wire   [0:0] icmp_ln899_1_fu_1165_p2;
wire   [0:0] xor_ln899_1_fu_1171_p2;
wire   [12:0] zext_ln186_3_fu_1181_p1;
wire   [0:0] icmp_ln899_2_fu_1185_p2;
wire   [0:0] xor_ln899_2_fu_1191_p2;
wire   [1:0] zext_ln700_1_fu_1177_p1;
wire   [1:0] zext_ln700_2_fu_1197_p1;
wire   [1:0] add_ln700_18_fu_1201_p2;
wire   [1:0] zext_ln700_fu_1153_p1;
wire   [12:0] zext_ln186_4_fu_1213_p1;
wire   [0:0] icmp_ln899_3_fu_1217_p2;
wire   [0:0] xor_ln899_3_fu_1223_p2;
wire  signed [8:0] sext_ln186_1_fu_1233_p1;
wire   [12:0] zext_ln186_5_fu_1237_p1;
wire   [0:0] icmp_ln899_4_fu_1241_p2;
wire   [0:0] xor_ln899_4_fu_1247_p2;
wire   [12:0] zext_ln186_6_fu_1257_p1;
wire   [0:0] icmp_ln899_5_fu_1261_p2;
wire   [0:0] xor_ln899_5_fu_1267_p2;
wire   [1:0] zext_ln700_4_fu_1253_p1;
wire   [1:0] zext_ln700_5_fu_1273_p1;
wire   [1:0] add_ln700_20_fu_1277_p2;
wire   [1:0] zext_ln700_3_fu_1229_p1;
wire   [1:0] add_ln700_21_fu_1283_p2;
wire   [1:0] add_ln700_19_fu_1207_p2;
wire   [3:0] tmp_V_fu_1289_p3;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

StreamingFCLayer_Batch_0_Matrix_Vector_Actbkb #(
    .DataWidth( 8 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
threshs_m_thresholds_5_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_5_address0),
    .ce0(threshs_m_thresholds_5_ce0),
    .q0(threshs_m_thresholds_5_q0)
);

StreamingFCLayer_Batch_0_Matrix_Vector_Actcud #(
    .DataWidth( 8 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
threshs_m_thresholds_4_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_4_address0),
    .ce0(threshs_m_thresholds_4_ce0),
    .q0(threshs_m_thresholds_4_q0)
);

StreamingFCLayer_Batch_0_Matrix_Vector_ActdEe #(
    .DataWidth( 10 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
threshs_m_thresholds_3_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_3_address0),
    .ce0(threshs_m_thresholds_3_ce0),
    .q0(threshs_m_thresholds_3_q0)
);

StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg #(
    .DataWidth( 8 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
threshs_m_thresholds_2_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_2_address0),
    .ce0(threshs_m_thresholds_2_ce0),
    .q0(threshs_m_thresholds_2_q0)
);

StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi #(
    .DataWidth( 8 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
threshs_m_thresholds_1_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_1_address0),
    .ce0(threshs_m_thresholds_1_ce0),
    .q0(threshs_m_thresholds_1_q0)
);

StreamingFCLayer_Batch_0_Matrix_Vector_Actg8j #(
    .DataWidth( 10 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
threshs_m_thresholds_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(threshs_m_thresholds_address0),
    .ce0(threshs_m_thresholds_ce0),
    .q0(threshs_m_thresholds_q0)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U1(
    .din0(mul_ln1352_fu_535_p0),
    .din1(wgt_M_instance_0_V_fu_439_p1),
    .dout(mul_ln1352_fu_535_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U2(
    .din0(mul_ln1352_1_fu_563_p0),
    .din1(wgt_M_instance_1_V_fu_443_p4),
    .dout(mul_ln1352_1_fu_563_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U3(
    .din0(mul_ln1352_2_fu_591_p0),
    .din1(wgt_M_instance_2_V_fu_453_p4),
    .dout(mul_ln1352_2_fu_591_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U4(
    .din0(mul_ln1352_3_fu_619_p0),
    .din1(wgt_M_instance_3_V_fu_463_p4),
    .dout(mul_ln1352_3_fu_619_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U5(
    .din0(mul_ln1352_4_fu_647_p0),
    .din1(wgt_M_instance_4_V_fu_473_p4),
    .dout(mul_ln1352_4_fu_647_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U6(
    .din0(mul_ln1352_5_fu_675_p0),
    .din1(wgt_M_instance_5_V_fu_483_p4),
    .dout(mul_ln1352_5_fu_675_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U7(
    .din0(mul_ln1352_6_fu_703_p0),
    .din1(p_Result_0_6_fu_493_p4),
    .dout(mul_ln1352_6_fu_703_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U8(
    .din0(mul_ln1352_7_fu_731_p0),
    .din1(p_Result_0_7_fu_503_p4),
    .dout(mul_ln1352_7_fu_731_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U9(
    .din0(mul_ln1352_8_fu_759_p0),
    .din1(p_Result_0_8_fu_513_p4),
    .dout(mul_ln1352_8_fu_759_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U10(
    .din0(mul_ln1352_9_fu_931_p0),
    .din1(wgt_M_instance_0_V_1_fu_843_p1),
    .dout(mul_ln1352_9_fu_931_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U11(
    .din0(mul_ln1352_10_fu_945_p0),
    .din1(wgt_M_instance_1_V_1_fu_847_p4),
    .dout(mul_ln1352_10_fu_945_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U12(
    .din0(mul_ln1352_11_fu_959_p0),
    .din1(wgt_M_instance_2_V_1_fu_857_p4),
    .dout(mul_ln1352_11_fu_959_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U13(
    .din0(mul_ln1352_12_fu_973_p0),
    .din1(wgt_M_instance_3_V_1_fu_867_p4),
    .dout(mul_ln1352_12_fu_973_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U14(
    .din0(mul_ln1352_13_fu_987_p0),
    .din1(wgt_M_instance_4_V_1_fu_877_p4),
    .dout(mul_ln1352_13_fu_987_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U15(
    .din0(mul_ln1352_14_fu_1001_p0),
    .din1(wgt_M_instance_5_V_1_fu_887_p4),
    .dout(mul_ln1352_14_fu_1001_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U16(
    .din0(mul_ln1352_15_fu_1015_p0),
    .din1(p_Result_116_6_fu_897_p4),
    .dout(mul_ln1352_15_fu_1015_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U17(
    .din0(mul_ln1352_16_fu_1029_p0),
    .din1(p_Result_116_7_fu_907_p4),
    .dout(mul_ln1352_16_fu_1029_p2)
);

StreamingFCLayer_Batch_0_StreamingFCLayer_hbi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 8 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 10 ))
StreamingFCLayer_hbi_U18(
    .din0(mul_ln1352_17_fu_1043_p0),
    .din1(p_Result_116_8_fu_917_p4),
    .dout(mul_ln1352_17_fu_1043_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        i_0_reg_273 <= i_fu_305_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_reg_273 <= 12'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln137_fu_331_p2 == 1'd1))) begin
        nf_assign_fu_148 <= select_ln173_fu_390_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        nf_assign_fu_148 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln137_fu_331_p2 == 1'd0) & (icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sf_1_fu_144 <= sf_fu_349_p2;
    end else if ((((icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln137_fu_331_p2 == 1'd1)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        sf_1_fu_144 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln137_fu_331_p2 == 1'd1))) begin
        tile_assign_fu_140 <= select_ln173_1_fu_398_p3;
    end else if (((icmp_ln137_fu_331_p2 == 1'd0) & (icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_140 <= tile_fu_343_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        tile_assign_fu_140 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accu_V_0_0_0_fu_132 <= accu_0_0_V_fu_837_p2;
        accu_V_0_1_0_fu_136 <= accu_0_1_V_fu_1121_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_299_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln137_reg_1355 <= icmp_ln137_fu_331_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_299_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln125_fu_314_p2 == 1'd1))) begin
        inElem_V_fu_152 <= in_V_V_TDATA;
    end
end

always @ (*) begin
    if ((icmp_ln122_fu_299_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln122_fu_299_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln125_fu_314_p2 == 1'd1))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_predicate_op27_read_state2 == 1'b1))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln137_reg_1355 == 1'd1))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln137_reg_1355 == 1'd1))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_1_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_1_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_2_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_2_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_3_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_3_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_4_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_4_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_5_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_5_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        threshs_m_thresholds_ce0 = 1'b1;
    end else begin
        threshs_m_thresholds_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_0_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_1_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_1_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln122_fu_299_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln122_fu_299_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign accu_0_0_V_fu_837_p2 = (add_ln700_3_fu_795_p2 + add_ln700_7_fu_831_p2);

assign accu_0_1_V_fu_1121_p2 = (add_ln700_12_fu_1079_p2 + add_ln700_16_fu_1115_p2);

assign add_ln700_10_fu_1059_p2 = ($signed(sext_ln170_11_fu_993_p1) + $signed(sext_ln170_12_fu_1007_p1));

assign add_ln700_11_fu_1069_p2 = ($signed(sext_ln170_13_fu_1035_p1) + $signed(sext_ln700_9_fu_1065_p1));

assign add_ln700_12_fu_1079_p2 = ($signed(add_ln700_9_fu_1053_p2) + $signed(sext_ln700_10_fu_1075_p1));

assign add_ln700_13_fu_1085_p2 = ($signed(sext_ln170_7_fu_937_p1) + $signed(sext_ln170_10_fu_979_p1));

assign add_ln700_14_fu_1095_p2 = ($signed(sext_ln700_8_fu_1049_p1) + $signed(sext_ln170_8_fu_951_p1));

assign add_ln700_15_fu_1105_p2 = ($signed(sext_ln170_9_fu_965_p1) + $signed(sext_ln700_12_fu_1101_p1));

assign add_ln700_16_fu_1115_p2 = ($signed(sext_ln700_11_fu_1091_p1) + $signed(sext_ln700_13_fu_1111_p1));

assign add_ln700_18_fu_1201_p2 = (zext_ln700_1_fu_1177_p1 + zext_ln700_2_fu_1197_p1);

assign add_ln700_19_fu_1207_p2 = (add_ln700_18_fu_1201_p2 + zext_ln700_fu_1153_p1);

assign add_ln700_1_fu_775_p2 = ($signed(sext_ln170_4_fu_653_p1) + $signed(sext_ln170_5_fu_681_p1));

assign add_ln700_20_fu_1277_p2 = (zext_ln700_4_fu_1253_p1 + zext_ln700_5_fu_1273_p1);

assign add_ln700_21_fu_1283_p2 = (add_ln700_20_fu_1277_p2 + zext_ln700_3_fu_1229_p1);

assign add_ln700_2_fu_785_p2 = ($signed(sext_ln170_6_fu_737_p1) + $signed(sext_ln700_2_fu_781_p1));

assign add_ln700_3_fu_795_p2 = ($signed(add_ln700_fu_769_p2) + $signed(sext_ln700_3_fu_791_p1));

assign add_ln700_4_fu_801_p2 = ($signed(sext_ln170_fu_541_p1) + $signed(sext_ln170_3_fu_625_p1));

assign add_ln700_5_fu_811_p2 = ($signed(sext_ln700_1_fu_765_p1) + $signed(sext_ln170_1_fu_569_p1));

assign add_ln700_6_fu_821_p2 = ($signed(sext_ln170_2_fu_597_p1) + $signed(sext_ln700_5_fu_817_p1));

assign add_ln700_7_fu_831_p2 = ($signed(sext_ln700_4_fu_807_p1) + $signed(sext_ln700_6_fu_827_p1));

assign add_ln700_9_fu_1053_p2 = ($signed(sext_ln700_7_fu_1021_p1) + $signed(select_ln137_fu_425_p3));

assign add_ln700_fu_769_p2 = ($signed(sext_ln700_fu_709_p1) + $signed(select_ln137_1_fu_432_p3));

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op27_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op27_read_state2 == 1'b1)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op27_read_state2 == 1'b1)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((in_V_V_TVALID == 1'b0) & (ap_predicate_op27_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state3_io = ((out_V_V_TREADY == 1'b0) & (icmp_ln137_reg_1355 == 1'd1));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_predicate_op27_read_state2 = ((icmp_ln122_fu_299_p2 == 1'd0) & (icmp_ln125_fu_314_p2 == 1'd1));
end

assign arg_V_read_assign_1_fu_545_p4 = {{inElem_V_fu_152[15:8]}};

assign arg_V_read_assign_2_fu_573_p4 = {{inElem_V_fu_152[23:16]}};

assign arg_V_read_assign_3_fu_601_p4 = {{inElem_V_fu_152[31:24]}};

assign arg_V_read_assign_4_fu_629_p4 = {{inElem_V_fu_152[39:32]}};

assign arg_V_read_assign_5_fu_657_p4 = {{inElem_V_fu_152[47:40]}};

assign arg_V_read_assign_6_fu_685_p4 = {{inElem_V_fu_152[55:48]}};

assign arg_V_read_assign_7_fu_713_p4 = {{inElem_V_fu_152[63:56]}};

assign arg_V_read_assign_8_fu_741_p4 = {{inElem_V_fu_152[71:64]}};

assign i_fu_305_p2 = (i_0_reg_273 + 12'd1);

assign icmp_ln122_fu_299_p2 = ((i_0_reg_273 == 12'd3200) ? 1'b1 : 1'b0);

assign icmp_ln125_fu_314_p2 = ((nf_assign_fu_148 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln137_fu_331_p2 = ((sf_1_fu_144 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln173_fu_384_p2 = ((nf_fu_378_p2 == 32'd32) ? 1'b1 : 1'b0);

assign icmp_ln899_1_fu_1165_p2 = (($signed(accu_0_0_V_fu_837_p2) < $signed(zext_ln186_2_fu_1161_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_2_fu_1185_p2 = (($signed(accu_0_0_V_fu_837_p2) < $signed(zext_ln186_3_fu_1181_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_3_fu_1217_p2 = (($signed(accu_0_1_V_fu_1121_p2) < $signed(zext_ln186_4_fu_1213_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_4_fu_1241_p2 = (($signed(accu_0_1_V_fu_1121_p2) < $signed(zext_ln186_5_fu_1237_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_5_fu_1261_p2 = (($signed(accu_0_1_V_fu_1121_p2) < $signed(zext_ln186_6_fu_1257_p1)) ? 1'b1 : 1'b0);

assign icmp_ln899_fu_1141_p2 = (($signed(accu_0_0_V_fu_837_p2) < $signed(zext_ln186_1_fu_1137_p1)) ? 1'b1 : 1'b0);

assign mul_ln1352_10_fu_945_p0 = zext_ln215_1_fu_559_p1;

assign mul_ln1352_11_fu_959_p0 = zext_ln215_2_fu_587_p1;

assign mul_ln1352_12_fu_973_p0 = zext_ln215_3_fu_615_p1;

assign mul_ln1352_13_fu_987_p0 = zext_ln215_4_fu_643_p1;

assign mul_ln1352_14_fu_1001_p0 = zext_ln215_5_fu_671_p1;

assign mul_ln1352_15_fu_1015_p0 = zext_ln215_6_fu_699_p1;

assign mul_ln1352_16_fu_1029_p0 = zext_ln215_7_fu_727_p1;

assign mul_ln1352_17_fu_1043_p0 = zext_ln215_8_fu_755_p1;

assign mul_ln1352_1_fu_563_p0 = zext_ln215_1_fu_559_p1;

assign mul_ln1352_2_fu_591_p0 = zext_ln215_2_fu_587_p1;

assign mul_ln1352_3_fu_619_p0 = zext_ln215_3_fu_615_p1;

assign mul_ln1352_4_fu_647_p0 = zext_ln215_4_fu_643_p1;

assign mul_ln1352_5_fu_675_p0 = zext_ln215_5_fu_671_p1;

assign mul_ln1352_6_fu_703_p0 = zext_ln215_6_fu_699_p1;

assign mul_ln1352_7_fu_731_p0 = zext_ln215_7_fu_727_p1;

assign mul_ln1352_8_fu_759_p0 = zext_ln215_8_fu_755_p1;

assign mul_ln1352_9_fu_931_p0 = zext_ln215_fu_531_p1;

assign mul_ln1352_fu_535_p0 = zext_ln215_fu_531_p1;

assign nf_fu_378_p2 = (nf_assign_fu_148 + 32'd1);

assign out_V_V_TDATA = tmp_V_fu_1289_p3;

assign p_Result_0_6_fu_493_p4 = {{weights_m_weights_0_V_q0[13:12]}};

assign p_Result_0_7_fu_503_p4 = {{weights_m_weights_0_V_q0[15:14]}};

assign p_Result_0_8_fu_513_p4 = {{weights_m_weights_0_V_q0[17:16]}};

assign p_Result_116_6_fu_897_p4 = {{weights_m_weights_1_V_q0[13:12]}};

assign p_Result_116_7_fu_907_p4 = {{weights_m_weights_1_V_q0[15:14]}};

assign p_Result_116_8_fu_917_p4 = {{weights_m_weights_1_V_q0[17:16]}};

assign select_ln137_1_fu_432_p3 = ((icmp_ln137_reg_1355[0:0] === 1'b1) ? 13'd0 : accu_V_0_0_0_fu_132);

assign select_ln137_fu_425_p3 = ((icmp_ln137_reg_1355[0:0] === 1'b1) ? 13'd0 : accu_V_0_1_0_fu_136);

assign select_ln173_1_fu_398_p3 = ((icmp_ln173_fu_384_p2[0:0] === 1'b1) ? 32'd0 : tile_fu_343_p2);

assign select_ln173_fu_390_p3 = ((icmp_ln173_fu_384_p2[0:0] === 1'b1) ? 32'd0 : nf_fu_378_p2);

assign sext_ln170_10_fu_979_p1 = mul_ln1352_12_fu_973_p2;

assign sext_ln170_11_fu_993_p1 = mul_ln1352_13_fu_987_p2;

assign sext_ln170_12_fu_1007_p1 = mul_ln1352_14_fu_1001_p2;

assign sext_ln170_13_fu_1035_p1 = mul_ln1352_16_fu_1029_p2;

assign sext_ln170_1_fu_569_p1 = mul_ln1352_1_fu_563_p2;

assign sext_ln170_2_fu_597_p1 = mul_ln1352_2_fu_591_p2;

assign sext_ln170_3_fu_625_p1 = mul_ln1352_3_fu_619_p2;

assign sext_ln170_4_fu_653_p1 = mul_ln1352_4_fu_647_p2;

assign sext_ln170_5_fu_681_p1 = mul_ln1352_5_fu_675_p2;

assign sext_ln170_6_fu_737_p1 = mul_ln1352_7_fu_731_p2;

assign sext_ln170_7_fu_937_p1 = mul_ln1352_9_fu_931_p2;

assign sext_ln170_8_fu_951_p1 = mul_ln1352_10_fu_945_p2;

assign sext_ln170_9_fu_965_p1 = mul_ln1352_11_fu_959_p2;

assign sext_ln170_fu_541_p1 = mul_ln1352_fu_535_p2;

assign sext_ln186_1_fu_1233_p1 = $signed(threshs_m_thresholds_1_q0);

assign sext_ln186_fu_1157_p1 = $signed(threshs_m_thresholds_4_q0);

assign sext_ln700_10_fu_1075_p1 = $signed(add_ln700_11_fu_1069_p2);

assign sext_ln700_11_fu_1091_p1 = $signed(add_ln700_13_fu_1085_p2);

assign sext_ln700_12_fu_1101_p1 = $signed(add_ln700_14_fu_1095_p2);

assign sext_ln700_13_fu_1111_p1 = $signed(add_ln700_15_fu_1105_p2);

assign sext_ln700_1_fu_765_p1 = mul_ln1352_8_fu_759_p2;

assign sext_ln700_2_fu_781_p1 = $signed(add_ln700_1_fu_775_p2);

assign sext_ln700_3_fu_791_p1 = $signed(add_ln700_2_fu_785_p2);

assign sext_ln700_4_fu_807_p1 = $signed(add_ln700_4_fu_801_p2);

assign sext_ln700_5_fu_817_p1 = $signed(add_ln700_5_fu_811_p2);

assign sext_ln700_6_fu_827_p1 = $signed(add_ln700_6_fu_821_p2);

assign sext_ln700_7_fu_1021_p1 = mul_ln1352_15_fu_1015_p2;

assign sext_ln700_8_fu_1049_p1 = mul_ln1352_17_fu_1043_p2;

assign sext_ln700_9_fu_1065_p1 = $signed(add_ln700_10_fu_1059_p2);

assign sext_ln700_fu_709_p1 = mul_ln1352_6_fu_703_p2;

assign sf_fu_349_p2 = (32'd1 + sf_1_fu_144);

assign threshs_m_thresholds_1_address0 = zext_ln186_fu_368_p1;

assign threshs_m_thresholds_2_address0 = zext_ln186_fu_368_p1;

assign threshs_m_thresholds_3_address0 = zext_ln186_fu_368_p1;

assign threshs_m_thresholds_4_address0 = zext_ln186_fu_368_p1;

assign threshs_m_thresholds_5_address0 = zext_ln186_fu_368_p1;

assign threshs_m_thresholds_address0 = zext_ln186_fu_368_p1;

assign tile_fu_343_p2 = (32'd1 + tile_assign_fu_140);

assign tmp_V_fu_1289_p3 = {{add_ln700_21_fu_1283_p2}, {add_ln700_19_fu_1207_p2}};

assign trunc_ln647_fu_523_p1 = inElem_V_fu_152[7:0];

assign weights_m_weights_0_V_address0 = zext_ln137_fu_337_p1;

assign weights_m_weights_1_V_address0 = zext_ln137_fu_337_p1;

assign wgt_M_instance_0_V_1_fu_843_p1 = weights_m_weights_1_V_q0[1:0];

assign wgt_M_instance_0_V_fu_439_p1 = weights_m_weights_0_V_q0[1:0];

assign wgt_M_instance_1_V_1_fu_847_p4 = {{weights_m_weights_1_V_q0[3:2]}};

assign wgt_M_instance_1_V_fu_443_p4 = {{weights_m_weights_0_V_q0[3:2]}};

assign wgt_M_instance_2_V_1_fu_857_p4 = {{weights_m_weights_1_V_q0[5:4]}};

assign wgt_M_instance_2_V_fu_453_p4 = {{weights_m_weights_0_V_q0[5:4]}};

assign wgt_M_instance_3_V_1_fu_867_p4 = {{weights_m_weights_1_V_q0[7:6]}};

assign wgt_M_instance_3_V_fu_463_p4 = {{weights_m_weights_0_V_q0[7:6]}};

assign wgt_M_instance_4_V_1_fu_877_p4 = {{weights_m_weights_1_V_q0[9:8]}};

assign wgt_M_instance_4_V_fu_473_p4 = {{weights_m_weights_0_V_q0[9:8]}};

assign wgt_M_instance_5_V_1_fu_887_p4 = {{weights_m_weights_1_V_q0[11:10]}};

assign wgt_M_instance_5_V_fu_483_p4 = {{weights_m_weights_0_V_q0[11:10]}};

assign xor_ln899_1_fu_1171_p2 = (icmp_ln899_1_fu_1165_p2 ^ 1'd1);

assign xor_ln899_2_fu_1191_p2 = (icmp_ln899_2_fu_1185_p2 ^ 1'd1);

assign xor_ln899_3_fu_1223_p2 = (icmp_ln899_3_fu_1217_p2 ^ 1'd1);

assign xor_ln899_4_fu_1247_p2 = (icmp_ln899_4_fu_1241_p2 ^ 1'd1);

assign xor_ln899_5_fu_1267_p2 = (icmp_ln899_5_fu_1261_p2 ^ 1'd1);

assign xor_ln899_fu_1147_p2 = (icmp_ln899_fu_1141_p2 ^ 1'd1);

assign zext_ln137_fu_337_p1 = tile_assign_fu_140;

assign zext_ln186_1_fu_1137_p1 = threshs_m_thresholds_5_q0;

assign zext_ln186_2_fu_1161_p1 = $unsigned(sext_ln186_fu_1157_p1);

assign zext_ln186_3_fu_1181_p1 = threshs_m_thresholds_3_q0;

assign zext_ln186_4_fu_1213_p1 = threshs_m_thresholds_2_q0;

assign zext_ln186_5_fu_1237_p1 = $unsigned(sext_ln186_1_fu_1233_p1);

assign zext_ln186_6_fu_1257_p1 = threshs_m_thresholds_q0;

assign zext_ln186_fu_368_p1 = nf_assign_fu_148;

assign zext_ln215_1_fu_559_p1 = arg_V_read_assign_1_fu_545_p4;

assign zext_ln215_2_fu_587_p1 = arg_V_read_assign_2_fu_573_p4;

assign zext_ln215_3_fu_615_p1 = arg_V_read_assign_3_fu_601_p4;

assign zext_ln215_4_fu_643_p1 = arg_V_read_assign_4_fu_629_p4;

assign zext_ln215_5_fu_671_p1 = arg_V_read_assign_5_fu_657_p4;

assign zext_ln215_6_fu_699_p1 = arg_V_read_assign_6_fu_685_p4;

assign zext_ln215_7_fu_727_p1 = arg_V_read_assign_7_fu_713_p4;

assign zext_ln215_8_fu_755_p1 = arg_V_read_assign_8_fu_741_p4;

assign zext_ln215_fu_531_p1 = trunc_ln647_fu_523_p1;

assign zext_ln700_1_fu_1177_p1 = xor_ln899_1_fu_1171_p2;

assign zext_ln700_2_fu_1197_p1 = xor_ln899_2_fu_1191_p2;

assign zext_ln700_3_fu_1229_p1 = xor_ln899_3_fu_1223_p2;

assign zext_ln700_4_fu_1253_p1 = xor_ln899_4_fu_1247_p2;

assign zext_ln700_5_fu_1273_p1 = xor_ln899_5_fu_1267_p2;

assign zext_ln700_fu_1153_p1 = xor_ln899_fu_1147_p2;

endmodule //StreamingFCLayer_Batch_0_Matrix_Vector_Activa
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_eOg.v

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

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingDataWidthConverter_Batch_0_0/synth/finn_design_StreamingDataWidthConverter_Batch_0_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingDataWidthConverter_Batch_0:1.0
// IP Revision: 2105101212

(* X_CORE_INFO = "StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingDataWidthConverter_Batch_0_0,StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingDataWidthConverter_Batch_0_0,StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingDataWidthConverter_Batch_0,x_ipVersion=1.0,x_ipCoreRevision=2105101212,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingDataWidthConverter_Batch_0_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 9, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [71 : 0] out_V_V_TDATA;

  StreamingDataWidthConverter_Batch_0_StreamingDataWidthConverter_Batch_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_StreamingFCLayer_fYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

(* use_dsp = "no" *) module StreamingFCLayer_Batch_2_StreamingFCLayer_fYi_Mul_LUT_0(a, b, p);
input[16 - 1 : 0] a; 
input[2 - 1 : 0] b; 
output[18 - 1 : 0] p;

assign p = $signed(a) * $signed(b);
endmodule
`timescale 1 ns / 1 ps
module StreamingFCLayer_Batch_2_StreamingFCLayer_fYi(
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



StreamingFCLayer_Batch_2_StreamingFCLayer_fYi_Mul_LUT_0 StreamingFCLayer_Batch_2_StreamingFCLayer_fYi_Mul_LUT_0_U(
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/synth/finn_design.v

//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
//Date        : Mon May 10 12:14:35 2021
//Host        : finn_dev_wenlong running 64-bit unknown
//Command     : generate_target finn_design.bd
//Design      : finn_design
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "finn_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=finn_design,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=17,numReposBlks=17,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=15,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "finn_design.hwdef" *) 
module finn_design
   (ap_clk,
    ap_rst_n,
    m_axis_0_tdata,
    m_axis_0_tready,
    m_axis_0_tvalid,
    s_axis_0_tdata,
    s_axis_0_tready,
    s_axis_0_tvalid);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AP_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AP_CLK, ASSOCIATED_BUSIF s_axis_0:m_axis_0, ASSOCIATED_RESET ap_rst_n, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.AP_RST_N RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.AP_RST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_0, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 50000000.000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [7:0]m_axis_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) input m_axis_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_0 " *) output m_axis_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_0, CLK_DOMAIN finn_design_ap_clk_0, FREQ_HZ 50000000.000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [7:0]s_axis_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) output s_axis_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_0 " *) input s_axis_0_tvalid;

  wire [7:0]ConvolutionInputGenerator_0_out_V_V_TDATA;
  wire ConvolutionInputGenerator_0_out_V_V_TREADY;
  wire ConvolutionInputGenerator_0_out_V_V_TVALID;
  wire [7:0]ConvolutionInputGenerator_1_out_V_V_TDATA;
  wire ConvolutionInputGenerator_1_out_V_V_TREADY;
  wire ConvolutionInputGenerator_1_out_V_V_TVALID;
  wire [15:0]ConvolutionInputGenerator_2_out_V_V_TDATA;
  wire ConvolutionInputGenerator_2_out_V_V_TREADY;
  wire ConvolutionInputGenerator_2_out_V_V_TVALID;
  wire [7:0]LabelSelect_Batch_0_out_V_V_TDATA;
  wire LabelSelect_Batch_0_out_V_V_TREADY;
  wire LabelSelect_Batch_0_out_V_V_TVALID;
  wire [71:0]StreamingDataWidthConverter_Batch_0_out_V_V_TDATA;
  wire StreamingDataWidthConverter_Batch_0_out_V_V_TREADY;
  wire StreamingDataWidthConverter_Batch_0_out_V_V_TVALID;
  wire [127:0]StreamingDataWidthConverter_Batch_1_out_V_V_TDATA;
  wire StreamingDataWidthConverter_Batch_1_out_V_V_TREADY;
  wire StreamingDataWidthConverter_Batch_1_out_V_V_TVALID;
  wire [7:0]StreamingDataWidthConverter_Batch_2_out_V_V_TDATA;
  wire StreamingDataWidthConverter_Batch_2_out_V_V_TREADY;
  wire StreamingDataWidthConverter_Batch_2_out_V_V_TVALID;
  wire [39:0]StreamingDataWidthConverter_Batch_3_out_V_V_TDATA;
  wire StreamingDataWidthConverter_Batch_3_out_V_V_TREADY;
  wire StreamingDataWidthConverter_Batch_3_out_V_V_TVALID;
  wire [15:0]StreamingDataWidthConverter_Batch_4_out_V_V_TDATA;
  wire StreamingDataWidthConverter_Batch_4_out_V_V_TREADY;
  wire StreamingDataWidthConverter_Batch_4_out_V_V_TVALID;
  wire [127:0]StreamingDataWidthConverter_Batch_5_out_V_V_TDATA;
  wire StreamingDataWidthConverter_Batch_5_out_V_V_TREADY;
  wire StreamingDataWidthConverter_Batch_5_out_V_V_TVALID;
  wire [7:0]StreamingFCLayer_Batch_0_out_V_V_TDATA;
  wire StreamingFCLayer_Batch_0_out_V_V_TREADY;
  wire StreamingFCLayer_Batch_0_out_V_V_TVALID;
  wire [63:0]StreamingFCLayer_Batch_1_out_V_V_TDATA;
  wire StreamingFCLayer_Batch_1_out_V_V_TREADY;
  wire StreamingFCLayer_Batch_1_out_V_V_TVALID;
  wire [7:0]StreamingFCLayer_Batch_2_out_V_V_TDATA;
  wire StreamingFCLayer_Batch_2_out_V_V_TREADY;
  wire StreamingFCLayer_Batch_2_out_V_V_TVALID;
  wire [7:0]StreamingFCLayer_Batch_3_out_V_V_TDATA;
  wire StreamingFCLayer_Batch_3_out_V_V_TREADY;
  wire StreamingFCLayer_Batch_3_out_V_V_TVALID;
  wire [7:0]StreamingFIFO_0_out_V_V_TDATA;
  wire StreamingFIFO_0_out_V_V_TREADY;
  wire StreamingFIFO_0_out_V_V_TVALID;
  wire [7:0]StreamingFIFO_1_out_V_V_TDATA;
  wire StreamingFIFO_1_out_V_V_TREADY;
  wire StreamingFIFO_1_out_V_V_TVALID;
  wire [127:0]StreamingMaxPool_Batch_0_out_V_V_TDATA;
  wire StreamingMaxPool_Batch_0_out_V_V_TREADY;
  wire StreamingMaxPool_Batch_0_out_V_V_TVALID;
  wire ap_clk_0_1;
  wire ap_rst_n_0_1;
  wire [7:0]in0_V_V_0_1_TDATA;
  wire in0_V_V_0_1_TREADY;
  wire in0_V_V_0_1_TVALID;

  assign StreamingFIFO_1_out_V_V_TREADY = m_axis_0_tready;
  assign ap_clk_0_1 = ap_clk;
  assign ap_rst_n_0_1 = ap_rst_n;
  assign in0_V_V_0_1_TDATA = s_axis_0_tdata[7:0];
  assign in0_V_V_0_1_TVALID = s_axis_0_tvalid;
  assign m_axis_0_tdata[7:0] = StreamingFIFO_1_out_V_V_TDATA;
  assign m_axis_0_tvalid = StreamingFIFO_1_out_V_V_TVALID;
  assign s_axis_0_tready = in0_V_V_0_1_TREADY;
  finn_design_ConvolutionInputGenerator_0_0 ConvolutionInputGenerator_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingFIFO_0_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingFIFO_0_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingFIFO_0_out_V_V_TVALID),
        .out_V_V_TDATA(ConvolutionInputGenerator_0_out_V_V_TDATA),
        .out_V_V_TREADY(ConvolutionInputGenerator_0_out_V_V_TREADY),
        .out_V_V_TVALID(ConvolutionInputGenerator_0_out_V_V_TVALID));
  finn_design_ConvolutionInputGenerator_1_0 ConvolutionInputGenerator_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingDataWidthConverter_Batch_2_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingDataWidthConverter_Batch_2_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingDataWidthConverter_Batch_2_out_V_V_TVALID),
        .out_V_V_TDATA(ConvolutionInputGenerator_1_out_V_V_TDATA),
        .out_V_V_TREADY(ConvolutionInputGenerator_1_out_V_V_TREADY),
        .out_V_V_TVALID(ConvolutionInputGenerator_1_out_V_V_TVALID));
  finn_design_ConvolutionInputGenerator_2_0 ConvolutionInputGenerator_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingDataWidthConverter_Batch_4_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingDataWidthConverter_Batch_4_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingDataWidthConverter_Batch_4_out_V_V_TVALID),
        .out_V_V_TDATA(ConvolutionInputGenerator_2_out_V_V_TDATA),
        .out_V_V_TREADY(ConvolutionInputGenerator_2_out_V_V_TREADY),
        .out_V_V_TVALID(ConvolutionInputGenerator_2_out_V_V_TVALID));
  finn_design_LabelSelect_Batch_0_0 LabelSelect_Batch_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingFCLayer_Batch_3_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingFCLayer_Batch_3_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingFCLayer_Batch_3_out_V_V_TVALID),
        .out_V_V_TDATA(LabelSelect_Batch_0_out_V_V_TDATA),
        .out_V_V_TREADY(LabelSelect_Batch_0_out_V_V_TREADY),
        .out_V_V_TVALID(LabelSelect_Batch_0_out_V_V_TVALID));
  finn_design_StreamingDataWidthConverter_Batch_0_0 StreamingDataWidthConverter_Batch_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(ConvolutionInputGenerator_0_out_V_V_TDATA),
        .in0_V_V_TREADY(ConvolutionInputGenerator_0_out_V_V_TREADY),
        .in0_V_V_TVALID(ConvolutionInputGenerator_0_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingDataWidthConverter_Batch_0_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingDataWidthConverter_Batch_0_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingDataWidthConverter_Batch_0_out_V_V_TVALID));
  finn_design_StreamingDataWidthConverter_Batch_1_0 StreamingDataWidthConverter_Batch_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingFCLayer_Batch_0_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingFCLayer_Batch_0_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingFCLayer_Batch_0_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingDataWidthConverter_Batch_1_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingDataWidthConverter_Batch_1_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingDataWidthConverter_Batch_1_out_V_V_TVALID));
  finn_design_StreamingDataWidthConverter_Batch_2_0 StreamingDataWidthConverter_Batch_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingMaxPool_Batch_0_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingMaxPool_Batch_0_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingMaxPool_Batch_0_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingDataWidthConverter_Batch_2_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingDataWidthConverter_Batch_2_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingDataWidthConverter_Batch_2_out_V_V_TVALID));
  finn_design_StreamingDataWidthConverter_Batch_3_0 StreamingDataWidthConverter_Batch_3
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(ConvolutionInputGenerator_1_out_V_V_TDATA),
        .in0_V_V_TREADY(ConvolutionInputGenerator_1_out_V_V_TREADY),
        .in0_V_V_TVALID(ConvolutionInputGenerator_1_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingDataWidthConverter_Batch_3_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingDataWidthConverter_Batch_3_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingDataWidthConverter_Batch_3_out_V_V_TVALID));
  finn_design_StreamingDataWidthConverter_Batch_4_0 StreamingDataWidthConverter_Batch_4
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingFCLayer_Batch_1_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingFCLayer_Batch_1_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingFCLayer_Batch_1_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingDataWidthConverter_Batch_4_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingDataWidthConverter_Batch_4_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingDataWidthConverter_Batch_4_out_V_V_TVALID));
  finn_design_StreamingDataWidthConverter_Batch_5_0 StreamingDataWidthConverter_Batch_5
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(ConvolutionInputGenerator_2_out_V_V_TDATA),
        .in0_V_V_TREADY(ConvolutionInputGenerator_2_out_V_V_TREADY),
        .in0_V_V_TVALID(ConvolutionInputGenerator_2_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingDataWidthConverter_Batch_5_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingDataWidthConverter_Batch_5_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingDataWidthConverter_Batch_5_out_V_V_TVALID));
  finn_design_StreamingFCLayer_Batch_0_0 StreamingFCLayer_Batch_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingDataWidthConverter_Batch_0_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingDataWidthConverter_Batch_0_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingDataWidthConverter_Batch_0_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingFCLayer_Batch_0_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingFCLayer_Batch_0_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingFCLayer_Batch_0_out_V_V_TVALID));
  finn_design_StreamingFCLayer_Batch_1_0 StreamingFCLayer_Batch_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingDataWidthConverter_Batch_3_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingDataWidthConverter_Batch_3_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingDataWidthConverter_Batch_3_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingFCLayer_Batch_1_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingFCLayer_Batch_1_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingFCLayer_Batch_1_out_V_V_TVALID));
  finn_design_StreamingFCLayer_Batch_2_0 StreamingFCLayer_Batch_2
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingDataWidthConverter_Batch_5_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingDataWidthConverter_Batch_5_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingDataWidthConverter_Batch_5_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingFCLayer_Batch_2_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingFCLayer_Batch_2_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingFCLayer_Batch_2_out_V_V_TVALID));
  finn_design_StreamingFCLayer_Batch_3_0 StreamingFCLayer_Batch_3
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingFCLayer_Batch_2_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingFCLayer_Batch_2_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingFCLayer_Batch_2_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingFCLayer_Batch_3_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingFCLayer_Batch_3_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingFCLayer_Batch_3_out_V_V_TVALID));
  finn_design_StreamingFIFO_0_0 StreamingFIFO_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(in0_V_V_0_1_TDATA),
        .in0_V_V_TREADY(in0_V_V_0_1_TREADY),
        .in0_V_V_TVALID(in0_V_V_0_1_TVALID),
        .out_V_V_TDATA(StreamingFIFO_0_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingFIFO_0_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingFIFO_0_out_V_V_TVALID));
  finn_design_StreamingFIFO_1_0 StreamingFIFO_1
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(LabelSelect_Batch_0_out_V_V_TDATA),
        .in0_V_V_TREADY(LabelSelect_Batch_0_out_V_V_TREADY),
        .in0_V_V_TVALID(LabelSelect_Batch_0_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingFIFO_1_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingFIFO_1_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingFIFO_1_out_V_V_TVALID));
  finn_design_StreamingMaxPool_Batch_0_0 StreamingMaxPool_Batch_0
       (.ap_clk(ap_clk_0_1),
        .ap_rst_n(ap_rst_n_0_1),
        .in0_V_V_TDATA(StreamingDataWidthConverter_Batch_1_out_V_V_TDATA),
        .in0_V_V_TREADY(StreamingDataWidthConverter_Batch_1_out_V_V_TREADY),
        .in0_V_V_TVALID(StreamingDataWidthConverter_Batch_1_out_V_V_TVALID),
        .out_V_V_TDATA(StreamingMaxPool_Batch_0_out_V_V_TDATA),
        .out_V_V_TREADY(StreamingMaxPool_Batch_0_out_V_V_TREADY),
        .out_V_V_TVALID(StreamingMaxPool_Batch_0_out_V_V_TVALID));
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/fab4/hdl/verilog/ConvolutionInputGenerator_0_ConvolutionInputGenerator_0.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="ConvolutionInputGenerator_0_ConvolutionInputGenerator_0,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=5.440000,HLS_SYN_LAT=941,HLS_SYN_TPT=none,HLS_SYN_MEM=4,HLS_SYN_DSP=0,HLS_SYN_FF=344,HLS_SYN_LUT=1422,HLS_VERSION=2020_1}" *)

module ConvolutionInputGenerator_0_ConvolutionInputGenerator_0 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_ConvolutionInputGene_1_fu_26_ap_start;
wire    grp_ConvolutionInputGene_1_fu_26_ap_done;
wire    grp_ConvolutionInputGene_1_fu_26_ap_idle;
wire    grp_ConvolutionInputGene_1_fu_26_ap_ready;
wire    grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY;
wire   [7:0] grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA;
wire    grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID;
wire    grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY;
reg    grp_ConvolutionInputGene_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_ConvolutionInputGene_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

ConvolutionInputGenerator_0_ConvolutionInputGene_1 grp_ConvolutionInputGene_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_ConvolutionInputGene_1_fu_26_ap_start),
    .ap_done(grp_ConvolutionInputGene_1_fu_26_ap_done),
    .ap_idle(grp_ConvolutionInputGene_1_fu_26_ap_idle),
    .ap_ready(grp_ConvolutionInputGene_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_ConvolutionInputGene_1_fu_26_ap_ready == 1'b1)) begin
            grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_ConvolutionInputGene_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_ConvolutionInputGene_1_fu_26_ap_start = grp_ConvolutionInputGene_1_fu_26_ap_start_reg;

assign grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //ConvolutionInputGenerator_0_ConvolutionInputGenerator_0
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingMaxPool_Batch_0_0/synth/finn_design_StreamingMaxPool_Batch_0_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingMaxPool_Batch_0:1.0
// IP Revision: 2105101210

(* X_CORE_INFO = "StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingMaxPool_Batch_0_0,StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingMaxPool_Batch_0_0,StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingMaxPool_Batch_0,x_ipVersion=1.0,x_ipCoreRevision=2105101210,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingMaxPool_Batch_0_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 16, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [127 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 16, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [127 : 0] out_V_V_TDATA;

  StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/hdl/finn_design_wrapper.v

//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
//Date        : Mon May 10 12:14:35 2021
//Host        : finn_dev_wenlong running 64-bit unknown
//Command     : generate_target finn_design_wrapper.bd
//Design      : finn_design_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module finn_design_wrapper
   (ap_clk,
    ap_rst_n,
    m_axis_0_tdata,
    m_axis_0_tready,
    m_axis_0_tvalid,
    s_axis_0_tdata,
    s_axis_0_tready,
    s_axis_0_tvalid);
  input ap_clk;
  input ap_rst_n;
  output [7:0]m_axis_0_tdata;
  input m_axis_0_tready;
  output m_axis_0_tvalid;
  input [7:0]s_axis_0_tdata;
  output s_axis_0_tready;
  input s_axis_0_tvalid;

  wire ap_clk;
  wire ap_rst_n;
  wire [7:0]m_axis_0_tdata;
  wire m_axis_0_tready;
  wire m_axis_0_tvalid;
  wire [7:0]s_axis_0_tdata;
  wire s_axis_0_tready;
  wire s_axis_0_tvalid;

  finn_design finn_design_i
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .m_axis_0_tdata(m_axis_0_tdata),
        .m_axis_0_tready(m_axis_0_tready),
        .m_axis_0_tvalid(m_axis_0_tvalid),
        .s_axis_0_tdata(s_axis_0_tdata),
        .s_axis_0_tready(s_axis_0_tready),
        .s_axis_0_tvalid(s_axis_0_tvalid));
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_Actcud.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_3_Matrix_Vector_Actcud_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 4;
parameter AWIDTH = 3;
parameter MEM_SIZE = 6;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_3_vpqar3vc/project_StreamingFCLayer_Batch_3/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_Actcud_rom.dat", ram);
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
module StreamingFCLayer_Batch_3_Matrix_Vector_Actcud(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd4;
parameter AddressRange = 32'd6;
parameter AddressWidth = 32'd3;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_3_Matrix_Vector_Actcud_rom StreamingFCLayer_Batch_3_Matrix_Vector_Actcud_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/51d1/hdl/verilog/ConvolutionInputGenerator_2_ConvolutionInputGenerator_2.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="ConvolutionInputGenerator_2_ConvolutionInputGenerator_2,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=6.122625,HLS_SYN_LAT=1157,HLS_SYN_TPT=none,HLS_SYN_MEM=4,HLS_SYN_DSP=0,HLS_SYN_FF=345,HLS_SYN_LUT=1486,HLS_VERSION=2020_1}" *)

module ConvolutionInputGenerator_2_ConvolutionInputGenerator_2 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [15:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [15:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_ConvolutionInputGene_1_fu_26_ap_start;
wire    grp_ConvolutionInputGene_1_fu_26_ap_done;
wire    grp_ConvolutionInputGene_1_fu_26_ap_idle;
wire    grp_ConvolutionInputGene_1_fu_26_ap_ready;
wire    grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY;
wire   [15:0] grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA;
wire    grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID;
wire    grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY;
reg    grp_ConvolutionInputGene_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [15:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_ConvolutionInputGene_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

ConvolutionInputGenerator_2_ConvolutionInputGene_1 grp_ConvolutionInputGene_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_ConvolutionInputGene_1_fu_26_ap_start),
    .ap_done(grp_ConvolutionInputGene_1_fu_26_ap_done),
    .ap_idle(grp_ConvolutionInputGene_1_fu_26_ap_idle),
    .ap_ready(grp_ConvolutionInputGene_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 16 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 16 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_ConvolutionInputGene_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_ConvolutionInputGene_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_ConvolutionInputGene_1_fu_26_ap_ready == 1'b1)) begin
            grp_ConvolutionInputGene_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_ConvolutionInputGene_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_ConvolutionInputGene_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_ConvolutionInputGene_1_fu_26_ap_start = grp_ConvolutionInputGene_1_fu_26_ap_start_reg;

assign grp_ConvolutionInputGene_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //ConvolutionInputGenerator_2_ConvolutionInputGenerator_2
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ae85/hdl/verilog/StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.331000,HLS_SYN_LAT=581,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=293,HLS_SYN_LUT=246,HLS_VERSION=2020_1}" *)

module StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [15:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [127:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_start;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_done;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_idle;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_ready;
wire    grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
wire   [127:0] grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY;
reg    grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [15:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_StreamingDataWidthCo_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingDataWidthConverter_Batch_5_StreamingDataWidthCo_1 grp_StreamingDataWidthCo_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingDataWidthCo_1_fu_26_ap_start),
    .ap_done(grp_StreamingDataWidthCo_1_fu_26_ap_done),
    .ap_idle(grp_StreamingDataWidthCo_1_fu_26_ap_idle),
    .ap_ready(grp_StreamingDataWidthCo_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 16 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 128 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingDataWidthCo_1_fu_26_ap_ready == 1'b1)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingDataWidthCo_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingDataWidthCo_1_fu_26_ap_start = grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;

assign grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/68cd/hdl/verilog/StreamingMaxPool_Batch_0_StreamingMaxPool_Pre.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingMaxPool_Batch_0_StreamingMaxPool_Pre (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 8'd1;
parameter    ap_ST_fsm_state2 = 8'd2;
parameter    ap_ST_fsm_state3 = 8'd4;
parameter    ap_ST_fsm_state4 = 8'd8;
parameter    ap_ST_fsm_state5 = 8'd16;
parameter    ap_ST_fsm_state6 = 8'd32;
parameter    ap_ST_fsm_state7 = 8'd64;
parameter    ap_ST_fsm_state8 = 8'd128;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [127:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [127:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [7:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_state5;
reg    out_V_V_TDATA_blk_n;
wire    ap_CS_fsm_state8;
wire   [2:0] i_fu_2398_p2;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln152_fu_2472_p2;
wire    ap_CS_fsm_state3;
wire   [2:0] yp_fu_2478_p2;
reg   [2:0] yp_reg_3948;
wire   [4:0] add_ln153_fu_2490_p2;
reg   [4:0] add_ln153_reg_3956;
wire    ap_CS_fsm_state4;
wire   [0:0] icmp_ln154_fu_2496_p2;
reg   [0:0] icmp_ln154_reg_3961;
wire   [0:0] icmp_ln153_fu_2484_p2;
wire   [0:0] and_ln154_fu_2522_p2;
reg   [0:0] and_ln154_reg_3967;
wire   [2:0] select_ln164_fu_2534_p3;
reg   [2:0] select_ln164_reg_3972;
reg   [2:0] buf_0_V_addr_2_reg_3977;
reg   [2:0] buf_1_V_addr_2_reg_3982;
reg   [2:0] buf_2_V_addr_2_reg_3987;
reg   [2:0] buf_3_V_addr_2_reg_3992;
reg   [2:0] buf_4_V_addr_2_reg_3997;
reg   [2:0] buf_5_V_addr_2_reg_4002;
reg   [2:0] buf_6_V_addr_2_reg_4007;
reg   [2:0] buf_7_V_addr_2_reg_4012;
reg   [2:0] buf_8_V_addr_2_reg_4017;
reg   [2:0] buf_9_V_addr_2_reg_4022;
reg   [2:0] buf_10_V_addr_2_reg_4027;
reg   [2:0] buf_11_V_addr_2_reg_4032;
reg   [2:0] buf_12_V_addr_2_reg_4037;
reg   [2:0] buf_13_V_addr_2_reg_4042;
reg   [2:0] buf_14_V_addr_2_reg_4047;
reg   [2:0] buf_15_V_addr_2_reg_4052;
reg   [2:0] buf_16_V_addr_2_reg_4057;
reg   [2:0] buf_17_V_addr_2_reg_4062;
reg   [2:0] buf_18_V_addr_2_reg_4067;
reg   [2:0] buf_19_V_addr_2_reg_4072;
reg   [2:0] buf_20_V_addr_2_reg_4077;
reg   [2:0] buf_21_V_addr_2_reg_4082;
reg   [2:0] buf_22_V_addr_2_reg_4087;
reg   [2:0] buf_23_V_addr_2_reg_4092;
reg   [2:0] buf_24_V_addr_2_reg_4097;
reg   [2:0] buf_25_V_addr_2_reg_4102;
reg   [2:0] buf_26_V_addr_2_reg_4107;
reg   [2:0] buf_27_V_addr_2_reg_4112;
reg   [2:0] buf_28_V_addr_2_reg_4117;
reg   [2:0] buf_29_V_addr_2_reg_4122;
reg   [2:0] buf_30_V_addr_2_reg_4127;
reg   [2:0] buf_31_V_addr_2_reg_4132;
reg   [2:0] buf_32_V_addr_2_reg_4137;
reg   [2:0] buf_33_V_addr_2_reg_4142;
reg   [2:0] buf_34_V_addr_2_reg_4147;
reg   [2:0] buf_35_V_addr_2_reg_4152;
reg   [2:0] buf_36_V_addr_2_reg_4157;
reg   [2:0] buf_37_V_addr_2_reg_4162;
reg   [2:0] buf_38_V_addr_2_reg_4167;
reg   [2:0] buf_39_V_addr_2_reg_4172;
reg   [2:0] buf_40_V_addr_2_reg_4177;
reg   [2:0] buf_41_V_addr_2_reg_4182;
reg   [2:0] buf_42_V_addr_2_reg_4187;
reg   [2:0] buf_43_V_addr_2_reg_4192;
reg   [2:0] buf_44_V_addr_2_reg_4197;
reg   [2:0] buf_45_V_addr_2_reg_4202;
reg   [2:0] buf_46_V_addr_2_reg_4207;
reg   [2:0] buf_47_V_addr_2_reg_4212;
reg   [2:0] buf_48_V_addr_2_reg_4217;
reg   [2:0] buf_49_V_addr_2_reg_4222;
reg   [2:0] buf_50_V_addr_2_reg_4227;
reg   [2:0] buf_51_V_addr_2_reg_4232;
reg   [2:0] buf_52_V_addr_2_reg_4237;
reg   [2:0] buf_53_V_addr_2_reg_4242;
reg   [2:0] buf_54_V_addr_2_reg_4247;
reg   [2:0] buf_55_V_addr_2_reg_4252;
reg   [2:0] buf_56_V_addr_2_reg_4257;
reg   [2:0] buf_57_V_addr_2_reg_4262;
reg   [2:0] buf_58_V_addr_2_reg_4267;
reg   [2:0] buf_59_V_addr_2_reg_4272;
reg   [2:0] buf_60_V_addr_2_reg_4277;
reg   [2:0] buf_61_V_addr_2_reg_4282;
reg   [2:0] buf_62_V_addr_2_reg_4287;
reg   [2:0] buf_63_V_addr_2_reg_4292;
wire   [1:0] kx_fu_3702_p3;
wire   [4:0] select_ln154_1_fu_3716_p3;
wire   [2:0] outpix_fu_3729_p2;
reg   [2:0] outpix_reg_4502;
wire    ap_CS_fsm_state7;
wire   [0:0] icmp_ln172_fu_3723_p2;
reg   [2:0] buf_0_V_address0;
reg    buf_0_V_ce0;
reg    buf_0_V_we0;
reg   [1:0] buf_0_V_d0;
wire   [1:0] buf_0_V_q0;
reg   [2:0] buf_1_V_address0;
reg    buf_1_V_ce0;
reg    buf_1_V_we0;
reg   [1:0] buf_1_V_d0;
wire   [1:0] buf_1_V_q0;
reg   [2:0] buf_2_V_address0;
reg    buf_2_V_ce0;
reg    buf_2_V_we0;
reg   [1:0] buf_2_V_d0;
wire   [1:0] buf_2_V_q0;
reg   [2:0] buf_3_V_address0;
reg    buf_3_V_ce0;
reg    buf_3_V_we0;
reg   [1:0] buf_3_V_d0;
wire   [1:0] buf_3_V_q0;
reg   [2:0] buf_4_V_address0;
reg    buf_4_V_ce0;
reg    buf_4_V_we0;
reg   [1:0] buf_4_V_d0;
wire   [1:0] buf_4_V_q0;
reg   [2:0] buf_5_V_address0;
reg    buf_5_V_ce0;
reg    buf_5_V_we0;
reg   [1:0] buf_5_V_d0;
wire   [1:0] buf_5_V_q0;
reg   [2:0] buf_6_V_address0;
reg    buf_6_V_ce0;
reg    buf_6_V_we0;
reg   [1:0] buf_6_V_d0;
wire   [1:0] buf_6_V_q0;
reg   [2:0] buf_7_V_address0;
reg    buf_7_V_ce0;
reg    buf_7_V_we0;
reg   [1:0] buf_7_V_d0;
wire   [1:0] buf_7_V_q0;
reg   [2:0] buf_8_V_address0;
reg    buf_8_V_ce0;
reg    buf_8_V_we0;
reg   [1:0] buf_8_V_d0;
wire   [1:0] buf_8_V_q0;
reg   [2:0] buf_9_V_address0;
reg    buf_9_V_ce0;
reg    buf_9_V_we0;
reg   [1:0] buf_9_V_d0;
wire   [1:0] buf_9_V_q0;
reg   [2:0] buf_10_V_address0;
reg    buf_10_V_ce0;
reg    buf_10_V_we0;
reg   [1:0] buf_10_V_d0;
wire   [1:0] buf_10_V_q0;
reg   [2:0] buf_11_V_address0;
reg    buf_11_V_ce0;
reg    buf_11_V_we0;
reg   [1:0] buf_11_V_d0;
wire   [1:0] buf_11_V_q0;
reg   [2:0] buf_12_V_address0;
reg    buf_12_V_ce0;
reg    buf_12_V_we0;
reg   [1:0] buf_12_V_d0;
wire   [1:0] buf_12_V_q0;
reg   [2:0] buf_13_V_address0;
reg    buf_13_V_ce0;
reg    buf_13_V_we0;
reg   [1:0] buf_13_V_d0;
wire   [1:0] buf_13_V_q0;
reg   [2:0] buf_14_V_address0;
reg    buf_14_V_ce0;
reg    buf_14_V_we0;
reg   [1:0] buf_14_V_d0;
wire   [1:0] buf_14_V_q0;
reg   [2:0] buf_15_V_address0;
reg    buf_15_V_ce0;
reg    buf_15_V_we0;
reg   [1:0] buf_15_V_d0;
wire   [1:0] buf_15_V_q0;
reg   [2:0] buf_16_V_address0;
reg    buf_16_V_ce0;
reg    buf_16_V_we0;
reg   [1:0] buf_16_V_d0;
wire   [1:0] buf_16_V_q0;
reg   [2:0] buf_17_V_address0;
reg    buf_17_V_ce0;
reg    buf_17_V_we0;
reg   [1:0] buf_17_V_d0;
wire   [1:0] buf_17_V_q0;
reg   [2:0] buf_18_V_address0;
reg    buf_18_V_ce0;
reg    buf_18_V_we0;
reg   [1:0] buf_18_V_d0;
wire   [1:0] buf_18_V_q0;
reg   [2:0] buf_19_V_address0;
reg    buf_19_V_ce0;
reg    buf_19_V_we0;
reg   [1:0] buf_19_V_d0;
wire   [1:0] buf_19_V_q0;
reg   [2:0] buf_20_V_address0;
reg    buf_20_V_ce0;
reg    buf_20_V_we0;
reg   [1:0] buf_20_V_d0;
wire   [1:0] buf_20_V_q0;
reg   [2:0] buf_21_V_address0;
reg    buf_21_V_ce0;
reg    buf_21_V_we0;
reg   [1:0] buf_21_V_d0;
wire   [1:0] buf_21_V_q0;
reg   [2:0] buf_22_V_address0;
reg    buf_22_V_ce0;
reg    buf_22_V_we0;
reg   [1:0] buf_22_V_d0;
wire   [1:0] buf_22_V_q0;
reg   [2:0] buf_23_V_address0;
reg    buf_23_V_ce0;
reg    buf_23_V_we0;
reg   [1:0] buf_23_V_d0;
wire   [1:0] buf_23_V_q0;
reg   [2:0] buf_24_V_address0;
reg    buf_24_V_ce0;
reg    buf_24_V_we0;
reg   [1:0] buf_24_V_d0;
wire   [1:0] buf_24_V_q0;
reg   [2:0] buf_25_V_address0;
reg    buf_25_V_ce0;
reg    buf_25_V_we0;
reg   [1:0] buf_25_V_d0;
wire   [1:0] buf_25_V_q0;
reg   [2:0] buf_26_V_address0;
reg    buf_26_V_ce0;
reg    buf_26_V_we0;
reg   [1:0] buf_26_V_d0;
wire   [1:0] buf_26_V_q0;
reg   [2:0] buf_27_V_address0;
reg    buf_27_V_ce0;
reg    buf_27_V_we0;
reg   [1:0] buf_27_V_d0;
wire   [1:0] buf_27_V_q0;
reg   [2:0] buf_28_V_address0;
reg    buf_28_V_ce0;
reg    buf_28_V_we0;
reg   [1:0] buf_28_V_d0;
wire   [1:0] buf_28_V_q0;
reg   [2:0] buf_29_V_address0;
reg    buf_29_V_ce0;
reg    buf_29_V_we0;
reg   [1:0] buf_29_V_d0;
wire   [1:0] buf_29_V_q0;
reg   [2:0] buf_30_V_address0;
reg    buf_30_V_ce0;
reg    buf_30_V_we0;
reg   [1:0] buf_30_V_d0;
wire   [1:0] buf_30_V_q0;
reg   [2:0] buf_31_V_address0;
reg    buf_31_V_ce0;
reg    buf_31_V_we0;
reg   [1:0] buf_31_V_d0;
wire   [1:0] buf_31_V_q0;
reg   [2:0] buf_32_V_address0;
reg    buf_32_V_ce0;
reg    buf_32_V_we0;
reg   [1:0] buf_32_V_d0;
wire   [1:0] buf_32_V_q0;
reg   [2:0] buf_33_V_address0;
reg    buf_33_V_ce0;
reg    buf_33_V_we0;
reg   [1:0] buf_33_V_d0;
wire   [1:0] buf_33_V_q0;
reg   [2:0] buf_34_V_address0;
reg    buf_34_V_ce0;
reg    buf_34_V_we0;
reg   [1:0] buf_34_V_d0;
wire   [1:0] buf_34_V_q0;
reg   [2:0] buf_35_V_address0;
reg    buf_35_V_ce0;
reg    buf_35_V_we0;
reg   [1:0] buf_35_V_d0;
wire   [1:0] buf_35_V_q0;
reg   [2:0] buf_36_V_address0;
reg    buf_36_V_ce0;
reg    buf_36_V_we0;
reg   [1:0] buf_36_V_d0;
wire   [1:0] buf_36_V_q0;
reg   [2:0] buf_37_V_address0;
reg    buf_37_V_ce0;
reg    buf_37_V_we0;
reg   [1:0] buf_37_V_d0;
wire   [1:0] buf_37_V_q0;
reg   [2:0] buf_38_V_address0;
reg    buf_38_V_ce0;
reg    buf_38_V_we0;
reg   [1:0] buf_38_V_d0;
wire   [1:0] buf_38_V_q0;
reg   [2:0] buf_39_V_address0;
reg    buf_39_V_ce0;
reg    buf_39_V_we0;
reg   [1:0] buf_39_V_d0;
wire   [1:0] buf_39_V_q0;
reg   [2:0] buf_40_V_address0;
reg    buf_40_V_ce0;
reg    buf_40_V_we0;
reg   [1:0] buf_40_V_d0;
wire   [1:0] buf_40_V_q0;
reg   [2:0] buf_41_V_address0;
reg    buf_41_V_ce0;
reg    buf_41_V_we0;
reg   [1:0] buf_41_V_d0;
wire   [1:0] buf_41_V_q0;
reg   [2:0] buf_42_V_address0;
reg    buf_42_V_ce0;
reg    buf_42_V_we0;
reg   [1:0] buf_42_V_d0;
wire   [1:0] buf_42_V_q0;
reg   [2:0] buf_43_V_address0;
reg    buf_43_V_ce0;
reg    buf_43_V_we0;
reg   [1:0] buf_43_V_d0;
wire   [1:0] buf_43_V_q0;
reg   [2:0] buf_44_V_address0;
reg    buf_44_V_ce0;
reg    buf_44_V_we0;
reg   [1:0] buf_44_V_d0;
wire   [1:0] buf_44_V_q0;
reg   [2:0] buf_45_V_address0;
reg    buf_45_V_ce0;
reg    buf_45_V_we0;
reg   [1:0] buf_45_V_d0;
wire   [1:0] buf_45_V_q0;
reg   [2:0] buf_46_V_address0;
reg    buf_46_V_ce0;
reg    buf_46_V_we0;
reg   [1:0] buf_46_V_d0;
wire   [1:0] buf_46_V_q0;
reg   [2:0] buf_47_V_address0;
reg    buf_47_V_ce0;
reg    buf_47_V_we0;
reg   [1:0] buf_47_V_d0;
wire   [1:0] buf_47_V_q0;
reg   [2:0] buf_48_V_address0;
reg    buf_48_V_ce0;
reg    buf_48_V_we0;
reg   [1:0] buf_48_V_d0;
wire   [1:0] buf_48_V_q0;
reg   [2:0] buf_49_V_address0;
reg    buf_49_V_ce0;
reg    buf_49_V_we0;
reg   [1:0] buf_49_V_d0;
wire   [1:0] buf_49_V_q0;
reg   [2:0] buf_50_V_address0;
reg    buf_50_V_ce0;
reg    buf_50_V_we0;
reg   [1:0] buf_50_V_d0;
wire   [1:0] buf_50_V_q0;
reg   [2:0] buf_51_V_address0;
reg    buf_51_V_ce0;
reg    buf_51_V_we0;
reg   [1:0] buf_51_V_d0;
wire   [1:0] buf_51_V_q0;
reg   [2:0] buf_52_V_address0;
reg    buf_52_V_ce0;
reg    buf_52_V_we0;
reg   [1:0] buf_52_V_d0;
wire   [1:0] buf_52_V_q0;
reg   [2:0] buf_53_V_address0;
reg    buf_53_V_ce0;
reg    buf_53_V_we0;
reg   [1:0] buf_53_V_d0;
wire   [1:0] buf_53_V_q0;
reg   [2:0] buf_54_V_address0;
reg    buf_54_V_ce0;
reg    buf_54_V_we0;
reg   [1:0] buf_54_V_d0;
wire   [1:0] buf_54_V_q0;
reg   [2:0] buf_55_V_address0;
reg    buf_55_V_ce0;
reg    buf_55_V_we0;
reg   [1:0] buf_55_V_d0;
wire   [1:0] buf_55_V_q0;
reg   [2:0] buf_56_V_address0;
reg    buf_56_V_ce0;
reg    buf_56_V_we0;
reg   [1:0] buf_56_V_d0;
wire   [1:0] buf_56_V_q0;
reg   [2:0] buf_57_V_address0;
reg    buf_57_V_ce0;
reg    buf_57_V_we0;
reg   [1:0] buf_57_V_d0;
wire   [1:0] buf_57_V_q0;
reg   [2:0] buf_58_V_address0;
reg    buf_58_V_ce0;
reg    buf_58_V_we0;
reg   [1:0] buf_58_V_d0;
wire   [1:0] buf_58_V_q0;
reg   [2:0] buf_59_V_address0;
reg    buf_59_V_ce0;
reg    buf_59_V_we0;
reg   [1:0] buf_59_V_d0;
wire   [1:0] buf_59_V_q0;
reg   [2:0] buf_60_V_address0;
reg    buf_60_V_ce0;
reg    buf_60_V_we0;
reg   [1:0] buf_60_V_d0;
wire   [1:0] buf_60_V_q0;
reg   [2:0] buf_61_V_address0;
reg    buf_61_V_ce0;
reg    buf_61_V_we0;
reg   [1:0] buf_61_V_d0;
wire   [1:0] buf_61_V_q0;
reg   [2:0] buf_62_V_address0;
reg    buf_62_V_ce0;
reg    buf_62_V_we0;
reg   [1:0] buf_62_V_d0;
wire   [1:0] buf_62_V_q0;
reg   [2:0] buf_63_V_address0;
reg    buf_63_V_ce0;
reg    buf_63_V_we0;
reg   [1:0] buf_63_V_d0;
wire   [1:0] buf_63_V_q0;
reg   [2:0] i_0_reg_2313;
wire   [0:0] icmp_ln145_fu_2392_p2;
reg   [2:0] yp_0_reg_2324;
reg   [4:0] indvar_flatten141_reg_2335;
reg   [4:0] indvar_flatten_reg_2346;
reg   [2:0] xp_0_reg_2358;
reg   [1:0] kx_0_reg_2369;
reg   [2:0] outpix_0_reg_2381;
wire    ap_CS_fsm_state6;
wire   [63:0] zext_ln148_fu_2404_p1;
wire   [63:0] zext_ln164_fu_2542_p1;
wire   [63:0] zext_ln177_fu_3735_p1;
wire   [0:0] icmp_ln895_fu_2615_p2;
wire   [1:0] trunc_ln647_fu_2610_p1;
wire   [0:0] icmp_ln895_1_fu_2632_p2;
wire   [1:0] p_Result_1_fu_2621_p4;
wire   [0:0] icmp_ln895_2_fu_2649_p2;
wire   [1:0] p_Result_s_fu_2638_p4;
wire   [0:0] icmp_ln895_3_fu_2666_p2;
wire   [1:0] p_Result_3_fu_2655_p4;
wire   [0:0] icmp_ln895_4_fu_2683_p2;
wire   [1:0] p_Result_4_fu_2672_p4;
wire   [0:0] icmp_ln895_5_fu_2700_p2;
wire   [1:0] p_Result_5_fu_2689_p4;
wire   [0:0] icmp_ln895_6_fu_2717_p2;
wire   [1:0] p_Result_6_fu_2706_p4;
wire   [0:0] icmp_ln895_7_fu_2734_p2;
wire   [1:0] p_Result_7_fu_2723_p4;
wire   [0:0] icmp_ln895_8_fu_2751_p2;
wire   [1:0] p_Result_8_fu_2740_p4;
wire   [0:0] icmp_ln895_9_fu_2768_p2;
wire   [1:0] p_Result_9_fu_2757_p4;
wire   [0:0] icmp_ln895_10_fu_2785_p2;
wire   [1:0] p_Result_2_fu_2774_p4;
wire   [0:0] icmp_ln895_11_fu_2802_p2;
wire   [1:0] p_Result_10_fu_2791_p4;
wire   [0:0] icmp_ln895_12_fu_2819_p2;
wire   [1:0] p_Result_11_fu_2808_p4;
wire   [0:0] icmp_ln895_13_fu_2836_p2;
wire   [1:0] p_Result_12_fu_2825_p4;
wire   [0:0] icmp_ln895_14_fu_2853_p2;
wire   [1:0] p_Result_13_fu_2842_p4;
wire   [0:0] icmp_ln895_15_fu_2870_p2;
wire   [1:0] p_Result_14_fu_2859_p4;
wire   [0:0] icmp_ln895_16_fu_2887_p2;
wire   [1:0] p_Result_15_fu_2876_p4;
wire   [0:0] icmp_ln895_17_fu_2904_p2;
wire   [1:0] p_Result_16_fu_2893_p4;
wire   [0:0] icmp_ln895_18_fu_2921_p2;
wire   [1:0] p_Result_17_fu_2910_p4;
wire   [0:0] icmp_ln895_19_fu_2938_p2;
wire   [1:0] p_Result_18_fu_2927_p4;
wire   [0:0] icmp_ln895_20_fu_2955_p2;
wire   [1:0] p_Result_19_fu_2944_p4;
wire   [0:0] icmp_ln895_21_fu_2972_p2;
wire   [1:0] p_Result_20_fu_2961_p4;
wire   [0:0] icmp_ln895_22_fu_2989_p2;
wire   [1:0] p_Result_21_fu_2978_p4;
wire   [0:0] icmp_ln895_23_fu_3006_p2;
wire   [1:0] p_Result_22_fu_2995_p4;
wire   [0:0] icmp_ln895_24_fu_3023_p2;
wire   [1:0] p_Result_23_fu_3012_p4;
wire   [0:0] icmp_ln895_25_fu_3040_p2;
wire   [1:0] p_Result_24_fu_3029_p4;
wire   [0:0] icmp_ln895_26_fu_3057_p2;
wire   [1:0] p_Result_25_fu_3046_p4;
wire   [0:0] icmp_ln895_27_fu_3074_p2;
wire   [1:0] p_Result_26_fu_3063_p4;
wire   [0:0] icmp_ln895_28_fu_3091_p2;
wire   [1:0] p_Result_27_fu_3080_p4;
wire   [0:0] icmp_ln895_29_fu_3108_p2;
wire   [1:0] p_Result_28_fu_3097_p4;
wire   [0:0] icmp_ln895_30_fu_3125_p2;
wire   [1:0] p_Result_29_fu_3114_p4;
wire   [0:0] icmp_ln895_31_fu_3142_p2;
wire   [1:0] p_Result_30_fu_3131_p4;
wire   [0:0] icmp_ln895_32_fu_3159_p2;
wire   [1:0] p_Result_31_fu_3148_p4;
wire   [0:0] icmp_ln895_33_fu_3176_p2;
wire   [1:0] p_Result_32_fu_3165_p4;
wire   [0:0] icmp_ln895_34_fu_3193_p2;
wire   [1:0] p_Result_33_fu_3182_p4;
wire   [0:0] icmp_ln895_35_fu_3210_p2;
wire   [1:0] p_Result_34_fu_3199_p4;
wire   [0:0] icmp_ln895_36_fu_3227_p2;
wire   [1:0] p_Result_35_fu_3216_p4;
wire   [0:0] icmp_ln895_37_fu_3244_p2;
wire   [1:0] p_Result_36_fu_3233_p4;
wire   [0:0] icmp_ln895_38_fu_3261_p2;
wire   [1:0] p_Result_37_fu_3250_p4;
wire   [0:0] icmp_ln895_39_fu_3278_p2;
wire   [1:0] p_Result_38_fu_3267_p4;
wire   [0:0] icmp_ln895_40_fu_3295_p2;
wire   [1:0] p_Result_39_fu_3284_p4;
wire   [0:0] icmp_ln895_41_fu_3312_p2;
wire   [1:0] p_Result_40_fu_3301_p4;
wire   [0:0] icmp_ln895_42_fu_3329_p2;
wire   [1:0] p_Result_41_fu_3318_p4;
wire   [0:0] icmp_ln895_43_fu_3346_p2;
wire   [1:0] p_Result_42_fu_3335_p4;
wire   [0:0] icmp_ln895_44_fu_3363_p2;
wire   [1:0] p_Result_43_fu_3352_p4;
wire   [0:0] icmp_ln895_45_fu_3380_p2;
wire   [1:0] p_Result_44_fu_3369_p4;
wire   [0:0] icmp_ln895_46_fu_3397_p2;
wire   [1:0] p_Result_45_fu_3386_p4;
wire   [0:0] icmp_ln895_47_fu_3414_p2;
wire   [1:0] p_Result_46_fu_3403_p4;
wire   [0:0] icmp_ln895_48_fu_3431_p2;
wire   [1:0] p_Result_47_fu_3420_p4;
wire   [0:0] icmp_ln895_49_fu_3448_p2;
wire   [1:0] p_Result_48_fu_3437_p4;
wire   [0:0] icmp_ln895_50_fu_3465_p2;
wire   [1:0] p_Result_49_fu_3454_p4;
wire   [0:0] icmp_ln895_51_fu_3482_p2;
wire   [1:0] p_Result_50_fu_3471_p4;
wire   [0:0] icmp_ln895_52_fu_3499_p2;
wire   [1:0] p_Result_51_fu_3488_p4;
wire   [0:0] icmp_ln895_53_fu_3516_p2;
wire   [1:0] p_Result_52_fu_3505_p4;
wire   [0:0] icmp_ln895_54_fu_3533_p2;
wire   [1:0] p_Result_53_fu_3522_p4;
wire   [0:0] icmp_ln895_55_fu_3550_p2;
wire   [1:0] p_Result_54_fu_3539_p4;
wire   [0:0] icmp_ln895_56_fu_3567_p2;
wire   [1:0] p_Result_55_fu_3556_p4;
wire   [0:0] icmp_ln895_57_fu_3584_p2;
wire   [1:0] p_Result_56_fu_3573_p4;
wire   [0:0] icmp_ln895_58_fu_3601_p2;
wire   [1:0] p_Result_57_fu_3590_p4;
wire   [0:0] icmp_ln895_59_fu_3618_p2;
wire   [1:0] p_Result_58_fu_3607_p4;
wire   [0:0] icmp_ln895_60_fu_3635_p2;
wire   [1:0] p_Result_59_fu_3624_p4;
wire   [0:0] icmp_ln895_61_fu_3652_p2;
wire   [1:0] p_Result_60_fu_3641_p4;
wire   [0:0] icmp_ln895_62_fu_3669_p2;
wire   [1:0] p_Result_61_fu_3658_p4;
wire   [0:0] icmp_ln895_63_fu_3686_p2;
wire   [1:0] p_Result_62_fu_3675_p4;
wire   [0:0] icmp_ln156_fu_2516_p2;
wire   [0:0] xor_ln154_fu_2510_p2;
wire   [2:0] select_ln154_fu_2502_p3;
wire   [2:0] xp_fu_2528_p2;
wire   [0:0] or_ln156_fu_3698_p2;
wire   [1:0] add_ln156_fu_3692_p2;
wire   [4:0] add_ln154_1_fu_3710_p2;
reg   [7:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 8'd1;
end

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_0_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_0_V_address0),
    .ce0(buf_0_V_ce0),
    .we0(buf_0_V_we0),
    .d0(buf_0_V_d0),
    .q0(buf_0_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_1_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_1_V_address0),
    .ce0(buf_1_V_ce0),
    .we0(buf_1_V_we0),
    .d0(buf_1_V_d0),
    .q0(buf_1_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_2_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_2_V_address0),
    .ce0(buf_2_V_ce0),
    .we0(buf_2_V_we0),
    .d0(buf_2_V_d0),
    .q0(buf_2_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_3_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_3_V_address0),
    .ce0(buf_3_V_ce0),
    .we0(buf_3_V_we0),
    .d0(buf_3_V_d0),
    .q0(buf_3_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_4_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_4_V_address0),
    .ce0(buf_4_V_ce0),
    .we0(buf_4_V_we0),
    .d0(buf_4_V_d0),
    .q0(buf_4_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_5_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_5_V_address0),
    .ce0(buf_5_V_ce0),
    .we0(buf_5_V_we0),
    .d0(buf_5_V_d0),
    .q0(buf_5_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_6_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_6_V_address0),
    .ce0(buf_6_V_ce0),
    .we0(buf_6_V_we0),
    .d0(buf_6_V_d0),
    .q0(buf_6_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_7_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_7_V_address0),
    .ce0(buf_7_V_ce0),
    .we0(buf_7_V_we0),
    .d0(buf_7_V_d0),
    .q0(buf_7_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_8_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_8_V_address0),
    .ce0(buf_8_V_ce0),
    .we0(buf_8_V_we0),
    .d0(buf_8_V_d0),
    .q0(buf_8_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_9_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_9_V_address0),
    .ce0(buf_9_V_ce0),
    .we0(buf_9_V_we0),
    .d0(buf_9_V_d0),
    .q0(buf_9_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_10_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_10_V_address0),
    .ce0(buf_10_V_ce0),
    .we0(buf_10_V_we0),
    .d0(buf_10_V_d0),
    .q0(buf_10_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_11_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_11_V_address0),
    .ce0(buf_11_V_ce0),
    .we0(buf_11_V_we0),
    .d0(buf_11_V_d0),
    .q0(buf_11_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_12_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_12_V_address0),
    .ce0(buf_12_V_ce0),
    .we0(buf_12_V_we0),
    .d0(buf_12_V_d0),
    .q0(buf_12_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_13_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_13_V_address0),
    .ce0(buf_13_V_ce0),
    .we0(buf_13_V_we0),
    .d0(buf_13_V_d0),
    .q0(buf_13_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_14_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_14_V_address0),
    .ce0(buf_14_V_ce0),
    .we0(buf_14_V_we0),
    .d0(buf_14_V_d0),
    .q0(buf_14_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_15_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_15_V_address0),
    .ce0(buf_15_V_ce0),
    .we0(buf_15_V_we0),
    .d0(buf_15_V_d0),
    .q0(buf_15_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_16_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_16_V_address0),
    .ce0(buf_16_V_ce0),
    .we0(buf_16_V_we0),
    .d0(buf_16_V_d0),
    .q0(buf_16_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_17_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_17_V_address0),
    .ce0(buf_17_V_ce0),
    .we0(buf_17_V_we0),
    .d0(buf_17_V_d0),
    .q0(buf_17_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_18_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_18_V_address0),
    .ce0(buf_18_V_ce0),
    .we0(buf_18_V_we0),
    .d0(buf_18_V_d0),
    .q0(buf_18_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_19_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_19_V_address0),
    .ce0(buf_19_V_ce0),
    .we0(buf_19_V_we0),
    .d0(buf_19_V_d0),
    .q0(buf_19_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_20_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_20_V_address0),
    .ce0(buf_20_V_ce0),
    .we0(buf_20_V_we0),
    .d0(buf_20_V_d0),
    .q0(buf_20_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_21_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_21_V_address0),
    .ce0(buf_21_V_ce0),
    .we0(buf_21_V_we0),
    .d0(buf_21_V_d0),
    .q0(buf_21_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_22_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_22_V_address0),
    .ce0(buf_22_V_ce0),
    .we0(buf_22_V_we0),
    .d0(buf_22_V_d0),
    .q0(buf_22_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_23_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_23_V_address0),
    .ce0(buf_23_V_ce0),
    .we0(buf_23_V_we0),
    .d0(buf_23_V_d0),
    .q0(buf_23_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_24_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_24_V_address0),
    .ce0(buf_24_V_ce0),
    .we0(buf_24_V_we0),
    .d0(buf_24_V_d0),
    .q0(buf_24_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_25_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_25_V_address0),
    .ce0(buf_25_V_ce0),
    .we0(buf_25_V_we0),
    .d0(buf_25_V_d0),
    .q0(buf_25_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_26_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_26_V_address0),
    .ce0(buf_26_V_ce0),
    .we0(buf_26_V_we0),
    .d0(buf_26_V_d0),
    .q0(buf_26_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_27_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_27_V_address0),
    .ce0(buf_27_V_ce0),
    .we0(buf_27_V_we0),
    .d0(buf_27_V_d0),
    .q0(buf_27_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_28_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_28_V_address0),
    .ce0(buf_28_V_ce0),
    .we0(buf_28_V_we0),
    .d0(buf_28_V_d0),
    .q0(buf_28_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_29_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_29_V_address0),
    .ce0(buf_29_V_ce0),
    .we0(buf_29_V_we0),
    .d0(buf_29_V_d0),
    .q0(buf_29_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_30_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_30_V_address0),
    .ce0(buf_30_V_ce0),
    .we0(buf_30_V_we0),
    .d0(buf_30_V_d0),
    .q0(buf_30_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_31_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_31_V_address0),
    .ce0(buf_31_V_ce0),
    .we0(buf_31_V_we0),
    .d0(buf_31_V_d0),
    .q0(buf_31_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_32_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_32_V_address0),
    .ce0(buf_32_V_ce0),
    .we0(buf_32_V_we0),
    .d0(buf_32_V_d0),
    .q0(buf_32_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_33_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_33_V_address0),
    .ce0(buf_33_V_ce0),
    .we0(buf_33_V_we0),
    .d0(buf_33_V_d0),
    .q0(buf_33_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_34_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_34_V_address0),
    .ce0(buf_34_V_ce0),
    .we0(buf_34_V_we0),
    .d0(buf_34_V_d0),
    .q0(buf_34_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_35_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_35_V_address0),
    .ce0(buf_35_V_ce0),
    .we0(buf_35_V_we0),
    .d0(buf_35_V_d0),
    .q0(buf_35_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_36_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_36_V_address0),
    .ce0(buf_36_V_ce0),
    .we0(buf_36_V_we0),
    .d0(buf_36_V_d0),
    .q0(buf_36_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_37_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_37_V_address0),
    .ce0(buf_37_V_ce0),
    .we0(buf_37_V_we0),
    .d0(buf_37_V_d0),
    .q0(buf_37_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_38_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_38_V_address0),
    .ce0(buf_38_V_ce0),
    .we0(buf_38_V_we0),
    .d0(buf_38_V_d0),
    .q0(buf_38_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_39_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_39_V_address0),
    .ce0(buf_39_V_ce0),
    .we0(buf_39_V_we0),
    .d0(buf_39_V_d0),
    .q0(buf_39_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_40_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_40_V_address0),
    .ce0(buf_40_V_ce0),
    .we0(buf_40_V_we0),
    .d0(buf_40_V_d0),
    .q0(buf_40_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_41_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_41_V_address0),
    .ce0(buf_41_V_ce0),
    .we0(buf_41_V_we0),
    .d0(buf_41_V_d0),
    .q0(buf_41_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_42_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_42_V_address0),
    .ce0(buf_42_V_ce0),
    .we0(buf_42_V_we0),
    .d0(buf_42_V_d0),
    .q0(buf_42_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_43_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_43_V_address0),
    .ce0(buf_43_V_ce0),
    .we0(buf_43_V_we0),
    .d0(buf_43_V_d0),
    .q0(buf_43_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_44_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_44_V_address0),
    .ce0(buf_44_V_ce0),
    .we0(buf_44_V_we0),
    .d0(buf_44_V_d0),
    .q0(buf_44_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_45_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_45_V_address0),
    .ce0(buf_45_V_ce0),
    .we0(buf_45_V_we0),
    .d0(buf_45_V_d0),
    .q0(buf_45_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_46_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_46_V_address0),
    .ce0(buf_46_V_ce0),
    .we0(buf_46_V_we0),
    .d0(buf_46_V_d0),
    .q0(buf_46_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_47_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_47_V_address0),
    .ce0(buf_47_V_ce0),
    .we0(buf_47_V_we0),
    .d0(buf_47_V_d0),
    .q0(buf_47_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_48_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_48_V_address0),
    .ce0(buf_48_V_ce0),
    .we0(buf_48_V_we0),
    .d0(buf_48_V_d0),
    .q0(buf_48_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_49_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_49_V_address0),
    .ce0(buf_49_V_ce0),
    .we0(buf_49_V_we0),
    .d0(buf_49_V_d0),
    .q0(buf_49_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_50_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_50_V_address0),
    .ce0(buf_50_V_ce0),
    .we0(buf_50_V_we0),
    .d0(buf_50_V_d0),
    .q0(buf_50_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_51_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_51_V_address0),
    .ce0(buf_51_V_ce0),
    .we0(buf_51_V_we0),
    .d0(buf_51_V_d0),
    .q0(buf_51_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_52_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_52_V_address0),
    .ce0(buf_52_V_ce0),
    .we0(buf_52_V_we0),
    .d0(buf_52_V_d0),
    .q0(buf_52_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_53_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_53_V_address0),
    .ce0(buf_53_V_ce0),
    .we0(buf_53_V_we0),
    .d0(buf_53_V_d0),
    .q0(buf_53_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_54_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_54_V_address0),
    .ce0(buf_54_V_ce0),
    .we0(buf_54_V_we0),
    .d0(buf_54_V_d0),
    .q0(buf_54_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_55_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_55_V_address0),
    .ce0(buf_55_V_ce0),
    .we0(buf_55_V_we0),
    .d0(buf_55_V_d0),
    .q0(buf_55_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_56_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_56_V_address0),
    .ce0(buf_56_V_ce0),
    .we0(buf_56_V_we0),
    .d0(buf_56_V_d0),
    .q0(buf_56_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_57_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_57_V_address0),
    .ce0(buf_57_V_ce0),
    .we0(buf_57_V_we0),
    .d0(buf_57_V_d0),
    .q0(buf_57_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_58_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_58_V_address0),
    .ce0(buf_58_V_ce0),
    .we0(buf_58_V_we0),
    .d0(buf_58_V_d0),
    .q0(buf_58_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_59_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_59_V_address0),
    .ce0(buf_59_V_ce0),
    .we0(buf_59_V_we0),
    .d0(buf_59_V_d0),
    .q0(buf_59_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_60_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_60_V_address0),
    .ce0(buf_60_V_ce0),
    .we0(buf_60_V_we0),
    .d0(buf_60_V_d0),
    .q0(buf_60_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_61_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_61_V_address0),
    .ce0(buf_61_V_ce0),
    .we0(buf_61_V_we0),
    .d0(buf_61_V_d0),
    .q0(buf_61_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_62_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_62_V_address0),
    .ce0(buf_62_V_ce0),
    .we0(buf_62_V_we0),
    .d0(buf_62_V_d0),
    .q0(buf_62_V_q0)
);

StreamingMaxPool_Batch_0_StreamingMaxPool_bkb #(
    .DataWidth( 2 ),
    .AddressRange( 5 ),
    .AddressWidth( 3 ))
buf_63_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(buf_63_V_address0),
    .ce0(buf_63_V_ce0),
    .we0(buf_63_V_we0),
    .d0(buf_63_V_d0),
    .q0(buf_63_V_q0)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        i_0_reg_2313 <= i_fu_2398_p2;
    end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
        i_0_reg_2313 <= 3'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln152_fu_2472_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        indvar_flatten141_reg_2335 <= 5'd0;
    end else if (((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
        indvar_flatten141_reg_2335 <= add_ln153_reg_3956;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln152_fu_2472_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        indvar_flatten_reg_2346 <= 5'd0;
    end else if (((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
        indvar_flatten_reg_2346 <= select_ln154_1_fu_3716_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln152_fu_2472_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        kx_0_reg_2369 <= 2'd0;
    end else if (((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
        kx_0_reg_2369 <= kx_fu_3702_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        outpix_0_reg_2381 <= 3'd0;
    end else if (((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state8))) begin
        outpix_0_reg_2381 <= outpix_reg_4502;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln152_fu_2472_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        xp_0_reg_2358 <= 3'd0;
    end else if (((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
        xp_0_reg_2358 <= select_ln164_reg_3972;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln145_fu_2392_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
        yp_0_reg_2324 <= 3'd0;
    end else if (((icmp_ln172_fu_3723_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state7))) begin
        yp_0_reg_2324 <= yp_reg_3948;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        add_ln153_reg_3956 <= add_ln153_fu_2490_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln153_fu_2484_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        and_ln154_reg_3967 <= and_ln154_fu_2522_p2;
        buf_0_V_addr_2_reg_3977 <= zext_ln164_fu_2542_p1;
        buf_10_V_addr_2_reg_4027 <= zext_ln164_fu_2542_p1;
        buf_11_V_addr_2_reg_4032 <= zext_ln164_fu_2542_p1;
        buf_12_V_addr_2_reg_4037 <= zext_ln164_fu_2542_p1;
        buf_13_V_addr_2_reg_4042 <= zext_ln164_fu_2542_p1;
        buf_14_V_addr_2_reg_4047 <= zext_ln164_fu_2542_p1;
        buf_15_V_addr_2_reg_4052 <= zext_ln164_fu_2542_p1;
        buf_16_V_addr_2_reg_4057 <= zext_ln164_fu_2542_p1;
        buf_17_V_addr_2_reg_4062 <= zext_ln164_fu_2542_p1;
        buf_18_V_addr_2_reg_4067 <= zext_ln164_fu_2542_p1;
        buf_19_V_addr_2_reg_4072 <= zext_ln164_fu_2542_p1;
        buf_1_V_addr_2_reg_3982 <= zext_ln164_fu_2542_p1;
        buf_20_V_addr_2_reg_4077 <= zext_ln164_fu_2542_p1;
        buf_21_V_addr_2_reg_4082 <= zext_ln164_fu_2542_p1;
        buf_22_V_addr_2_reg_4087 <= zext_ln164_fu_2542_p1;
        buf_23_V_addr_2_reg_4092 <= zext_ln164_fu_2542_p1;
        buf_24_V_addr_2_reg_4097 <= zext_ln164_fu_2542_p1;
        buf_25_V_addr_2_reg_4102 <= zext_ln164_fu_2542_p1;
        buf_26_V_addr_2_reg_4107 <= zext_ln164_fu_2542_p1;
        buf_27_V_addr_2_reg_4112 <= zext_ln164_fu_2542_p1;
        buf_28_V_addr_2_reg_4117 <= zext_ln164_fu_2542_p1;
        buf_29_V_addr_2_reg_4122 <= zext_ln164_fu_2542_p1;
        buf_2_V_addr_2_reg_3987 <= zext_ln164_fu_2542_p1;
        buf_30_V_addr_2_reg_4127 <= zext_ln164_fu_2542_p1;
        buf_31_V_addr_2_reg_4132 <= zext_ln164_fu_2542_p1;
        buf_32_V_addr_2_reg_4137 <= zext_ln164_fu_2542_p1;
        buf_33_V_addr_2_reg_4142 <= zext_ln164_fu_2542_p1;
        buf_34_V_addr_2_reg_4147 <= zext_ln164_fu_2542_p1;
        buf_35_V_addr_2_reg_4152 <= zext_ln164_fu_2542_p1;
        buf_36_V_addr_2_reg_4157 <= zext_ln164_fu_2542_p1;
        buf_37_V_addr_2_reg_4162 <= zext_ln164_fu_2542_p1;
        buf_38_V_addr_2_reg_4167 <= zext_ln164_fu_2542_p1;
        buf_39_V_addr_2_reg_4172 <= zext_ln164_fu_2542_p1;
        buf_3_V_addr_2_reg_3992 <= zext_ln164_fu_2542_p1;
        buf_40_V_addr_2_reg_4177 <= zext_ln164_fu_2542_p1;
        buf_41_V_addr_2_reg_4182 <= zext_ln164_fu_2542_p1;
        buf_42_V_addr_2_reg_4187 <= zext_ln164_fu_2542_p1;
        buf_43_V_addr_2_reg_4192 <= zext_ln164_fu_2542_p1;
        buf_44_V_addr_2_reg_4197 <= zext_ln164_fu_2542_p1;
        buf_45_V_addr_2_reg_4202 <= zext_ln164_fu_2542_p1;
        buf_46_V_addr_2_reg_4207 <= zext_ln164_fu_2542_p1;
        buf_47_V_addr_2_reg_4212 <= zext_ln164_fu_2542_p1;
        buf_48_V_addr_2_reg_4217 <= zext_ln164_fu_2542_p1;
        buf_49_V_addr_2_reg_4222 <= zext_ln164_fu_2542_p1;
        buf_4_V_addr_2_reg_3997 <= zext_ln164_fu_2542_p1;
        buf_50_V_addr_2_reg_4227 <= zext_ln164_fu_2542_p1;
        buf_51_V_addr_2_reg_4232 <= zext_ln164_fu_2542_p1;
        buf_52_V_addr_2_reg_4237 <= zext_ln164_fu_2542_p1;
        buf_53_V_addr_2_reg_4242 <= zext_ln164_fu_2542_p1;
        buf_54_V_addr_2_reg_4247 <= zext_ln164_fu_2542_p1;
        buf_55_V_addr_2_reg_4252 <= zext_ln164_fu_2542_p1;
        buf_56_V_addr_2_reg_4257 <= zext_ln164_fu_2542_p1;
        buf_57_V_addr_2_reg_4262 <= zext_ln164_fu_2542_p1;
        buf_58_V_addr_2_reg_4267 <= zext_ln164_fu_2542_p1;
        buf_59_V_addr_2_reg_4272 <= zext_ln164_fu_2542_p1;
        buf_5_V_addr_2_reg_4002 <= zext_ln164_fu_2542_p1;
        buf_60_V_addr_2_reg_4277 <= zext_ln164_fu_2542_p1;
        buf_61_V_addr_2_reg_4282 <= zext_ln164_fu_2542_p1;
        buf_62_V_addr_2_reg_4287 <= zext_ln164_fu_2542_p1;
        buf_63_V_addr_2_reg_4292 <= zext_ln164_fu_2542_p1;
        buf_6_V_addr_2_reg_4007 <= zext_ln164_fu_2542_p1;
        buf_7_V_addr_2_reg_4012 <= zext_ln164_fu_2542_p1;
        buf_8_V_addr_2_reg_4017 <= zext_ln164_fu_2542_p1;
        buf_9_V_addr_2_reg_4022 <= zext_ln164_fu_2542_p1;
        icmp_ln154_reg_3961 <= icmp_ln154_fu_2496_p2;
        select_ln164_reg_3972 <= select_ln164_fu_2534_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        outpix_reg_4502 <= outpix_fu_3729_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        yp_reg_3948 <= yp_fu_2478_p2;
    end
end

always @ (*) begin
    if ((((icmp_ln152_fu_2472_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln152_fu_2472_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_0_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_0_V_address0 = buf_0_V_addr_2_reg_3977;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_0_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_0_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_0_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_0_V_ce0 = 1'b1;
    end else begin
        buf_0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_0_V_d0 = trunc_ln647_fu_2610_p1;
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_0_V_d0 = 2'd0;
    end else begin
        buf_0_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_fu_2615_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_0_V_we0 = 1'b1;
    end else begin
        buf_0_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_10_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_10_V_address0 = buf_10_V_addr_2_reg_4027;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_10_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_10_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_10_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_10_V_ce0 = 1'b1;
    end else begin
        buf_10_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_10_V_d0 = {{in_V_V_TDATA[21:20]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_10_V_d0 = 2'd0;
    end else begin
        buf_10_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_10_fu_2785_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_10_V_we0 = 1'b1;
    end else begin
        buf_10_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_11_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_11_V_address0 = buf_11_V_addr_2_reg_4032;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_11_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_11_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_11_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_11_V_ce0 = 1'b1;
    end else begin
        buf_11_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_11_V_d0 = {{in_V_V_TDATA[23:22]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_11_V_d0 = 2'd0;
    end else begin
        buf_11_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_11_fu_2802_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_11_V_we0 = 1'b1;
    end else begin
        buf_11_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_12_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_12_V_address0 = buf_12_V_addr_2_reg_4037;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_12_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_12_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_12_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_12_V_ce0 = 1'b1;
    end else begin
        buf_12_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_12_V_d0 = {{in_V_V_TDATA[25:24]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_12_V_d0 = 2'd0;
    end else begin
        buf_12_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_12_fu_2819_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_12_V_we0 = 1'b1;
    end else begin
        buf_12_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_13_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_13_V_address0 = buf_13_V_addr_2_reg_4042;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_13_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_13_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_13_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_13_V_ce0 = 1'b1;
    end else begin
        buf_13_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_13_V_d0 = {{in_V_V_TDATA[27:26]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_13_V_d0 = 2'd0;
    end else begin
        buf_13_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_13_fu_2836_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_13_V_we0 = 1'b1;
    end else begin
        buf_13_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_14_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_14_V_address0 = buf_14_V_addr_2_reg_4047;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_14_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_14_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_14_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_14_V_ce0 = 1'b1;
    end else begin
        buf_14_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_14_V_d0 = {{in_V_V_TDATA[29:28]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_14_V_d0 = 2'd0;
    end else begin
        buf_14_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_14_fu_2853_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_14_V_we0 = 1'b1;
    end else begin
        buf_14_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_15_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_15_V_address0 = buf_15_V_addr_2_reg_4052;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_15_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_15_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_15_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_15_V_ce0 = 1'b1;
    end else begin
        buf_15_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_15_V_d0 = {{in_V_V_TDATA[31:30]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_15_V_d0 = 2'd0;
    end else begin
        buf_15_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_15_fu_2870_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_15_V_we0 = 1'b1;
    end else begin
        buf_15_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_16_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_16_V_address0 = buf_16_V_addr_2_reg_4057;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_16_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_16_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_16_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_16_V_ce0 = 1'b1;
    end else begin
        buf_16_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_16_V_d0 = {{in_V_V_TDATA[33:32]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_16_V_d0 = 2'd0;
    end else begin
        buf_16_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_16_fu_2887_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_16_V_we0 = 1'b1;
    end else begin
        buf_16_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_17_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_17_V_address0 = buf_17_V_addr_2_reg_4062;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_17_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_17_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_17_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_17_V_ce0 = 1'b1;
    end else begin
        buf_17_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_17_V_d0 = {{in_V_V_TDATA[35:34]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_17_V_d0 = 2'd0;
    end else begin
        buf_17_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_17_fu_2904_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_17_V_we0 = 1'b1;
    end else begin
        buf_17_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_18_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_18_V_address0 = buf_18_V_addr_2_reg_4067;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_18_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_18_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_18_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_18_V_ce0 = 1'b1;
    end else begin
        buf_18_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_18_V_d0 = {{in_V_V_TDATA[37:36]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_18_V_d0 = 2'd0;
    end else begin
        buf_18_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_18_fu_2921_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_18_V_we0 = 1'b1;
    end else begin
        buf_18_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_19_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_19_V_address0 = buf_19_V_addr_2_reg_4072;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_19_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_19_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_19_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_19_V_ce0 = 1'b1;
    end else begin
        buf_19_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_19_V_d0 = {{in_V_V_TDATA[39:38]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_19_V_d0 = 2'd0;
    end else begin
        buf_19_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_19_fu_2938_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_19_V_we0 = 1'b1;
    end else begin
        buf_19_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_1_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_1_V_address0 = buf_1_V_addr_2_reg_3982;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_1_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_1_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_1_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_1_V_ce0 = 1'b1;
    end else begin
        buf_1_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_1_V_d0 = {{in_V_V_TDATA[3:2]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_1_V_d0 = 2'd0;
    end else begin
        buf_1_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_1_fu_2632_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_1_V_we0 = 1'b1;
    end else begin
        buf_1_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_20_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_20_V_address0 = buf_20_V_addr_2_reg_4077;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_20_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_20_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_20_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_20_V_ce0 = 1'b1;
    end else begin
        buf_20_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_20_V_d0 = {{in_V_V_TDATA[41:40]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_20_V_d0 = 2'd0;
    end else begin
        buf_20_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_20_fu_2955_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_20_V_we0 = 1'b1;
    end else begin
        buf_20_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_21_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_21_V_address0 = buf_21_V_addr_2_reg_4082;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_21_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_21_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_21_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_21_V_ce0 = 1'b1;
    end else begin
        buf_21_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_21_V_d0 = {{in_V_V_TDATA[43:42]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_21_V_d0 = 2'd0;
    end else begin
        buf_21_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_21_fu_2972_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_21_V_we0 = 1'b1;
    end else begin
        buf_21_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_22_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_22_V_address0 = buf_22_V_addr_2_reg_4087;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_22_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_22_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_22_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_22_V_ce0 = 1'b1;
    end else begin
        buf_22_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_22_V_d0 = {{in_V_V_TDATA[45:44]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_22_V_d0 = 2'd0;
    end else begin
        buf_22_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_22_fu_2989_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_22_V_we0 = 1'b1;
    end else begin
        buf_22_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_23_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_23_V_address0 = buf_23_V_addr_2_reg_4092;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_23_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_23_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_23_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_23_V_ce0 = 1'b1;
    end else begin
        buf_23_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_23_V_d0 = {{in_V_V_TDATA[47:46]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_23_V_d0 = 2'd0;
    end else begin
        buf_23_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_23_fu_3006_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_23_V_we0 = 1'b1;
    end else begin
        buf_23_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_24_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_24_V_address0 = buf_24_V_addr_2_reg_4097;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_24_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_24_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_24_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_24_V_ce0 = 1'b1;
    end else begin
        buf_24_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_24_V_d0 = {{in_V_V_TDATA[49:48]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_24_V_d0 = 2'd0;
    end else begin
        buf_24_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_24_fu_3023_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_24_V_we0 = 1'b1;
    end else begin
        buf_24_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_25_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_25_V_address0 = buf_25_V_addr_2_reg_4102;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_25_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_25_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_25_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_25_V_ce0 = 1'b1;
    end else begin
        buf_25_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_25_V_d0 = {{in_V_V_TDATA[51:50]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_25_V_d0 = 2'd0;
    end else begin
        buf_25_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_25_fu_3040_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_25_V_we0 = 1'b1;
    end else begin
        buf_25_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_26_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_26_V_address0 = buf_26_V_addr_2_reg_4107;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_26_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_26_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_26_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_26_V_ce0 = 1'b1;
    end else begin
        buf_26_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_26_V_d0 = {{in_V_V_TDATA[53:52]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_26_V_d0 = 2'd0;
    end else begin
        buf_26_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_26_fu_3057_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_26_V_we0 = 1'b1;
    end else begin
        buf_26_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_27_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_27_V_address0 = buf_27_V_addr_2_reg_4112;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_27_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_27_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_27_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_27_V_ce0 = 1'b1;
    end else begin
        buf_27_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_27_V_d0 = {{in_V_V_TDATA[55:54]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_27_V_d0 = 2'd0;
    end else begin
        buf_27_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_27_fu_3074_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_27_V_we0 = 1'b1;
    end else begin
        buf_27_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_28_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_28_V_address0 = buf_28_V_addr_2_reg_4117;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_28_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_28_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_28_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_28_V_ce0 = 1'b1;
    end else begin
        buf_28_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_28_V_d0 = {{in_V_V_TDATA[57:56]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_28_V_d0 = 2'd0;
    end else begin
        buf_28_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_28_fu_3091_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_28_V_we0 = 1'b1;
    end else begin
        buf_28_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_29_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_29_V_address0 = buf_29_V_addr_2_reg_4122;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_29_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_29_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_29_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_29_V_ce0 = 1'b1;
    end else begin
        buf_29_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_29_V_d0 = {{in_V_V_TDATA[59:58]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_29_V_d0 = 2'd0;
    end else begin
        buf_29_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_29_fu_3108_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_29_V_we0 = 1'b1;
    end else begin
        buf_29_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_2_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_2_V_address0 = buf_2_V_addr_2_reg_3987;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_2_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_2_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_2_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_2_V_ce0 = 1'b1;
    end else begin
        buf_2_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_2_V_d0 = {{in_V_V_TDATA[5:4]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_2_V_d0 = 2'd0;
    end else begin
        buf_2_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_2_fu_2649_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_2_V_we0 = 1'b1;
    end else begin
        buf_2_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_30_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_30_V_address0 = buf_30_V_addr_2_reg_4127;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_30_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_30_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_30_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_30_V_ce0 = 1'b1;
    end else begin
        buf_30_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_30_V_d0 = {{in_V_V_TDATA[61:60]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_30_V_d0 = 2'd0;
    end else begin
        buf_30_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_30_fu_3125_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_30_V_we0 = 1'b1;
    end else begin
        buf_30_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_31_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_31_V_address0 = buf_31_V_addr_2_reg_4132;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_31_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_31_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_31_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_31_V_ce0 = 1'b1;
    end else begin
        buf_31_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_31_V_d0 = {{in_V_V_TDATA[63:62]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_31_V_d0 = 2'd0;
    end else begin
        buf_31_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_31_fu_3142_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_31_V_we0 = 1'b1;
    end else begin
        buf_31_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_32_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_32_V_address0 = buf_32_V_addr_2_reg_4137;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_32_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_32_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_32_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_32_V_ce0 = 1'b1;
    end else begin
        buf_32_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_32_V_d0 = {{in_V_V_TDATA[65:64]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_32_V_d0 = 2'd0;
    end else begin
        buf_32_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_32_fu_3159_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_32_V_we0 = 1'b1;
    end else begin
        buf_32_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_33_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_33_V_address0 = buf_33_V_addr_2_reg_4142;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_33_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_33_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_33_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_33_V_ce0 = 1'b1;
    end else begin
        buf_33_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_33_V_d0 = {{in_V_V_TDATA[67:66]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_33_V_d0 = 2'd0;
    end else begin
        buf_33_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_33_fu_3176_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_33_V_we0 = 1'b1;
    end else begin
        buf_33_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_34_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_34_V_address0 = buf_34_V_addr_2_reg_4147;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_34_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_34_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_34_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_34_V_ce0 = 1'b1;
    end else begin
        buf_34_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_34_V_d0 = {{in_V_V_TDATA[69:68]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_34_V_d0 = 2'd0;
    end else begin
        buf_34_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_34_fu_3193_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_34_V_we0 = 1'b1;
    end else begin
        buf_34_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_35_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_35_V_address0 = buf_35_V_addr_2_reg_4152;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_35_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_35_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_35_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_35_V_ce0 = 1'b1;
    end else begin
        buf_35_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_35_V_d0 = {{in_V_V_TDATA[71:70]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_35_V_d0 = 2'd0;
    end else begin
        buf_35_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_35_fu_3210_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_35_V_we0 = 1'b1;
    end else begin
        buf_35_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_36_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_36_V_address0 = buf_36_V_addr_2_reg_4157;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_36_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_36_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_36_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_36_V_ce0 = 1'b1;
    end else begin
        buf_36_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_36_V_d0 = {{in_V_V_TDATA[73:72]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_36_V_d0 = 2'd0;
    end else begin
        buf_36_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_36_fu_3227_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_36_V_we0 = 1'b1;
    end else begin
        buf_36_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_37_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_37_V_address0 = buf_37_V_addr_2_reg_4162;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_37_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_37_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_37_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_37_V_ce0 = 1'b1;
    end else begin
        buf_37_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_37_V_d0 = {{in_V_V_TDATA[75:74]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_37_V_d0 = 2'd0;
    end else begin
        buf_37_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_37_fu_3244_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_37_V_we0 = 1'b1;
    end else begin
        buf_37_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_38_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_38_V_address0 = buf_38_V_addr_2_reg_4167;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_38_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_38_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_38_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_38_V_ce0 = 1'b1;
    end else begin
        buf_38_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_38_V_d0 = {{in_V_V_TDATA[77:76]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_38_V_d0 = 2'd0;
    end else begin
        buf_38_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_38_fu_3261_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_38_V_we0 = 1'b1;
    end else begin
        buf_38_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_39_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_39_V_address0 = buf_39_V_addr_2_reg_4172;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_39_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_39_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_39_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_39_V_ce0 = 1'b1;
    end else begin
        buf_39_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_39_V_d0 = {{in_V_V_TDATA[79:78]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_39_V_d0 = 2'd0;
    end else begin
        buf_39_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_39_fu_3278_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_39_V_we0 = 1'b1;
    end else begin
        buf_39_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_3_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_3_V_address0 = buf_3_V_addr_2_reg_3992;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_3_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_3_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_3_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_3_V_ce0 = 1'b1;
    end else begin
        buf_3_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_3_V_d0 = {{in_V_V_TDATA[7:6]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_3_V_d0 = 2'd0;
    end else begin
        buf_3_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_3_fu_2666_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_3_V_we0 = 1'b1;
    end else begin
        buf_3_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_40_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_40_V_address0 = buf_40_V_addr_2_reg_4177;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_40_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_40_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_40_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_40_V_ce0 = 1'b1;
    end else begin
        buf_40_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_40_V_d0 = {{in_V_V_TDATA[81:80]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_40_V_d0 = 2'd0;
    end else begin
        buf_40_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_40_fu_3295_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_40_V_we0 = 1'b1;
    end else begin
        buf_40_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_41_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_41_V_address0 = buf_41_V_addr_2_reg_4182;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_41_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_41_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_41_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_41_V_ce0 = 1'b1;
    end else begin
        buf_41_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_41_V_d0 = {{in_V_V_TDATA[83:82]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_41_V_d0 = 2'd0;
    end else begin
        buf_41_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_41_fu_3312_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_41_V_we0 = 1'b1;
    end else begin
        buf_41_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_42_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_42_V_address0 = buf_42_V_addr_2_reg_4187;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_42_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_42_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_42_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_42_V_ce0 = 1'b1;
    end else begin
        buf_42_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_42_V_d0 = {{in_V_V_TDATA[85:84]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_42_V_d0 = 2'd0;
    end else begin
        buf_42_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_42_fu_3329_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_42_V_we0 = 1'b1;
    end else begin
        buf_42_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_43_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_43_V_address0 = buf_43_V_addr_2_reg_4192;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_43_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_43_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_43_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_43_V_ce0 = 1'b1;
    end else begin
        buf_43_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_43_V_d0 = {{in_V_V_TDATA[87:86]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_43_V_d0 = 2'd0;
    end else begin
        buf_43_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_43_fu_3346_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_43_V_we0 = 1'b1;
    end else begin
        buf_43_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_44_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_44_V_address0 = buf_44_V_addr_2_reg_4197;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_44_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_44_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_44_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_44_V_ce0 = 1'b1;
    end else begin
        buf_44_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_44_V_d0 = {{in_V_V_TDATA[89:88]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_44_V_d0 = 2'd0;
    end else begin
        buf_44_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_44_fu_3363_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_44_V_we0 = 1'b1;
    end else begin
        buf_44_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_45_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_45_V_address0 = buf_45_V_addr_2_reg_4202;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_45_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_45_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_45_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_45_V_ce0 = 1'b1;
    end else begin
        buf_45_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_45_V_d0 = {{in_V_V_TDATA[91:90]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_45_V_d0 = 2'd0;
    end else begin
        buf_45_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_45_fu_3380_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_45_V_we0 = 1'b1;
    end else begin
        buf_45_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_46_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_46_V_address0 = buf_46_V_addr_2_reg_4207;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_46_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_46_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_46_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_46_V_ce0 = 1'b1;
    end else begin
        buf_46_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_46_V_d0 = {{in_V_V_TDATA[93:92]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_46_V_d0 = 2'd0;
    end else begin
        buf_46_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_46_fu_3397_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_46_V_we0 = 1'b1;
    end else begin
        buf_46_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_47_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_47_V_address0 = buf_47_V_addr_2_reg_4212;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_47_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_47_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_47_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_47_V_ce0 = 1'b1;
    end else begin
        buf_47_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_47_V_d0 = {{in_V_V_TDATA[95:94]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_47_V_d0 = 2'd0;
    end else begin
        buf_47_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_47_fu_3414_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_47_V_we0 = 1'b1;
    end else begin
        buf_47_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_48_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_48_V_address0 = buf_48_V_addr_2_reg_4217;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_48_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_48_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_48_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_48_V_ce0 = 1'b1;
    end else begin
        buf_48_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_48_V_d0 = {{in_V_V_TDATA[97:96]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_48_V_d0 = 2'd0;
    end else begin
        buf_48_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_48_fu_3431_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_48_V_we0 = 1'b1;
    end else begin
        buf_48_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_49_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_49_V_address0 = buf_49_V_addr_2_reg_4222;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_49_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_49_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_49_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_49_V_ce0 = 1'b1;
    end else begin
        buf_49_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_49_V_d0 = {{in_V_V_TDATA[99:98]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_49_V_d0 = 2'd0;
    end else begin
        buf_49_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_49_fu_3448_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_49_V_we0 = 1'b1;
    end else begin
        buf_49_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_4_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_4_V_address0 = buf_4_V_addr_2_reg_3997;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_4_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_4_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_4_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_4_V_ce0 = 1'b1;
    end else begin
        buf_4_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_4_V_d0 = {{in_V_V_TDATA[9:8]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_4_V_d0 = 2'd0;
    end else begin
        buf_4_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_4_fu_2683_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_4_V_we0 = 1'b1;
    end else begin
        buf_4_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_50_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_50_V_address0 = buf_50_V_addr_2_reg_4227;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_50_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_50_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_50_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_50_V_ce0 = 1'b1;
    end else begin
        buf_50_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_50_V_d0 = {{in_V_V_TDATA[101:100]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_50_V_d0 = 2'd0;
    end else begin
        buf_50_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_50_fu_3465_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_50_V_we0 = 1'b1;
    end else begin
        buf_50_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_51_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_51_V_address0 = buf_51_V_addr_2_reg_4232;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_51_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_51_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_51_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_51_V_ce0 = 1'b1;
    end else begin
        buf_51_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_51_V_d0 = {{in_V_V_TDATA[103:102]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_51_V_d0 = 2'd0;
    end else begin
        buf_51_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_51_fu_3482_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_51_V_we0 = 1'b1;
    end else begin
        buf_51_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_52_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_52_V_address0 = buf_52_V_addr_2_reg_4237;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_52_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_52_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_52_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_52_V_ce0 = 1'b1;
    end else begin
        buf_52_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_52_V_d0 = {{in_V_V_TDATA[105:104]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_52_V_d0 = 2'd0;
    end else begin
        buf_52_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_52_fu_3499_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_52_V_we0 = 1'b1;
    end else begin
        buf_52_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_53_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_53_V_address0 = buf_53_V_addr_2_reg_4242;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_53_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_53_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_53_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_53_V_ce0 = 1'b1;
    end else begin
        buf_53_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_53_V_d0 = {{in_V_V_TDATA[107:106]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_53_V_d0 = 2'd0;
    end else begin
        buf_53_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_53_fu_3516_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_53_V_we0 = 1'b1;
    end else begin
        buf_53_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_54_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_54_V_address0 = buf_54_V_addr_2_reg_4247;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_54_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_54_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_54_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_54_V_ce0 = 1'b1;
    end else begin
        buf_54_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_54_V_d0 = {{in_V_V_TDATA[109:108]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_54_V_d0 = 2'd0;
    end else begin
        buf_54_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_54_fu_3533_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_54_V_we0 = 1'b1;
    end else begin
        buf_54_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_55_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_55_V_address0 = buf_55_V_addr_2_reg_4252;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_55_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_55_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_55_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_55_V_ce0 = 1'b1;
    end else begin
        buf_55_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_55_V_d0 = {{in_V_V_TDATA[111:110]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_55_V_d0 = 2'd0;
    end else begin
        buf_55_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_55_fu_3550_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_55_V_we0 = 1'b1;
    end else begin
        buf_55_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_56_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_56_V_address0 = buf_56_V_addr_2_reg_4257;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_56_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_56_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_56_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_56_V_ce0 = 1'b1;
    end else begin
        buf_56_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_56_V_d0 = {{in_V_V_TDATA[113:112]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_56_V_d0 = 2'd0;
    end else begin
        buf_56_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_56_fu_3567_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_56_V_we0 = 1'b1;
    end else begin
        buf_56_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_57_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_57_V_address0 = buf_57_V_addr_2_reg_4262;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_57_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_57_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_57_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_57_V_ce0 = 1'b1;
    end else begin
        buf_57_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_57_V_d0 = {{in_V_V_TDATA[115:114]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_57_V_d0 = 2'd0;
    end else begin
        buf_57_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_57_fu_3584_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_57_V_we0 = 1'b1;
    end else begin
        buf_57_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_58_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_58_V_address0 = buf_58_V_addr_2_reg_4267;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_58_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_58_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_58_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_58_V_ce0 = 1'b1;
    end else begin
        buf_58_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_58_V_d0 = {{in_V_V_TDATA[117:116]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_58_V_d0 = 2'd0;
    end else begin
        buf_58_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_58_fu_3601_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_58_V_we0 = 1'b1;
    end else begin
        buf_58_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_59_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_59_V_address0 = buf_59_V_addr_2_reg_4272;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_59_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_59_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_59_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_59_V_ce0 = 1'b1;
    end else begin
        buf_59_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_59_V_d0 = {{in_V_V_TDATA[119:118]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_59_V_d0 = 2'd0;
    end else begin
        buf_59_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_59_fu_3618_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_59_V_we0 = 1'b1;
    end else begin
        buf_59_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_5_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_5_V_address0 = buf_5_V_addr_2_reg_4002;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_5_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_5_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_5_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_5_V_ce0 = 1'b1;
    end else begin
        buf_5_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_5_V_d0 = {{in_V_V_TDATA[11:10]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_5_V_d0 = 2'd0;
    end else begin
        buf_5_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_5_fu_2700_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_5_V_we0 = 1'b1;
    end else begin
        buf_5_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_60_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_60_V_address0 = buf_60_V_addr_2_reg_4277;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_60_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_60_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_60_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_60_V_ce0 = 1'b1;
    end else begin
        buf_60_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_60_V_d0 = {{in_V_V_TDATA[121:120]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_60_V_d0 = 2'd0;
    end else begin
        buf_60_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_60_fu_3635_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_60_V_we0 = 1'b1;
    end else begin
        buf_60_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_61_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_61_V_address0 = buf_61_V_addr_2_reg_4282;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_61_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_61_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_61_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_61_V_ce0 = 1'b1;
    end else begin
        buf_61_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_61_V_d0 = {{in_V_V_TDATA[123:122]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_61_V_d0 = 2'd0;
    end else begin
        buf_61_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_61_fu_3652_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_61_V_we0 = 1'b1;
    end else begin
        buf_61_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_62_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_62_V_address0 = buf_62_V_addr_2_reg_4287;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_62_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_62_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_62_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_62_V_ce0 = 1'b1;
    end else begin
        buf_62_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_62_V_d0 = {{in_V_V_TDATA[125:124]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_62_V_d0 = 2'd0;
    end else begin
        buf_62_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_62_fu_3669_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_62_V_we0 = 1'b1;
    end else begin
        buf_62_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_63_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_63_V_address0 = buf_63_V_addr_2_reg_4292;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_63_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_63_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_63_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_63_V_ce0 = 1'b1;
    end else begin
        buf_63_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_63_V_d0 = {{in_V_V_TDATA[127:126]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_63_V_d0 = 2'd0;
    end else begin
        buf_63_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_63_fu_3686_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_63_V_we0 = 1'b1;
    end else begin
        buf_63_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_6_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_6_V_address0 = buf_6_V_addr_2_reg_4007;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_6_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_6_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_6_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_6_V_ce0 = 1'b1;
    end else begin
        buf_6_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_6_V_d0 = {{in_V_V_TDATA[13:12]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_6_V_d0 = 2'd0;
    end else begin
        buf_6_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_6_fu_2717_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_6_V_we0 = 1'b1;
    end else begin
        buf_6_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_7_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_7_V_address0 = buf_7_V_addr_2_reg_4012;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_7_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_7_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_7_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_7_V_ce0 = 1'b1;
    end else begin
        buf_7_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_7_V_d0 = {{in_V_V_TDATA[15:14]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_7_V_d0 = 2'd0;
    end else begin
        buf_7_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_7_fu_2734_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_7_V_we0 = 1'b1;
    end else begin
        buf_7_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_8_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_8_V_address0 = buf_8_V_addr_2_reg_4017;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_8_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_8_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_8_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_8_V_ce0 = 1'b1;
    end else begin
        buf_8_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_8_V_d0 = {{in_V_V_TDATA[17:16]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_8_V_d0 = 2'd0;
    end else begin
        buf_8_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_8_fu_2751_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_8_V_we0 = 1'b1;
    end else begin
        buf_8_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7))) begin
        buf_9_V_address0 = zext_ln177_fu_3735_p1;
    end else if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_9_V_address0 = buf_9_V_addr_2_reg_4022;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        buf_9_V_address0 = zext_ln164_fu_2542_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        buf_9_V_address0 = zext_ln148_fu_2404_p1;
    end else begin
        buf_9_V_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state2) | ((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_9_V_ce0 = 1'b1;
    end else begin
        buf_9_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        buf_9_V_d0 = {{in_V_V_TDATA[19:18]}};
    end else if (((1'b1 == ap_CS_fsm_state2) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_9_V_d0 = 2'd0;
    end else begin
        buf_9_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((icmp_ln145_fu_2392_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) | ((icmp_ln895_9_fu_2768_p2 == 1'd1) & (in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5)) | ((icmp_ln172_fu_3723_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state7)))) begin
        buf_9_V_we0 = 1'b1;
    end else begin
        buf_9_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state8)) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state8))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((icmp_ln145_fu_2392_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((icmp_ln152_fu_2472_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((icmp_ln153_fu_2484_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        ap_ST_fsm_state5 : begin
            if (((in_V_V_TVALID == 1'b1) & (1'b1 == ap_CS_fsm_state5))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            if (((icmp_ln172_fu_3723_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state7))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        ap_ST_fsm_state8 : begin
            if (((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state8))) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state8;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln153_fu_2490_p2 = (indvar_flatten141_reg_2335 + 5'd1);

assign add_ln154_1_fu_3710_p2 = (indvar_flatten_reg_2346 + 5'd1);

assign add_ln156_fu_3692_p2 = (kx_0_reg_2369 + 2'd1);

assign and_ln154_fu_2522_p2 = (xor_ln154_fu_2510_p2 & icmp_ln156_fu_2516_p2);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];

assign i_fu_2398_p2 = (i_0_reg_2313 + 3'd1);

assign icmp_ln145_fu_2392_p2 = ((i_0_reg_2313 == 3'd5) ? 1'b1 : 1'b0);

assign icmp_ln152_fu_2472_p2 = ((yp_0_reg_2324 == 3'd5) ? 1'b1 : 1'b0);

assign icmp_ln153_fu_2484_p2 = ((indvar_flatten141_reg_2335 == 5'd20) ? 1'b1 : 1'b0);

assign icmp_ln154_fu_2496_p2 = ((indvar_flatten_reg_2346 == 5'd10) ? 1'b1 : 1'b0);

assign icmp_ln156_fu_2516_p2 = ((kx_0_reg_2369 == 2'd2) ? 1'b1 : 1'b0);

assign icmp_ln172_fu_3723_p2 = ((outpix_0_reg_2381 == 3'd5) ? 1'b1 : 1'b0);

assign icmp_ln895_10_fu_2785_p2 = ((p_Result_2_fu_2774_p4 > buf_10_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_11_fu_2802_p2 = ((p_Result_10_fu_2791_p4 > buf_11_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_12_fu_2819_p2 = ((p_Result_11_fu_2808_p4 > buf_12_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_13_fu_2836_p2 = ((p_Result_12_fu_2825_p4 > buf_13_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_14_fu_2853_p2 = ((p_Result_13_fu_2842_p4 > buf_14_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_15_fu_2870_p2 = ((p_Result_14_fu_2859_p4 > buf_15_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_16_fu_2887_p2 = ((p_Result_15_fu_2876_p4 > buf_16_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_17_fu_2904_p2 = ((p_Result_16_fu_2893_p4 > buf_17_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_18_fu_2921_p2 = ((p_Result_17_fu_2910_p4 > buf_18_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_19_fu_2938_p2 = ((p_Result_18_fu_2927_p4 > buf_19_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_1_fu_2632_p2 = ((p_Result_1_fu_2621_p4 > buf_1_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_20_fu_2955_p2 = ((p_Result_19_fu_2944_p4 > buf_20_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_21_fu_2972_p2 = ((p_Result_20_fu_2961_p4 > buf_21_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_22_fu_2989_p2 = ((p_Result_21_fu_2978_p4 > buf_22_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_23_fu_3006_p2 = ((p_Result_22_fu_2995_p4 > buf_23_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_24_fu_3023_p2 = ((p_Result_23_fu_3012_p4 > buf_24_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_25_fu_3040_p2 = ((p_Result_24_fu_3029_p4 > buf_25_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_26_fu_3057_p2 = ((p_Result_25_fu_3046_p4 > buf_26_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_27_fu_3074_p2 = ((p_Result_26_fu_3063_p4 > buf_27_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_28_fu_3091_p2 = ((p_Result_27_fu_3080_p4 > buf_28_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_29_fu_3108_p2 = ((p_Result_28_fu_3097_p4 > buf_29_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_2_fu_2649_p2 = ((p_Result_s_fu_2638_p4 > buf_2_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_30_fu_3125_p2 = ((p_Result_29_fu_3114_p4 > buf_30_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_31_fu_3142_p2 = ((p_Result_30_fu_3131_p4 > buf_31_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_32_fu_3159_p2 = ((p_Result_31_fu_3148_p4 > buf_32_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_33_fu_3176_p2 = ((p_Result_32_fu_3165_p4 > buf_33_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_34_fu_3193_p2 = ((p_Result_33_fu_3182_p4 > buf_34_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_35_fu_3210_p2 = ((p_Result_34_fu_3199_p4 > buf_35_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_36_fu_3227_p2 = ((p_Result_35_fu_3216_p4 > buf_36_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_37_fu_3244_p2 = ((p_Result_36_fu_3233_p4 > buf_37_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_38_fu_3261_p2 = ((p_Result_37_fu_3250_p4 > buf_38_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_39_fu_3278_p2 = ((p_Result_38_fu_3267_p4 > buf_39_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_3_fu_2666_p2 = ((p_Result_3_fu_2655_p4 > buf_3_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_40_fu_3295_p2 = ((p_Result_39_fu_3284_p4 > buf_40_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_41_fu_3312_p2 = ((p_Result_40_fu_3301_p4 > buf_41_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_42_fu_3329_p2 = ((p_Result_41_fu_3318_p4 > buf_42_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_43_fu_3346_p2 = ((p_Result_42_fu_3335_p4 > buf_43_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_44_fu_3363_p2 = ((p_Result_43_fu_3352_p4 > buf_44_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_45_fu_3380_p2 = ((p_Result_44_fu_3369_p4 > buf_45_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_46_fu_3397_p2 = ((p_Result_45_fu_3386_p4 > buf_46_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_47_fu_3414_p2 = ((p_Result_46_fu_3403_p4 > buf_47_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_48_fu_3431_p2 = ((p_Result_47_fu_3420_p4 > buf_48_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_49_fu_3448_p2 = ((p_Result_48_fu_3437_p4 > buf_49_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_4_fu_2683_p2 = ((p_Result_4_fu_2672_p4 > buf_4_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_50_fu_3465_p2 = ((p_Result_49_fu_3454_p4 > buf_50_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_51_fu_3482_p2 = ((p_Result_50_fu_3471_p4 > buf_51_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_52_fu_3499_p2 = ((p_Result_51_fu_3488_p4 > buf_52_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_53_fu_3516_p2 = ((p_Result_52_fu_3505_p4 > buf_53_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_54_fu_3533_p2 = ((p_Result_53_fu_3522_p4 > buf_54_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_55_fu_3550_p2 = ((p_Result_54_fu_3539_p4 > buf_55_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_56_fu_3567_p2 = ((p_Result_55_fu_3556_p4 > buf_56_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_57_fu_3584_p2 = ((p_Result_56_fu_3573_p4 > buf_57_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_58_fu_3601_p2 = ((p_Result_57_fu_3590_p4 > buf_58_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_59_fu_3618_p2 = ((p_Result_58_fu_3607_p4 > buf_59_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_5_fu_2700_p2 = ((p_Result_5_fu_2689_p4 > buf_5_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_60_fu_3635_p2 = ((p_Result_59_fu_3624_p4 > buf_60_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_61_fu_3652_p2 = ((p_Result_60_fu_3641_p4 > buf_61_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_62_fu_3669_p2 = ((p_Result_61_fu_3658_p4 > buf_62_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_63_fu_3686_p2 = ((p_Result_62_fu_3675_p4 > buf_63_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_6_fu_2717_p2 = ((p_Result_6_fu_2706_p4 > buf_6_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_7_fu_2734_p2 = ((p_Result_7_fu_2723_p4 > buf_7_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_8_fu_2751_p2 = ((p_Result_8_fu_2740_p4 > buf_8_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_9_fu_2768_p2 = ((p_Result_9_fu_2757_p4 > buf_9_V_q0) ? 1'b1 : 1'b0);

assign icmp_ln895_fu_2615_p2 = ((trunc_ln647_fu_2610_p1 > buf_0_V_q0) ? 1'b1 : 1'b0);

assign kx_fu_3702_p3 = ((or_ln156_fu_3698_p2[0:0] === 1'b1) ? 2'd1 : add_ln156_fu_3692_p2);

assign or_ln156_fu_3698_p2 = (icmp_ln154_reg_3961 | and_ln154_reg_3967);

assign out_V_V_TDATA = {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{buf_63_V_q0}, {buf_62_V_q0}}, {buf_61_V_q0}}, {buf_60_V_q0}}, {buf_59_V_q0}}, {buf_58_V_q0}}, {buf_57_V_q0}}, {buf_56_V_q0}}, {buf_55_V_q0}}, {buf_54_V_q0}}, {buf_53_V_q0}}, {buf_52_V_q0}}, {buf_51_V_q0}}, {buf_50_V_q0}}, {buf_49_V_q0}}, {buf_48_V_q0}}, {buf_47_V_q0}}, {buf_46_V_q0}}, {buf_45_V_q0}}, {buf_44_V_q0}}, {buf_43_V_q0}}, {buf_42_V_q0}}, {buf_41_V_q0}}, {buf_40_V_q0}}, {buf_39_V_q0}}, {buf_38_V_q0}}, {buf_37_V_q0}}, {buf_36_V_q0}}, {buf_35_V_q0}}, {buf_34_V_q0}}, {buf_33_V_q0}}, {buf_32_V_q0}}, {buf_31_V_q0}}, {buf_30_V_q0}}, {buf_29_V_q0}}, {buf_28_V_q0}}, {buf_27_V_q0}}, {buf_26_V_q0}}, {buf_25_V_q0}}, {buf_24_V_q0}}, {buf_23_V_q0}}, {buf_22_V_q0}}, {buf_21_V_q0}}, {buf_20_V_q0}}, {buf_19_V_q0}}, {buf_18_V_q0}}, {buf_17_V_q0}}, {buf_16_V_q0}}, {buf_15_V_q0}}, {buf_14_V_q0}}, {buf_13_V_q0}}, {buf_12_V_q0}}, {buf_11_V_q0}}, {buf_10_V_q0}}, {buf_9_V_q0}}, {buf_8_V_q0}}, {buf_7_V_q0}}, {buf_6_V_q0}}, {buf_5_V_q0}}, {buf_4_V_q0}}, {buf_3_V_q0}}, {buf_2_V_q0}}, {buf_1_V_q0}}, {buf_0_V_q0}};

assign outpix_fu_3729_p2 = (outpix_0_reg_2381 + 3'd1);

assign p_Result_10_fu_2791_p4 = {{in_V_V_TDATA[23:22]}};

assign p_Result_11_fu_2808_p4 = {{in_V_V_TDATA[25:24]}};

assign p_Result_12_fu_2825_p4 = {{in_V_V_TDATA[27:26]}};

assign p_Result_13_fu_2842_p4 = {{in_V_V_TDATA[29:28]}};

assign p_Result_14_fu_2859_p4 = {{in_V_V_TDATA[31:30]}};

assign p_Result_15_fu_2876_p4 = {{in_V_V_TDATA[33:32]}};

assign p_Result_16_fu_2893_p4 = {{in_V_V_TDATA[35:34]}};

assign p_Result_17_fu_2910_p4 = {{in_V_V_TDATA[37:36]}};

assign p_Result_18_fu_2927_p4 = {{in_V_V_TDATA[39:38]}};

assign p_Result_19_fu_2944_p4 = {{in_V_V_TDATA[41:40]}};

assign p_Result_1_fu_2621_p4 = {{in_V_V_TDATA[3:2]}};

assign p_Result_20_fu_2961_p4 = {{in_V_V_TDATA[43:42]}};

assign p_Result_21_fu_2978_p4 = {{in_V_V_TDATA[45:44]}};

assign p_Result_22_fu_2995_p4 = {{in_V_V_TDATA[47:46]}};

assign p_Result_23_fu_3012_p4 = {{in_V_V_TDATA[49:48]}};

assign p_Result_24_fu_3029_p4 = {{in_V_V_TDATA[51:50]}};

assign p_Result_25_fu_3046_p4 = {{in_V_V_TDATA[53:52]}};

assign p_Result_26_fu_3063_p4 = {{in_V_V_TDATA[55:54]}};

assign p_Result_27_fu_3080_p4 = {{in_V_V_TDATA[57:56]}};

assign p_Result_28_fu_3097_p4 = {{in_V_V_TDATA[59:58]}};

assign p_Result_29_fu_3114_p4 = {{in_V_V_TDATA[61:60]}};

assign p_Result_2_fu_2774_p4 = {{in_V_V_TDATA[21:20]}};

assign p_Result_30_fu_3131_p4 = {{in_V_V_TDATA[63:62]}};

assign p_Result_31_fu_3148_p4 = {{in_V_V_TDATA[65:64]}};

assign p_Result_32_fu_3165_p4 = {{in_V_V_TDATA[67:66]}};

assign p_Result_33_fu_3182_p4 = {{in_V_V_TDATA[69:68]}};

assign p_Result_34_fu_3199_p4 = {{in_V_V_TDATA[71:70]}};

assign p_Result_35_fu_3216_p4 = {{in_V_V_TDATA[73:72]}};

assign p_Result_36_fu_3233_p4 = {{in_V_V_TDATA[75:74]}};

assign p_Result_37_fu_3250_p4 = {{in_V_V_TDATA[77:76]}};

assign p_Result_38_fu_3267_p4 = {{in_V_V_TDATA[79:78]}};

assign p_Result_39_fu_3284_p4 = {{in_V_V_TDATA[81:80]}};

assign p_Result_3_fu_2655_p4 = {{in_V_V_TDATA[7:6]}};

assign p_Result_40_fu_3301_p4 = {{in_V_V_TDATA[83:82]}};

assign p_Result_41_fu_3318_p4 = {{in_V_V_TDATA[85:84]}};

assign p_Result_42_fu_3335_p4 = {{in_V_V_TDATA[87:86]}};

assign p_Result_43_fu_3352_p4 = {{in_V_V_TDATA[89:88]}};

assign p_Result_44_fu_3369_p4 = {{in_V_V_TDATA[91:90]}};

assign p_Result_45_fu_3386_p4 = {{in_V_V_TDATA[93:92]}};

assign p_Result_46_fu_3403_p4 = {{in_V_V_TDATA[95:94]}};

assign p_Result_47_fu_3420_p4 = {{in_V_V_TDATA[97:96]}};

assign p_Result_48_fu_3437_p4 = {{in_V_V_TDATA[99:98]}};

assign p_Result_49_fu_3454_p4 = {{in_V_V_TDATA[101:100]}};

assign p_Result_4_fu_2672_p4 = {{in_V_V_TDATA[9:8]}};

assign p_Result_50_fu_3471_p4 = {{in_V_V_TDATA[103:102]}};

assign p_Result_51_fu_3488_p4 = {{in_V_V_TDATA[105:104]}};

assign p_Result_52_fu_3505_p4 = {{in_V_V_TDATA[107:106]}};

assign p_Result_53_fu_3522_p4 = {{in_V_V_TDATA[109:108]}};

assign p_Result_54_fu_3539_p4 = {{in_V_V_TDATA[111:110]}};

assign p_Result_55_fu_3556_p4 = {{in_V_V_TDATA[113:112]}};

assign p_Result_56_fu_3573_p4 = {{in_V_V_TDATA[115:114]}};

assign p_Result_57_fu_3590_p4 = {{in_V_V_TDATA[117:116]}};

assign p_Result_58_fu_3607_p4 = {{in_V_V_TDATA[119:118]}};

assign p_Result_59_fu_3624_p4 = {{in_V_V_TDATA[121:120]}};

assign p_Result_5_fu_2689_p4 = {{in_V_V_TDATA[11:10]}};

assign p_Result_60_fu_3641_p4 = {{in_V_V_TDATA[123:122]}};

assign p_Result_61_fu_3658_p4 = {{in_V_V_TDATA[125:124]}};

assign p_Result_62_fu_3675_p4 = {{in_V_V_TDATA[127:126]}};

assign p_Result_6_fu_2706_p4 = {{in_V_V_TDATA[13:12]}};

assign p_Result_7_fu_2723_p4 = {{in_V_V_TDATA[15:14]}};

assign p_Result_8_fu_2740_p4 = {{in_V_V_TDATA[17:16]}};

assign p_Result_9_fu_2757_p4 = {{in_V_V_TDATA[19:18]}};

assign p_Result_s_fu_2638_p4 = {{in_V_V_TDATA[5:4]}};

assign select_ln154_1_fu_3716_p3 = ((icmp_ln154_reg_3961[0:0] === 1'b1) ? 5'd1 : add_ln154_1_fu_3710_p2);

assign select_ln154_fu_2502_p3 = ((icmp_ln154_fu_2496_p2[0:0] === 1'b1) ? 3'd0 : xp_0_reg_2358);

assign select_ln164_fu_2534_p3 = ((and_ln154_fu_2522_p2[0:0] === 1'b1) ? xp_fu_2528_p2 : select_ln154_fu_2502_p3);

assign trunc_ln647_fu_2610_p1 = in_V_V_TDATA[1:0];

assign xor_ln154_fu_2510_p2 = (icmp_ln154_fu_2496_p2 ^ 1'd1);

assign xp_fu_2528_p2 = (3'd1 + select_ln154_fu_2502_p3);

assign yp_fu_2478_p2 = (yp_0_reg_2324 + 3'd1);

assign zext_ln148_fu_2404_p1 = i_0_reg_2313;

assign zext_ln164_fu_2542_p1 = select_ln164_fu_2534_p3;

assign zext_ln177_fu_3735_p1 = outpix_0_reg_2381;

endmodule //StreamingMaxPool_Batch_0_StreamingMaxPool_Pre
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_Matrix_Vector_Activa.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingFCLayer_Batch_1_Matrix_Vector_Activa (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY,
        weights_m_weights_0_V_address0,
        weights_m_weights_0_V_ce0,
        weights_m_weights_0_V_q0,
        weights_m_weights_1_V_address0,
        weights_m_weights_1_V_ce0,
        weights_m_weights_1_V_q0,
        weights_m_weights_2_V_address0,
        weights_m_weights_2_V_ce0,
        weights_m_weights_2_V_q0,
        weights_m_weights_3_V_address0,
        weights_m_weights_3_V_ce0,
        weights_m_weights_3_V_q0
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [39:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [63:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;
output  [8:0] weights_m_weights_0_V_address0;
output   weights_m_weights_0_V_ce0;
input  [35:0] weights_m_weights_0_V_q0;
output  [8:0] weights_m_weights_1_V_address0;
output   weights_m_weights_1_V_ce0;
input  [35:0] weights_m_weights_1_V_q0;
output  [8:0] weights_m_weights_2_V_address0;
output   weights_m_weights_2_V_ce0;
input  [35:0] weights_m_weights_2_V_q0;
output  [8:0] weights_m_weights_3_V_address0;
output   weights_m_weights_3_V_ce0;
input  [35:0] weights_m_weights_3_V_q0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;
reg weights_m_weights_0_V_ce0;
reg weights_m_weights_1_V_ce0;
reg weights_m_weights_2_V_ce0;
reg weights_m_weights_3_V_ce0;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln122_fu_512_p2;
wire   [0:0] icmp_ln125_fu_527_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln160_reg_3920;
reg   [12:0] i_0_reg_415;
reg    ap_predicate_op96_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [12:0] i_fu_518_p2;
wire   [35:0] inElem_V_1_fu_636_p34;
wire   [35:0] inputBuf_0_V_fu_706_p1;
wire   [4:0] trunc_ln321_fu_710_p1;
wire   [0:0] icmp_ln137_fu_880_p2;
reg   [0:0] icmp_ln137_reg_3892;
wire   [0:0] icmp_ln160_fu_906_p2;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [35:0] ap_phi_reg_pp0_iter0_act_m_val_V_reg_426;
reg   [35:0] ap_phi_reg_pp0_iter1_act_m_val_V_reg_426;
wire   [63:0] zext_ln137_fu_886_p1;
reg   [15:0] accu_0_0_V_1_fu_194;
wire   [15:0] accu_0_0_V_fu_1821_p2;
reg   [15:0] accu_0_1_V_1_fu_198;
wire   [15:0] accu_0_1_V_fu_2399_p2;
reg   [15:0] accu_0_2_V_1_fu_202;
wire   [15:0] accu_0_2_V_fu_2977_p2;
reg   [15:0] accu_0_3_V_1_fu_206;
wire   [15:0] accu_0_3_V_fu_3555_p2;
reg   [31:0] tile_assign_fu_210;
wire   [31:0] tile_fu_894_p2;
wire   [31:0] select_ln173_1_fu_945_p3;
reg   [31:0] sf_1_fu_214;
wire   [31:0] sf_fu_900_p2;
reg   [35:0] inputBuf_31_V_fu_218;
reg   [35:0] inputBuf_31_V_1_fu_222;
reg   [35:0] inputBuf_31_V_2_fu_226;
reg   [35:0] inputBuf_31_V_3_fu_230;
reg   [35:0] inputBuf_31_V_4_fu_234;
reg   [35:0] inputBuf_31_V_5_fu_238;
reg   [35:0] inputBuf_31_V_6_fu_242;
reg   [35:0] inputBuf_31_V_7_fu_246;
reg   [35:0] inputBuf_31_V_8_fu_250;
reg   [35:0] inputBuf_31_V_9_fu_254;
reg   [35:0] inputBuf_31_V_10_fu_258;
reg   [35:0] inputBuf_31_V_11_fu_262;
reg   [35:0] inputBuf_31_V_12_fu_266;
reg   [35:0] inputBuf_31_V_13_fu_270;
reg   [35:0] inputBuf_31_V_14_fu_274;
reg   [35:0] inputBuf_31_V_15_fu_278;
reg   [35:0] inputBuf_31_V_16_fu_282;
reg   [35:0] inputBuf_31_V_17_fu_286;
reg   [35:0] inputBuf_31_V_18_fu_290;
reg   [35:0] inputBuf_31_V_19_fu_294;
reg   [35:0] inputBuf_31_V_20_fu_298;
reg   [35:0] inputBuf_31_V_21_fu_302;
reg   [35:0] inputBuf_31_V_22_fu_306;
reg   [35:0] inputBuf_31_V_23_fu_310;
reg   [35:0] inputBuf_31_V_24_fu_314;
reg   [35:0] inputBuf_31_V_25_fu_318;
reg   [35:0] inputBuf_31_V_26_fu_322;
reg   [35:0] inputBuf_31_V_27_fu_326;
reg   [35:0] inputBuf_31_V_28_fu_330;
reg   [35:0] inputBuf_31_V_29_fu_334;
reg   [35:0] inputBuf_31_V_30_fu_338;
reg   [35:0] inputBuf_31_V_31_fu_342;
reg   [31:0] nf_0_fu_346;
wire   [31:0] select_ln173_fu_937_p3;
reg    ap_block_pp0_stage0_01001;
wire   [4:0] inElem_V_1_fu_636_p33;
wire   [31:0] nf_fu_925_p2;
wire   [0:0] icmp_ln173_fu_931_p2;
wire  signed [1:0] wgt_M_instance_0_V_fu_1003_p1;
wire   [1:0] trunc_ln647_fu_1177_p1;
wire   [1:0] mul_ln1352_fu_1189_p0;
wire   [3:0] zext_ln215_fu_1185_p1;
wire  signed [3:0] mul_ln1352_fu_1189_p2;
wire  signed [1:0] wgt_M_instance_1_V_fu_1007_p4;
wire   [1:0] arg_V_read_assign_1_fu_1199_p4;
wire   [1:0] mul_ln1352_1_fu_1217_p0;
wire   [3:0] zext_ln215_1_fu_1213_p1;
wire  signed [3:0] mul_ln1352_1_fu_1217_p2;
wire  signed [1:0] wgt_M_instance_2_V_fu_1017_p4;
wire   [1:0] arg_V_read_assign_2_fu_1227_p4;
wire   [1:0] mul_ln1352_2_fu_1245_p0;
wire   [3:0] zext_ln215_2_fu_1241_p1;
wire  signed [3:0] mul_ln1352_2_fu_1245_p2;
wire  signed [1:0] wgt_M_instance_3_V_fu_1027_p4;
wire   [1:0] arg_V_read_assign_3_fu_1255_p4;
wire   [1:0] mul_ln1352_3_fu_1273_p0;
wire   [3:0] zext_ln215_3_fu_1269_p1;
wire  signed [3:0] mul_ln1352_3_fu_1273_p2;
wire  signed [1:0] wgt_M_instance_4_V_fu_1037_p4;
wire   [1:0] arg_V_read_assign_4_fu_1283_p4;
wire   [1:0] mul_ln1352_4_fu_1301_p0;
wire   [3:0] zext_ln215_4_fu_1297_p1;
wire  signed [3:0] mul_ln1352_4_fu_1301_p2;
wire  signed [1:0] wgt_M_instance_5_V_fu_1047_p4;
wire   [1:0] arg_V_read_assign_5_fu_1311_p4;
wire   [1:0] mul_ln1352_5_fu_1329_p0;
wire   [3:0] zext_ln215_5_fu_1325_p1;
wire  signed [3:0] mul_ln1352_5_fu_1329_p2;
wire  signed [1:0] wgt_M_instance_6_V_fu_1057_p4;
wire   [1:0] arg_V_read_assign_6_fu_1339_p4;
wire   [1:0] mul_ln1352_6_fu_1357_p0;
wire   [3:0] zext_ln215_6_fu_1353_p1;
wire  signed [3:0] mul_ln1352_6_fu_1357_p2;
wire  signed [1:0] wgt_M_instance_7_V_fu_1067_p4;
wire   [1:0] arg_V_read_assign_7_fu_1367_p4;
wire   [1:0] mul_ln1352_7_fu_1385_p0;
wire   [3:0] zext_ln215_7_fu_1381_p1;
wire  signed [3:0] mul_ln1352_7_fu_1385_p2;
wire  signed [1:0] wgt_M_instance_8_V_fu_1077_p4;
wire   [1:0] arg_V_read_assign_8_fu_1395_p4;
wire   [1:0] mul_ln1352_8_fu_1413_p0;
wire   [3:0] zext_ln215_8_fu_1409_p1;
wire  signed [3:0] mul_ln1352_8_fu_1413_p2;
wire  signed [1:0] wgt_M_instance_9_V_fu_1087_p4;
wire   [1:0] arg_V_read_assign_9_fu_1423_p4;
wire   [1:0] mul_ln1352_9_fu_1441_p0;
wire   [3:0] zext_ln215_9_fu_1437_p1;
wire  signed [3:0] mul_ln1352_9_fu_1441_p2;
wire  signed [1:0] wgt_M_instance_10_s_fu_1097_p4;
wire   [1:0] arg_V_read_assign_s_fu_1451_p4;
wire   [1:0] mul_ln1352_10_fu_1469_p0;
wire   [3:0] zext_ln215_10_fu_1465_p1;
wire  signed [3:0] mul_ln1352_10_fu_1469_p2;
wire  signed [1:0] wgt_M_instance_11_s_fu_1107_p4;
wire   [1:0] arg_V_read_assign_10_fu_1479_p4;
wire   [1:0] mul_ln1352_11_fu_1497_p0;
wire   [3:0] zext_ln215_11_fu_1493_p1;
wire  signed [3:0] mul_ln1352_11_fu_1497_p2;
wire  signed [1:0] wgt_M_instance_12_s_fu_1117_p4;
wire   [1:0] arg_V_read_assign_11_fu_1507_p4;
wire   [1:0] mul_ln1352_12_fu_1525_p0;
wire   [3:0] zext_ln215_12_fu_1521_p1;
wire  signed [3:0] mul_ln1352_12_fu_1525_p2;
wire  signed [1:0] wgt_M_instance_13_s_fu_1127_p4;
wire   [1:0] arg_V_read_assign_12_fu_1535_p4;
wire   [1:0] mul_ln1352_13_fu_1553_p0;
wire   [3:0] zext_ln215_13_fu_1549_p1;
wire  signed [3:0] mul_ln1352_13_fu_1553_p2;
wire  signed [1:0] wgt_M_instance_14_s_fu_1137_p4;
wire   [1:0] arg_V_read_assign_13_fu_1563_p4;
wire   [1:0] mul_ln1352_14_fu_1581_p0;
wire   [3:0] zext_ln215_14_fu_1577_p1;
wire  signed [3:0] mul_ln1352_14_fu_1581_p2;
wire  signed [1:0] wgt_M_instance_15_s_fu_1147_p4;
wire   [1:0] arg_V_read_assign_14_fu_1591_p4;
wire   [1:0] mul_ln1352_15_fu_1609_p0;
wire   [3:0] zext_ln215_15_fu_1605_p1;
wire  signed [3:0] mul_ln1352_15_fu_1609_p2;
wire  signed [1:0] wgt_M_instance_16_s_fu_1157_p4;
wire   [1:0] arg_V_read_assign_15_fu_1619_p4;
wire   [1:0] mul_ln1352_16_fu_1637_p0;
wire   [3:0] zext_ln215_16_fu_1633_p1;
wire  signed [3:0] mul_ln1352_16_fu_1637_p2;
wire  signed [1:0] wgt_M_instance_17_s_fu_1167_p4;
wire   [1:0] arg_V_read_assign_16_fu_1647_p4;
wire   [1:0] mul_ln1352_17_fu_1665_p0;
wire   [3:0] zext_ln215_17_fu_1661_p1;
wire  signed [3:0] mul_ln1352_17_fu_1665_p2;
wire  signed [15:0] sext_ln700_fu_1615_p1;
wire   [15:0] select_ln137_3_fu_996_p3;
wire  signed [4:0] sext_ln170_14_fu_1587_p1;
wire  signed [4:0] sext_ln170_15_fu_1643_p1;
wire   [4:0] add_ln700_1_fu_1681_p2;
wire   [15:0] add_ln700_fu_1675_p2;
wire  signed [15:0] sext_ln700_2_fu_1687_p1;
wire  signed [4:0] sext_ln170_12_fu_1531_p1;
wire  signed [4:0] sext_ln170_13_fu_1559_p1;
wire   [4:0] add_ln700_3_fu_1697_p2;
wire  signed [4:0] sext_ln170_11_fu_1503_p1;
wire  signed [4:0] sext_ln170_8_fu_1419_p1;
wire   [4:0] add_ln700_4_fu_1707_p2;
wire  signed [5:0] sext_ln170_9_fu_1447_p1;
wire  signed [5:0] sext_ln700_4_fu_1713_p1;
wire  signed [5:0] sext_ln700_3_fu_1703_p1;
wire   [5:0] add_ln700_5_fu_1717_p2;
wire   [5:0] add_ln700_6_fu_1723_p2;
wire   [15:0] add_ln700_2_fu_1691_p2;
wire  signed [15:0] sext_ln700_5_fu_1729_p1;
wire  signed [4:0] sext_ln170_fu_1195_p1;
wire  signed [4:0] sext_ln170_10_fu_1475_p1;
wire   [4:0] add_ln700_8_fu_1739_p2;
wire  signed [4:0] sext_ln170_4_fu_1307_p1;
wire  signed [4:0] sext_ln170_1_fu_1223_p1;
wire   [4:0] add_ln700_9_fu_1749_p2;
wire  signed [5:0] sext_ln170_2_fu_1251_p1;
wire  signed [5:0] sext_ln700_7_fu_1755_p1;
wire  signed [5:0] sext_ln700_6_fu_1745_p1;
wire   [5:0] add_ln700_10_fu_1759_p2;
wire   [5:0] add_ln700_11_fu_1765_p2;
wire  signed [4:0] sext_ln170_5_fu_1335_p1;
wire  signed [4:0] sext_ln170_3_fu_1279_p1;
wire   [4:0] add_ln700_12_fu_1775_p2;
wire  signed [4:0] sext_ln700_1_fu_1671_p1;
wire  signed [4:0] sext_ln170_6_fu_1363_p1;
wire   [4:0] add_ln700_13_fu_1785_p2;
wire  signed [5:0] sext_ln170_7_fu_1391_p1;
wire  signed [5:0] sext_ln700_10_fu_1791_p1;
wire  signed [5:0] sext_ln700_9_fu_1781_p1;
wire   [5:0] add_ln700_14_fu_1795_p2;
wire   [5:0] add_ln700_15_fu_1801_p2;
wire  signed [6:0] sext_ln700_8_fu_1771_p1;
wire  signed [6:0] sext_ln700_11_fu_1807_p1;
wire   [6:0] add_ln700_16_fu_1811_p2;
wire   [15:0] add_ln700_7_fu_1733_p2;
wire  signed [15:0] sext_ln700_12_fu_1817_p1;
wire  signed [1:0] wgt_M_instance_0_V_1_fu_1827_p1;
wire   [1:0] mul_ln1352_18_fu_2005_p0;
wire  signed [3:0] mul_ln1352_18_fu_2005_p2;
wire  signed [1:0] wgt_M_instance_1_V_1_fu_1831_p4;
wire   [1:0] mul_ln1352_19_fu_2019_p0;
wire  signed [3:0] mul_ln1352_19_fu_2019_p2;
wire  signed [1:0] wgt_M_instance_2_V_1_fu_1841_p4;
wire   [1:0] mul_ln1352_20_fu_2033_p0;
wire  signed [3:0] mul_ln1352_20_fu_2033_p2;
wire  signed [1:0] wgt_M_instance_3_V_1_fu_1851_p4;
wire   [1:0] mul_ln1352_21_fu_2047_p0;
wire  signed [3:0] mul_ln1352_21_fu_2047_p2;
wire  signed [1:0] wgt_M_instance_4_V_1_fu_1861_p4;
wire   [1:0] mul_ln1352_22_fu_2061_p0;
wire  signed [3:0] mul_ln1352_22_fu_2061_p2;
wire  signed [1:0] wgt_M_instance_5_V_1_fu_1871_p4;
wire   [1:0] mul_ln1352_23_fu_2075_p0;
wire  signed [3:0] mul_ln1352_23_fu_2075_p2;
wire  signed [1:0] wgt_M_instance_6_V_1_fu_1881_p4;
wire   [1:0] mul_ln1352_24_fu_2089_p0;
wire  signed [3:0] mul_ln1352_24_fu_2089_p2;
wire  signed [1:0] wgt_M_instance_7_V_1_fu_1891_p4;
wire   [1:0] mul_ln1352_25_fu_2103_p0;
wire  signed [3:0] mul_ln1352_25_fu_2103_p2;
wire  signed [1:0] wgt_M_instance_8_V_1_fu_1901_p4;
wire   [1:0] mul_ln1352_26_fu_2117_p0;
wire  signed [3:0] mul_ln1352_26_fu_2117_p2;
wire  signed [1:0] wgt_M_instance_9_V_1_fu_1911_p4;
wire   [1:0] mul_ln1352_27_fu_2131_p0;
wire  signed [3:0] mul_ln1352_27_fu_2131_p2;
wire  signed [1:0] wgt_M_instance_10_1_fu_1921_p4;
wire   [1:0] mul_ln1352_28_fu_2145_p0;
wire  signed [3:0] mul_ln1352_28_fu_2145_p2;
wire  signed [1:0] wgt_M_instance_11_1_fu_1931_p4;
wire   [1:0] mul_ln1352_29_fu_2159_p0;
wire  signed [3:0] mul_ln1352_29_fu_2159_p2;
wire  signed [1:0] wgt_M_instance_12_1_fu_1941_p4;
wire   [1:0] mul_ln1352_30_fu_2173_p0;
wire  signed [3:0] mul_ln1352_30_fu_2173_p2;
wire  signed [1:0] wgt_M_instance_13_1_fu_1951_p4;
wire   [1:0] mul_ln1352_31_fu_2187_p0;
wire  signed [3:0] mul_ln1352_31_fu_2187_p2;
wire  signed [1:0] wgt_M_instance_14_1_fu_1961_p4;
wire   [1:0] mul_ln1352_32_fu_2201_p0;
wire  signed [3:0] mul_ln1352_32_fu_2201_p2;
wire  signed [1:0] wgt_M_instance_15_1_fu_1971_p4;
wire   [1:0] mul_ln1352_33_fu_2215_p0;
wire  signed [3:0] mul_ln1352_33_fu_2215_p2;
wire  signed [1:0] wgt_M_instance_16_1_fu_1981_p4;
wire   [1:0] mul_ln1352_34_fu_2229_p0;
wire  signed [3:0] mul_ln1352_34_fu_2229_p2;
wire  signed [1:0] wgt_M_instance_17_1_fu_1991_p4;
wire   [1:0] mul_ln1352_35_fu_2243_p0;
wire  signed [3:0] mul_ln1352_35_fu_2243_p2;
wire  signed [15:0] sext_ln700_13_fu_2221_p1;
wire   [15:0] select_ln137_2_fu_989_p3;
wire  signed [4:0] sext_ln170_30_fu_2207_p1;
wire  signed [4:0] sext_ln170_31_fu_2235_p1;
wire   [4:0] add_ln700_19_fu_2259_p2;
wire   [15:0] add_ln700_18_fu_2253_p2;
wire  signed [15:0] sext_ln700_15_fu_2265_p1;
wire  signed [4:0] sext_ln170_28_fu_2179_p1;
wire  signed [4:0] sext_ln170_29_fu_2193_p1;
wire   [4:0] add_ln700_21_fu_2275_p2;
wire  signed [4:0] sext_ln170_27_fu_2165_p1;
wire  signed [4:0] sext_ln170_24_fu_2123_p1;
wire   [4:0] add_ln700_22_fu_2285_p2;
wire  signed [5:0] sext_ln170_25_fu_2137_p1;
wire  signed [5:0] sext_ln700_17_fu_2291_p1;
wire  signed [5:0] sext_ln700_16_fu_2281_p1;
wire   [5:0] add_ln700_23_fu_2295_p2;
wire   [5:0] add_ln700_24_fu_2301_p2;
wire   [15:0] add_ln700_20_fu_2269_p2;
wire  signed [15:0] sext_ln700_18_fu_2307_p1;
wire  signed [4:0] sext_ln170_16_fu_2011_p1;
wire  signed [4:0] sext_ln170_26_fu_2151_p1;
wire   [4:0] add_ln700_26_fu_2317_p2;
wire  signed [4:0] sext_ln170_20_fu_2067_p1;
wire  signed [4:0] sext_ln170_17_fu_2025_p1;
wire   [4:0] add_ln700_27_fu_2327_p2;
wire  signed [5:0] sext_ln170_18_fu_2039_p1;
wire  signed [5:0] sext_ln700_20_fu_2333_p1;
wire  signed [5:0] sext_ln700_19_fu_2323_p1;
wire   [5:0] add_ln700_28_fu_2337_p2;
wire   [5:0] add_ln700_29_fu_2343_p2;
wire  signed [4:0] sext_ln170_21_fu_2081_p1;
wire  signed [4:0] sext_ln170_19_fu_2053_p1;
wire   [4:0] add_ln700_30_fu_2353_p2;
wire  signed [4:0] sext_ln700_14_fu_2249_p1;
wire  signed [4:0] sext_ln170_22_fu_2095_p1;
wire   [4:0] add_ln700_31_fu_2363_p2;
wire  signed [5:0] sext_ln170_23_fu_2109_p1;
wire  signed [5:0] sext_ln700_23_fu_2369_p1;
wire  signed [5:0] sext_ln700_22_fu_2359_p1;
wire   [5:0] add_ln700_32_fu_2373_p2;
wire   [5:0] add_ln700_33_fu_2379_p2;
wire  signed [6:0] sext_ln700_21_fu_2349_p1;
wire  signed [6:0] sext_ln700_24_fu_2385_p1;
wire   [6:0] add_ln700_34_fu_2389_p2;
wire   [15:0] add_ln700_25_fu_2311_p2;
wire  signed [15:0] sext_ln700_25_fu_2395_p1;
wire  signed [1:0] wgt_M_instance_0_V_2_fu_2405_p1;
wire   [1:0] mul_ln1352_36_fu_2583_p0;
wire  signed [3:0] mul_ln1352_36_fu_2583_p2;
wire  signed [1:0] wgt_M_instance_1_V_2_fu_2409_p4;
wire   [1:0] mul_ln1352_37_fu_2597_p0;
wire  signed [3:0] mul_ln1352_37_fu_2597_p2;
wire  signed [1:0] wgt_M_instance_2_V_2_fu_2419_p4;
wire   [1:0] mul_ln1352_38_fu_2611_p0;
wire  signed [3:0] mul_ln1352_38_fu_2611_p2;
wire  signed [1:0] wgt_M_instance_3_V_2_fu_2429_p4;
wire   [1:0] mul_ln1352_39_fu_2625_p0;
wire  signed [3:0] mul_ln1352_39_fu_2625_p2;
wire  signed [1:0] wgt_M_instance_4_V_2_fu_2439_p4;
wire   [1:0] mul_ln1352_40_fu_2639_p0;
wire  signed [3:0] mul_ln1352_40_fu_2639_p2;
wire  signed [1:0] wgt_M_instance_5_V_2_fu_2449_p4;
wire   [1:0] mul_ln1352_41_fu_2653_p0;
wire  signed [3:0] mul_ln1352_41_fu_2653_p2;
wire  signed [1:0] wgt_M_instance_6_V_2_fu_2459_p4;
wire   [1:0] mul_ln1352_42_fu_2667_p0;
wire  signed [3:0] mul_ln1352_42_fu_2667_p2;
wire  signed [1:0] wgt_M_instance_7_V_2_fu_2469_p4;
wire   [1:0] mul_ln1352_43_fu_2681_p0;
wire  signed [3:0] mul_ln1352_43_fu_2681_p2;
wire  signed [1:0] wgt_M_instance_8_V_2_fu_2479_p4;
wire   [1:0] mul_ln1352_44_fu_2695_p0;
wire  signed [3:0] mul_ln1352_44_fu_2695_p2;
wire  signed [1:0] wgt_M_instance_9_V_2_fu_2489_p4;
wire   [1:0] mul_ln1352_45_fu_2709_p0;
wire  signed [3:0] mul_ln1352_45_fu_2709_p2;
wire  signed [1:0] wgt_M_instance_10_2_fu_2499_p4;
wire   [1:0] mul_ln1352_46_fu_2723_p0;
wire  signed [3:0] mul_ln1352_46_fu_2723_p2;
wire  signed [1:0] wgt_M_instance_11_2_fu_2509_p4;
wire   [1:0] mul_ln1352_47_fu_2737_p0;
wire  signed [3:0] mul_ln1352_47_fu_2737_p2;
wire  signed [1:0] wgt_M_instance_12_2_fu_2519_p4;
wire   [1:0] mul_ln1352_48_fu_2751_p0;
wire  signed [3:0] mul_ln1352_48_fu_2751_p2;
wire  signed [1:0] wgt_M_instance_13_2_fu_2529_p4;
wire   [1:0] mul_ln1352_49_fu_2765_p0;
wire  signed [3:0] mul_ln1352_49_fu_2765_p2;
wire  signed [1:0] wgt_M_instance_14_2_fu_2539_p4;
wire   [1:0] mul_ln1352_50_fu_2779_p0;
wire  signed [3:0] mul_ln1352_50_fu_2779_p2;
wire  signed [1:0] wgt_M_instance_15_2_fu_2549_p4;
wire   [1:0] mul_ln1352_51_fu_2793_p0;
wire  signed [3:0] mul_ln1352_51_fu_2793_p2;
wire  signed [1:0] wgt_M_instance_16_2_fu_2559_p4;
wire   [1:0] mul_ln1352_52_fu_2807_p0;
wire  signed [3:0] mul_ln1352_52_fu_2807_p2;
wire  signed [1:0] wgt_M_instance_17_2_fu_2569_p4;
wire   [1:0] mul_ln1352_53_fu_2821_p0;
wire  signed [3:0] mul_ln1352_53_fu_2821_p2;
wire  signed [15:0] sext_ln700_26_fu_2799_p1;
wire   [15:0] select_ln137_1_fu_982_p3;
wire  signed [4:0] sext_ln170_46_fu_2785_p1;
wire  signed [4:0] sext_ln170_47_fu_2813_p1;
wire   [4:0] add_ln700_37_fu_2837_p2;
wire   [15:0] add_ln700_36_fu_2831_p2;
wire  signed [15:0] sext_ln700_28_fu_2843_p1;
wire  signed [4:0] sext_ln170_44_fu_2757_p1;
wire  signed [4:0] sext_ln170_45_fu_2771_p1;
wire   [4:0] add_ln700_39_fu_2853_p2;
wire  signed [4:0] sext_ln170_43_fu_2743_p1;
wire  signed [4:0] sext_ln170_40_fu_2701_p1;
wire   [4:0] add_ln700_40_fu_2863_p2;
wire  signed [5:0] sext_ln170_41_fu_2715_p1;
wire  signed [5:0] sext_ln700_30_fu_2869_p1;
wire  signed [5:0] sext_ln700_29_fu_2859_p1;
wire   [5:0] add_ln700_41_fu_2873_p2;
wire   [5:0] add_ln700_42_fu_2879_p2;
wire   [15:0] add_ln700_38_fu_2847_p2;
wire  signed [15:0] sext_ln700_31_fu_2885_p1;
wire  signed [4:0] sext_ln170_32_fu_2589_p1;
wire  signed [4:0] sext_ln170_42_fu_2729_p1;
wire   [4:0] add_ln700_44_fu_2895_p2;
wire  signed [4:0] sext_ln170_36_fu_2645_p1;
wire  signed [4:0] sext_ln170_33_fu_2603_p1;
wire   [4:0] add_ln700_45_fu_2905_p2;
wire  signed [5:0] sext_ln170_34_fu_2617_p1;
wire  signed [5:0] sext_ln700_33_fu_2911_p1;
wire  signed [5:0] sext_ln700_32_fu_2901_p1;
wire   [5:0] add_ln700_46_fu_2915_p2;
wire   [5:0] add_ln700_47_fu_2921_p2;
wire  signed [4:0] sext_ln170_37_fu_2659_p1;
wire  signed [4:0] sext_ln170_35_fu_2631_p1;
wire   [4:0] add_ln700_48_fu_2931_p2;
wire  signed [4:0] sext_ln700_27_fu_2827_p1;
wire  signed [4:0] sext_ln170_38_fu_2673_p1;
wire   [4:0] add_ln700_49_fu_2941_p2;
wire  signed [5:0] sext_ln170_39_fu_2687_p1;
wire  signed [5:0] sext_ln700_36_fu_2947_p1;
wire  signed [5:0] sext_ln700_35_fu_2937_p1;
wire   [5:0] add_ln700_50_fu_2951_p2;
wire   [5:0] add_ln700_51_fu_2957_p2;
wire  signed [6:0] sext_ln700_34_fu_2927_p1;
wire  signed [6:0] sext_ln700_37_fu_2963_p1;
wire   [6:0] add_ln700_52_fu_2967_p2;
wire   [15:0] add_ln700_43_fu_2889_p2;
wire  signed [15:0] sext_ln700_38_fu_2973_p1;
wire  signed [1:0] wgt_M_instance_0_V_3_fu_2983_p1;
wire   [1:0] mul_ln1352_54_fu_3161_p0;
wire  signed [3:0] mul_ln1352_54_fu_3161_p2;
wire  signed [1:0] wgt_M_instance_1_V_3_fu_2987_p4;
wire   [1:0] mul_ln1352_55_fu_3175_p0;
wire  signed [3:0] mul_ln1352_55_fu_3175_p2;
wire  signed [1:0] wgt_M_instance_2_V_3_fu_2997_p4;
wire   [1:0] mul_ln1352_56_fu_3189_p0;
wire  signed [3:0] mul_ln1352_56_fu_3189_p2;
wire  signed [1:0] wgt_M_instance_3_V_3_fu_3007_p4;
wire   [1:0] mul_ln1352_57_fu_3203_p0;
wire  signed [3:0] mul_ln1352_57_fu_3203_p2;
wire  signed [1:0] wgt_M_instance_4_V_3_fu_3017_p4;
wire   [1:0] mul_ln1352_58_fu_3217_p0;
wire  signed [3:0] mul_ln1352_58_fu_3217_p2;
wire  signed [1:0] wgt_M_instance_5_V_3_fu_3027_p4;
wire   [1:0] mul_ln1352_59_fu_3231_p0;
wire  signed [3:0] mul_ln1352_59_fu_3231_p2;
wire  signed [1:0] wgt_M_instance_6_V_3_fu_3037_p4;
wire   [1:0] mul_ln1352_60_fu_3245_p0;
wire  signed [3:0] mul_ln1352_60_fu_3245_p2;
wire  signed [1:0] wgt_M_instance_7_V_3_fu_3047_p4;
wire   [1:0] mul_ln1352_61_fu_3259_p0;
wire  signed [3:0] mul_ln1352_61_fu_3259_p2;
wire  signed [1:0] wgt_M_instance_8_V_3_fu_3057_p4;
wire   [1:0] mul_ln1352_62_fu_3273_p0;
wire  signed [3:0] mul_ln1352_62_fu_3273_p2;
wire  signed [1:0] wgt_M_instance_9_V_3_fu_3067_p4;
wire   [1:0] mul_ln1352_63_fu_3287_p0;
wire  signed [3:0] mul_ln1352_63_fu_3287_p2;
wire  signed [1:0] wgt_M_instance_10_3_fu_3077_p4;
wire   [1:0] mul_ln1352_64_fu_3301_p0;
wire  signed [3:0] mul_ln1352_64_fu_3301_p2;
wire  signed [1:0] wgt_M_instance_11_3_fu_3087_p4;
wire   [1:0] mul_ln1352_65_fu_3315_p0;
wire  signed [3:0] mul_ln1352_65_fu_3315_p2;
wire  signed [1:0] wgt_M_instance_12_3_fu_3097_p4;
wire   [1:0] mul_ln1352_66_fu_3329_p0;
wire  signed [3:0] mul_ln1352_66_fu_3329_p2;
wire  signed [1:0] wgt_M_instance_13_3_fu_3107_p4;
wire   [1:0] mul_ln1352_67_fu_3343_p0;
wire  signed [3:0] mul_ln1352_67_fu_3343_p2;
wire  signed [1:0] wgt_M_instance_14_3_fu_3117_p4;
wire   [1:0] mul_ln1352_68_fu_3357_p0;
wire  signed [3:0] mul_ln1352_68_fu_3357_p2;
wire  signed [1:0] wgt_M_instance_15_3_fu_3127_p4;
wire   [1:0] mul_ln1352_69_fu_3371_p0;
wire  signed [3:0] mul_ln1352_69_fu_3371_p2;
wire  signed [1:0] wgt_M_instance_16_3_fu_3137_p4;
wire   [1:0] mul_ln1352_70_fu_3385_p0;
wire  signed [3:0] mul_ln1352_70_fu_3385_p2;
wire  signed [1:0] wgt_M_instance_17_3_fu_3147_p4;
wire   [1:0] mul_ln1352_71_fu_3399_p0;
wire  signed [3:0] mul_ln1352_71_fu_3399_p2;
wire  signed [15:0] sext_ln700_39_fu_3377_p1;
wire   [15:0] select_ln137_fu_975_p3;
wire  signed [4:0] sext_ln170_62_fu_3363_p1;
wire  signed [4:0] sext_ln170_63_fu_3391_p1;
wire   [4:0] add_ln700_55_fu_3415_p2;
wire   [15:0] add_ln700_54_fu_3409_p2;
wire  signed [15:0] sext_ln700_41_fu_3421_p1;
wire  signed [4:0] sext_ln170_60_fu_3335_p1;
wire  signed [4:0] sext_ln170_61_fu_3349_p1;
wire   [4:0] add_ln700_57_fu_3431_p2;
wire  signed [4:0] sext_ln170_59_fu_3321_p1;
wire  signed [4:0] sext_ln170_56_fu_3279_p1;
wire   [4:0] add_ln700_58_fu_3441_p2;
wire  signed [5:0] sext_ln170_57_fu_3293_p1;
wire  signed [5:0] sext_ln700_43_fu_3447_p1;
wire  signed [5:0] sext_ln700_42_fu_3437_p1;
wire   [5:0] add_ln700_59_fu_3451_p2;
wire   [5:0] add_ln700_60_fu_3457_p2;
wire   [15:0] add_ln700_56_fu_3425_p2;
wire  signed [15:0] sext_ln700_44_fu_3463_p1;
wire  signed [4:0] sext_ln170_48_fu_3167_p1;
wire  signed [4:0] sext_ln170_58_fu_3307_p1;
wire   [4:0] add_ln700_62_fu_3473_p2;
wire  signed [4:0] sext_ln170_52_fu_3223_p1;
wire  signed [4:0] sext_ln170_49_fu_3181_p1;
wire   [4:0] add_ln700_63_fu_3483_p2;
wire  signed [5:0] sext_ln170_50_fu_3195_p1;
wire  signed [5:0] sext_ln700_46_fu_3489_p1;
wire  signed [5:0] sext_ln700_45_fu_3479_p1;
wire   [5:0] add_ln700_64_fu_3493_p2;
wire   [5:0] add_ln700_65_fu_3499_p2;
wire  signed [4:0] sext_ln170_53_fu_3237_p1;
wire  signed [4:0] sext_ln170_51_fu_3209_p1;
wire   [4:0] add_ln700_66_fu_3509_p2;
wire  signed [4:0] sext_ln700_40_fu_3405_p1;
wire  signed [4:0] sext_ln170_54_fu_3251_p1;
wire   [4:0] add_ln700_67_fu_3519_p2;
wire  signed [5:0] sext_ln170_55_fu_3265_p1;
wire  signed [5:0] sext_ln700_49_fu_3525_p1;
wire  signed [5:0] sext_ln700_48_fu_3515_p1;
wire   [5:0] add_ln700_68_fu_3529_p2;
wire   [5:0] add_ln700_69_fu_3535_p2;
wire  signed [6:0] sext_ln700_47_fu_3505_p1;
wire  signed [6:0] sext_ln700_50_fu_3541_p1;
wire   [6:0] add_ln700_70_fu_3545_p2;
wire   [15:0] add_ln700_61_fu_3467_p2;
wire  signed [15:0] sext_ln700_51_fu_3551_p1;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

StreamingFCLayer_Batch_1_StreamingFCLayer_bkb #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 36 ),
    .din1_WIDTH( 36 ),
    .din2_WIDTH( 36 ),
    .din3_WIDTH( 36 ),
    .din4_WIDTH( 36 ),
    .din5_WIDTH( 36 ),
    .din6_WIDTH( 36 ),
    .din7_WIDTH( 36 ),
    .din8_WIDTH( 36 ),
    .din9_WIDTH( 36 ),
    .din10_WIDTH( 36 ),
    .din11_WIDTH( 36 ),
    .din12_WIDTH( 36 ),
    .din13_WIDTH( 36 ),
    .din14_WIDTH( 36 ),
    .din15_WIDTH( 36 ),
    .din16_WIDTH( 36 ),
    .din17_WIDTH( 36 ),
    .din18_WIDTH( 36 ),
    .din19_WIDTH( 36 ),
    .din20_WIDTH( 36 ),
    .din21_WIDTH( 36 ),
    .din22_WIDTH( 36 ),
    .din23_WIDTH( 36 ),
    .din24_WIDTH( 36 ),
    .din25_WIDTH( 36 ),
    .din26_WIDTH( 36 ),
    .din27_WIDTH( 36 ),
    .din28_WIDTH( 36 ),
    .din29_WIDTH( 36 ),
    .din30_WIDTH( 36 ),
    .din31_WIDTH( 36 ),
    .din32_WIDTH( 5 ),
    .dout_WIDTH( 36 ))
StreamingFCLayer_bkb_U1(
    .din0(inputBuf_31_V_fu_218),
    .din1(inputBuf_31_V_1_fu_222),
    .din2(inputBuf_31_V_2_fu_226),
    .din3(inputBuf_31_V_3_fu_230),
    .din4(inputBuf_31_V_4_fu_234),
    .din5(inputBuf_31_V_5_fu_238),
    .din6(inputBuf_31_V_6_fu_242),
    .din7(inputBuf_31_V_7_fu_246),
    .din8(inputBuf_31_V_8_fu_250),
    .din9(inputBuf_31_V_9_fu_254),
    .din10(inputBuf_31_V_10_fu_258),
    .din11(inputBuf_31_V_11_fu_262),
    .din12(inputBuf_31_V_12_fu_266),
    .din13(inputBuf_31_V_13_fu_270),
    .din14(inputBuf_31_V_14_fu_274),
    .din15(inputBuf_31_V_15_fu_278),
    .din16(inputBuf_31_V_16_fu_282),
    .din17(inputBuf_31_V_17_fu_286),
    .din18(inputBuf_31_V_18_fu_290),
    .din19(inputBuf_31_V_19_fu_294),
    .din20(inputBuf_31_V_20_fu_298),
    .din21(inputBuf_31_V_21_fu_302),
    .din22(inputBuf_31_V_22_fu_306),
    .din23(inputBuf_31_V_23_fu_310),
    .din24(inputBuf_31_V_24_fu_314),
    .din25(inputBuf_31_V_25_fu_318),
    .din26(inputBuf_31_V_26_fu_322),
    .din27(inputBuf_31_V_27_fu_326),
    .din28(inputBuf_31_V_28_fu_330),
    .din29(inputBuf_31_V_29_fu_334),
    .din30(inputBuf_31_V_30_fu_338),
    .din31(inputBuf_31_V_31_fu_342),
    .din32(inElem_V_1_fu_636_p33),
    .dout(inElem_V_1_fu_636_p34)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U2(
    .din0(mul_ln1352_fu_1189_p0),
    .din1(wgt_M_instance_0_V_fu_1003_p1),
    .dout(mul_ln1352_fu_1189_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U3(
    .din0(mul_ln1352_1_fu_1217_p0),
    .din1(wgt_M_instance_1_V_fu_1007_p4),
    .dout(mul_ln1352_1_fu_1217_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U4(
    .din0(mul_ln1352_2_fu_1245_p0),
    .din1(wgt_M_instance_2_V_fu_1017_p4),
    .dout(mul_ln1352_2_fu_1245_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U5(
    .din0(mul_ln1352_3_fu_1273_p0),
    .din1(wgt_M_instance_3_V_fu_1027_p4),
    .dout(mul_ln1352_3_fu_1273_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U6(
    .din0(mul_ln1352_4_fu_1301_p0),
    .din1(wgt_M_instance_4_V_fu_1037_p4),
    .dout(mul_ln1352_4_fu_1301_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U7(
    .din0(mul_ln1352_5_fu_1329_p0),
    .din1(wgt_M_instance_5_V_fu_1047_p4),
    .dout(mul_ln1352_5_fu_1329_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U8(
    .din0(mul_ln1352_6_fu_1357_p0),
    .din1(wgt_M_instance_6_V_fu_1057_p4),
    .dout(mul_ln1352_6_fu_1357_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U9(
    .din0(mul_ln1352_7_fu_1385_p0),
    .din1(wgt_M_instance_7_V_fu_1067_p4),
    .dout(mul_ln1352_7_fu_1385_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U10(
    .din0(mul_ln1352_8_fu_1413_p0),
    .din1(wgt_M_instance_8_V_fu_1077_p4),
    .dout(mul_ln1352_8_fu_1413_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U11(
    .din0(mul_ln1352_9_fu_1441_p0),
    .din1(wgt_M_instance_9_V_fu_1087_p4),
    .dout(mul_ln1352_9_fu_1441_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U12(
    .din0(mul_ln1352_10_fu_1469_p0),
    .din1(wgt_M_instance_10_s_fu_1097_p4),
    .dout(mul_ln1352_10_fu_1469_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U13(
    .din0(mul_ln1352_11_fu_1497_p0),
    .din1(wgt_M_instance_11_s_fu_1107_p4),
    .dout(mul_ln1352_11_fu_1497_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U14(
    .din0(mul_ln1352_12_fu_1525_p0),
    .din1(wgt_M_instance_12_s_fu_1117_p4),
    .dout(mul_ln1352_12_fu_1525_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U15(
    .din0(mul_ln1352_13_fu_1553_p0),
    .din1(wgt_M_instance_13_s_fu_1127_p4),
    .dout(mul_ln1352_13_fu_1553_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U16(
    .din0(mul_ln1352_14_fu_1581_p0),
    .din1(wgt_M_instance_14_s_fu_1137_p4),
    .dout(mul_ln1352_14_fu_1581_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U17(
    .din0(mul_ln1352_15_fu_1609_p0),
    .din1(wgt_M_instance_15_s_fu_1147_p4),
    .dout(mul_ln1352_15_fu_1609_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U18(
    .din0(mul_ln1352_16_fu_1637_p0),
    .din1(wgt_M_instance_16_s_fu_1157_p4),
    .dout(mul_ln1352_16_fu_1637_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U19(
    .din0(mul_ln1352_17_fu_1665_p0),
    .din1(wgt_M_instance_17_s_fu_1167_p4),
    .dout(mul_ln1352_17_fu_1665_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U20(
    .din0(mul_ln1352_18_fu_2005_p0),
    .din1(wgt_M_instance_0_V_1_fu_1827_p1),
    .dout(mul_ln1352_18_fu_2005_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U21(
    .din0(mul_ln1352_19_fu_2019_p0),
    .din1(wgt_M_instance_1_V_1_fu_1831_p4),
    .dout(mul_ln1352_19_fu_2019_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U22(
    .din0(mul_ln1352_20_fu_2033_p0),
    .din1(wgt_M_instance_2_V_1_fu_1841_p4),
    .dout(mul_ln1352_20_fu_2033_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U23(
    .din0(mul_ln1352_21_fu_2047_p0),
    .din1(wgt_M_instance_3_V_1_fu_1851_p4),
    .dout(mul_ln1352_21_fu_2047_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U24(
    .din0(mul_ln1352_22_fu_2061_p0),
    .din1(wgt_M_instance_4_V_1_fu_1861_p4),
    .dout(mul_ln1352_22_fu_2061_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U25(
    .din0(mul_ln1352_23_fu_2075_p0),
    .din1(wgt_M_instance_5_V_1_fu_1871_p4),
    .dout(mul_ln1352_23_fu_2075_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U26(
    .din0(mul_ln1352_24_fu_2089_p0),
    .din1(wgt_M_instance_6_V_1_fu_1881_p4),
    .dout(mul_ln1352_24_fu_2089_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U27(
    .din0(mul_ln1352_25_fu_2103_p0),
    .din1(wgt_M_instance_7_V_1_fu_1891_p4),
    .dout(mul_ln1352_25_fu_2103_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U28(
    .din0(mul_ln1352_26_fu_2117_p0),
    .din1(wgt_M_instance_8_V_1_fu_1901_p4),
    .dout(mul_ln1352_26_fu_2117_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U29(
    .din0(mul_ln1352_27_fu_2131_p0),
    .din1(wgt_M_instance_9_V_1_fu_1911_p4),
    .dout(mul_ln1352_27_fu_2131_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U30(
    .din0(mul_ln1352_28_fu_2145_p0),
    .din1(wgt_M_instance_10_1_fu_1921_p4),
    .dout(mul_ln1352_28_fu_2145_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U31(
    .din0(mul_ln1352_29_fu_2159_p0),
    .din1(wgt_M_instance_11_1_fu_1931_p4),
    .dout(mul_ln1352_29_fu_2159_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U32(
    .din0(mul_ln1352_30_fu_2173_p0),
    .din1(wgt_M_instance_12_1_fu_1941_p4),
    .dout(mul_ln1352_30_fu_2173_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U33(
    .din0(mul_ln1352_31_fu_2187_p0),
    .din1(wgt_M_instance_13_1_fu_1951_p4),
    .dout(mul_ln1352_31_fu_2187_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U34(
    .din0(mul_ln1352_32_fu_2201_p0),
    .din1(wgt_M_instance_14_1_fu_1961_p4),
    .dout(mul_ln1352_32_fu_2201_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U35(
    .din0(mul_ln1352_33_fu_2215_p0),
    .din1(wgt_M_instance_15_1_fu_1971_p4),
    .dout(mul_ln1352_33_fu_2215_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U36(
    .din0(mul_ln1352_34_fu_2229_p0),
    .din1(wgt_M_instance_16_1_fu_1981_p4),
    .dout(mul_ln1352_34_fu_2229_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U37(
    .din0(mul_ln1352_35_fu_2243_p0),
    .din1(wgt_M_instance_17_1_fu_1991_p4),
    .dout(mul_ln1352_35_fu_2243_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U38(
    .din0(mul_ln1352_36_fu_2583_p0),
    .din1(wgt_M_instance_0_V_2_fu_2405_p1),
    .dout(mul_ln1352_36_fu_2583_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U39(
    .din0(mul_ln1352_37_fu_2597_p0),
    .din1(wgt_M_instance_1_V_2_fu_2409_p4),
    .dout(mul_ln1352_37_fu_2597_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U40(
    .din0(mul_ln1352_38_fu_2611_p0),
    .din1(wgt_M_instance_2_V_2_fu_2419_p4),
    .dout(mul_ln1352_38_fu_2611_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U41(
    .din0(mul_ln1352_39_fu_2625_p0),
    .din1(wgt_M_instance_3_V_2_fu_2429_p4),
    .dout(mul_ln1352_39_fu_2625_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U42(
    .din0(mul_ln1352_40_fu_2639_p0),
    .din1(wgt_M_instance_4_V_2_fu_2439_p4),
    .dout(mul_ln1352_40_fu_2639_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U43(
    .din0(mul_ln1352_41_fu_2653_p0),
    .din1(wgt_M_instance_5_V_2_fu_2449_p4),
    .dout(mul_ln1352_41_fu_2653_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U44(
    .din0(mul_ln1352_42_fu_2667_p0),
    .din1(wgt_M_instance_6_V_2_fu_2459_p4),
    .dout(mul_ln1352_42_fu_2667_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U45(
    .din0(mul_ln1352_43_fu_2681_p0),
    .din1(wgt_M_instance_7_V_2_fu_2469_p4),
    .dout(mul_ln1352_43_fu_2681_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U46(
    .din0(mul_ln1352_44_fu_2695_p0),
    .din1(wgt_M_instance_8_V_2_fu_2479_p4),
    .dout(mul_ln1352_44_fu_2695_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U47(
    .din0(mul_ln1352_45_fu_2709_p0),
    .din1(wgt_M_instance_9_V_2_fu_2489_p4),
    .dout(mul_ln1352_45_fu_2709_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U48(
    .din0(mul_ln1352_46_fu_2723_p0),
    .din1(wgt_M_instance_10_2_fu_2499_p4),
    .dout(mul_ln1352_46_fu_2723_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U49(
    .din0(mul_ln1352_47_fu_2737_p0),
    .din1(wgt_M_instance_11_2_fu_2509_p4),
    .dout(mul_ln1352_47_fu_2737_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U50(
    .din0(mul_ln1352_48_fu_2751_p0),
    .din1(wgt_M_instance_12_2_fu_2519_p4),
    .dout(mul_ln1352_48_fu_2751_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U51(
    .din0(mul_ln1352_49_fu_2765_p0),
    .din1(wgt_M_instance_13_2_fu_2529_p4),
    .dout(mul_ln1352_49_fu_2765_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U52(
    .din0(mul_ln1352_50_fu_2779_p0),
    .din1(wgt_M_instance_14_2_fu_2539_p4),
    .dout(mul_ln1352_50_fu_2779_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U53(
    .din0(mul_ln1352_51_fu_2793_p0),
    .din1(wgt_M_instance_15_2_fu_2549_p4),
    .dout(mul_ln1352_51_fu_2793_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U54(
    .din0(mul_ln1352_52_fu_2807_p0),
    .din1(wgt_M_instance_16_2_fu_2559_p4),
    .dout(mul_ln1352_52_fu_2807_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U55(
    .din0(mul_ln1352_53_fu_2821_p0),
    .din1(wgt_M_instance_17_2_fu_2569_p4),
    .dout(mul_ln1352_53_fu_2821_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U56(
    .din0(mul_ln1352_54_fu_3161_p0),
    .din1(wgt_M_instance_0_V_3_fu_2983_p1),
    .dout(mul_ln1352_54_fu_3161_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U57(
    .din0(mul_ln1352_55_fu_3175_p0),
    .din1(wgt_M_instance_1_V_3_fu_2987_p4),
    .dout(mul_ln1352_55_fu_3175_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U58(
    .din0(mul_ln1352_56_fu_3189_p0),
    .din1(wgt_M_instance_2_V_3_fu_2997_p4),
    .dout(mul_ln1352_56_fu_3189_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U59(
    .din0(mul_ln1352_57_fu_3203_p0),
    .din1(wgt_M_instance_3_V_3_fu_3007_p4),
    .dout(mul_ln1352_57_fu_3203_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U60(
    .din0(mul_ln1352_58_fu_3217_p0),
    .din1(wgt_M_instance_4_V_3_fu_3017_p4),
    .dout(mul_ln1352_58_fu_3217_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U61(
    .din0(mul_ln1352_59_fu_3231_p0),
    .din1(wgt_M_instance_5_V_3_fu_3027_p4),
    .dout(mul_ln1352_59_fu_3231_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U62(
    .din0(mul_ln1352_60_fu_3245_p0),
    .din1(wgt_M_instance_6_V_3_fu_3037_p4),
    .dout(mul_ln1352_60_fu_3245_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U63(
    .din0(mul_ln1352_61_fu_3259_p0),
    .din1(wgt_M_instance_7_V_3_fu_3047_p4),
    .dout(mul_ln1352_61_fu_3259_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U64(
    .din0(mul_ln1352_62_fu_3273_p0),
    .din1(wgt_M_instance_8_V_3_fu_3057_p4),
    .dout(mul_ln1352_62_fu_3273_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U65(
    .din0(mul_ln1352_63_fu_3287_p0),
    .din1(wgt_M_instance_9_V_3_fu_3067_p4),
    .dout(mul_ln1352_63_fu_3287_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U66(
    .din0(mul_ln1352_64_fu_3301_p0),
    .din1(wgt_M_instance_10_3_fu_3077_p4),
    .dout(mul_ln1352_64_fu_3301_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U67(
    .din0(mul_ln1352_65_fu_3315_p0),
    .din1(wgt_M_instance_11_3_fu_3087_p4),
    .dout(mul_ln1352_65_fu_3315_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U68(
    .din0(mul_ln1352_66_fu_3329_p0),
    .din1(wgt_M_instance_12_3_fu_3097_p4),
    .dout(mul_ln1352_66_fu_3329_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U69(
    .din0(mul_ln1352_67_fu_3343_p0),
    .din1(wgt_M_instance_13_3_fu_3107_p4),
    .dout(mul_ln1352_67_fu_3343_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U70(
    .din0(mul_ln1352_68_fu_3357_p0),
    .din1(wgt_M_instance_14_3_fu_3117_p4),
    .dout(mul_ln1352_68_fu_3357_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U71(
    .din0(mul_ln1352_69_fu_3371_p0),
    .din1(wgt_M_instance_15_3_fu_3127_p4),
    .dout(mul_ln1352_69_fu_3371_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U72(
    .din0(mul_ln1352_70_fu_3385_p0),
    .din1(wgt_M_instance_16_3_fu_3137_p4),
    .dout(mul_ln1352_70_fu_3385_p2)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_cud #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 2 ),
    .din1_WIDTH( 2 ),
    .dout_WIDTH( 4 ))
StreamingFCLayer_cud_U73(
    .din0(mul_ln1352_71_fu_3399_p0),
    .din1(wgt_M_instance_17_3_fu_3147_p4),
    .dout(mul_ln1352_71_fu_3399_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd0) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_phi_reg_pp0_iter1_act_m_val_V_reg_426 <= inElem_V_1_fu_636_p34;
    end else if ((((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd2) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd3) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd4) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd5) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd6) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd7) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd8) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd9) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd10) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd11) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd12) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd13) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd14) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd15) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd16) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd17) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd18) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd19) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd20) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd21) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd22) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd23) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd24) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd25) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd26) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd27) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd28) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd29) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd30) & (1'b0 == ap_block_pp0_stage0_11001)) | ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd31) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        ap_phi_reg_pp0_iter1_act_m_val_V_reg_426 <= inputBuf_0_V_fu_706_p1;
    end else if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_phi_reg_pp0_iter1_act_m_val_V_reg_426 <= ap_phi_reg_pp0_iter0_act_m_val_V_reg_426;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        i_0_reg_415 <= i_fu_518_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_reg_415 <= 13'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_906_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        nf_0_fu_346 <= select_ln173_fu_937_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        nf_0_fu_346 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_906_p2 == 1'd0) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sf_1_fu_214 <= sf_fu_900_p2;
    end else if ((((icmp_ln160_fu_906_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        sf_1_fu_214 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln160_fu_906_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_210 <= select_ln173_1_fu_945_p3;
    end else if (((icmp_ln160_fu_906_p2 == 1'd0) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tile_assign_fu_210 <= tile_fu_894_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        tile_assign_fu_210 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        accu_0_0_V_1_fu_194 <= accu_0_0_V_fu_1821_p2;
        accu_0_1_V_1_fu_198 <= accu_0_1_V_fu_2399_p2;
        accu_0_2_V_1_fu_202 <= accu_0_2_V_fu_2977_p2;
        accu_0_3_V_1_fu_206 <= accu_0_3_V_fu_3555_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln122_fu_512_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln137_reg_3892 <= icmp_ln137_fu_880_p2;
        icmp_ln160_reg_3920 <= icmp_ln160_fu_906_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd10) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_10_fu_258 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd11) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_11_fu_262 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd12) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_12_fu_266 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd13) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_13_fu_270 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd14) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_14_fu_274 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd15) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_15_fu_278 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd16) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_16_fu_282 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd17) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_17_fu_286 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd18) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_18_fu_290 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd19) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_19_fu_294 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_1_fu_222 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd20) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_20_fu_298 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd21) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_21_fu_302 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd22) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_22_fu_306 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd23) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_23_fu_310 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd24) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_24_fu_314 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd25) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_25_fu_318 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd26) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_26_fu_322 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd27) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_27_fu_326 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd28) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_28_fu_330 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd29) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_29_fu_334 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd2) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_2_fu_226 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd30) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_30_fu_338 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd31) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_31_fu_342 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd3) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_3_fu_230 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd4) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_4_fu_234 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd5) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_5_fu_238 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd6) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_6_fu_242 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd7) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_7_fu_246 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd8) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_8_fu_250 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd9) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_9_fu_254 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln321_fu_710_p1 == 5'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        inputBuf_31_V_fu_218 <= inputBuf_0_V_fu_706_p1;
    end
end

always @ (*) begin
    if ((icmp_ln122_fu_512_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op96_read_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln160_reg_3920 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((icmp_ln160_reg_3920 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_0_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_1_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_1_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_2_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_2_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        weights_m_weights_3_V_ce0 = 1'b1;
    end else begin
        weights_m_weights_3_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln122_fu_512_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln122_fu_512_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign accu_0_0_V_fu_1821_p2 = ($signed(add_ln700_7_fu_1733_p2) + $signed(sext_ln700_12_fu_1817_p1));

assign accu_0_1_V_fu_2399_p2 = ($signed(add_ln700_25_fu_2311_p2) + $signed(sext_ln700_25_fu_2395_p1));

assign accu_0_2_V_fu_2977_p2 = ($signed(add_ln700_43_fu_2889_p2) + $signed(sext_ln700_38_fu_2973_p1));

assign accu_0_3_V_fu_3555_p2 = ($signed(add_ln700_61_fu_3467_p2) + $signed(sext_ln700_51_fu_3551_p1));

assign add_ln700_10_fu_1759_p2 = ($signed(sext_ln170_2_fu_1251_p1) + $signed(sext_ln700_7_fu_1755_p1));

assign add_ln700_11_fu_1765_p2 = ($signed(sext_ln700_6_fu_1745_p1) + $signed(add_ln700_10_fu_1759_p2));

assign add_ln700_12_fu_1775_p2 = ($signed(sext_ln170_5_fu_1335_p1) + $signed(sext_ln170_3_fu_1279_p1));

assign add_ln700_13_fu_1785_p2 = ($signed(sext_ln700_1_fu_1671_p1) + $signed(sext_ln170_6_fu_1363_p1));

assign add_ln700_14_fu_1795_p2 = ($signed(sext_ln170_7_fu_1391_p1) + $signed(sext_ln700_10_fu_1791_p1));

assign add_ln700_15_fu_1801_p2 = ($signed(sext_ln700_9_fu_1781_p1) + $signed(add_ln700_14_fu_1795_p2));

assign add_ln700_16_fu_1811_p2 = ($signed(sext_ln700_8_fu_1771_p1) + $signed(sext_ln700_11_fu_1807_p1));

assign add_ln700_18_fu_2253_p2 = ($signed(sext_ln700_13_fu_2221_p1) + $signed(select_ln137_2_fu_989_p3));

assign add_ln700_19_fu_2259_p2 = ($signed(sext_ln170_30_fu_2207_p1) + $signed(sext_ln170_31_fu_2235_p1));

assign add_ln700_1_fu_1681_p2 = ($signed(sext_ln170_14_fu_1587_p1) + $signed(sext_ln170_15_fu_1643_p1));

assign add_ln700_20_fu_2269_p2 = ($signed(add_ln700_18_fu_2253_p2) + $signed(sext_ln700_15_fu_2265_p1));

assign add_ln700_21_fu_2275_p2 = ($signed(sext_ln170_28_fu_2179_p1) + $signed(sext_ln170_29_fu_2193_p1));

assign add_ln700_22_fu_2285_p2 = ($signed(sext_ln170_27_fu_2165_p1) + $signed(sext_ln170_24_fu_2123_p1));

assign add_ln700_23_fu_2295_p2 = ($signed(sext_ln170_25_fu_2137_p1) + $signed(sext_ln700_17_fu_2291_p1));

assign add_ln700_24_fu_2301_p2 = ($signed(sext_ln700_16_fu_2281_p1) + $signed(add_ln700_23_fu_2295_p2));

assign add_ln700_25_fu_2311_p2 = ($signed(add_ln700_20_fu_2269_p2) + $signed(sext_ln700_18_fu_2307_p1));

assign add_ln700_26_fu_2317_p2 = ($signed(sext_ln170_16_fu_2011_p1) + $signed(sext_ln170_26_fu_2151_p1));

assign add_ln700_27_fu_2327_p2 = ($signed(sext_ln170_20_fu_2067_p1) + $signed(sext_ln170_17_fu_2025_p1));

assign add_ln700_28_fu_2337_p2 = ($signed(sext_ln170_18_fu_2039_p1) + $signed(sext_ln700_20_fu_2333_p1));

assign add_ln700_29_fu_2343_p2 = ($signed(sext_ln700_19_fu_2323_p1) + $signed(add_ln700_28_fu_2337_p2));

assign add_ln700_2_fu_1691_p2 = ($signed(add_ln700_fu_1675_p2) + $signed(sext_ln700_2_fu_1687_p1));

assign add_ln700_30_fu_2353_p2 = ($signed(sext_ln170_21_fu_2081_p1) + $signed(sext_ln170_19_fu_2053_p1));

assign add_ln700_31_fu_2363_p2 = ($signed(sext_ln700_14_fu_2249_p1) + $signed(sext_ln170_22_fu_2095_p1));

assign add_ln700_32_fu_2373_p2 = ($signed(sext_ln170_23_fu_2109_p1) + $signed(sext_ln700_23_fu_2369_p1));

assign add_ln700_33_fu_2379_p2 = ($signed(sext_ln700_22_fu_2359_p1) + $signed(add_ln700_32_fu_2373_p2));

assign add_ln700_34_fu_2389_p2 = ($signed(sext_ln700_21_fu_2349_p1) + $signed(sext_ln700_24_fu_2385_p1));

assign add_ln700_36_fu_2831_p2 = ($signed(sext_ln700_26_fu_2799_p1) + $signed(select_ln137_1_fu_982_p3));

assign add_ln700_37_fu_2837_p2 = ($signed(sext_ln170_46_fu_2785_p1) + $signed(sext_ln170_47_fu_2813_p1));

assign add_ln700_38_fu_2847_p2 = ($signed(add_ln700_36_fu_2831_p2) + $signed(sext_ln700_28_fu_2843_p1));

assign add_ln700_39_fu_2853_p2 = ($signed(sext_ln170_44_fu_2757_p1) + $signed(sext_ln170_45_fu_2771_p1));

assign add_ln700_3_fu_1697_p2 = ($signed(sext_ln170_12_fu_1531_p1) + $signed(sext_ln170_13_fu_1559_p1));

assign add_ln700_40_fu_2863_p2 = ($signed(sext_ln170_43_fu_2743_p1) + $signed(sext_ln170_40_fu_2701_p1));

assign add_ln700_41_fu_2873_p2 = ($signed(sext_ln170_41_fu_2715_p1) + $signed(sext_ln700_30_fu_2869_p1));

assign add_ln700_42_fu_2879_p2 = ($signed(sext_ln700_29_fu_2859_p1) + $signed(add_ln700_41_fu_2873_p2));

assign add_ln700_43_fu_2889_p2 = ($signed(add_ln700_38_fu_2847_p2) + $signed(sext_ln700_31_fu_2885_p1));

assign add_ln700_44_fu_2895_p2 = ($signed(sext_ln170_32_fu_2589_p1) + $signed(sext_ln170_42_fu_2729_p1));

assign add_ln700_45_fu_2905_p2 = ($signed(sext_ln170_36_fu_2645_p1) + $signed(sext_ln170_33_fu_2603_p1));

assign add_ln700_46_fu_2915_p2 = ($signed(sext_ln170_34_fu_2617_p1) + $signed(sext_ln700_33_fu_2911_p1));

assign add_ln700_47_fu_2921_p2 = ($signed(sext_ln700_32_fu_2901_p1) + $signed(add_ln700_46_fu_2915_p2));

assign add_ln700_48_fu_2931_p2 = ($signed(sext_ln170_37_fu_2659_p1) + $signed(sext_ln170_35_fu_2631_p1));

assign add_ln700_49_fu_2941_p2 = ($signed(sext_ln700_27_fu_2827_p1) + $signed(sext_ln170_38_fu_2673_p1));

assign add_ln700_4_fu_1707_p2 = ($signed(sext_ln170_11_fu_1503_p1) + $signed(sext_ln170_8_fu_1419_p1));

assign add_ln700_50_fu_2951_p2 = ($signed(sext_ln170_39_fu_2687_p1) + $signed(sext_ln700_36_fu_2947_p1));

assign add_ln700_51_fu_2957_p2 = ($signed(sext_ln700_35_fu_2937_p1) + $signed(add_ln700_50_fu_2951_p2));

assign add_ln700_52_fu_2967_p2 = ($signed(sext_ln700_34_fu_2927_p1) + $signed(sext_ln700_37_fu_2963_p1));

assign add_ln700_54_fu_3409_p2 = ($signed(sext_ln700_39_fu_3377_p1) + $signed(select_ln137_fu_975_p3));

assign add_ln700_55_fu_3415_p2 = ($signed(sext_ln170_62_fu_3363_p1) + $signed(sext_ln170_63_fu_3391_p1));

assign add_ln700_56_fu_3425_p2 = ($signed(add_ln700_54_fu_3409_p2) + $signed(sext_ln700_41_fu_3421_p1));

assign add_ln700_57_fu_3431_p2 = ($signed(sext_ln170_60_fu_3335_p1) + $signed(sext_ln170_61_fu_3349_p1));

assign add_ln700_58_fu_3441_p2 = ($signed(sext_ln170_59_fu_3321_p1) + $signed(sext_ln170_56_fu_3279_p1));

assign add_ln700_59_fu_3451_p2 = ($signed(sext_ln170_57_fu_3293_p1) + $signed(sext_ln700_43_fu_3447_p1));

assign add_ln700_5_fu_1717_p2 = ($signed(sext_ln170_9_fu_1447_p1) + $signed(sext_ln700_4_fu_1713_p1));

assign add_ln700_60_fu_3457_p2 = ($signed(sext_ln700_42_fu_3437_p1) + $signed(add_ln700_59_fu_3451_p2));

assign add_ln700_61_fu_3467_p2 = ($signed(add_ln700_56_fu_3425_p2) + $signed(sext_ln700_44_fu_3463_p1));

assign add_ln700_62_fu_3473_p2 = ($signed(sext_ln170_48_fu_3167_p1) + $signed(sext_ln170_58_fu_3307_p1));

assign add_ln700_63_fu_3483_p2 = ($signed(sext_ln170_52_fu_3223_p1) + $signed(sext_ln170_49_fu_3181_p1));

assign add_ln700_64_fu_3493_p2 = ($signed(sext_ln170_50_fu_3195_p1) + $signed(sext_ln700_46_fu_3489_p1));

assign add_ln700_65_fu_3499_p2 = ($signed(sext_ln700_45_fu_3479_p1) + $signed(add_ln700_64_fu_3493_p2));

assign add_ln700_66_fu_3509_p2 = ($signed(sext_ln170_53_fu_3237_p1) + $signed(sext_ln170_51_fu_3209_p1));

assign add_ln700_67_fu_3519_p2 = ($signed(sext_ln700_40_fu_3405_p1) + $signed(sext_ln170_54_fu_3251_p1));

assign add_ln700_68_fu_3529_p2 = ($signed(sext_ln170_55_fu_3265_p1) + $signed(sext_ln700_49_fu_3525_p1));

assign add_ln700_69_fu_3535_p2 = ($signed(sext_ln700_48_fu_3515_p1) + $signed(add_ln700_68_fu_3529_p2));

assign add_ln700_6_fu_1723_p2 = ($signed(sext_ln700_3_fu_1703_p1) + $signed(add_ln700_5_fu_1717_p2));

assign add_ln700_70_fu_3545_p2 = ($signed(sext_ln700_47_fu_3505_p1) + $signed(sext_ln700_50_fu_3541_p1));

assign add_ln700_7_fu_1733_p2 = ($signed(add_ln700_2_fu_1691_p2) + $signed(sext_ln700_5_fu_1729_p1));

assign add_ln700_8_fu_1739_p2 = ($signed(sext_ln170_fu_1195_p1) + $signed(sext_ln170_10_fu_1475_p1));

assign add_ln700_9_fu_1749_p2 = ($signed(sext_ln170_4_fu_1307_p1) + $signed(sext_ln170_1_fu_1223_p1));

assign add_ln700_fu_1675_p2 = ($signed(sext_ln700_fu_1615_p1) + $signed(select_ln137_3_fu_996_p3));

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op96_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op96_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (ap_predicate_op96_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((in_V_V_TVALID == 1'b0) & (ap_predicate_op96_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln160_reg_3920 == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_phi_reg_pp0_iter0_act_m_val_V_reg_426 = 'bx;

always @ (*) begin
    ap_predicate_op96_read_state2 = ((icmp_ln125_fu_527_p2 == 1'd1) & (icmp_ln122_fu_512_p2 == 1'd0));
end

assign arg_V_read_assign_10_fu_1479_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[23:22]}};

assign arg_V_read_assign_11_fu_1507_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[25:24]}};

assign arg_V_read_assign_12_fu_1535_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[27:26]}};

assign arg_V_read_assign_13_fu_1563_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[29:28]}};

assign arg_V_read_assign_14_fu_1591_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[31:30]}};

assign arg_V_read_assign_15_fu_1619_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[33:32]}};

assign arg_V_read_assign_16_fu_1647_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[35:34]}};

assign arg_V_read_assign_1_fu_1199_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[3:2]}};

assign arg_V_read_assign_2_fu_1227_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[5:4]}};

assign arg_V_read_assign_3_fu_1255_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[7:6]}};

assign arg_V_read_assign_4_fu_1283_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[9:8]}};

assign arg_V_read_assign_5_fu_1311_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[11:10]}};

assign arg_V_read_assign_6_fu_1339_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[13:12]}};

assign arg_V_read_assign_7_fu_1367_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[15:14]}};

assign arg_V_read_assign_8_fu_1395_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[17:16]}};

assign arg_V_read_assign_9_fu_1423_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[19:18]}};

assign arg_V_read_assign_s_fu_1451_p4 = {{ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[21:20]}};

assign i_fu_518_p2 = (i_0_reg_415 + 13'd1);

assign icmp_ln122_fu_512_p2 = ((i_0_reg_415 == 13'd4608) ? 1'b1 : 1'b0);

assign icmp_ln125_fu_527_p2 = ((nf_0_fu_346 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln137_fu_880_p2 = ((sf_1_fu_214 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln160_fu_906_p2 = ((sf_fu_900_p2 == 32'd32) ? 1'b1 : 1'b0);

assign icmp_ln173_fu_931_p2 = ((nf_fu_925_p2 == 32'd16) ? 1'b1 : 1'b0);

assign inElem_V_1_fu_636_p33 = sf_1_fu_214[4:0];

assign inputBuf_0_V_fu_706_p1 = in_V_V_TDATA[35:0];

assign mul_ln1352_10_fu_1469_p0 = zext_ln215_10_fu_1465_p1;

assign mul_ln1352_11_fu_1497_p0 = zext_ln215_11_fu_1493_p1;

assign mul_ln1352_12_fu_1525_p0 = zext_ln215_12_fu_1521_p1;

assign mul_ln1352_13_fu_1553_p0 = zext_ln215_13_fu_1549_p1;

assign mul_ln1352_14_fu_1581_p0 = zext_ln215_14_fu_1577_p1;

assign mul_ln1352_15_fu_1609_p0 = zext_ln215_15_fu_1605_p1;

assign mul_ln1352_16_fu_1637_p0 = zext_ln215_16_fu_1633_p1;

assign mul_ln1352_17_fu_1665_p0 = zext_ln215_17_fu_1661_p1;

assign mul_ln1352_18_fu_2005_p0 = zext_ln215_fu_1185_p1;

assign mul_ln1352_19_fu_2019_p0 = zext_ln215_1_fu_1213_p1;

assign mul_ln1352_1_fu_1217_p0 = zext_ln215_1_fu_1213_p1;

assign mul_ln1352_20_fu_2033_p0 = zext_ln215_2_fu_1241_p1;

assign mul_ln1352_21_fu_2047_p0 = zext_ln215_3_fu_1269_p1;

assign mul_ln1352_22_fu_2061_p0 = zext_ln215_4_fu_1297_p1;

assign mul_ln1352_23_fu_2075_p0 = zext_ln215_5_fu_1325_p1;

assign mul_ln1352_24_fu_2089_p0 = zext_ln215_6_fu_1353_p1;

assign mul_ln1352_25_fu_2103_p0 = zext_ln215_7_fu_1381_p1;

assign mul_ln1352_26_fu_2117_p0 = zext_ln215_8_fu_1409_p1;

assign mul_ln1352_27_fu_2131_p0 = zext_ln215_9_fu_1437_p1;

assign mul_ln1352_28_fu_2145_p0 = zext_ln215_10_fu_1465_p1;

assign mul_ln1352_29_fu_2159_p0 = zext_ln215_11_fu_1493_p1;

assign mul_ln1352_2_fu_1245_p0 = zext_ln215_2_fu_1241_p1;

assign mul_ln1352_30_fu_2173_p0 = zext_ln215_12_fu_1521_p1;

assign mul_ln1352_31_fu_2187_p0 = zext_ln215_13_fu_1549_p1;

assign mul_ln1352_32_fu_2201_p0 = zext_ln215_14_fu_1577_p1;

assign mul_ln1352_33_fu_2215_p0 = zext_ln215_15_fu_1605_p1;

assign mul_ln1352_34_fu_2229_p0 = zext_ln215_16_fu_1633_p1;

assign mul_ln1352_35_fu_2243_p0 = zext_ln215_17_fu_1661_p1;

assign mul_ln1352_36_fu_2583_p0 = zext_ln215_fu_1185_p1;

assign mul_ln1352_37_fu_2597_p0 = zext_ln215_1_fu_1213_p1;

assign mul_ln1352_38_fu_2611_p0 = zext_ln215_2_fu_1241_p1;

assign mul_ln1352_39_fu_2625_p0 = zext_ln215_3_fu_1269_p1;

assign mul_ln1352_3_fu_1273_p0 = zext_ln215_3_fu_1269_p1;

assign mul_ln1352_40_fu_2639_p0 = zext_ln215_4_fu_1297_p1;

assign mul_ln1352_41_fu_2653_p0 = zext_ln215_5_fu_1325_p1;

assign mul_ln1352_42_fu_2667_p0 = zext_ln215_6_fu_1353_p1;

assign mul_ln1352_43_fu_2681_p0 = zext_ln215_7_fu_1381_p1;

assign mul_ln1352_44_fu_2695_p0 = zext_ln215_8_fu_1409_p1;

assign mul_ln1352_45_fu_2709_p0 = zext_ln215_9_fu_1437_p1;

assign mul_ln1352_46_fu_2723_p0 = zext_ln215_10_fu_1465_p1;

assign mul_ln1352_47_fu_2737_p0 = zext_ln215_11_fu_1493_p1;

assign mul_ln1352_48_fu_2751_p0 = zext_ln215_12_fu_1521_p1;

assign mul_ln1352_49_fu_2765_p0 = zext_ln215_13_fu_1549_p1;

assign mul_ln1352_4_fu_1301_p0 = zext_ln215_4_fu_1297_p1;

assign mul_ln1352_50_fu_2779_p0 = zext_ln215_14_fu_1577_p1;

assign mul_ln1352_51_fu_2793_p0 = zext_ln215_15_fu_1605_p1;

assign mul_ln1352_52_fu_2807_p0 = zext_ln215_16_fu_1633_p1;

assign mul_ln1352_53_fu_2821_p0 = zext_ln215_17_fu_1661_p1;

assign mul_ln1352_54_fu_3161_p0 = zext_ln215_fu_1185_p1;

assign mul_ln1352_55_fu_3175_p0 = zext_ln215_1_fu_1213_p1;

assign mul_ln1352_56_fu_3189_p0 = zext_ln215_2_fu_1241_p1;

assign mul_ln1352_57_fu_3203_p0 = zext_ln215_3_fu_1269_p1;

assign mul_ln1352_58_fu_3217_p0 = zext_ln215_4_fu_1297_p1;

assign mul_ln1352_59_fu_3231_p0 = zext_ln215_5_fu_1325_p1;

assign mul_ln1352_5_fu_1329_p0 = zext_ln215_5_fu_1325_p1;

assign mul_ln1352_60_fu_3245_p0 = zext_ln215_6_fu_1353_p1;

assign mul_ln1352_61_fu_3259_p0 = zext_ln215_7_fu_1381_p1;

assign mul_ln1352_62_fu_3273_p0 = zext_ln215_8_fu_1409_p1;

assign mul_ln1352_63_fu_3287_p0 = zext_ln215_9_fu_1437_p1;

assign mul_ln1352_64_fu_3301_p0 = zext_ln215_10_fu_1465_p1;

assign mul_ln1352_65_fu_3315_p0 = zext_ln215_11_fu_1493_p1;

assign mul_ln1352_66_fu_3329_p0 = zext_ln215_12_fu_1521_p1;

assign mul_ln1352_67_fu_3343_p0 = zext_ln215_13_fu_1549_p1;

assign mul_ln1352_68_fu_3357_p0 = zext_ln215_14_fu_1577_p1;

assign mul_ln1352_69_fu_3371_p0 = zext_ln215_15_fu_1605_p1;

assign mul_ln1352_6_fu_1357_p0 = zext_ln215_6_fu_1353_p1;

assign mul_ln1352_70_fu_3385_p0 = zext_ln215_16_fu_1633_p1;

assign mul_ln1352_71_fu_3399_p0 = zext_ln215_17_fu_1661_p1;

assign mul_ln1352_7_fu_1385_p0 = zext_ln215_7_fu_1381_p1;

assign mul_ln1352_8_fu_1413_p0 = zext_ln215_8_fu_1409_p1;

assign mul_ln1352_9_fu_1441_p0 = zext_ln215_9_fu_1437_p1;

assign mul_ln1352_fu_1189_p0 = zext_ln215_fu_1185_p1;

assign nf_fu_925_p2 = (nf_0_fu_346 + 32'd1);

assign out_V_V_TDATA = {{{{accu_0_3_V_fu_3555_p2}, {accu_0_2_V_fu_2977_p2}}, {accu_0_1_V_fu_2399_p2}}, {accu_0_0_V_fu_1821_p2}};

assign select_ln137_1_fu_982_p3 = ((icmp_ln137_reg_3892[0:0] === 1'b1) ? 16'd0 : accu_0_2_V_1_fu_202);

assign select_ln137_2_fu_989_p3 = ((icmp_ln137_reg_3892[0:0] === 1'b1) ? 16'd0 : accu_0_1_V_1_fu_198);

assign select_ln137_3_fu_996_p3 = ((icmp_ln137_reg_3892[0:0] === 1'b1) ? 16'd0 : accu_0_0_V_1_fu_194);

assign select_ln137_fu_975_p3 = ((icmp_ln137_reg_3892[0:0] === 1'b1) ? 16'd0 : accu_0_3_V_1_fu_206);

assign select_ln173_1_fu_945_p3 = ((icmp_ln173_fu_931_p2[0:0] === 1'b1) ? 32'd0 : tile_fu_894_p2);

assign select_ln173_fu_937_p3 = ((icmp_ln173_fu_931_p2[0:0] === 1'b1) ? 32'd0 : nf_fu_925_p2);

assign sext_ln170_10_fu_1475_p1 = mul_ln1352_10_fu_1469_p2;

assign sext_ln170_11_fu_1503_p1 = mul_ln1352_11_fu_1497_p2;

assign sext_ln170_12_fu_1531_p1 = mul_ln1352_12_fu_1525_p2;

assign sext_ln170_13_fu_1559_p1 = mul_ln1352_13_fu_1553_p2;

assign sext_ln170_14_fu_1587_p1 = mul_ln1352_14_fu_1581_p2;

assign sext_ln170_15_fu_1643_p1 = mul_ln1352_16_fu_1637_p2;

assign sext_ln170_16_fu_2011_p1 = mul_ln1352_18_fu_2005_p2;

assign sext_ln170_17_fu_2025_p1 = mul_ln1352_19_fu_2019_p2;

assign sext_ln170_18_fu_2039_p1 = mul_ln1352_20_fu_2033_p2;

assign sext_ln170_19_fu_2053_p1 = mul_ln1352_21_fu_2047_p2;

assign sext_ln170_1_fu_1223_p1 = mul_ln1352_1_fu_1217_p2;

assign sext_ln170_20_fu_2067_p1 = mul_ln1352_22_fu_2061_p2;

assign sext_ln170_21_fu_2081_p1 = mul_ln1352_23_fu_2075_p2;

assign sext_ln170_22_fu_2095_p1 = mul_ln1352_24_fu_2089_p2;

assign sext_ln170_23_fu_2109_p1 = mul_ln1352_25_fu_2103_p2;

assign sext_ln170_24_fu_2123_p1 = mul_ln1352_26_fu_2117_p2;

assign sext_ln170_25_fu_2137_p1 = mul_ln1352_27_fu_2131_p2;

assign sext_ln170_26_fu_2151_p1 = mul_ln1352_28_fu_2145_p2;

assign sext_ln170_27_fu_2165_p1 = mul_ln1352_29_fu_2159_p2;

assign sext_ln170_28_fu_2179_p1 = mul_ln1352_30_fu_2173_p2;

assign sext_ln170_29_fu_2193_p1 = mul_ln1352_31_fu_2187_p2;

assign sext_ln170_2_fu_1251_p1 = mul_ln1352_2_fu_1245_p2;

assign sext_ln170_30_fu_2207_p1 = mul_ln1352_32_fu_2201_p2;

assign sext_ln170_31_fu_2235_p1 = mul_ln1352_34_fu_2229_p2;

assign sext_ln170_32_fu_2589_p1 = mul_ln1352_36_fu_2583_p2;

assign sext_ln170_33_fu_2603_p1 = mul_ln1352_37_fu_2597_p2;

assign sext_ln170_34_fu_2617_p1 = mul_ln1352_38_fu_2611_p2;

assign sext_ln170_35_fu_2631_p1 = mul_ln1352_39_fu_2625_p2;

assign sext_ln170_36_fu_2645_p1 = mul_ln1352_40_fu_2639_p2;

assign sext_ln170_37_fu_2659_p1 = mul_ln1352_41_fu_2653_p2;

assign sext_ln170_38_fu_2673_p1 = mul_ln1352_42_fu_2667_p2;

assign sext_ln170_39_fu_2687_p1 = mul_ln1352_43_fu_2681_p2;

assign sext_ln170_3_fu_1279_p1 = mul_ln1352_3_fu_1273_p2;

assign sext_ln170_40_fu_2701_p1 = mul_ln1352_44_fu_2695_p2;

assign sext_ln170_41_fu_2715_p1 = mul_ln1352_45_fu_2709_p2;

assign sext_ln170_42_fu_2729_p1 = mul_ln1352_46_fu_2723_p2;

assign sext_ln170_43_fu_2743_p1 = mul_ln1352_47_fu_2737_p2;

assign sext_ln170_44_fu_2757_p1 = mul_ln1352_48_fu_2751_p2;

assign sext_ln170_45_fu_2771_p1 = mul_ln1352_49_fu_2765_p2;

assign sext_ln170_46_fu_2785_p1 = mul_ln1352_50_fu_2779_p2;

assign sext_ln170_47_fu_2813_p1 = mul_ln1352_52_fu_2807_p2;

assign sext_ln170_48_fu_3167_p1 = mul_ln1352_54_fu_3161_p2;

assign sext_ln170_49_fu_3181_p1 = mul_ln1352_55_fu_3175_p2;

assign sext_ln170_4_fu_1307_p1 = mul_ln1352_4_fu_1301_p2;

assign sext_ln170_50_fu_3195_p1 = mul_ln1352_56_fu_3189_p2;

assign sext_ln170_51_fu_3209_p1 = mul_ln1352_57_fu_3203_p2;

assign sext_ln170_52_fu_3223_p1 = mul_ln1352_58_fu_3217_p2;

assign sext_ln170_53_fu_3237_p1 = mul_ln1352_59_fu_3231_p2;

assign sext_ln170_54_fu_3251_p1 = mul_ln1352_60_fu_3245_p2;

assign sext_ln170_55_fu_3265_p1 = mul_ln1352_61_fu_3259_p2;

assign sext_ln170_56_fu_3279_p1 = mul_ln1352_62_fu_3273_p2;

assign sext_ln170_57_fu_3293_p1 = mul_ln1352_63_fu_3287_p2;

assign sext_ln170_58_fu_3307_p1 = mul_ln1352_64_fu_3301_p2;

assign sext_ln170_59_fu_3321_p1 = mul_ln1352_65_fu_3315_p2;

assign sext_ln170_5_fu_1335_p1 = mul_ln1352_5_fu_1329_p2;

assign sext_ln170_60_fu_3335_p1 = mul_ln1352_66_fu_3329_p2;

assign sext_ln170_61_fu_3349_p1 = mul_ln1352_67_fu_3343_p2;

assign sext_ln170_62_fu_3363_p1 = mul_ln1352_68_fu_3357_p2;

assign sext_ln170_63_fu_3391_p1 = mul_ln1352_70_fu_3385_p2;

assign sext_ln170_6_fu_1363_p1 = mul_ln1352_6_fu_1357_p2;

assign sext_ln170_7_fu_1391_p1 = mul_ln1352_7_fu_1385_p2;

assign sext_ln170_8_fu_1419_p1 = mul_ln1352_8_fu_1413_p2;

assign sext_ln170_9_fu_1447_p1 = mul_ln1352_9_fu_1441_p2;

assign sext_ln170_fu_1195_p1 = mul_ln1352_fu_1189_p2;

assign sext_ln700_10_fu_1791_p1 = $signed(add_ln700_13_fu_1785_p2);

assign sext_ln700_11_fu_1807_p1 = $signed(add_ln700_15_fu_1801_p2);

assign sext_ln700_12_fu_1817_p1 = $signed(add_ln700_16_fu_1811_p2);

assign sext_ln700_13_fu_2221_p1 = mul_ln1352_33_fu_2215_p2;

assign sext_ln700_14_fu_2249_p1 = mul_ln1352_35_fu_2243_p2;

assign sext_ln700_15_fu_2265_p1 = $signed(add_ln700_19_fu_2259_p2);

assign sext_ln700_16_fu_2281_p1 = $signed(add_ln700_21_fu_2275_p2);

assign sext_ln700_17_fu_2291_p1 = $signed(add_ln700_22_fu_2285_p2);

assign sext_ln700_18_fu_2307_p1 = $signed(add_ln700_24_fu_2301_p2);

assign sext_ln700_19_fu_2323_p1 = $signed(add_ln700_26_fu_2317_p2);

assign sext_ln700_1_fu_1671_p1 = mul_ln1352_17_fu_1665_p2;

assign sext_ln700_20_fu_2333_p1 = $signed(add_ln700_27_fu_2327_p2);

assign sext_ln700_21_fu_2349_p1 = $signed(add_ln700_29_fu_2343_p2);

assign sext_ln700_22_fu_2359_p1 = $signed(add_ln700_30_fu_2353_p2);

assign sext_ln700_23_fu_2369_p1 = $signed(add_ln700_31_fu_2363_p2);

assign sext_ln700_24_fu_2385_p1 = $signed(add_ln700_33_fu_2379_p2);

assign sext_ln700_25_fu_2395_p1 = $signed(add_ln700_34_fu_2389_p2);

assign sext_ln700_26_fu_2799_p1 = mul_ln1352_51_fu_2793_p2;

assign sext_ln700_27_fu_2827_p1 = mul_ln1352_53_fu_2821_p2;

assign sext_ln700_28_fu_2843_p1 = $signed(add_ln700_37_fu_2837_p2);

assign sext_ln700_29_fu_2859_p1 = $signed(add_ln700_39_fu_2853_p2);

assign sext_ln700_2_fu_1687_p1 = $signed(add_ln700_1_fu_1681_p2);

assign sext_ln700_30_fu_2869_p1 = $signed(add_ln700_40_fu_2863_p2);

assign sext_ln700_31_fu_2885_p1 = $signed(add_ln700_42_fu_2879_p2);

assign sext_ln700_32_fu_2901_p1 = $signed(add_ln700_44_fu_2895_p2);

assign sext_ln700_33_fu_2911_p1 = $signed(add_ln700_45_fu_2905_p2);

assign sext_ln700_34_fu_2927_p1 = $signed(add_ln700_47_fu_2921_p2);

assign sext_ln700_35_fu_2937_p1 = $signed(add_ln700_48_fu_2931_p2);

assign sext_ln700_36_fu_2947_p1 = $signed(add_ln700_49_fu_2941_p2);

assign sext_ln700_37_fu_2963_p1 = $signed(add_ln700_51_fu_2957_p2);

assign sext_ln700_38_fu_2973_p1 = $signed(add_ln700_52_fu_2967_p2);

assign sext_ln700_39_fu_3377_p1 = mul_ln1352_69_fu_3371_p2;

assign sext_ln700_3_fu_1703_p1 = $signed(add_ln700_3_fu_1697_p2);

assign sext_ln700_40_fu_3405_p1 = mul_ln1352_71_fu_3399_p2;

assign sext_ln700_41_fu_3421_p1 = $signed(add_ln700_55_fu_3415_p2);

assign sext_ln700_42_fu_3437_p1 = $signed(add_ln700_57_fu_3431_p2);

assign sext_ln700_43_fu_3447_p1 = $signed(add_ln700_58_fu_3441_p2);

assign sext_ln700_44_fu_3463_p1 = $signed(add_ln700_60_fu_3457_p2);

assign sext_ln700_45_fu_3479_p1 = $signed(add_ln700_62_fu_3473_p2);

assign sext_ln700_46_fu_3489_p1 = $signed(add_ln700_63_fu_3483_p2);

assign sext_ln700_47_fu_3505_p1 = $signed(add_ln700_65_fu_3499_p2);

assign sext_ln700_48_fu_3515_p1 = $signed(add_ln700_66_fu_3509_p2);

assign sext_ln700_49_fu_3525_p1 = $signed(add_ln700_67_fu_3519_p2);

assign sext_ln700_4_fu_1713_p1 = $signed(add_ln700_4_fu_1707_p2);

assign sext_ln700_50_fu_3541_p1 = $signed(add_ln700_69_fu_3535_p2);

assign sext_ln700_51_fu_3551_p1 = $signed(add_ln700_70_fu_3545_p2);

assign sext_ln700_5_fu_1729_p1 = $signed(add_ln700_6_fu_1723_p2);

assign sext_ln700_6_fu_1745_p1 = $signed(add_ln700_8_fu_1739_p2);

assign sext_ln700_7_fu_1755_p1 = $signed(add_ln700_9_fu_1749_p2);

assign sext_ln700_8_fu_1771_p1 = $signed(add_ln700_11_fu_1765_p2);

assign sext_ln700_9_fu_1781_p1 = $signed(add_ln700_12_fu_1775_p2);

assign sext_ln700_fu_1615_p1 = mul_ln1352_15_fu_1609_p2;

assign sf_fu_900_p2 = (32'd1 + sf_1_fu_214);

assign tile_fu_894_p2 = (32'd1 + tile_assign_fu_210);

assign trunc_ln321_fu_710_p1 = sf_1_fu_214[4:0];

assign trunc_ln647_fu_1177_p1 = ap_phi_reg_pp0_iter1_act_m_val_V_reg_426[1:0];

assign weights_m_weights_0_V_address0 = zext_ln137_fu_886_p1;

assign weights_m_weights_1_V_address0 = zext_ln137_fu_886_p1;

assign weights_m_weights_2_V_address0 = zext_ln137_fu_886_p1;

assign weights_m_weights_3_V_address0 = zext_ln137_fu_886_p1;

assign wgt_M_instance_0_V_1_fu_1827_p1 = weights_m_weights_1_V_q0[1:0];

assign wgt_M_instance_0_V_2_fu_2405_p1 = weights_m_weights_2_V_q0[1:0];

assign wgt_M_instance_0_V_3_fu_2983_p1 = weights_m_weights_3_V_q0[1:0];

assign wgt_M_instance_0_V_fu_1003_p1 = weights_m_weights_0_V_q0[1:0];

assign wgt_M_instance_10_1_fu_1921_p4 = {{weights_m_weights_1_V_q0[21:20]}};

assign wgt_M_instance_10_2_fu_2499_p4 = {{weights_m_weights_2_V_q0[21:20]}};

assign wgt_M_instance_10_3_fu_3077_p4 = {{weights_m_weights_3_V_q0[21:20]}};

assign wgt_M_instance_10_s_fu_1097_p4 = {{weights_m_weights_0_V_q0[21:20]}};

assign wgt_M_instance_11_1_fu_1931_p4 = {{weights_m_weights_1_V_q0[23:22]}};

assign wgt_M_instance_11_2_fu_2509_p4 = {{weights_m_weights_2_V_q0[23:22]}};

assign wgt_M_instance_11_3_fu_3087_p4 = {{weights_m_weights_3_V_q0[23:22]}};

assign wgt_M_instance_11_s_fu_1107_p4 = {{weights_m_weights_0_V_q0[23:22]}};

assign wgt_M_instance_12_1_fu_1941_p4 = {{weights_m_weights_1_V_q0[25:24]}};

assign wgt_M_instance_12_2_fu_2519_p4 = {{weights_m_weights_2_V_q0[25:24]}};

assign wgt_M_instance_12_3_fu_3097_p4 = {{weights_m_weights_3_V_q0[25:24]}};

assign wgt_M_instance_12_s_fu_1117_p4 = {{weights_m_weights_0_V_q0[25:24]}};

assign wgt_M_instance_13_1_fu_1951_p4 = {{weights_m_weights_1_V_q0[27:26]}};

assign wgt_M_instance_13_2_fu_2529_p4 = {{weights_m_weights_2_V_q0[27:26]}};

assign wgt_M_instance_13_3_fu_3107_p4 = {{weights_m_weights_3_V_q0[27:26]}};

assign wgt_M_instance_13_s_fu_1127_p4 = {{weights_m_weights_0_V_q0[27:26]}};

assign wgt_M_instance_14_1_fu_1961_p4 = {{weights_m_weights_1_V_q0[29:28]}};

assign wgt_M_instance_14_2_fu_2539_p4 = {{weights_m_weights_2_V_q0[29:28]}};

assign wgt_M_instance_14_3_fu_3117_p4 = {{weights_m_weights_3_V_q0[29:28]}};

assign wgt_M_instance_14_s_fu_1137_p4 = {{weights_m_weights_0_V_q0[29:28]}};

assign wgt_M_instance_15_1_fu_1971_p4 = {{weights_m_weights_1_V_q0[31:30]}};

assign wgt_M_instance_15_2_fu_2549_p4 = {{weights_m_weights_2_V_q0[31:30]}};

assign wgt_M_instance_15_3_fu_3127_p4 = {{weights_m_weights_3_V_q0[31:30]}};

assign wgt_M_instance_15_s_fu_1147_p4 = {{weights_m_weights_0_V_q0[31:30]}};

assign wgt_M_instance_16_1_fu_1981_p4 = {{weights_m_weights_1_V_q0[33:32]}};

assign wgt_M_instance_16_2_fu_2559_p4 = {{weights_m_weights_2_V_q0[33:32]}};

assign wgt_M_instance_16_3_fu_3137_p4 = {{weights_m_weights_3_V_q0[33:32]}};

assign wgt_M_instance_16_s_fu_1157_p4 = {{weights_m_weights_0_V_q0[33:32]}};

assign wgt_M_instance_17_1_fu_1991_p4 = {{weights_m_weights_1_V_q0[35:34]}};

assign wgt_M_instance_17_2_fu_2569_p4 = {{weights_m_weights_2_V_q0[35:34]}};

assign wgt_M_instance_17_3_fu_3147_p4 = {{weights_m_weights_3_V_q0[35:34]}};

assign wgt_M_instance_17_s_fu_1167_p4 = {{weights_m_weights_0_V_q0[35:34]}};

assign wgt_M_instance_1_V_1_fu_1831_p4 = {{weights_m_weights_1_V_q0[3:2]}};

assign wgt_M_instance_1_V_2_fu_2409_p4 = {{weights_m_weights_2_V_q0[3:2]}};

assign wgt_M_instance_1_V_3_fu_2987_p4 = {{weights_m_weights_3_V_q0[3:2]}};

assign wgt_M_instance_1_V_fu_1007_p4 = {{weights_m_weights_0_V_q0[3:2]}};

assign wgt_M_instance_2_V_1_fu_1841_p4 = {{weights_m_weights_1_V_q0[5:4]}};

assign wgt_M_instance_2_V_2_fu_2419_p4 = {{weights_m_weights_2_V_q0[5:4]}};

assign wgt_M_instance_2_V_3_fu_2997_p4 = {{weights_m_weights_3_V_q0[5:4]}};

assign wgt_M_instance_2_V_fu_1017_p4 = {{weights_m_weights_0_V_q0[5:4]}};

assign wgt_M_instance_3_V_1_fu_1851_p4 = {{weights_m_weights_1_V_q0[7:6]}};

assign wgt_M_instance_3_V_2_fu_2429_p4 = {{weights_m_weights_2_V_q0[7:6]}};

assign wgt_M_instance_3_V_3_fu_3007_p4 = {{weights_m_weights_3_V_q0[7:6]}};

assign wgt_M_instance_3_V_fu_1027_p4 = {{weights_m_weights_0_V_q0[7:6]}};

assign wgt_M_instance_4_V_1_fu_1861_p4 = {{weights_m_weights_1_V_q0[9:8]}};

assign wgt_M_instance_4_V_2_fu_2439_p4 = {{weights_m_weights_2_V_q0[9:8]}};

assign wgt_M_instance_4_V_3_fu_3017_p4 = {{weights_m_weights_3_V_q0[9:8]}};

assign wgt_M_instance_4_V_fu_1037_p4 = {{weights_m_weights_0_V_q0[9:8]}};

assign wgt_M_instance_5_V_1_fu_1871_p4 = {{weights_m_weights_1_V_q0[11:10]}};

assign wgt_M_instance_5_V_2_fu_2449_p4 = {{weights_m_weights_2_V_q0[11:10]}};

assign wgt_M_instance_5_V_3_fu_3027_p4 = {{weights_m_weights_3_V_q0[11:10]}};

assign wgt_M_instance_5_V_fu_1047_p4 = {{weights_m_weights_0_V_q0[11:10]}};

assign wgt_M_instance_6_V_1_fu_1881_p4 = {{weights_m_weights_1_V_q0[13:12]}};

assign wgt_M_instance_6_V_2_fu_2459_p4 = {{weights_m_weights_2_V_q0[13:12]}};

assign wgt_M_instance_6_V_3_fu_3037_p4 = {{weights_m_weights_3_V_q0[13:12]}};

assign wgt_M_instance_6_V_fu_1057_p4 = {{weights_m_weights_0_V_q0[13:12]}};

assign wgt_M_instance_7_V_1_fu_1891_p4 = {{weights_m_weights_1_V_q0[15:14]}};

assign wgt_M_instance_7_V_2_fu_2469_p4 = {{weights_m_weights_2_V_q0[15:14]}};

assign wgt_M_instance_7_V_3_fu_3047_p4 = {{weights_m_weights_3_V_q0[15:14]}};

assign wgt_M_instance_7_V_fu_1067_p4 = {{weights_m_weights_0_V_q0[15:14]}};

assign wgt_M_instance_8_V_1_fu_1901_p4 = {{weights_m_weights_1_V_q0[17:16]}};

assign wgt_M_instance_8_V_2_fu_2479_p4 = {{weights_m_weights_2_V_q0[17:16]}};

assign wgt_M_instance_8_V_3_fu_3057_p4 = {{weights_m_weights_3_V_q0[17:16]}};

assign wgt_M_instance_8_V_fu_1077_p4 = {{weights_m_weights_0_V_q0[17:16]}};

assign wgt_M_instance_9_V_1_fu_1911_p4 = {{weights_m_weights_1_V_q0[19:18]}};

assign wgt_M_instance_9_V_2_fu_2489_p4 = {{weights_m_weights_2_V_q0[19:18]}};

assign wgt_M_instance_9_V_3_fu_3067_p4 = {{weights_m_weights_3_V_q0[19:18]}};

assign wgt_M_instance_9_V_fu_1087_p4 = {{weights_m_weights_0_V_q0[19:18]}};

assign zext_ln137_fu_886_p1 = tile_assign_fu_210;

assign zext_ln215_10_fu_1465_p1 = arg_V_read_assign_s_fu_1451_p4;

assign zext_ln215_11_fu_1493_p1 = arg_V_read_assign_10_fu_1479_p4;

assign zext_ln215_12_fu_1521_p1 = arg_V_read_assign_11_fu_1507_p4;

assign zext_ln215_13_fu_1549_p1 = arg_V_read_assign_12_fu_1535_p4;

assign zext_ln215_14_fu_1577_p1 = arg_V_read_assign_13_fu_1563_p4;

assign zext_ln215_15_fu_1605_p1 = arg_V_read_assign_14_fu_1591_p4;

assign zext_ln215_16_fu_1633_p1 = arg_V_read_assign_15_fu_1619_p4;

assign zext_ln215_17_fu_1661_p1 = arg_V_read_assign_16_fu_1647_p4;

assign zext_ln215_1_fu_1213_p1 = arg_V_read_assign_1_fu_1199_p4;

assign zext_ln215_2_fu_1241_p1 = arg_V_read_assign_2_fu_1227_p4;

assign zext_ln215_3_fu_1269_p1 = arg_V_read_assign_3_fu_1255_p4;

assign zext_ln215_4_fu_1297_p1 = arg_V_read_assign_4_fu_1283_p4;

assign zext_ln215_5_fu_1325_p1 = arg_V_read_assign_5_fu_1311_p4;

assign zext_ln215_6_fu_1353_p1 = arg_V_read_assign_6_fu_1339_p4;

assign zext_ln215_7_fu_1381_p1 = arg_V_read_assign_7_fu_1367_p4;

assign zext_ln215_8_fu_1409_p1 = arg_V_read_assign_8_fu_1395_p4;

assign zext_ln215_9_fu_1437_p1 = arg_V_read_assign_9_fu_1423_p4;

assign zext_ln215_fu_1185_p1 = trunc_ln647_fu_1177_p1;

endmodule //StreamingFCLayer_Batch_1_Matrix_Vector_Activa
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_StreamingFCLayer_g8j.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_3_StreamingFCLayer_g8j_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 2;
parameter AWIDTH = 9;
parameter MEM_SIZE = 384;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_3_vpqar3vc/project_StreamingFCLayer_Batch_3/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_3_StreamingFCLayer_g8j_rom.dat", ram);
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
module StreamingFCLayer_Batch_3_StreamingFCLayer_g8j(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd2;
parameter AddressRange = 32'd384;
parameter AddressWidth = 32'd9;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_3_StreamingFCLayer_g8j_rom StreamingFCLayer_Batch_3_StreamingFCLayer_g8j_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 8;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd8;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi_rom StreamingFCLayer_Batch_0_Matrix_Vector_ActfYi_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/68cd/hdl/verilog/StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=5.014500,HLS_SYN_LAT=560,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=505,HLS_SYN_LUT=3636,HLS_VERSION=2020_1}" *)

module StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [127:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [127:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire   [1:0] rep_fu_61_p2;
reg   [1:0] rep_reg_70;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    grp_StreamingMaxPool_Pre_fu_47_ap_start;
wire    grp_StreamingMaxPool_Pre_fu_47_ap_done;
wire    grp_StreamingMaxPool_Pre_fu_47_ap_idle;
wire    grp_StreamingMaxPool_Pre_fu_47_ap_ready;
wire    grp_StreamingMaxPool_Pre_fu_47_in_V_V_TREADY;
wire   [127:0] grp_StreamingMaxPool_Pre_fu_47_out_V_V_TDATA;
wire    grp_StreamingMaxPool_Pre_fu_47_out_V_V_TVALID;
wire    grp_StreamingMaxPool_Pre_fu_47_out_V_V_TREADY;
reg   [1:0] rep_0_i_reg_36;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state3;
reg    grp_StreamingMaxPool_Pre_fu_47_ap_start_reg;
wire   [0:0] icmp_ln212_fu_55_p2;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [127:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
#0 grp_StreamingMaxPool_Pre_fu_47_ap_start_reg = 1'b0;
end

StreamingMaxPool_Batch_0_StreamingMaxPool_Pre grp_StreamingMaxPool_Pre_fu_47(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingMaxPool_Pre_fu_47_ap_start),
    .ap_done(grp_StreamingMaxPool_Pre_fu_47_ap_done),
    .ap_idle(grp_StreamingMaxPool_Pre_fu_47_ap_idle),
    .ap_ready(grp_StreamingMaxPool_Pre_fu_47_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingMaxPool_Pre_fu_47_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingMaxPool_Pre_fu_47_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingMaxPool_Pre_fu_47_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingMaxPool_Pre_fu_47_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 128 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 128 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingMaxPool_Pre_fu_47_out_V_V_TDATA),
    .vld_in(grp_StreamingMaxPool_Pre_fu_47_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingMaxPool_Pre_fu_47_ap_start_reg <= 1'b0;
    end else begin
        if (((icmp_ln212_fu_55_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
            grp_StreamingMaxPool_Pre_fu_47_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingMaxPool_Pre_fu_47_ap_ready == 1'b1)) begin
            grp_StreamingMaxPool_Pre_fu_47_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((grp_StreamingMaxPool_Pre_fu_47_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
        rep_0_i_reg_36 <= rep_reg_70;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        rep_0_i_reg_36 <= 2'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        rep_reg_70 <= rep_fu_61_p2;
    end
end

always @ (*) begin
    if (((in0_V_V_TVALID == 1'b1) & (regslice_both_in0_V_V_U_ack_in == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingMaxPool_Pre_fu_47_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            if (((icmp_ln212_fu_55_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingMaxPool_Pre_fu_47_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingMaxPool_Pre_fu_47_ap_start = grp_StreamingMaxPool_Pre_fu_47_ap_start_reg;

assign grp_StreamingMaxPool_Pre_fu_47_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign icmp_ln212_fu_55_p2 = ((rep_0_i_reg_36 == 2'd2) ? 1'b1 : 1'b0);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

assign rep_fu_61_p2 = (rep_0_i_reg_36 + 2'd1);

endmodule //StreamingMaxPool_Batch_0_StreamingMaxPool_Batch_0
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=11.571500,HLS_SYN_LAT=4613,HLS_SYN_TPT=none,HLS_SYN_MEM=4,HLS_SYN_DSP=0,HLS_SYN_FF=1373,HLS_SYN_LUT=2026,HLS_VERSION=2020_1}" *)

module StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [39:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [63:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire   [35:0] weights_m_weights_0_q0;
wire   [35:0] weights_m_weights_1_q0;
wire   [35:0] weights_m_weights_2_q0;
wire   [35:0] weights_m_weights_3_q0;
wire    grp_Matrix_Vector_Activa_fu_34_ap_start;
wire    grp_Matrix_Vector_Activa_fu_34_ap_done;
wire    grp_Matrix_Vector_Activa_fu_34_ap_idle;
wire    grp_Matrix_Vector_Activa_fu_34_ap_ready;
wire    grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY;
wire   [63:0] grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA;
wire    grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID;
wire    grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY;
wire   [8:0] grp_Matrix_Vector_Activa_fu_34_weights_m_weights_0_V_address0;
wire    grp_Matrix_Vector_Activa_fu_34_weights_m_weights_0_V_ce0;
wire   [8:0] grp_Matrix_Vector_Activa_fu_34_weights_m_weights_1_V_address0;
wire    grp_Matrix_Vector_Activa_fu_34_weights_m_weights_1_V_ce0;
wire   [8:0] grp_Matrix_Vector_Activa_fu_34_weights_m_weights_2_V_address0;
wire    grp_Matrix_Vector_Activa_fu_34_weights_m_weights_2_V_ce0;
wire   [8:0] grp_Matrix_Vector_Activa_fu_34_weights_m_weights_3_V_address0;
wire    grp_Matrix_Vector_Activa_fu_34_weights_m_weights_3_V_ce0;
reg    grp_Matrix_Vector_Activa_fu_34_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [39:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_Matrix_Vector_Activa_fu_34_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingFCLayer_Batch_1_StreamingFCLayer_dEe #(
    .DataWidth( 36 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
weights_m_weights_0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_0_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_0_V_ce0),
    .q0(weights_m_weights_0_q0)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_eOg #(
    .DataWidth( 36 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
weights_m_weights_1_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_1_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_1_V_ce0),
    .q0(weights_m_weights_1_q0)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_fYi #(
    .DataWidth( 36 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
weights_m_weights_2_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_2_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_2_V_ce0),
    .q0(weights_m_weights_2_q0)
);

StreamingFCLayer_Batch_1_StreamingFCLayer_g8j #(
    .DataWidth( 36 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
weights_m_weights_3_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_3_V_address0),
    .ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_3_V_ce0),
    .q0(weights_m_weights_3_q0)
);

StreamingFCLayer_Batch_1_Matrix_Vector_Activa grp_Matrix_Vector_Activa_fu_34(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_Matrix_Vector_Activa_fu_34_ap_start),
    .ap_done(grp_Matrix_Vector_Activa_fu_34_ap_done),
    .ap_idle(grp_Matrix_Vector_Activa_fu_34_ap_idle),
    .ap_ready(grp_Matrix_Vector_Activa_fu_34_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY),
    .out_V_V_TDATA(grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA),
    .out_V_V_TVALID(grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID),
    .out_V_V_TREADY(grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY),
    .weights_m_weights_0_V_address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_0_V_address0),
    .weights_m_weights_0_V_ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_0_V_ce0),
    .weights_m_weights_0_V_q0(weights_m_weights_0_q0),
    .weights_m_weights_1_V_address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_1_V_address0),
    .weights_m_weights_1_V_ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_1_V_ce0),
    .weights_m_weights_1_V_q0(weights_m_weights_1_q0),
    .weights_m_weights_2_V_address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_2_V_address0),
    .weights_m_weights_2_V_ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_2_V_ce0),
    .weights_m_weights_2_V_q0(weights_m_weights_2_q0),
    .weights_m_weights_3_V_address0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_3_V_address0),
    .weights_m_weights_3_V_ce0(grp_Matrix_Vector_Activa_fu_34_weights_m_weights_3_V_ce0),
    .weights_m_weights_3_V_q0(weights_m_weights_3_q0)
);

regslice_both #(
    .DataWidth( 40 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 64 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_Matrix_Vector_Activa_fu_34_out_V_V_TDATA),
    .vld_in(grp_Matrix_Vector_Activa_fu_34_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b1;
        end else if ((grp_Matrix_Vector_Activa_fu_34_ap_ready == 1'b1)) begin
            grp_Matrix_Vector_Activa_fu_34_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_Matrix_Vector_Activa_fu_34_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_Matrix_Vector_Activa_fu_34_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((1'b1 == ap_CS_fsm_state4) & (regslice_both_out_V_V_U_apdone_blk == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_Matrix_Vector_Activa_fu_34_ap_start = grp_Matrix_Vector_Activa_fu_34_ap_start_reg;

assign grp_Matrix_Vector_Activa_fu_34_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingFCLayer_Batch_1_StreamingFCLayer_Batch_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_StreamingFCLayer_ibs.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_StreamingFCLayer_ibs_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 18;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_StreamingFCLayer_ibs_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_StreamingFCLayer_ibs(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd18;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_StreamingFCLayer_ibs_rom StreamingFCLayer_Batch_0_StreamingFCLayer_ibs_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingDataWidthConverter_Batch_5_0/synth/finn_design_StreamingDataWidthConverter_Batch_5_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingDataWidthConverter_Batch_5:1.0
// IP Revision: 2105101203

(* X_CORE_INFO = "StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingDataWidthConverter_Batch_5_0,StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingDataWidthConverter_Batch_5_0,StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingDataWidthConverter_Batch_5,x_ipVersion=1.0,x_ipCoreRevision=2105101203,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingDataWidthConverter_Batch_5_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 2, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [15 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 16, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [127 : 0] out_V_V_TDATA;

  StreamingDataWidthConverter_Batch_5_StreamingDataWidthConverter_Batch_5 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/650e/hdl/verilog/StreamingDataWidthConverter_Batch_3_StreamingDataWidthCo_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module StreamingDataWidthConverter_Batch_3_StreamingDataWidthCo_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [39:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln508_fu_94_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln517_reg_181;
reg   [31:0] r_V_reg_67;
reg   [11:0] t_0_reg_78;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [11:0] t_fu_100_p2;
wire   [35:0] p_Result_s_fu_113_p3;
reg   [35:0] p_Result_s_reg_176;
wire   [0:0] icmp_ln517_fu_127_p2;
wire   [31:0] trunc_ln_fu_148_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg   [31:0] i_1_fu_50;
wire   [31:0] i_fu_121_p2;
reg    ap_block_pp0_stage0_01001;
wire   [3:0] tmp_V_fu_109_p1;
wire   [27:0] tmp_1_fu_138_p4;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_condition_pp0_exit_iter0_state2))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_127_p2 == 1'd0) & (icmp_ln508_fu_94_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_1_fu_50 <= i_fu_121_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_fu_127_p2 == 1'd1) & (icmp_ln508_fu_94_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        i_1_fu_50 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_94_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        r_V_reg_67 <= trunc_ln_fu_148_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        r_V_reg_67 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_94_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        t_0_reg_78 <= t_fu_100_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        t_0_reg_78 <= 12'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_94_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln517_reg_181 <= icmp_ln517_fu_127_p2;
        p_Result_s_reg_176 <= p_Result_s_fu_113_p3;
    end
end

always @ (*) begin
    if ((icmp_ln508_fu_94_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln508_fu_94_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln508_fu_94_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln517_reg_181 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln517_reg_181 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_94_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (icmp_ln508_fu_94_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((icmp_ln508_fu_94_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_94_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((icmp_ln508_fu_94_p2 == 1'd0) & (in_V_V_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = ((icmp_ln508_fu_94_p2 == 1'd0) & (in_V_V_TVALID == 1'b0));
end

always @ (*) begin
    ap_block_state3_io = ((icmp_ln517_reg_181 == 1'd1) & (out_V_V_TREADY == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign i_fu_121_p2 = (32'd1 + i_1_fu_50);

assign icmp_ln508_fu_94_p2 = ((t_0_reg_78 == 12'd2592) ? 1'b1 : 1'b0);

assign icmp_ln517_fu_127_p2 = ((i_fu_121_p2 == 32'd9) ? 1'b1 : 1'b0);

assign out_V_V_TDATA = p_Result_s_reg_176;

assign p_Result_s_fu_113_p3 = {{tmp_V_fu_109_p1}, {r_V_reg_67}};

assign t_fu_100_p2 = (t_0_reg_78 + 12'd1);

assign tmp_1_fu_138_p4 = {{r_V_reg_67[31:4]}};

assign tmp_V_fu_109_p1 = in_V_V_TDATA[3:0];

assign trunc_ln_fu_148_p3 = {{tmp_V_fu_109_p1}, {tmp_1_fu_138_p4}};

endmodule //StreamingDataWidthConverter_Batch_3_StreamingDataWidthCo_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_StreamingFCLayer_hbi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

(* use_dsp = "no" *) module StreamingFCLayer_Batch_0_StreamingFCLayer_hbi_Mul_LUT_0(a, b, p);
input[8 - 1 : 0] a; 
input[2 - 1 : 0] b; 
output[10 - 1 : 0] p;

assign p = $signed({1'b0, a}) * $signed(b);
endmodule
`timescale 1 ns / 1 ps
module StreamingFCLayer_Batch_0_StreamingFCLayer_hbi(
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



StreamingFCLayer_Batch_0_StreamingFCLayer_hbi_Mul_LUT_0 StreamingFCLayer_Batch_0_StreamingFCLayer_hbi_Mul_LUT_0_U(
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/650e/hdl/verilog/StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.331000,HLS_SYN_LAT=2597,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=123,HLS_SYN_LUT=248,HLS_VERSION=2020_1}" *)

module StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [7:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [39:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_start;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_done;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_idle;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_ready;
wire    grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
wire   [39:0] grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY;
reg    grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [7:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_StreamingDataWidthCo_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingDataWidthConverter_Batch_3_StreamingDataWidthCo_1 grp_StreamingDataWidthCo_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingDataWidthCo_1_fu_26_ap_start),
    .ap_done(grp_StreamingDataWidthCo_1_fu_26_ap_done),
    .ap_idle(grp_StreamingDataWidthCo_1_fu_26_ap_idle),
    .ap_ready(grp_StreamingDataWidthCo_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 40 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingDataWidthCo_1_fu_26_ap_ready == 1'b1)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingDataWidthCo_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingDataWidthCo_1_fu_26_ap_start = grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;

assign grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingDataWidthConverter_Batch_3_StreamingDataWidthConverter_Batch_3
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/0d80/hdl/verilog/StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.962000,HLS_SYN_LAT=581,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=166,HLS_SYN_LUT=326,HLS_VERSION=2020_1}" *)

module StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [63:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [15:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_start;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_done;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_idle;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_ready;
wire    grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
wire   [15:0] grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY;
reg    grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [63:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_StreamingDataWidthCo_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingDataWidthConverter_Batch_4_StreamingDataWidthCo_1 grp_StreamingDataWidthCo_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingDataWidthCo_1_fu_26_ap_start),
    .ap_done(grp_StreamingDataWidthCo_1_fu_26_ap_done),
    .ap_idle(grp_StreamingDataWidthCo_1_fu_26_ap_idle),
    .ap_ready(grp_StreamingDataWidthCo_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 64 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 16 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingDataWidthCo_1_fu_26_ap_ready == 1'b1)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingDataWidthCo_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingDataWidthCo_1_fu_26_ap_start = grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;

assign grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingDataWidthConverter_Batch_4_StreamingDataWidthConverter_Batch_4
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingDataWidthConverter_Batch_1_0/synth/finn_design_StreamingDataWidthConverter_Batch_1_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingDataWidthConverter_Batch_1:1.0
// IP Revision: 2105101210

(* X_CORE_INFO = "StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingDataWidthConverter_Batch_1_0,StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingDataWidthConverter_Batch_1_0,StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingDataWidthConverter_Batch_1,x_ipVersion=1.0,x_ipCoreRevision=2105101210,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingDataWidthConverter_Batch_1_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 16, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [127 : 0] out_V_V_TDATA;

  StreamingDataWidthConverter_Batch_1_StreamingDataWidthConverter_Batch_1 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/c5b2/Q_srl.v

// original source:
// https://github.com/nachiket/tdfc/blob/master/verilog/queues/Q_srl_oreg3_prefull_SIMPLE.v


// Copyright (c) 1999 The Regents of the University of California
// Copyright (c) 2010 The Regents of the University of Pennsylvania
// Copyright (c) 2011 Department of Electrical and Electronic Engineering, Imperial College London
// Copyright (c) 2020 Xilinx
//
// Permission to use, copy, modify, and distribute this software and
// its documentation for any purpose, without fee, and without a
// written agreement is hereby granted, provided that the above copyright
// notice and this paragraph and the following two paragraphs appear in
// all copies.
//
// IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
// DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
// LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
// EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF
// SUCH DAMAGE.
//
// THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
// AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON
// AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO
// PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
//

// Q_srl_oreg3_prefull_SIMPLE.v
//
//  - In-page queue with parameterizable depth, bit width
//  - Stream I/O is triple (data, valid, back-pressure),
//      with EOS concatenated into the data
//  - Flow control for input & output is combinationally decoupled
//  - 2 <= depth <= 256
//      * (depth >= 2)  is required to decouple I/O flow control,
//          where empty => no produce,  full => no consume,
//          and depth 1 would ping-pong between the two at half rate
//      * (depth <= 256) can be modified
//           by changing ''synthesis loop_limit X'' below
//          and changing ''addrwidth'' or its log computation
//  - 1 <= width
//  - Queue storage is in SRL16E, up to depth 16 per LUT per bit-slice,
//      plus output register (for fast output)
//  - Queue addressing is done by ''addr'' up-down counter
//  - Queue fullness is checked by comparator (addr==depth)
//  - Queue fullness                           is pre-computed for next cycle
//  - Queue input back-pressure                is pre-computed for next cycle
//  - Queue output valid (state!=state__empty) is pre-computed for next cycle
//      (necessary since SRL data output reg requires non-boolean state)
//  - FSM has 3 states (empty, one, more)
//  - When empty, continue to emit most recently emitted value (for debugging)
//
//  - Queue slots used      = / (state==state_empty) ? 0
//                            | (state==state_one)   ? 1
//                            \ (state==state_more)  ? addr+2
//  - Queue slots used     <=  depth
//  - Queue slots remaining =  depth - used
//                          = / (state==state_empty) ? depth
//                            | (state==state_one)   ? depth-1
//                            \ (state==state_more)  ? depth-2-addr
//
//  - Synplify 7.1 / 8.0
//  - Eylon Caspi,  9/11/03, 8/18/04, 3/29/05


`ifdef  Q_srl
`else
`define Q_srl


module Q_srl (clock, reset, i_d, i_v, i_r, o_d, o_v, o_r, count);

   parameter depth = 16;   // - greatest #items in queue  (2 <= depth <= 256)
   parameter width = 16;   // - width of data (i_d, o_d)

   parameter addrwidth = $clog2(depth);

   input     clock;
   input     reset;

   input  [width-1:0] i_d;	// - input  stream data (concat data + eos)
   input              i_v;	// - input  stream valid
   output             i_r;	// - input  stream ready
   wire               i_b;  // - input  stream back-pressure

   output [width-1:0] o_d;	// - output stream data (concat data + eos)
   output             o_v;	// - output stream valid
   input              o_r;	// - output stream ready
   wire               o_b;	// - output stream back-pressure

   output [addrwidth:0] count;  // - output number of elems in queue

   reg    [addrwidth-1:0] addr, addr_, a_;		// - SRL16 address
							//     for data output
   reg 			  shift_en_;			// - SRL16 shift enable
   reg    [width-1:0] 	  srl [depth-2:0];		// - SRL16 memory
   reg 			  shift_en_o_;			// - SRLO  shift enable
   reg    [width-1:0] 	  srlo_, srlo			// - SRLO  output reg
			  /* synthesis syn_allow_retiming=0 */ ;

   parameter state_empty = 2'd0;    // - state empty : o_v=0 o_d=UNDEFINED
   parameter state_one   = 2'd1;    // - state one   : o_v=1 o_d=srlo
   parameter state_more  = 2'd2;    // - state more  : o_v=1 o_d=srlo
				    //     #items in srl = addr+2

   reg [1:0] state, state_;	    // - state register

   wire      addr_full_;	    // - true iff addr==depth-2 on NEXT cycle
   reg       addr_full; 	    // - true iff addr==depth-2
   wire      addr_zero_;	    // - true iff addr==0
   wire      o_v_reg_;		    // - true iff state_empty   on NEXT cycle
   reg       o_v_reg  		    // - true iff state_empty
	     /* synthesis syn_allow_retiming=0 */ ;
   wire      i_b_reg_;		    // - true iff !full         on NEXT cycle
   reg       i_b_reg  		    // - true iff !full
	     /* synthesis syn_allow_retiming=0 */ ;

   assign addr_full_ = (state_==state_more) && (addr_==depth-2);
						// - queue full
   assign addr_zero_ = (addr==0);		// - queue contains 2 (or 1,0)
   assign o_v_reg_   = (state_!=state_empty);	// - output valid if non-empty
   assign i_b_reg_   = addr_full_;		// - input bp if full
   assign o_d = srlo;				// - output data from queue
   assign o_v = o_v_reg;			// - output valid if non-empty
   assign i_b = i_b_reg;			// - input bp if full

   assign i_r = !i_b;
   assign o_b = !o_r;

   assign count = (state==state_more ? addr+2 : (state==state_one ? 1 : 0));

   // - ''always'' block with both FFs and SRL16 does not work,
   //      since FFs need reset but SRL16 does not

   always @(posedge clock) begin	// - seq always: FFs
      if (reset) begin
	 state     <= state_empty;
	 addr      <= 0;
         addr_full <= 0;
	 o_v_reg   <= 0;
	 i_b_reg   <= 1;
      end
      else begin
	 state     <= state_;
	 addr      <= addr_;
         addr_full <= addr_full_;
	 o_v_reg   <= o_v_reg_;
	 i_b_reg   <= i_b_reg_;
      end
   end // always @ (posedge clock)

   always @(posedge clock) begin	// - seq always: srlo
      // - infer enabled output reg at end of shift chain
      // - input first element from i_d, all subsequent elements from SRL16
      if (reset) begin
	 srlo <= 0;
      end
      else begin
	 if (shift_en_o_) begin
	    srlo <= srlo_;
	 end
      end
   end // always @ (posedge clock)

   always @(posedge clock) begin			// - seq always: srl
      // - infer enabled SRL16E from shifting srl array
      // - no reset capability;  srl[] contents undefined on reset
      if (shift_en_) begin
	 // synthesis loop_limit 256
	 for (a_=depth-2; a_>0; a_=a_-1) begin
	    srl[a_] = srl[a_-1];
	 end
	 srl[0] <= i_d;
      end
   end // always @ (posedge clock or negedge reset)

   always @* begin					// - combi always
        srlo_       <=  'bx;
        shift_en_o_ <= 1'bx;
        shift_en_   <= 1'bx;
        addr_       <=  'bx;
        state_      <= 2'bx;
      case (state)

	state_empty: begin		    // - (empty, will not produce)
	      if (i_v) begin		    // - empty & i_v => consume
		 srlo_       <= i_d;
		 shift_en_o_ <= 1;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_one;
	      end
	      else	begin		    // - empty & !i_v => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_empty;
	      end
	end

	state_one: begin		    // - (contains one)
	      if (i_v && o_b) begin	    // - one & i_v & o_b => consume
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1;
		 addr_       <= 0;
		 state_      <= state_more;
	      end
	      else if (i_v && !o_b) begin   // - one & i_v & !o_b => cons+prod
		 srlo_       <= i_d;
		 shift_en_o_ <= 1;
		 shift_en_   <= 1;
		 addr_       <= 0;
		 state_      <= state_one;
	      end
	      else if (!i_v && o_b) begin   // - one & !i_v & o_b => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_one;
	      end
	      else if (!i_v && !o_b) begin  // - one & !i_v & !o_b => produce
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_empty;
	      end
	end // case: state_one

	state_more: begin		    // - (contains more than one)
	   if (addr_full || (depth==2)) begin
					    // - (full, will not consume)
					    // - (full here if depth==2)
	      if (o_b) begin		    // - full & o_b => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 0;
		 addr_       <= addr;
		 state_      <= state_more;
	      end
	      else begin		    // - full & !o_b => produce
		 srlo_       <= srl[addr];
		 shift_en_o_ <= 1;
		 shift_en_   <= 0;
//		 addr_       <= addr-1;
//		 state_      <= state_more;
		 addr_       <= addr_zero_ ? 0         : addr-1;
		 state_      <= addr_zero_ ? state_one : state_more;
	      end
	   end
	   else begin			    // - (mid: neither empty nor full)
	      if (i_v && o_b) begin	    // - mid & i_v & o_b => consume
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1;
		 addr_       <= addr+1;
		 state_      <= state_more;
	      end
	      else if (i_v && !o_b) begin   // - mid & i_v & !o_b => cons+prod
		 srlo_       <= srl[addr];
		 shift_en_o_ <= 1;
		 shift_en_   <= 1;
		 addr_       <= addr;
		 state_      <= state_more;
	      end
	      else if (!i_v && o_b) begin   // - mid & !i_v & o_b => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 0;
		 addr_       <= addr;
		 state_      <= state_more;
	      end
	      else if (!i_v && !o_b) begin  // - mid & !i_v & !o_b => produce
		 srlo_       <= srl[addr];
		 shift_en_o_ <= 1;
		 shift_en_   <= 0;
		 addr_       <= addr_zero_ ? 0         : addr-1;
		 state_      <= addr_zero_ ? state_one : state_more;
	      end
	   end // else: !if(addr_full)
	end // case: state_more

	default: begin
		 srlo_       <=  'bx;
		 shift_en_o_ <= 1'bx;
		 shift_en_   <= 1'bx;
		 addr_       <=  'bx;
		 state_      <= 2'bx;
	end // case: default

      endcase // case(state)
   end // always @ *

endmodule // Q_srl


`endif  // `ifdef  Q_srl
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_ConvolutionInputGenerator_1_0/synth/finn_design_ConvolutionInputGenerator_1_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:ConvolutionInputGenerator_1:1.0
// IP Revision: 2105101208

(* X_CORE_INFO = "ConvolutionInputGenerator_1_ConvolutionInputGenerator_1,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_ConvolutionInputGenerator_1_0,ConvolutionInputGenerator_1_ConvolutionInputGenerator_1,{}" *)
(* CORE_GENERATION_INFO = "finn_design_ConvolutionInputGenerator_1_0,ConvolutionInputGenerator_1_ConvolutionInputGenerator_1,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=ConvolutionInputGenerator_1,x_ipVersion=1.0,x_ipCoreRevision=2105101208,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_ConvolutionInputGenerator_1_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  ConvolutionInputGenerator_1_ConvolutionInputGenerator_1 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_ConvolutionInputGenerator_0_0/synth/finn_design_ConvolutionInputGenerator_0_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:ConvolutionInputGenerator_0:1.0
// IP Revision: 2105101213

(* X_CORE_INFO = "ConvolutionInputGenerator_0_ConvolutionInputGenerator_0,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_ConvolutionInputGenerator_0_0,ConvolutionInputGenerator_0_ConvolutionInputGenerator_0,{}" *)
(* CORE_GENERATION_INFO = "finn_design_ConvolutionInputGenerator_0_0,ConvolutionInputGenerator_0_ConvolutionInputGenerator_0,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=ConvolutionInputGenerator_0,x_ipVersion=1.0,x_ipCoreRevision=2105101213,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_ConvolutionInputGenerator_0_0 (
  ap_clk,
  ap_rst_n,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  in0_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY,
  out_V_V_TDATA
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, LAYERED_METADATA undef, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TUSER_WIDTH 0, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;

  ConvolutionInputGenerator_0_ConvolutionInputGenerator_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/6a71/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_fYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "block" *) module StreamingFCLayer_Batch_1_StreamingFCLayer_fYi_rom (
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
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_1_q80qszbp/project_StreamingFCLayer_Batch_1/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_1_StreamingFCLayer_fYi_rom.dat", ram);
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
module StreamingFCLayer_Batch_1_StreamingFCLayer_fYi(
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



StreamingFCLayer_Batch_1_StreamingFCLayer_fYi_rom StreamingFCLayer_Batch_1_StreamingFCLayer_fYi_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/51d1/hdl/verilog/ConvolutionInputGenerator_2_ConvolutionInputGene_1.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module ConvolutionInputGenerator_2_ConvolutionInputGene_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_pp0_stage0 = 3'd2;
parameter    ap_ST_fsm_state4 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [15:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [15:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage0;
wire   [0:0] icmp_ln196_fu_368_p2;
wire   [0:0] icmp_ln198_fu_390_p2;
wire   [0:0] and_ln244_fu_600_p2;
reg    out_V_V_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] icmp_ln198_reg_887;
reg   [0:0] icmp_ln214_reg_891;
reg   [10:0] i_0_0_reg_271;
reg    ap_predicate_op119_read_state2;
reg    ap_predicate_op162_read_state2;
reg    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
reg    ap_predicate_op205_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
wire   [10:0] add_ln196_fu_374_p2;
wire   [0:0] icmp_ln214_fu_399_p2;
wire   [1:0] add_ln220_fu_473_p2;
reg   [1:0] add_ln220_reg_895;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
wire   [7:0] inputBuf_0_V_address0;
reg    inputBuf_0_V_ce0;
wire   [15:0] inputBuf_0_V_q0;
reg   [7:0] inputBuf_0_V_address1;
reg    inputBuf_0_V_ce1;
reg    inputBuf_0_V_we1;
wire   [7:0] inputBuf_1_V_address0;
reg    inputBuf_1_V_ce0;
wire   [15:0] inputBuf_1_V_q0;
reg   [7:0] inputBuf_1_V_address1;
reg    inputBuf_1_V_ce1;
reg    inputBuf_1_V_we1;
wire   [7:0] inputBuf_2_V_address0;
reg    inputBuf_2_V_ce0;
wire   [15:0] inputBuf_2_V_q0;
reg   [7:0] inputBuf_2_V_address1;
reg    inputBuf_2_V_ce1;
reg    inputBuf_2_V_we1;
wire   [7:0] inputBuf_3_V_address0;
reg    inputBuf_3_V_ce0;
wire   [15:0] inputBuf_3_V_q0;
reg   [7:0] inputBuf_3_V_address1;
reg    inputBuf_3_V_ce1;
reg    inputBuf_3_V_we1;
wire   [63:0] zext_ln220_fu_459_p1;
wire   [63:0] zext_ln247_fu_606_p1;
wire   [63:0] zext_ln201_fu_718_p1;
reg   [31:0] ofm_y_1_0_fu_78;
wire   [31:0] select_ln235_1_fu_567_p3;
wire   [0:0] icmp_ln223_fu_485_p2;
wire   [0:0] icmp_ln226_fu_502_p2;
wire   [0:0] icmp_ln229_fu_513_p2;
wire   [0:0] icmp_ln232_fu_533_p2;
reg   [31:0] ofm_x_1_0_fu_82;
wire   [31:0] add_ln231_fu_527_p2;
reg   [31:0] k_y_1_0_fu_86;
wire   [31:0] add_ln215_fu_421_p2;
reg   [31:0] inp_15_0_fu_90;
wire   [31:0] select_ln235_fu_559_p3;
wire   [31:0] add_ln203_fu_730_p2;
reg   [31:0] k_x_1_0_fu_94;
wire   [31:0] add_ln225_fu_496_p2;
reg   [31:0] count_simd_1_0_fu_98;
wire   [31:0] add_ln222_fu_479_p2;
reg   [31:0] read_block_1_0_fu_102;
wire   [31:0] zext_ln251_fu_671_p1;
wire   [31:0] add_ln210_fu_766_p2;
wire   [0:0] icmp_ln204_fu_342_p2;
reg   [31:0] current_block_write_s_fu_106;
wire   [31:0] select_ln251_fu_647_p3;
wire   [31:0] select_ln207_fu_758_p3;
reg   [31:0] current_line_1_0_fu_110;
wire   [31:0] select_ln251_1_fu_655_p3;
wire   [31:0] grp_fu_330_p2;
reg   [31:0] counter_internal_blo_fu_114;
wire   [31:0] select_ln263_fu_705_p3;
wire   [15:0] tmp_V_1_fu_782_p6;
reg    ap_block_pp0_stage0_01001;
wire   [1:0] trunc_ln321_1_fu_614_p1;
wire   [1:0] trunc_ln321_fu_726_p1;
wire   [25:0] trunc_ln219_1_fu_435_p1;
wire   [25:0] trunc_ln219_fu_431_p1;
wire   [25:0] add_ln219_fu_439_p2;
wire   [31:0] shl_ln_fu_445_p3;
wire   [31:0] add_ln219_1_fu_453_p2;
wire   [1:0] trunc_ln215_1_fu_427_p1;
wire   [1:0] add_ln220_1_fu_467_p2;
wire   [1:0] trunc_ln215_fu_417_p1;
wire   [0:0] icmp_ln235_fu_553_p2;
wire   [31:0] add_ln234_fu_547_p2;
wire   [0:0] icmp_ln244_fu_588_p2;
wire   [0:0] icmp_ln244_1_fu_594_p2;
wire   [1:0] trunc_ln196_fu_386_p1;
wire   [31:0] add_ln255_fu_627_p2;
wire   [0:0] icmp_ln256_fu_633_p2;
wire   [0:0] icmp_ln251_fu_336_p2;
wire   [31:0] select_ln256_fu_639_p3;
wire   [1:0] add_ln255_1_fu_621_p2;
wire   [1:0] select_ln251_2_fu_663_p3;
wire   [31:0] add_ln262_fu_693_p2;
wire   [0:0] icmp_ln263_fu_699_p2;
wire   [31:0] add_ln206_fu_746_p2;
wire   [0:0] icmp_ln207_fu_752_p2;
wire    ap_CS_fsm_state4;
reg   [2:0] ap_NS_fsm;
reg    ap_block_pp0;
reg    ap_predicate_op127_store_state2;
reg    ap_enable_operation_127;
reg    ap_enable_state2_pp0_iter0_stage0;
reg    ap_predicate_op69_load_state2;
reg    ap_enable_operation_69;
reg    ap_predicate_op202_load_state3;
reg    ap_enable_operation_202;
reg    ap_enable_state3_pp0_iter1_stage0;
reg    ap_predicate_op170_store_state2;
reg    ap_enable_operation_170;
reg    ap_predicate_op129_store_state2;
reg    ap_enable_operation_129;
reg    ap_predicate_op67_load_state2;
reg    ap_enable_operation_67;
reg    ap_predicate_op201_load_state3;
reg    ap_enable_operation_201;
reg    ap_predicate_op172_store_state2;
reg    ap_enable_operation_172;
reg    ap_predicate_op131_store_state2;
reg    ap_enable_operation_131;
reg    ap_predicate_op65_load_state2;
reg    ap_enable_operation_65;
reg    ap_predicate_op200_load_state3;
reg    ap_enable_operation_200;
reg    ap_predicate_op174_store_state2;
reg    ap_enable_operation_174;
reg    ap_predicate_op133_store_state2;
reg    ap_enable_operation_133;
reg    ap_predicate_op71_load_state2;
reg    ap_enable_operation_71;
reg    ap_predicate_op203_load_state3;
reg    ap_enable_operation_203;
reg    ap_predicate_op176_store_state2;
reg    ap_enable_operation_176;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_657;
reg    ap_condition_230;
reg    ap_condition_663;
reg    ap_condition_667;
reg    ap_condition_671;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

ConvolutionInputGenerator_2_ConvolutionInputGbkb #(
    .DataWidth( 16 ),
    .AddressRange( 192 ),
    .AddressWidth( 8 ))
inputBuf_0_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_0_V_address0),
    .ce0(inputBuf_0_V_ce0),
    .q0(inputBuf_0_V_q0),
    .address1(inputBuf_0_V_address1),
    .ce1(inputBuf_0_V_ce1),
    .we1(inputBuf_0_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_2_ConvolutionInputGbkb #(
    .DataWidth( 16 ),
    .AddressRange( 192 ),
    .AddressWidth( 8 ))
inputBuf_1_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_1_V_address0),
    .ce0(inputBuf_1_V_ce0),
    .q0(inputBuf_1_V_q0),
    .address1(inputBuf_1_V_address1),
    .ce1(inputBuf_1_V_ce1),
    .we1(inputBuf_1_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_2_ConvolutionInputGbkb #(
    .DataWidth( 16 ),
    .AddressRange( 192 ),
    .AddressWidth( 8 ))
inputBuf_2_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_2_V_address0),
    .ce0(inputBuf_2_V_ce0),
    .q0(inputBuf_2_V_q0),
    .address1(inputBuf_2_V_address1),
    .ce1(inputBuf_2_V_ce1),
    .we1(inputBuf_2_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_2_ConvolutionInputGbkb #(
    .DataWidth( 16 ),
    .AddressRange( 192 ),
    .AddressWidth( 8 ))
inputBuf_3_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(inputBuf_3_V_address0),
    .ce0(inputBuf_3_V_ce0),
    .q0(inputBuf_3_V_q0),
    .address1(inputBuf_3_V_address1),
    .ce1(inputBuf_3_V_ce1),
    .we1(inputBuf_3_V_we1),
    .d1(in_V_V_TDATA)
);

ConvolutionInputGenerator_2_ConvolutionInputGfYi #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 16 ),
    .din2_WIDTH( 16 ),
    .din3_WIDTH( 16 ),
    .din4_WIDTH( 2 ),
    .dout_WIDTH( 16 ))
ConvolutionInputGfYi_U1(
    .din0(inputBuf_0_V_q0),
    .din1(inputBuf_1_V_q0),
    .din2(inputBuf_2_V_q0),
    .din3(inputBuf_3_V_q0),
    .din4(add_ln220_reg_895),
    .dout(tmp_V_1_fu_782_p6)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_pp0_exit_iter0_state2) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= (1'b1 ^ ap_condition_pp0_exit_iter0_state2);
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln223_fu_485_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        count_simd_1_0_fu_98 <= add_ln222_fu_479_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln226_fu_502_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln229_fu_513_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln232_fu_533_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        count_simd_1_0_fu_98 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        counter_internal_blo_fu_114 <= select_ln263_fu_705_p3;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        counter_internal_blo_fu_114 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_block_write_s_fu_106 <= select_ln207_fu_758_p3;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_block_write_s_fu_106 <= select_ln251_fu_647_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        current_block_write_s_fu_106 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln204_fu_342_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_line_1_0_fu_110 <= grp_fu_330_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        current_line_1_0_fu_110 <= select_ln251_1_fu_655_p3;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        current_line_1_0_fu_110 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        i_0_0_reg_271 <= 11'd0;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        i_0_0_reg_271 <= add_ln196_fu_374_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inp_15_0_fu_90 <= add_ln203_fu_730_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inp_15_0_fu_90 <= select_ln235_fu_559_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        inp_15_0_fu_90 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln226_fu_502_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        k_x_1_0_fu_94 <= add_ln225_fu_496_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln229_fu_513_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln232_fu_533_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        k_x_1_0_fu_94 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln229_fu_513_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        k_y_1_0_fu_86 <= add_ln215_fu_421_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        k_y_1_0_fu_86 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln232_fu_533_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ofm_x_1_0_fu_82 <= add_ln231_fu_527_p2;
    end else if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
        ofm_x_1_0_fu_82 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln232_fu_533_p2 == 1'd1) & (icmp_ln229_fu_513_p2 == 1'd1) & (icmp_ln226_fu_502_p2 == 1'd1) & (icmp_ln223_fu_485_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ofm_y_1_0_fu_78 <= select_ln235_1_fu_567_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ofm_y_1_0_fu_78 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln204_fu_342_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        read_block_1_0_fu_102 <= add_ln210_fu_766_p2;
    end else if (((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        read_block_1_0_fu_102 <= zext_ln251_fu_671_p1;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        read_block_1_0_fu_102 <= 32'd0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        add_ln220_reg_895 <= add_ln220_fu_473_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln198_reg_887 <= icmp_ln198_fu_390_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln214_reg_891 <= icmp_ln214_fu_399_p2;
    end
end

always @ (*) begin
    if ((icmp_ln196_fu_368_p2 == 1'd1)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op162_read_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op119_read_state2 == 1'b1)))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_726_p1 == 2'd0))) begin
            inputBuf_0_V_address1 = zext_ln201_fu_718_p1;
        end else if ((1'b1 == ap_condition_657)) begin
            inputBuf_0_V_address1 = zext_ln247_fu_606_p1;
        end else begin
            inputBuf_0_V_address1 = 'bx;
        end
    end else begin
        inputBuf_0_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_0_V_ce0 = 1'b1;
    end else begin
        inputBuf_0_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_0_V_ce1 = 1'b1;
    end else begin
        inputBuf_0_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_0_V_we1 = 1'b1;
    end else begin
        inputBuf_0_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_726_p1 == 2'd1))) begin
            inputBuf_1_V_address1 = zext_ln201_fu_718_p1;
        end else if ((1'b1 == ap_condition_663)) begin
            inputBuf_1_V_address1 = zext_ln247_fu_606_p1;
        end else begin
            inputBuf_1_V_address1 = 'bx;
        end
    end else begin
        inputBuf_1_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_1_V_ce0 = 1'b1;
    end else begin
        inputBuf_1_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_1_V_ce1 = 1'b1;
    end else begin
        inputBuf_1_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_1_V_we1 = 1'b1;
    end else begin
        inputBuf_1_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_726_p1 == 2'd2))) begin
            inputBuf_2_V_address1 = zext_ln201_fu_718_p1;
        end else if ((1'b1 == ap_condition_667)) begin
            inputBuf_2_V_address1 = zext_ln247_fu_606_p1;
        end else begin
            inputBuf_2_V_address1 = 'bx;
        end
    end else begin
        inputBuf_2_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_2_V_ce0 = 1'b1;
    end else begin
        inputBuf_2_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_2_V_ce1 = 1'b1;
    end else begin
        inputBuf_2_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_2_V_we1 = 1'b1;
    end else begin
        inputBuf_2_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_230)) begin
        if (((icmp_ln198_fu_390_p2 == 1'd1) & (trunc_ln321_fu_726_p1 == 2'd3))) begin
            inputBuf_3_V_address1 = zext_ln201_fu_718_p1;
        end else if ((1'b1 == ap_condition_671)) begin
            inputBuf_3_V_address1 = zext_ln247_fu_606_p1;
        end else begin
            inputBuf_3_V_address1 = 'bx;
        end
    end else begin
        inputBuf_3_V_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        inputBuf_3_V_ce0 = 1'b1;
    end else begin
        inputBuf_3_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_3_V_ce1 = 1'b1;
    end else begin
        inputBuf_3_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        inputBuf_3_V_we1 = 1'b1;
    end else begin
        inputBuf_3_V_we1 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln214_reg_891 == 1'd1) & (icmp_ln198_reg_887 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op205_write_state3 == 1'b1))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if (~((icmp_ln196_fu_368_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((icmp_ln196_fu_368_p2 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln196_fu_374_p2 = (i_0_0_reg_271 + 11'd1);

assign add_ln203_fu_730_p2 = (inp_15_0_fu_90 + 32'd1);

assign add_ln206_fu_746_p2 = (current_block_write_s_fu_106 + 32'd1);

assign add_ln210_fu_766_p2 = (read_block_1_0_fu_102 + 32'd1);

assign add_ln215_fu_421_p2 = (32'd1 + k_y_1_0_fu_86);

assign add_ln219_1_fu_453_p2 = (shl_ln_fu_445_p3 + count_simd_1_0_fu_98);

assign add_ln219_fu_439_p2 = (trunc_ln219_1_fu_435_p1 + trunc_ln219_fu_431_p1);

assign add_ln220_1_fu_467_p2 = (2'd1 + trunc_ln215_1_fu_427_p1);

assign add_ln220_fu_473_p2 = (add_ln220_1_fu_467_p2 + trunc_ln215_fu_417_p1);

assign add_ln222_fu_479_p2 = (32'd1 + count_simd_1_0_fu_98);

assign add_ln225_fu_496_p2 = (k_x_1_0_fu_94 + 32'd1);

assign add_ln231_fu_527_p2 = (ofm_x_1_0_fu_82 + 32'd1);

assign add_ln234_fu_547_p2 = (ofm_y_1_0_fu_78 + 32'd1);

assign add_ln255_1_fu_621_p2 = (trunc_ln196_fu_386_p1 + 2'd1);

assign add_ln255_fu_627_p2 = (current_block_write_s_fu_106 + 32'd1);

assign add_ln262_fu_693_p2 = (counter_internal_blo_fu_114 + 32'd1);

assign and_ln244_fu_600_p2 = (icmp_ln244_fu_588_p2 & icmp_ln244_1_fu_594_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_pp0 = ((ap_ST_fsm_pp0_stage0 == ap_CS_fsm) & (1'b1 == ap_block_pp0_stage0_subdone));
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op162_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op162_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state3_io)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((in_V_V_TVALID == 1'b0) & (ap_predicate_op162_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter0 = (((in_V_V_TVALID == 1'b0) & (ap_predicate_op162_read_state2 == 1'b1)) | ((in_V_V_TVALID == 1'b0) & (ap_predicate_op119_read_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_io = ((out_V_V_TREADY == 1'b0) & (ap_predicate_op205_write_state3 == 1'b1));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_230 = ((icmp_ln196_fu_368_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_657 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd0));
end

always @ (*) begin
    ap_condition_663 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd1));
end

always @ (*) begin
    ap_condition_667 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd2));
end

always @ (*) begin
    ap_condition_671 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd3));
end

always @ (*) begin
    ap_enable_operation_127 = (ap_predicate_op127_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_129 = (ap_predicate_op129_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_131 = (ap_predicate_op131_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_133 = (ap_predicate_op133_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_170 = (ap_predicate_op170_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_172 = (ap_predicate_op172_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_174 = (ap_predicate_op174_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_176 = (ap_predicate_op176_store_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_200 = (ap_predicate_op200_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_201 = (ap_predicate_op201_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_202 = (ap_predicate_op202_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_203 = (ap_predicate_op203_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_65 = (ap_predicate_op65_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_67 = (ap_predicate_op67_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_69 = (ap_predicate_op69_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_71 = (ap_predicate_op71_load_state2 == 1'b1);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_enable_state2_pp0_iter0_stage0 = ((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state3_pp0_iter1_stage0 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_predicate_op119_read_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op127_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd2));
end

always @ (*) begin
    ap_predicate_op129_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd1));
end

always @ (*) begin
    ap_predicate_op131_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd0));
end

always @ (*) begin
    ap_predicate_op133_store_state2 = ((1'd1 == and_ln244_fu_600_p2) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_1_fu_614_p1 == 2'd3));
end

always @ (*) begin
    ap_predicate_op162_read_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op170_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd2));
end

always @ (*) begin
    ap_predicate_op172_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd1));
end

always @ (*) begin
    ap_predicate_op174_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd0));
end

always @ (*) begin
    ap_predicate_op176_store_state2 = ((icmp_ln198_fu_390_p2 == 1'd1) & (icmp_ln196_fu_368_p2 == 1'd0) & (trunc_ln321_fu_726_p1 == 2'd3));
end

always @ (*) begin
    ap_predicate_op200_load_state3 = ((icmp_ln214_reg_891 == 1'd1) & (icmp_ln198_reg_887 == 1'd0));
end

always @ (*) begin
    ap_predicate_op201_load_state3 = ((icmp_ln214_reg_891 == 1'd1) & (icmp_ln198_reg_887 == 1'd0));
end

always @ (*) begin
    ap_predicate_op202_load_state3 = ((icmp_ln214_reg_891 == 1'd1) & (icmp_ln198_reg_887 == 1'd0));
end

always @ (*) begin
    ap_predicate_op203_load_state3 = ((icmp_ln214_reg_891 == 1'd1) & (icmp_ln198_reg_887 == 1'd0));
end

always @ (*) begin
    ap_predicate_op205_write_state3 = ((icmp_ln214_reg_891 == 1'd1) & (icmp_ln198_reg_887 == 1'd0));
end

always @ (*) begin
    ap_predicate_op65_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op67_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op69_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

always @ (*) begin
    ap_predicate_op71_load_state2 = ((icmp_ln214_fu_399_p2 == 1'd1) & (icmp_ln198_fu_390_p2 == 1'd0) & (icmp_ln196_fu_368_p2 == 1'd0));
end

assign grp_fu_330_p2 = (current_line_1_0_fu_110 + 32'd1);

assign icmp_ln196_fu_368_p2 = ((i_0_0_reg_271 == 11'd1152) ? 1'b1 : 1'b0);

assign icmp_ln198_fu_390_p2 = ((inp_15_0_fu_90 < 32'd576) ? 1'b1 : 1'b0);

assign icmp_ln204_fu_342_p2 = ((grp_fu_330_p2 == 32'd192) ? 1'b1 : 1'b0);

assign icmp_ln207_fu_752_p2 = ((add_ln206_fu_746_p2 == 32'd4) ? 1'b1 : 1'b0);

assign icmp_ln214_fu_399_p2 = ((counter_internal_blo_fu_114 < 32'd575) ? 1'b1 : 1'b0);

assign icmp_ln223_fu_485_p2 = ((add_ln222_fu_479_p2 == 32'd64) ? 1'b1 : 1'b0);

assign icmp_ln226_fu_502_p2 = ((add_ln225_fu_496_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln229_fu_513_p2 = ((add_ln215_fu_421_p2 == 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln232_fu_533_p2 = ((ofm_x_1_0_fu_82 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln235_fu_553_p2 = ((ofm_y_1_0_fu_78 == 32'd0) ? 1'b1 : 1'b0);

assign icmp_ln244_1_fu_594_p2 = ((read_block_1_0_fu_102 < 32'd3) ? 1'b1 : 1'b0);

assign icmp_ln244_fu_588_p2 = ((counter_internal_blo_fu_114 < 32'd191) ? 1'b1 : 1'b0);

assign icmp_ln251_fu_336_p2 = ((grp_fu_330_p2 == 32'd192) ? 1'b1 : 1'b0);

assign icmp_ln256_fu_633_p2 = ((add_ln255_fu_627_p2 == 32'd4) ? 1'b1 : 1'b0);

assign icmp_ln263_fu_699_p2 = ((add_ln262_fu_693_p2 == 32'd575) ? 1'b1 : 1'b0);

assign inputBuf_0_V_address0 = zext_ln220_fu_459_p1;

assign inputBuf_1_V_address0 = zext_ln220_fu_459_p1;

assign inputBuf_2_V_address0 = zext_ln220_fu_459_p1;

assign inputBuf_3_V_address0 = zext_ln220_fu_459_p1;

assign out_V_V_TDATA = tmp_V_1_fu_782_p6;

assign select_ln207_fu_758_p3 = ((icmp_ln207_fu_752_p2[0:0] === 1'b1) ? 32'd0 : add_ln206_fu_746_p2);

assign select_ln235_1_fu_567_p3 = ((icmp_ln235_fu_553_p2[0:0] === 1'b1) ? 32'd0 : add_ln234_fu_547_p2);

assign select_ln235_fu_559_p3 = ((icmp_ln235_fu_553_p2[0:0] === 1'b1) ? 32'd0 : inp_15_0_fu_90);

assign select_ln251_1_fu_655_p3 = ((icmp_ln251_fu_336_p2[0:0] === 1'b1) ? 32'd0 : grp_fu_330_p2);

assign select_ln251_2_fu_663_p3 = ((icmp_ln251_fu_336_p2[0:0] === 1'b1) ? add_ln255_1_fu_621_p2 : trunc_ln196_fu_386_p1);

assign select_ln251_fu_647_p3 = ((icmp_ln251_fu_336_p2[0:0] === 1'b1) ? select_ln256_fu_639_p3 : current_block_write_s_fu_106);

assign select_ln256_fu_639_p3 = ((icmp_ln256_fu_633_p2[0:0] === 1'b1) ? 32'd0 : add_ln255_fu_627_p2);

assign select_ln263_fu_705_p3 = ((icmp_ln263_fu_699_p2[0:0] === 1'b1) ? 32'd0 : add_ln262_fu_693_p2);

assign shl_ln_fu_445_p3 = {{add_ln219_fu_439_p2}, {6'd0}};

assign trunc_ln196_fu_386_p1 = read_block_1_0_fu_102[1:0];

assign trunc_ln215_1_fu_427_p1 = current_block_write_s_fu_106[1:0];

assign trunc_ln215_fu_417_p1 = k_y_1_0_fu_86[1:0];

assign trunc_ln219_1_fu_435_p1 = ofm_x_1_0_fu_82[25:0];

assign trunc_ln219_fu_431_p1 = k_x_1_0_fu_94[25:0];

assign trunc_ln321_1_fu_614_p1 = current_block_write_s_fu_106[1:0];

assign trunc_ln321_fu_726_p1 = current_block_write_s_fu_106[1:0];

assign zext_ln201_fu_718_p1 = current_line_1_0_fu_110;

assign zext_ln220_fu_459_p1 = add_ln219_1_fu_453_p2;

assign zext_ln247_fu_606_p1 = current_line_1_0_fu_110;

assign zext_ln251_fu_671_p1 = select_ln251_2_fu_663_p3;

endmodule //ConvolutionInputGenerator_2_ConvolutionInputGene_1
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/82df/Q_srl.v

// original source:
// https://github.com/nachiket/tdfc/blob/master/verilog/queues/Q_srl_oreg3_prefull_SIMPLE.v


// Copyright (c) 1999 The Regents of the University of California
// Copyright (c) 2010 The Regents of the University of Pennsylvania
// Copyright (c) 2011 Department of Electrical and Electronic Engineering, Imperial College London
// Copyright (c) 2020 Xilinx
//
// Permission to use, copy, modify, and distribute this software and
// its documentation for any purpose, without fee, and without a
// written agreement is hereby granted, provided that the above copyright
// notice and this paragraph and the following two paragraphs appear in
// all copies.
//
// IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
// DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
// LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
// EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF
// SUCH DAMAGE.
//
// THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
// AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON
// AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO
// PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
//

// Q_srl_oreg3_prefull_SIMPLE.v
//
//  - In-page queue with parameterizable depth, bit width
//  - Stream I/O is triple (data, valid, back-pressure),
//      with EOS concatenated into the data
//  - Flow control for input & output is combinationally decoupled
//  - 2 <= depth <= 256
//      * (depth >= 2)  is required to decouple I/O flow control,
//          where empty => no produce,  full => no consume,
//          and depth 1 would ping-pong between the two at half rate
//      * (depth <= 256) can be modified
//           by changing ''synthesis loop_limit X'' below
//          and changing ''addrwidth'' or its log computation
//  - 1 <= width
//  - Queue storage is in SRL16E, up to depth 16 per LUT per bit-slice,
//      plus output register (for fast output)
//  - Queue addressing is done by ''addr'' up-down counter
//  - Queue fullness is checked by comparator (addr==depth)
//  - Queue fullness                           is pre-computed for next cycle
//  - Queue input back-pressure                is pre-computed for next cycle
//  - Queue output valid (state!=state__empty) is pre-computed for next cycle
//      (necessary since SRL data output reg requires non-boolean state)
//  - FSM has 3 states (empty, one, more)
//  - When empty, continue to emit most recently emitted value (for debugging)
//
//  - Queue slots used      = / (state==state_empty) ? 0
//                            | (state==state_one)   ? 1
//                            \ (state==state_more)  ? addr+2
//  - Queue slots used     <=  depth
//  - Queue slots remaining =  depth - used
//                          = / (state==state_empty) ? depth
//                            | (state==state_one)   ? depth-1
//                            \ (state==state_more)  ? depth-2-addr
//
//  - Synplify 7.1 / 8.0
//  - Eylon Caspi,  9/11/03, 8/18/04, 3/29/05


`ifdef  Q_srl
`else
`define Q_srl


module Q_srl (clock, reset, i_d, i_v, i_r, o_d, o_v, o_r, count);

   parameter depth = 16;   // - greatest #items in queue  (2 <= depth <= 256)
   parameter width = 16;   // - width of data (i_d, o_d)

   parameter addrwidth = $clog2(depth);

   input     clock;
   input     reset;

   input  [width-1:0] i_d;	// - input  stream data (concat data + eos)
   input              i_v;	// - input  stream valid
   output             i_r;	// - input  stream ready
   wire               i_b;  // - input  stream back-pressure

   output [width-1:0] o_d;	// - output stream data (concat data + eos)
   output             o_v;	// - output stream valid
   input              o_r;	// - output stream ready
   wire               o_b;	// - output stream back-pressure

   output [addrwidth:0] count;  // - output number of elems in queue

   reg    [addrwidth-1:0] addr, addr_, a_;		// - SRL16 address
							//     for data output
   reg 			  shift_en_;			// - SRL16 shift enable
   reg    [width-1:0] 	  srl [depth-2:0];		// - SRL16 memory
   reg 			  shift_en_o_;			// - SRLO  shift enable
   reg    [width-1:0] 	  srlo_, srlo			// - SRLO  output reg
			  /* synthesis syn_allow_retiming=0 */ ;

   parameter state_empty = 2'd0;    // - state empty : o_v=0 o_d=UNDEFINED
   parameter state_one   = 2'd1;    // - state one   : o_v=1 o_d=srlo
   parameter state_more  = 2'd2;    // - state more  : o_v=1 o_d=srlo
				    //     #items in srl = addr+2

   reg [1:0] state, state_;	    // - state register

   wire      addr_full_;	    // - true iff addr==depth-2 on NEXT cycle
   reg       addr_full; 	    // - true iff addr==depth-2
   wire      addr_zero_;	    // - true iff addr==0
   wire      o_v_reg_;		    // - true iff state_empty   on NEXT cycle
   reg       o_v_reg  		    // - true iff state_empty
	     /* synthesis syn_allow_retiming=0 */ ;
   wire      i_b_reg_;		    // - true iff !full         on NEXT cycle
   reg       i_b_reg  		    // - true iff !full
	     /* synthesis syn_allow_retiming=0 */ ;

   assign addr_full_ = (state_==state_more) && (addr_==depth-2);
						// - queue full
   assign addr_zero_ = (addr==0);		// - queue contains 2 (or 1,0)
   assign o_v_reg_   = (state_!=state_empty);	// - output valid if non-empty
   assign i_b_reg_   = addr_full_;		// - input bp if full
   assign o_d = srlo;				// - output data from queue
   assign o_v = o_v_reg;			// - output valid if non-empty
   assign i_b = i_b_reg;			// - input bp if full

   assign i_r = !i_b;
   assign o_b = !o_r;

   assign count = (state==state_more ? addr+2 : (state==state_one ? 1 : 0));

   // - ''always'' block with both FFs and SRL16 does not work,
   //      since FFs need reset but SRL16 does not

   always @(posedge clock) begin	// - seq always: FFs
      if (reset) begin
	 state     <= state_empty;
	 addr      <= 0;
         addr_full <= 0;
	 o_v_reg   <= 0;
	 i_b_reg   <= 1;
      end
      else begin
	 state     <= state_;
	 addr      <= addr_;
         addr_full <= addr_full_;
	 o_v_reg   <= o_v_reg_;
	 i_b_reg   <= i_b_reg_;
      end
   end // always @ (posedge clock)

   always @(posedge clock) begin	// - seq always: srlo
      // - infer enabled output reg at end of shift chain
      // - input first element from i_d, all subsequent elements from SRL16
      if (reset) begin
	 srlo <= 0;
      end
      else begin
	 if (shift_en_o_) begin
	    srlo <= srlo_;
	 end
      end
   end // always @ (posedge clock)

   always @(posedge clock) begin			// - seq always: srl
      // - infer enabled SRL16E from shifting srl array
      // - no reset capability;  srl[] contents undefined on reset
      if (shift_en_) begin
	 // synthesis loop_limit 256
	 for (a_=depth-2; a_>0; a_=a_-1) begin
	    srl[a_] = srl[a_-1];
	 end
	 srl[0] <= i_d;
      end
   end // always @ (posedge clock or negedge reset)

   always @* begin					// - combi always
        srlo_       <=  'bx;
        shift_en_o_ <= 1'bx;
        shift_en_   <= 1'bx;
        addr_       <=  'bx;
        state_      <= 2'bx;
      case (state)

	state_empty: begin		    // - (empty, will not produce)
	      if (i_v) begin		    // - empty & i_v => consume
		 srlo_       <= i_d;
		 shift_en_o_ <= 1;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_one;
	      end
	      else	begin		    // - empty & !i_v => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_empty;
	      end
	end

	state_one: begin		    // - (contains one)
	      if (i_v && o_b) begin	    // - one & i_v & o_b => consume
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1;
		 addr_       <= 0;
		 state_      <= state_more;
	      end
	      else if (i_v && !o_b) begin   // - one & i_v & !o_b => cons+prod
		 srlo_       <= i_d;
		 shift_en_o_ <= 1;
		 shift_en_   <= 1;
		 addr_       <= 0;
		 state_      <= state_one;
	      end
	      else if (!i_v && o_b) begin   // - one & !i_v & o_b => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_one;
	      end
	      else if (!i_v && !o_b) begin  // - one & !i_v & !o_b => produce
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1'bx;
		 addr_       <= 0;
		 state_      <= state_empty;
	      end
	end // case: state_one

	state_more: begin		    // - (contains more than one)
	   if (addr_full || (depth==2)) begin
					    // - (full, will not consume)
					    // - (full here if depth==2)
	      if (o_b) begin		    // - full & o_b => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 0;
		 addr_       <= addr;
		 state_      <= state_more;
	      end
	      else begin		    // - full & !o_b => produce
		 srlo_       <= srl[addr];
		 shift_en_o_ <= 1;
		 shift_en_   <= 0;
//		 addr_       <= addr-1;
//		 state_      <= state_more;
		 addr_       <= addr_zero_ ? 0         : addr-1;
		 state_      <= addr_zero_ ? state_one : state_more;
	      end
	   end
	   else begin			    // - (mid: neither empty nor full)
	      if (i_v && o_b) begin	    // - mid & i_v & o_b => consume
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 1;
		 addr_       <= addr+1;
		 state_      <= state_more;
	      end
	      else if (i_v && !o_b) begin   // - mid & i_v & !o_b => cons+prod
		 srlo_       <= srl[addr];
		 shift_en_o_ <= 1;
		 shift_en_   <= 1;
		 addr_       <= addr;
		 state_      <= state_more;
	      end
	      else if (!i_v && o_b) begin   // - mid & !i_v & o_b => idle
		 srlo_       <= 'bx;
		 shift_en_o_ <= 0;
		 shift_en_   <= 0;
		 addr_       <= addr;
		 state_      <= state_more;
	      end
	      else if (!i_v && !o_b) begin  // - mid & !i_v & !o_b => produce
		 srlo_       <= srl[addr];
		 shift_en_o_ <= 1;
		 shift_en_   <= 0;
		 addr_       <= addr_zero_ ? 0         : addr-1;
		 state_      <= addr_zero_ ? state_one : state_more;
	      end
	   end // else: !if(addr_full)
	end // case: state_more

	default: begin
		 srlo_       <=  'bx;
		 shift_en_o_ <= 1'bx;
		 shift_en_   <= 1'bx;
		 addr_       <=  'bx;
		 state_      <= 2'bx;
	end // case: default

      endcase // case(state)
   end // always @ *

endmodule // Q_srl


`endif  // `ifdef  Q_srl
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 8;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd8;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg_rom StreamingFCLayer_Batch_0_Matrix_Vector_ActeOg_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingFIFO_0_0/synth/finn_design_StreamingFIFO_0_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingFIFO_0:1.0
// IP Revision: 2

(* X_CORE_INFO = "StreamingFIFO_0,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingFIFO_0_0,StreamingFIFO_0,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingFIFO_0_0,StreamingFIFO_0,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingFIFO_0,x_ipVersion=1.0,x_ipCoreRevision=2,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingFIFO_0_0 (
  ap_clk,
  ap_rst_n,
  count,
  in0_V_V_TDATA,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  out_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
output wire [4 : 0] count;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;

  StreamingFIFO_0 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .count(count),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/aa04/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Actcud.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_0_Matrix_Vector_Actcud_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 8;
parameter AWIDTH = 5;
parameter MEM_SIZE = 32;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_0_40c4o5tn/project_StreamingFCLayer_Batch_0/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_0_Matrix_Vector_Actcud_rom.dat", ram);
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
module StreamingFCLayer_Batch_0_Matrix_Vector_Actcud(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd8;
parameter AddressRange = 32'd32;
parameter AddressWidth = 32'd5;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_0_Matrix_Vector_Actcud_rom StreamingFCLayer_Batch_0_Matrix_Vector_Actcud_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/2003/hdl/verilog/StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k70t-fbg484-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.962000,HLS_SYN_LAT=805,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=306,HLS_SYN_LUT=326,HLS_VERSION=2020_1}" *)

module StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2 (
        ap_clk,
        ap_rst_n,
        in0_V_V_TDATA,
        in0_V_V_TVALID,
        in0_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst_n;
input  [127:0] in0_V_V_TDATA;
input   in0_V_V_TVALID;
output   in0_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg in0_V_V_TREADY;

 reg    ap_rst_n_inv;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_start;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_done;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_idle;
wire    grp_StreamingDataWidthCo_1_fu_26_ap_ready;
wire    grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
wire   [7:0] grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID;
wire    grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY;
reg    grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [3:0] ap_NS_fsm;
wire    ap_CS_fsm_state4;
wire    regslice_both_out_V_V_U_apdone_blk;
wire    regslice_both_in0_V_V_U_apdone_blk;
wire   [127:0] in0_V_V_TDATA_int;
wire    in0_V_V_TVALID_int;
reg    in0_V_V_TREADY_int;
wire    regslice_both_in0_V_V_U_ack_in;
wire    out_V_V_TREADY_int;
wire    regslice_both_out_V_V_U_vld_out;

// power-on initialization
initial begin
#0 grp_StreamingDataWidthCo_1_fu_26_ap_start_reg = 1'b0;
#0 ap_CS_fsm = 4'd1;
end

StreamingDataWidthConverter_Batch_2_StreamingDataWidthCo_1 grp_StreamingDataWidthCo_1_fu_26(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(grp_StreamingDataWidthCo_1_fu_26_ap_start),
    .ap_done(grp_StreamingDataWidthCo_1_fu_26_ap_done),
    .ap_idle(grp_StreamingDataWidthCo_1_fu_26_ap_idle),
    .ap_ready(grp_StreamingDataWidthCo_1_fu_26_ap_ready),
    .in_V_V_TDATA(in0_V_V_TDATA_int),
    .in_V_V_TVALID(in0_V_V_TVALID_int),
    .in_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY),
    .out_V_V_TDATA(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .out_V_V_TVALID(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .out_V_V_TREADY(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY)
);

regslice_both #(
    .DataWidth( 128 ))
regslice_both_in0_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in0_V_V_TDATA),
    .vld_in(in0_V_V_TVALID),
    .ack_in(regslice_both_in0_V_V_U_ack_in),
    .data_out(in0_V_V_TDATA_int),
    .vld_out(in0_V_V_TVALID_int),
    .ack_out(in0_V_V_TREADY_int),
    .apdone_blk(regslice_both_in0_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_out_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TDATA),
    .vld_in(grp_StreamingDataWidthCo_1_fu_26_out_V_V_TVALID),
    .ack_in(out_V_V_TREADY_int),
    .data_out(out_V_V_TDATA),
    .vld_out(regslice_both_out_V_V_U_vld_out),
    .ack_out(out_V_V_TREADY),
    .apdone_blk(regslice_both_out_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b1;
        end else if ((grp_StreamingDataWidthCo_1_fu_26_ap_ready == 1'b1)) begin
            grp_StreamingDataWidthCo_1_fu_26_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if (((regslice_both_in0_V_V_U_ack_in == 1'b1) & (in0_V_V_TVALID == 1'b1))) begin
        in0_V_V_TREADY = 1'b1;
    end else begin
        in0_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        in0_V_V_TREADY_int = grp_StreamingDataWidthCo_1_fu_26_in_V_V_TREADY;
    end else begin
        in0_V_V_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state2;
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_StreamingDataWidthCo_1_fu_26_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if (((regslice_both_out_V_V_U_apdone_blk == 1'b0) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign grp_StreamingDataWidthCo_1_fu_26_ap_start = grp_StreamingDataWidthCo_1_fu_26_ap_start_reg;

assign grp_StreamingDataWidthCo_1_fu_26_out_V_V_TREADY = (out_V_V_TREADY_int & ap_CS_fsm_state3);

assign out_V_V_TVALID = regslice_both_out_V_V_U_vld_out;

endmodule //StreamingDataWidthConverter_Batch_2_StreamingDataWidthConverter_Batch_2
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "distributed" *) module StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 1;
parameter AWIDTH = 3;
parameter MEM_SIZE = 6;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "distributed" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_3_vpqar3vc/project_StreamingFCLayer_Batch_3/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe_rom.dat", ram);
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
module StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd1;
parameter AddressRange = 32'd6;
parameter AddressWidth = 32'd3;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe_rom StreamingFCLayer_Batch_3_Matrix_Vector_ActdEe_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2c1/hdl/verilog/LabelSelect_Batch_0_LabelSelect_Batch.v

// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module LabelSelect_Batch_0_LabelSelect_Batch (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_V_V_TDATA,
        in_V_V_TVALID,
        in_V_V_TREADY,
        out_V_V_TDATA,
        out_V_V_TVALID,
        out_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_state2 = 3'd2;
parameter    ap_ST_fsm_state3 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] in_V_V_TDATA;
input   in_V_V_TVALID;
output   in_V_V_TREADY;
output  [7:0] out_V_V_TDATA;
output   out_V_V_TVALID;
input   out_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg in_V_V_TREADY;
reg out_V_V_TVALID;

(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    in_V_V_TDATA_blk_n;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln374_fu_83_p2;
reg    out_V_V_TDATA_blk_n;
wire    ap_CS_fsm_state3;
wire   [2:0] add_ln397_fu_89_p2;
reg    ap_block_state2;
wire   [1:0] topval_0_V_1_fu_109_p3;
reg   [1:0] topval_V_0_0_reg_57;
reg   [2:0] idx_0_0_reg_68;
reg   [7:0] tmp_V_fu_40;
wire   [7:0] toplabels_0_V_1_fu_117_p3;
wire   [1:0] tmp_V_2_fu_95_p1;
wire   [0:0] icmp_ln895_fu_99_p2;
wire   [7:0] toplabels_0_V_fu_105_p1;
reg   [2:0] ap_NS_fsm;

// power-on initialization
initial begin
#0 ap_CS_fsm = 3'd1;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if ((~((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0)) & (icmp_ln374_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        idx_0_0_reg_68 <= add_ln397_fu_89_p2;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        idx_0_0_reg_68 <= 3'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((~((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0)) & (icmp_ln374_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        topval_V_0_0_reg_57 <= topval_0_V_1_fu_109_p3;
    end else if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        topval_V_0_0_reg_57 <= 2'd0;
    end
end

always @ (posedge ap_clk) begin
    if ((~((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0)) & (icmp_ln374_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        tmp_V_fu_40 <= toplabels_0_V_1_fu_117_p3;
    end
end

always @ (*) begin
    if ((((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state3)) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln374_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        in_V_V_TDATA_blk_n = in_V_V_TVALID;
    end else begin
        in_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0)) & (icmp_ln374_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        in_V_V_TREADY = 1'b1;
    end else begin
        in_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        out_V_V_TDATA_blk_n = out_V_V_TREADY;
    end else begin
        out_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
        out_V_V_TVALID = 1'b1;
    end else begin
        out_V_V_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if ((~((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0)) & (icmp_ln374_fu_83_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else if ((~((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0)) & (icmp_ln374_fu_83_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((out_V_V_TREADY == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln397_fu_89_p2 = (idx_0_0_reg_68 + 3'd1);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_state2 = ((icmp_ln374_fu_83_p2 == 1'd0) & (in_V_V_TVALID == 1'b0));
end

assign icmp_ln374_fu_83_p2 = ((idx_0_0_reg_68 == 3'd6) ? 1'b1 : 1'b0);

assign icmp_ln895_fu_99_p2 = ((tmp_V_2_fu_95_p1 > topval_V_0_0_reg_57) ? 1'b1 : 1'b0);

assign out_V_V_TDATA = tmp_V_fu_40;

assign tmp_V_2_fu_95_p1 = in_V_V_TDATA[1:0];

assign toplabels_0_V_1_fu_117_p3 = ((icmp_ln895_fu_99_p2[0:0] === 1'b1) ? toplabels_0_V_fu_105_p1 : tmp_V_fu_40);

assign toplabels_0_V_fu_105_p1 = idx_0_0_reg_68;

assign topval_0_V_1_fu_109_p3 = ((icmp_ln895_fu_99_p2[0:0] === 1'b1) ? tmp_V_2_fu_95_p1 : topval_V_0_0_reg_57);

endmodule //LabelSelect_Batch_0_LabelSelect_Batch
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/ba05/hdl/verilog/StreamingFCLayer_Batch_3_StreamingFCLayer_fYi.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps

(* use_dsp = "no" *) module StreamingFCLayer_Batch_3_StreamingFCLayer_fYi_Mul_LUT_0(a, b, p);
input[2 - 1 : 0] a; 
input[2 - 1 : 0] b; 
output[4 - 1 : 0] p;

assign p = $signed({1'b0, a}) * $signed(b);
endmodule
`timescale 1 ns / 1 ps
module StreamingFCLayer_Batch_3_StreamingFCLayer_fYi(
    din0,
    din1,
    dout);

parameter ID = 32'd1;
parameter NUM_STAGE = 32'd1;
parameter din0_WIDTH = 32'd1;
parameter din1_WIDTH = 32'd1;
parameter dout_WIDTH = 32'd1;
input[din0_WIDTH - 1:0] din0;
input[din1_WIDTH - 1:0] din1;
output[dout_WIDTH - 1:0] dout;



StreamingFCLayer_Batch_3_StreamingFCLayer_fYi_Mul_LUT_0 StreamingFCLayer_Batch_3_StreamingFCLayer_fYi_Mul_LUT_0_U(
    .a( din0 ),
    .b( din1 ),
    .p( dout ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/d2b8/hdl/verilog/ConvolutionInputGenerator_1_ConvolutionInputGbkb.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module ConvolutionInputGenerator_1_ConvolutionInputGbkb_ram (addr0, ce0, q0, addr1, ce1, d1, we1,  clk);

parameter DWIDTH = 4;
parameter AWIDTH = 8;
parameter MEM_SIZE = 160;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input[AWIDTH-1:0] addr1;
input ce1;
input[DWIDTH-1:0] d1;
input we1;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];




always @(posedge clk)  
begin 
    if (ce0) begin
        q0 <= ram[addr0];
    end
end


always @(posedge clk)  
begin 
    if (ce1) begin
        if (we1) 
            ram[addr1] <= d1; 
    end
end


endmodule

`timescale 1 ns / 1 ps
module ConvolutionInputGenerator_1_ConvolutionInputGbkb(
    reset,
    clk,
    address0,
    ce0,
    q0,
    address1,
    ce1,
    we1,
    d1);

parameter DataWidth = 32'd4;
parameter AddressRange = 32'd160;
parameter AddressWidth = 32'd8;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;
input[AddressWidth - 1:0] address1;
input ce1;
input we1;
input[DataWidth - 1:0] d1;



ConvolutionInputGenerator_1_ConvolutionInputGbkb_ram ConvolutionInputGenerator_1_ConvolutionInputGbkb_ram_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ),
    .addr1( address1 ),
    .ce1( ce1 ),
    .we1( we1 ),
    .d1( d1 ));

endmodule

//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ip/finn_design_StreamingFIFO_1_0/synth/finn_design_StreamingFIFO_1_0.v

// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:StreamingFIFO_1:1.0
// IP Revision: 2

(* X_CORE_INFO = "StreamingFIFO_1,Vivado 2020.1" *)
(* CHECK_LICENSE_TYPE = "finn_design_StreamingFIFO_1_0,StreamingFIFO_1,{}" *)
(* CORE_GENERATION_INFO = "finn_design_StreamingFIFO_1_0,StreamingFIFO_1,{x_ipProduct=Vivado 2020.1,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=StreamingFIFO_1,x_ipVersion=1.0,x_ipCoreRevision=2,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module finn_design_StreamingFIFO_1_0 (
  ap_clk,
  ap_rst_n,
  count,
  in0_V_V_TDATA,
  in0_V_V_TVALID,
  in0_V_V_TREADY,
  out_V_V_TDATA,
  out_V_V_TVALID,
  out_V_V_TREADY
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF in0_V_V:out_V_V, FREQ_HZ 50000000.000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
output wire [4 : 0] count;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TDATA" *)
input wire [7 : 0] in0_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TVALID" *)
input wire in0_V_V_TVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in0_V_V, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in0_V_V TREADY" *)
output wire in0_V_V_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TDATA" *)
output wire [7 : 0] out_V_V_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TVALID" *)
output wire out_V_V_TVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out_V_V, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 50000000.000000, PHASE 0.000, CLK_DOMAIN finn_design_ap_clk_0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out_V_V TREADY" *)
input wire out_V_V_TREADY;

  StreamingFIFO_1 inst (
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .count(count),
    .in0_V_V_TDATA(in0_V_V_TDATA),
    .in0_V_V_TVALID(in0_V_V_TVALID),
    .in0_V_V_TREADY(in0_V_V_TREADY),
    .out_V_V_TDATA(out_V_V_TDATA),
    .out_V_V_TVALID(out_V_V_TVALID),
    .out_V_V_TREADY(out_V_V_TREADY)
  );
endmodule
//Added from /tmp/finn_dev_wenlong/vivado_stitch_proj_qsclxew6/finn_vivado_stitch_proj.srcs/sources_1/bd/finn_design/ipshared/f165/hdl/verilog/StreamingFCLayer_Batch_2_StreamingFCLayer_g8j.v

// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
(* rom_style = "block" *) module StreamingFCLayer_Batch_2_StreamingFCLayer_g8j_rom (
addr0, ce0, q0, clk);

parameter DWIDTH = 16;
parameter AWIDTH = 13;
parameter MEM_SIZE = 4608;

input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input clk;

(* ram_style = "block" *)reg [DWIDTH-1:0] ram[0:MEM_SIZE-1];

initial begin
    $readmemh("/tmp/finn_dev_wenlong/code_gen_ipgen_StreamingFCLayer_Batch_2_j8ke1nb0/project_StreamingFCLayer_Batch_2/sol1/impl/ip/hdl/verilog/StreamingFCLayer_Batch_2_StreamingFCLayer_g8j_rom.dat", ram);
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
module StreamingFCLayer_Batch_2_StreamingFCLayer_g8j(
    reset,
    clk,
    address0,
    ce0,
    q0);

parameter DataWidth = 32'd16;
parameter AddressRange = 32'd4608;
parameter AddressWidth = 32'd13;
input reset;
input clk;
input[AddressWidth - 1:0] address0;
input ce0;
output[DataWidth - 1:0] q0;



StreamingFCLayer_Batch_2_StreamingFCLayer_g8j_rom StreamingFCLayer_Batch_2_StreamingFCLayer_g8j_rom_U(
    .clk( clk ),
    .addr0( address0 ),
    .ce0( ce0 ),
    .q0( q0 ));

endmodule

