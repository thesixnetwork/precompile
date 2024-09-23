// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {BridgePrecompile, IBridge} from "../src/IBridge.sol";

contract DeployBridge is Script {
    address ownerAddress;
    uint64 currentNonce;

    function setUp() public {
        ownerAddress = vm.envAddress("OWNER");
        currentNonce = vm.getNonce(ownerAddress);
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new BridgePrecompile();
        vm.stopBroadcast();
    }
}

contract SendToCosmosScript is Script {
    address ownerAddress;
    uint64 currentNonce;

    function setUp() public {
        ownerAddress = vm.envAddress("OWNER");
        currentNonce = vm.getNonce(ownerAddress);
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Initialize variables
        address contractAddress = 0x0000000000000000000000000000000000000069;
        string memory destinationAddress = "6x1myrlxmmasv6yq4axrxmdswj9kv5gc0ppx95rmq";
        uint256 amount = 100000 * 1e18;

        // Execute the transaction
        (bool success, bytes memory result) = contractAddress.call(
            abi.encodeWithSignature(
                "transferToCosmos(string,uint256)",
                destinationAddress,
                amount
            )
        );

        require(success, "Transaction failed");

        // Log the success message
        console.log("Transfer to attendee success!");
        console.log(string(result));

        vm.stopBroadcast();
    }
}
