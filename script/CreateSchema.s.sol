// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "openzeppelin-contracts/utils/Create2.sol";
import {INFTMNGR, NFTMNGR_PRECOMPILE_ADDRESS} from "../src/INFTManager.sol";

contract CreateSchema is Script {
    address ownerAddress;
    uint64 currentNonce;

    function setUp() public {
        ownerAddress = vm.envAddress("OWNER");
        currentNonce = vm.getNonce(ownerAddress);

        string memory schemaPath = "./resources/nft-schema.json";
        string memory nftSchemaJSON = vm.readFile(schemaPath);
        bytes memory schemaJsonParsed = vm.parseJson(
            nftSchemaJSON,
            ".transactions[0].contractAddress"
        );
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        //require(success, "Transaction failed. Check error message below:");

        // Log the success message
        console.log("Action executed successfully!");
        vm.stopBroadcast();
    }

    function createSchema(bytes memory datas) public payable returns (bool) {
        (bool success, ) = NFTMNGR_PRECOMPILE_ADDRESS.call{value: 0}(datas);
        if (!success) revert("transaction failed");

        return success;
    }
}
