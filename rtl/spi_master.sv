`timescale 1ns / 1ps
module spi_master(
    input clk, newd, rst,
    input [11:0] din, 
    output reg sclk, cs, mosi
);

  typedef enum bit [1:0] {idle = 2'b00, send = 2'b01} state_type;
  state_type state = idle;

  reg [11:0] temp;
  int count = 0;
  int countc = 0;

  // Generate slower SCLK
  always @(posedge clk) begin
    if (rst) begin
      countc <= 0;
      sclk <= 0;
    end else if (countc < 10) begin
      countc <= countc + 1;
    end else begin
      countc <= 0;
      sclk <= ~sclk;
    end
  end

  // FSM for SPI Master
  always @(posedge sclk) begin
    if (rst) begin
      cs <= 1'b1;
      mosi <= 1'b0;
      state <= idle;
      count <= 0;
    end else begin
      case (state)
        idle: begin
          if (newd) begin
            cs <= 1'b0;
            temp <= din;
            count <= 0;
            state <= send;
          end
        end
        send: begin
          if (count < 12) begin
            mosi <= temp[count]; // LSB first
            count <= count + 1;
          end else begin
            cs <= 1'b1;
            mosi <= 1'b0;
            state <= idle;
          end
        end
      endcase
    end
  end

endmodule

