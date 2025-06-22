`timescale 1ns / 1ps
import spi_pkg::*;

class scoreboard;
  mailbox #(bit [11:0]) mbxds, mbxms;
  event sconext;

  function new(mailbox #(bit [11:0]) mbxds, mailbox #(bit [11:0]) mbxms);
    this.mbxds = mbxds;
    this.mbxms = mbxms;
  endfunction

  task run();
    bit [11:0] ds, ms;
    forever begin
      mbxds.get(ds);
      mbxms.get(ms);
      if (ds == ms)
        $display("[SCOREBOARD] Match: %h", ds);
      else
        $display("[SCOREBOARD] Mismatch: sent %h, received %h", ds, ms);
      ->sconext;
    end
  endtask
endclass

