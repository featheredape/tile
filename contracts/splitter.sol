contract Splitter {
  // function name same as contract name, gets called when created
  function Splitter() {
    address x = 0x0294c750f1E92c92170298c4849B8d1aaB5A3C8d;
    address y = 0x7AAFE996764769FF7B41D6E0519c1fA6e7164950;
    x.send(msg.value / 2);
    y.send(msg.value / 2);

  }
}
