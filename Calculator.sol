// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Calculator {
    function Addition (uint256 num1, uint256 num2) public pure returns (uint256) {
        uint256 answer = num1 + num2;
        return answer;
    }
    function Substaction (uint256 num1, uint256 num2) public pure returns (uint256) {
        if(num2 > num1){
            (num1, num2) = (num2, num1);
        }
        uint256 answer = num1 - num2;
        return answer;
    }
    function multiplication (uint256 num1, uint256 num2) public pure returns (uint256) {
        uint256 answer = num1 * num2;
        return answer;
    }
    function division (uint256 num1, uint256 num2) public pure returns (uint256) {
        require(num2 != 0, "Division by Zero");
        uint256 answer = num1 / num2;
        return answer;
    }
}
