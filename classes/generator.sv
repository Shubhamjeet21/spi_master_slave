`timescale 1ns / 1ps
class generator;
  transaction tr;
  mailbox #(transaction) mbx;
  event done;
  int count = 0;
  event sconext;

  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    tr = new();
  endfunction

  task run();
    repeat(count) begin
      assert(tr.randomize()) else $fatal("Randomization failed!");
      mbx.put(tr.copy());
      @(sconext);
    end
    ->done;
  endtask
endclass

