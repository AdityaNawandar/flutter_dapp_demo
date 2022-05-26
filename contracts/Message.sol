// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract MessageContract
{
    string _message;

    function setMessage(string memory _newMessage) public {
        _message = _newMessage;
    }

    function getMessage() public view returns (string memory) {
        return _message;
    }
}
