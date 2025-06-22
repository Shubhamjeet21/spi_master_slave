`timescale 1ns / 1ps
class monitor;
  transaction tr;
  mailbox #(bit [11:0]) mbx;
  virtual spi_if vif;

  function new(mailbox #(bit [11:0]) mbx);
    this.mbx = mbx;
  endfunction

  task run();
    forever begin
      wait(vif.done);
      @(posedge vif.sclk);
      tr = new();
      tr.dout = vif.dout;
      mbx.put(tr.dout);
    end
  endtask
endclass

