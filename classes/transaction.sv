`timescale 1ns / 1ps
class transaction;
  rand bit [11:0] din;
       bit [11:0] dout;

  function transaction copy();
    copy = new();
    copy.din  = this.din;
    copy.dout = this.dout;
  endfunction
endclass

