`timescale 1 ns / 1 ps

module testbench( );
    reg     ap_clk;
    reg ap_rst_n;
    wire [7:0] m_axis_0_tdata;
    reg [7:0] m_axis_0_tdata_reg;
    reg     m_axis_0_tready;
    wire    m_axis_0_tvalid;
    reg [7:0] s_axis_0_tdata;
    wire    s_axis_0_tready;
    reg     s_axis_0_tvalid;
    
finn_design_wrapper test_for_finn(
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .m_axis_0_tdata(m_axis_0_tdata),
    .m_axis_0_tready(m_axis_0_tready),
    .m_axis_0_tvalid(m_axis_0_tvalid),
    .s_axis_0_tdata(s_axis_0_tdata),
    .s_axis_0_tready(s_axis_0_tready),
    .s_axis_0_tvalid(s_axis_0_tvalid)
);

integer i;
reg [7:0] read_data [144:1];

initial begin
    
    ap_clk = 0;  //reset
    ap_rst_n = 0;
    m_axis_0_tready = 0;
    s_axis_0_tvalid = 0;
    #1000;


    $readmemb("test.txt", read_data); //read .txt file and store in array temp
    i = 0;


    @(posedge ap_clk); #2;
    ap_rst_n = 1;  //begin to work
    s_axis_0_tvalid = 1;
    #200;

    repeat(144) begin
        @(posedge ap_clk && s_axis_0_tready && s_axis_0_tvalid);
        i = i + 1;
        s_axis_0_tdata = read_data [i]; //input every 8bit data from temp into finn IP core

    end

    #20;
    s_axis_0_tvalid = 0;

    #1000000000;
    $finish;
end

integer change;


always @(posedge ap_clk) begin
    m_axis_0_tready <= m_axis_0_tvalid;
    
end


always @(m_axis_0_tready && m_axis_0_tvalid) begin
    m_axis_0_tdata_reg <= m_axis_0_tdata;
    $display("Detected number: %0x", m_axis_0_tdata_reg);
end


always #10 ap_clk = ~ap_clk; // 50MHz clock

endmodule