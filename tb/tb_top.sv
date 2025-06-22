`timescale 1ns / 1ps
import spi_pkg::*;
module tb_top;

  spi_if vif();  // Create interface instance

  // DUT instantiation
  top dut (
    .clk(vif.clk),
    .rst(vif.rst),
    .newd(vif.newd),
    .din(vif.din),
    .dout(vif.dout),
    .done(vif.done)
  );

  // Connect signals from DUT submodules to interface
  assign vif.sclk = dut.m1.sclk;
  assign vif.cs   = dut.m1.cs;
  assign vif.mosi = dut.m1.mosi;

  // Clock generation
  initial begin
    vif.clk = 0;
    forever #5 vif.clk = ~vif.clk;  // 100 MHz clock
  end

  // VCD waveform dump
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_top);
  end

  // Environment instantiation and run
  environment env;

  initial begin
    env = new(vif);       // Pass virtual interface
    env.gen.count = 4;    // Set number of transactions
    env.run();            // Start full test
  end

endmodule
