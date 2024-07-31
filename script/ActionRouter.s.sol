// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Router} from "../src/ActionRouter.sol";

contract DeployRouter is Script {
    address ownerAddress;
    uint64 currentNonce;

    function setUp() public {
        ownerAddress = vm.envAddress("OWNER");
        currentNonce = vm.getNonce(ownerAddress);
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new Router();
        vm.stopBroadcast();
    }
}

contract ActionScript is Script {
    address ownerAddress;
    uint64 currentNonce;

    function setUp() public {
        ownerAddress = vm.envAddress("OWNER");
        currentNonce = vm.getNonce(ownerAddress);
        // Read the contract address from the JSON file
        string memory contractInfoPath = "../broadcast/DeployRouter.s.sol/run-latest.json";
        string memory contractInfo = vm.readFile(contractInfoPath);

        // Parse JSON to get the contract address
        bytes memory parsed = vm.parseJson(contractInfo, ".transactions[0].contractAddress");
        address contractAddress = abi.decode(parsed, (address));

        console.log("contract Address: ", contractAddress);
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // // Replace with the actual deployment address
        // address contractAddress = 0x0000000000000000000000000000000000000055;

        // // Initialize variables
        // address nftContractAddress = 0x2b304d0C42D05e21F1dF0f5c9314986fA2544fD0;
        // string memory actionName = "attend_main_stage";
        // string memory tokenId = "5";
        // string memory nftSchema = "TechSauceV9.GlobalSummit2024";
        // string memory refId = "5";

        // // Encoded parameters as JSON string
        // string memory jsonParams = "[{\"name\":\"stage\",\"value\":\"stage_1\"},{\"name\":\"section\",\"value\":\"section_A\"}]";

        // INFTMNGR moduleContract= NFTMNGR(contractAddress);

        // bool success = moduleContract.actionByNftOwner(nftContractAddress,nftSchema, tokenId, actionName, refId, jsonParams);

        // require(success, "Transaction failed. Check error message below:");

        // // Log the success message
        // console.log("Action executed successfully!");

        vm.stopBroadcast();
    }
}
