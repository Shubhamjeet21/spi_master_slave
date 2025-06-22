`timescale 1ns / 1ps
class driver;
  virtual spi_if vif;
  transaction tr;
  mailbox #(transaction) mbx;
  mailbox #(bit [11:0]) mbxds;

  function new(mailbox #(bit [11:0]) mbxds, mailbox #(transaction) mbx);
    this.mbxds = mbxds;
    this.mbx = mbx;
  endfunction

  task reset();
    vif.rst <= 1;
    vif.newd <= 0;
    vif.din <= 0;
    repeat(10) @(posedge vif.clk);
    vif.rst <= 0;
    repeat(5) @(posedge vif.clk);
  endtask

  task run();
    forever begin
      mbx.get(tr);
      vif.newd <= 1;
      vif.din <= tr.din;
      mbxds.put(tr.din);
      @(posedge vif.sclk);
      vif.newd <= 0;
      wait(vif.done);
    end
  endtask
endclass

