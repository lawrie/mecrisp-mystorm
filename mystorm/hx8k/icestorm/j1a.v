`timescale 1 ns / 1 ps

`default_nettype none
`define WIDTH 16

module SB_RAM2048x2(
	output  [1:0] RDATA,
	input         RCLK, RCLKE, RE,
	input  [10:0] RADDR,
	input         WCLK, WCLKE, WE,
	input  [10:0] WADDR,
	input   [1:0] MASK, WDATA
);
	parameter INIT_0 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_4 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_5 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_6 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_7 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_8 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_9 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

  wire [15:0] rd;

  SB_RAM40_4K #(
    .WRITE_MODE(3),
    .READ_MODE(3),
    .INIT_0(INIT_0),
    .INIT_1(INIT_1),
    .INIT_2(INIT_2),
    .INIT_3(INIT_3),
    .INIT_4(INIT_4),
    .INIT_5(INIT_5),
    .INIT_6(INIT_6),
    .INIT_7(INIT_7),
    .INIT_8(INIT_8),
    .INIT_9(INIT_9),
    .INIT_A(INIT_A),
    .INIT_B(INIT_B),
    .INIT_C(INIT_C),
    .INIT_D(INIT_D),
    .INIT_E(INIT_E),
    .INIT_F(INIT_F)
  ) _ram (
    .RDATA(rd),
    .RADDR(RADDR),
    .RCLK(RCLK), .RCLKE(RCLKE), .RE(RE),
    .WCLK(WCLK), .WCLKE(WCLKE), .WE(WE),
    .WADDR(WADDR),
    .MASK(16'h0000), .WDATA({4'b0, WDATA[1], 7'b0, WDATA[0], 3'b0}));

  assign RDATA[0] = rd[3];
  assign RDATA[1] = rd[11];

endmodule

module top(input oscillator,
           input resetq,

           output TXD,        // UART TX
           input  RXD,        // UART RX

           output LED_K1,
           output LED_K2,
           output LED_K3,
           output LED_K4,

//           output SPI_SCK,    // Flash SCK
//           input  SPI_MISO,   // Flash MISO
//           output SPI_MOSI,   // Flash MOSI
//           output SPI_CS,     // Flash CS

           inout PORTA0,
           inout PORTA1,
           inout PORTA2,
           inout PORTA3,
           inout PORTA4,
           inout PORTA5,
           inout PORTA6,
           inout PORTA7,
           inout PORTA8,
           inout PORTA9,
           inout PORTA10,
           inout PORTA11,
           inout PORTA12,
           inout PORTA13,
           inout PORTA14,
           inout PORTA15,

           inout PORTB0,
           inout PORTB1,
           inout PORTB2,
           inout PORTB3,
           inout PORTB4,
           inout PORTB5,
           inout PORTB6,
           inout PORTB7,
           inout PORTB8,
           inout PORTB9,
           inout PORTB10,
           inout PORTB11,
           inout PORTB12,
           inout PORTB13,
           inout PORTB14,
           inout PORTB15,

           inout PORTC0,
           inout PORTC1,
           inout PORTC2,
           inout PORTC3,
           inout PORTC4,
           inout PORTC5,
           inout PORTC6,
           inout PORTC7,
           inout PORTC8,
           inout PORTC9,
           inout PORTC10,
           inout PORTC11,
           inout PORTC12,
           inout PORTC13,
           inout PORTC14,
           inout PORTC15,

           output SRAM_CS,
           output SRAM_WE,
           output SRAM_OE,
           output SRAM_LB,
           output SRAM_UB,
           inout SRAM_D0,
           inout SRAM_D1,
           inout SRAM_D2,
           inout SRAM_D3,
           inout SRAM_D4,
           inout SRAM_D5,
           inout SRAM_D6,
           inout SRAM_D7,
           inout SRAM_D8,
           inout SRAM_D9,
           inout SRAM_D10,
           inout SRAM_D11,
           inout SRAM_D12,
           inout SRAM_D13,
           inout SRAM_D14,
           inout SRAM_D15,

           output SRAM_A0,
           output SRAM_A1,
           output SRAM_A2,
           output SRAM_A3,
           output SRAM_A4,
           output SRAM_A5,
           output SRAM_A6,
           output SRAM_A7,
           output SRAM_A8,
           output SRAM_A9,
           output SRAM_A10,
           output SRAM_A11,
           output SRAM_A12,
           output SRAM_A13,
           output SRAM_A14,
           output SRAM_A15,
           output SRAM_A16,
           output SRAM_A17,

);

  reg SRAM_A18;
  assign SRAM_UB = 0;
  assign SRAM_LB = 0;
  

  // Divide incoming 100 MHz from the oscillator by 4 to 25 MHz.

  reg clk_50mhz = 0;  // 50 Mhz
  reg clk = 0;       // 25 MHz

  always @(posedge oscillator)
  begin
    clk_50mhz <= ~clk_50mhz;
  end

  always @(posedge clk_50mhz)
  begin
    clk <= ~clk;
  end

  // A few wires and registers

  wire io_rd, io_wr;
  wire [15:0] mem_addr;
  wire mem_wr;
  wire [15:0] dout;
  wire [15:0] io_din;
  wire [12:0] code_addr;

  reg unlocked = 0;

`include "../build/ram.v"

  reg interrupt = 0;

  // ######   PROCESSOR   #####################################

  j1 _j1(
    .clk(clk),
    .resetq(resetq),
    .io_rd(io_rd),
    .io_wr(io_wr),
    .mem_wr(mem_wr),
    .dout(dout),
    .io_din(io_din),
    .mem_addr(mem_addr),
    .code_addr(code_addr),
    .insn_from_memory(insn),
    .interrupt_request(interrupt)
  );

  // ######   TICKS   #########################################

  reg [15:0] ticks;

  wire [16:0] ticks_plus_1 = ticks + 1;

  always @(posedge clk)
    if (io_wr & mem_addr[14])
      ticks <= dout;
    else
      ticks <= ticks_plus_1;

  always @(posedge clk) // Generate interrupt on ticks overflow
    interrupt <= ticks_plus_1[16];

  // ######   PORTA   ###########################################

  reg  [15:0] porta_dir;   // 1:output, 0:input
  reg  [15:0] porta_out;
  wire [15:0] porta_in;

  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa0  (.PACKAGE_PIN(PORTA0),  .D_OUT_0(porta_out[0]),  .D_IN_0(porta_in[0]),  .OUTPUT_ENABLE(porta_dir[0]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa1  (.PACKAGE_PIN(PORTA1),  .D_OUT_0(porta_out[1]),  .D_IN_0(porta_in[1]),  .OUTPUT_ENABLE(porta_dir[1]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa2  (.PACKAGE_PIN(PORTA2),  .D_OUT_0(porta_out[2]),  .D_IN_0(porta_in[2]),  .OUTPUT_ENABLE(porta_dir[2]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa3  (.PACKAGE_PIN(PORTA3),  .D_OUT_0(porta_out[3]),  .D_IN_0(porta_in[3]),  .OUTPUT_ENABLE(porta_dir[3]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa4  (.PACKAGE_PIN(PORTA4),  .D_OUT_0(porta_out[4]),  .D_IN_0(porta_in[4]),  .OUTPUT_ENABLE(porta_dir[4]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa5  (.PACKAGE_PIN(PORTA5),  .D_OUT_0(porta_out[5]),  .D_IN_0(porta_in[5]),  .OUTPUT_ENABLE(porta_dir[5]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa6  (.PACKAGE_PIN(PORTA6),  .D_OUT_0(porta_out[6]),  .D_IN_0(porta_in[6]),  .OUTPUT_ENABLE(porta_dir[6]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa7  (.PACKAGE_PIN(PORTA7),  .D_OUT_0(porta_out[7]),  .D_IN_0(porta_in[7]),  .OUTPUT_ENABLE(porta_dir[7]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa8  (.PACKAGE_PIN(PORTA8),  .D_OUT_0(porta_out[8]),  .D_IN_0(porta_in[8]),  .OUTPUT_ENABLE(porta_dir[8]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa9  (.PACKAGE_PIN(PORTA9),  .D_OUT_0(porta_out[9]),  .D_IN_0(porta_in[9]),  .OUTPUT_ENABLE(porta_dir[9]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa10 (.PACKAGE_PIN(PORTA10), .D_OUT_0(porta_out[10]), .D_IN_0(porta_in[10]), .OUTPUT_ENABLE(porta_dir[10]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa11 (.PACKAGE_PIN(PORTA11), .D_OUT_0(porta_out[11]), .D_IN_0(porta_in[11]), .OUTPUT_ENABLE(porta_dir[11]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa12 (.PACKAGE_PIN(PORTA12), .D_OUT_0(porta_out[12]), .D_IN_0(porta_in[12]), .OUTPUT_ENABLE(porta_dir[12]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa13 (.PACKAGE_PIN(PORTA13), .D_OUT_0(porta_out[13]), .D_IN_0(porta_in[13]), .OUTPUT_ENABLE(porta_dir[13]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa14 (.PACKAGE_PIN(PORTA14), .D_OUT_0(porta_out[14]), .D_IN_0(porta_in[14]), .OUTPUT_ENABLE(porta_dir[14]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioa15 (.PACKAGE_PIN(PORTA15), .D_OUT_0(porta_out[15]), .D_IN_0(porta_in[15]), .OUTPUT_ENABLE(porta_dir[15]));


  // ######   PORTB   ###########################################

  reg  [15:0] portb_dir;   // 1:output, 0:input
  reg  [15:0] portb_out;
  wire [15:0] portb_in;

  SB_IO #(.PIN_TYPE(6'b1010_01)) iob0  (.PACKAGE_PIN(PORTB0),  .D_OUT_0(portb_out[0]),  .D_IN_0(portb_in[0]),  .OUTPUT_ENABLE(portb_dir[0]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob1  (.PACKAGE_PIN(PORTB1),  .D_OUT_0(portb_out[1]),  .D_IN_0(portb_in[1]),  .OUTPUT_ENABLE(portb_dir[1]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob2  (.PACKAGE_PIN(PORTB2),  .D_OUT_0(portb_out[2]),  .D_IN_0(portb_in[2]),  .OUTPUT_ENABLE(portb_dir[2]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob3  (.PACKAGE_PIN(PORTB3),  .D_OUT_0(portb_out[3]),  .D_IN_0(portb_in[3]),  .OUTPUT_ENABLE(portb_dir[3]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob4  (.PACKAGE_PIN(PORTB4),  .D_OUT_0(portb_out[4]),  .D_IN_0(portb_in[4]),  .OUTPUT_ENABLE(portb_dir[4]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob5  (.PACKAGE_PIN(PORTB5),  .D_OUT_0(portb_out[5]),  .D_IN_0(portb_in[5]),  .OUTPUT_ENABLE(portb_dir[5]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob6  (.PACKAGE_PIN(PORTB6),  .D_OUT_0(portb_out[6]),  .D_IN_0(portb_in[6]),  .OUTPUT_ENABLE(portb_dir[6]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob7  (.PACKAGE_PIN(PORTB7),  .D_OUT_0(portb_out[7]),  .D_IN_0(portb_in[7]),  .OUTPUT_ENABLE(portb_dir[7]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob8  (.PACKAGE_PIN(PORTB8),  .D_OUT_0(portb_out[8]),  .D_IN_0(portb_in[8]),  .OUTPUT_ENABLE(portb_dir[8]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob9  (.PACKAGE_PIN(PORTB9),  .D_OUT_0(portb_out[9]),  .D_IN_0(portb_in[9]),  .OUTPUT_ENABLE(portb_dir[9]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob10 (.PACKAGE_PIN(PORTB10), .D_OUT_0(portb_out[10]), .D_IN_0(portb_in[10]), .OUTPUT_ENABLE(portb_dir[10]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob11 (.PACKAGE_PIN(PORTB11), .D_OUT_0(portb_out[11]), .D_IN_0(portb_in[11]), .OUTPUT_ENABLE(portb_dir[11]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob12 (.PACKAGE_PIN(PORTB12), .D_OUT_0(portb_out[12]), .D_IN_0(portb_in[12]), .OUTPUT_ENABLE(portb_dir[12]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob13 (.PACKAGE_PIN(PORTB13), .D_OUT_0(portb_out[13]), .D_IN_0(portb_in[13]), .OUTPUT_ENABLE(portb_dir[13]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob14 (.PACKAGE_PIN(PORTB14), .D_OUT_0(portb_out[14]), .D_IN_0(portb_in[14]), .OUTPUT_ENABLE(portb_dir[14]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) iob15 (.PACKAGE_PIN(PORTB15), .D_OUT_0(portb_out[15]), .D_IN_0(portb_in[15]), .OUTPUT_ENABLE(portb_dir[15]));

  // ######   PORTC   ###########################################

  reg  [15:0] portc_dir;   // 1:output, 0:input
  reg  [15:0] portc_out;
  wire [15:0] portc_in;

  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc0  (.PACKAGE_PIN(PORTC0),  .D_OUT_0(portc_out[0]),  .D_IN_0(portc_in[0]),  .OUTPUT_ENABLE(portc_dir[0]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc1  (.PACKAGE_PIN(PORTC1),  .D_OUT_0(portc_out[1]),  .D_IN_0(portc_in[1]),  .OUTPUT_ENABLE(portc_dir[1]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc2  (.PACKAGE_PIN(PORTC2),  .D_OUT_0(portc_out[2]),  .D_IN_0(portc_in[2]),  .OUTPUT_ENABLE(portc_dir[2]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc3  (.PACKAGE_PIN(PORTC3),  .D_OUT_0(portc_out[3]),  .D_IN_0(portc_in[3]),  .OUTPUT_ENABLE(portc_dir[3]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc4  (.PACKAGE_PIN(PORTC4),  .D_OUT_0(portc_out[4]),  .D_IN_0(portc_in[4]),  .OUTPUT_ENABLE(portc_dir[4]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc5  (.PACKAGE_PIN(PORTC5),  .D_OUT_0(portc_out[5]),  .D_IN_0(portc_in[5]),  .OUTPUT_ENABLE(portc_dir[5]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc6  (.PACKAGE_PIN(PORTC6),  .D_OUT_0(portc_out[6]),  .D_IN_0(portc_in[6]),  .OUTPUT_ENABLE(portc_dir[6]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc7  (.PACKAGE_PIN(PORTC7),  .D_OUT_0(portc_out[7]),  .D_IN_0(portc_in[7]),  .OUTPUT_ENABLE(portc_dir[7]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc8  (.PACKAGE_PIN(PORTC8),  .D_OUT_0(portc_out[8]),  .D_IN_0(portc_in[8]),  .OUTPUT_ENABLE(portc_dir[8]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc9  (.PACKAGE_PIN(PORTC9),  .D_OUT_0(portc_out[9]),  .D_IN_0(portc_in[9]),  .OUTPUT_ENABLE(portc_dir[9]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc10 (.PACKAGE_PIN(PORTC10), .D_OUT_0(portc_out[10]), .D_IN_0(portc_in[10]), .OUTPUT_ENABLE(portc_dir[10]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc11 (.PACKAGE_PIN(PORTC11), .D_OUT_0(portc_out[11]), .D_IN_0(portc_in[11]), .OUTPUT_ENABLE(portc_dir[11]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc12 (.PACKAGE_PIN(PORTC12), .D_OUT_0(portc_out[12]), .D_IN_0(portc_in[12]), .OUTPUT_ENABLE(portc_dir[12]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc13 (.PACKAGE_PIN(PORTC13), .D_OUT_0(portc_out[13]), .D_IN_0(portc_in[13]), .OUTPUT_ENABLE(portc_dir[13]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc14 (.PACKAGE_PIN(PORTC14), .D_OUT_0(portc_out[14]), .D_IN_0(portc_in[14]), .OUTPUT_ENABLE(portc_dir[14]));
  SB_IO #(.PIN_TYPE(6'b1010_01)) ioc15 (.PACKAGE_PIN(PORTC15), .D_OUT_0(portc_out[15]), .D_IN_0(portc_in[15]), .OUTPUT_ENABLE(portc_dir[15]));


  // ######   SRAM   ############################################

  reg  [18:0] sram_addr;

  assign {          SRAM_A18, SRAM_A17, SRAM_A16,
          SRAM_A15, SRAM_A14, SRAM_A13, SRAM_A12,
          SRAM_A11, SRAM_A10, SRAM_A9,  SRAM_A8,
          SRAM_A7,  SRAM_A6,  SRAM_A5,  SRAM_A4,
          SRAM_A3,  SRAM_A2,  SRAM_A1,  SRAM_A0   } = sram_addr;

  wire [15:0] sram_in;
  reg  [15:0] sram_out;
  reg         sram_dir;

  always @(posedge clk)
  begin
    if (io_wr & mem_addr[7])
    begin
      sram_out <= dout;
      sram_dir <= 1;
    end else begin
      sram_dir <= 0;
    end
  end

  assign SRAM_OE =  sram_dir;
  assign SRAM_WE = ~sram_dir;
  assign SRAM_CS = 0;

  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata0  (.PACKAGE_PIN(SRAM_D0),  .D_OUT_0(sram_out[0]),  .D_IN_0(sram_in[0]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata1  (.PACKAGE_PIN(SRAM_D1),  .D_OUT_0(sram_out[1]),  .D_IN_0(sram_in[1]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata2  (.PACKAGE_PIN(SRAM_D2),  .D_OUT_0(sram_out[2]),  .D_IN_0(sram_in[2]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata3  (.PACKAGE_PIN(SRAM_D3),  .D_OUT_0(sram_out[3]),  .D_IN_0(sram_in[3]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata4  (.PACKAGE_PIN(SRAM_D4),  .D_OUT_0(sram_out[4]),  .D_IN_0(sram_in[4]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata5  (.PACKAGE_PIN(SRAM_D5),  .D_OUT_0(sram_out[5]),  .D_IN_0(sram_in[5]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata6  (.PACKAGE_PIN(SRAM_D6),  .D_OUT_0(sram_out[6]),  .D_IN_0(sram_in[6]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata7  (.PACKAGE_PIN(SRAM_D7),  .D_OUT_0(sram_out[7]),  .D_IN_0(sram_in[7]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata8  (.PACKAGE_PIN(SRAM_D8),  .D_OUT_0(sram_out[8]),  .D_IN_0(sram_in[8]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata9  (.PACKAGE_PIN(SRAM_D9),  .D_OUT_0(sram_out[9]),  .D_IN_0(sram_in[9]),  .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata10 (.PACKAGE_PIN(SRAM_D10), .D_OUT_0(sram_out[10]), .D_IN_0(sram_in[10]), .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata11 (.PACKAGE_PIN(SRAM_D11), .D_OUT_0(sram_out[11]), .D_IN_0(sram_in[11]), .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata12 (.PACKAGE_PIN(SRAM_D12), .D_OUT_0(sram_out[12]), .D_IN_0(sram_in[12]), .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata13 (.PACKAGE_PIN(SRAM_D13), .D_OUT_0(sram_out[13]), .D_IN_0(sram_in[13]), .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata14 (.PACKAGE_PIN(SRAM_D14), .D_OUT_0(sram_out[14]), .D_IN_0(sram_in[14]), .OUTPUT_ENABLE(sram_dir));
  SB_IO #(.PIN_TYPE(6'b1010_01)) sramdata15 (.PACKAGE_PIN(SRAM_D15), .D_OUT_0(sram_out[15]), .D_IN_0(sram_in[15]), .OUTPUT_ENABLE(sram_dir));


  // ######   UART   ##########################################

  wire uart0_valid, uart0_busy;
  wire [7:0] uart0_data;
  wire uart0_wr = io_wr & mem_addr[12];
  wire uart0_rd = io_rd & mem_addr[12];
  wire UART0_RX;
  buart _uart0 (
     .clk(clk),
     .resetq(1'b1),
     .rx(RXD),
     .tx(TXD),
     .rd(uart0_rd),
     .wr(uart0_wr),
     .valid(uart0_valid),
     .busy(uart0_busy),
     .tx_data(dout[7:0]),
     .rx_data(uart0_data));

  // ######   LEDS & PIOS   ###################################

//  reg [5:0] PIOS;
//  assign {CTS, PIO1_20, PIO1_18, SPI_SCK, SPI_MOSI, SPI_CS} = PIOS;

  reg [3:0] LEDS;
  assign {LED_K4,LED_K3,LED_K2,LED_K1} = LEDS;

  // ######   RING OSCILLATOR   ###############################

  wire [1:0] buffers_in, buffers_out;
  assign buffers_in = {buffers_out[0:0], ~buffers_out[1]};
  SB_LUT4 #(
          .LUT_INIT(16'd2)
  ) buffers [1:0] (
          .O(buffers_out),
          .I0(buffers_in),
          .I1(1'b0),
          .I2(1'b0),
          .I3(1'b0)
  );

  wire random = ~buffers_out[1];

  // ######   IO PORTS   ######################################

  /*        bit READ            WRITE

      0001  0   PMOD in
      0002  1   PMOD out        PMOD out
      0004  2   PMOD dir        PMOD dir
      0008  3   misc.out        misc.out

      0010  4   header 1 in
      0020  5   header 1 out    header 1 out
      0040  6   header 1 dir    header 1 dir
      0080  7   SRAM read       SRAM write

      0100  8   header 2 in
      0200  9   header 2 out    header 2 out
      0400  10  header 2 dir    header 2 dir
      0800  11  SRAM addr low   SRAM addr low

      1000  12  UART RX         UART TX
      2000  13  misc.in
      4000  14  ticks           clear ticks
      8000  15  SRAM addr high  SRAM addr high
  */


  assign io_din =

    (mem_addr[ 0] ?         porta_in                                                 : 16'd0) |
    (mem_addr[ 1] ?         porta_out                                                : 16'd0) |
    (mem_addr[ 2] ?         porta_dir                                                : 16'd0) |
    (mem_addr[ 3] ? {12'd0, LEDS}                                                    : 16'd0) |

    (mem_addr[ 4] ?         portb_in                                                 : 16'd0) |
    (mem_addr[ 5] ?         portb_out                                                : 16'd0) |
    (mem_addr[ 6] ?         portb_dir                                                : 16'd0) |
    (mem_addr[ 7] ?         sram_in                                                  : 16'd0) |

    (mem_addr[ 8] ?         portc_in                                                 : 16'd0) |
    (mem_addr[ 9] ?         portc_out                                                : 16'd0) |
    (mem_addr[10] ?         portc_dir                                                : 16'd0) |
    (mem_addr[11] ?         sram_addr[15:0]                                          : 16'd0) |

    (mem_addr[12] ? { 8'd0, uart0_data}                                              : 16'd0) |
    (mem_addr[13] ? {13'd0, random, uart0_valid, !uart0_busy}                        : 16'd0) |
    (mem_addr[14] ?         ticks                                                    : 16'd0) |
    (mem_addr[15] ? {13'd0, sram_addr[18:16]}                                        : 16'd0) ;

  // Very few gates needed: Simply trigger warmboot by any IO access to $8000 / $8001 / $8002 / $8003.
  // SB_WARMBOOT _sb_warmboot ( .BOOT(io_wr & mem_addr[15]), .S1(mem_addr[1]), .S0(mem_addr[0]) );

  always @(posedge clk) begin

    if (io_wr & mem_addr[1])  porta_out <= dout;
    if (io_wr & mem_addr[2])  porta_dir <= dout;
    if (io_wr & mem_addr[3])  LEDS      <= dout[3:0];

    if (io_wr & mem_addr[5])  portb_out <= dout;
    if (io_wr & mem_addr[6])  portb_dir <= dout;

    if (io_wr & mem_addr[9])  portc_out <= dout;
    if (io_wr & mem_addr[10]) portc_dir <= dout;

    if (io_wr & mem_addr[11]) sram_addr[15:0]  <= dout;
    if (io_wr & mem_addr[15]) sram_addr[18:16] <= dout[2:0];

  end

  // ######   MEMLOCK   #######################################

  // This is a workaround to protect memory contents during Reset.
  // Somehow it happens sometimes that the first memory location is corrupted during startup,
  // and as an IO write is one of the earliest things which are done, memory write access is unlocked
  // only after the processor is up and running and sending its welcome message.

  always @(negedge resetq or posedge clk)
  if (!resetq) unlocked <= 0;
  else         unlocked <= unlocked | io_wr;

endmodule // top
