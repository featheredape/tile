// Transcibed from Vitalik's Taipei talk
// https://www.youtube.com/watch?v=MlaLRgUYeLo&feature=youtu.be&t=20m20s


contract Escrow {
  address seller;
  address buyer;
  address arbiter;

  function Escrow(address _seller, address _arbiter) {
    seller = _seller;
    buyer = msg.sender;
    aribter = _arbiter;
  }

  function finalize() {
    // allow only buyer and arbiter to finalize transaction
    if (msg.sender == buyer || msg.sender == arbiter)
      seller.send(this.balance)
  }

  function refund() {
    // allows anyone to refund the buyer
    buyer.send(this.balance);
  }
}
