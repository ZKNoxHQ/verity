// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "./yul/YulTestBase.sol";

/**
 * @title PropertyVoidHelperSequenceTest
 * @notice Auto-generated baseline property stubs from `verity_contract` declarations.
 * @dev Source: Contracts/Smoke/VoidHelperSequence.lean
 */
contract PropertyVoidHelperSequenceTest is YulTestBase {
    address target;
    address alice = address(0x1111);

    function setUp() public {
        target = deployYul("VoidHelperSequence");
        require(target != address(0), "Deploy failed");
    }

    // Property 1: twice has no unexpected revert
    function testAuto_Twice_NoUnexpectedRevert() public {
        vm.prank(alice);
        (bool ok,) = target.call(abi.encodeWithSignature("twice()"));
        require(ok, "twice reverted unexpectedly");
    }
    // Property 2: get reads storage slot 0 and decodes the result
    function testAuto_Get_ReadsConfiguredStorage() public {
        uint256 expected = uint256(1);
        vm.store(target, bytes32(uint256(0)), bytes32(uint256(expected)));
        vm.prank(alice);
        (bool ok, bytes memory ret) = target.call(abi.encodeWithSignature("get()"));
        require(ok, "get reverted unexpectedly");
        assertEq(ret.length, 32, "get ABI return length mismatch (expected 32 bytes)");
        uint256 actual = abi.decode(ret, (uint256));
        assertEq(actual, expected, "get should return storage slot 0");
    }
}
