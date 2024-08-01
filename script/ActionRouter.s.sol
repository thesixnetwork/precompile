// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "openzeppelin-contracts/utils/Create2.sol";
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
    address routerContractAddress;
    address nftContractAddress;

    function setUp() public {
        ownerAddress = vm.envAddress("OWNER");
        currentNonce = vm.getNonce(ownerAddress);

        string memory routerContractInfoPath = "./broadcast/ActionRouter.s.sol/666/run-latest.json";
        string memory routerContractInfo = vm.readFile(routerContractInfoPath);
        bytes memory routerJsonParsed = vm.parseJson(routerContractInfo, ".transactions[0].contractAddress");
        routerContractAddress = abi.decode(routerJsonParsed, (address));

        string memory nftContractInfoPath = "./broadcast/ERC721.s.sol/666/run-latest.json";
        string memory nftContractInfo = vm.readFile(nftContractInfoPath);
        bytes memory nftJsonParsed = vm.parseJson(nftContractInfo, ".transactions[0].contractAddress");
        nftContractAddress = abi.decode(nftJsonParsed, (address));
    }

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Initialize variables
        string memory actionName = "attend_stage";
        string memory tokenId = "5";
        string memory nftSchema = "TechSauceV10.GlobalSummit2024";
        string memory refId = vm.toString(vm.getNonce(ownerAddress));
        string memory jsonParams = '[{"name":"stage","value":"stage_2"}]';

        Router actionRouter = Router(routerContractAddress);

        bool success = actionRouter.actionByNftOwner(
            nftContractAddress,
            nftSchema,
            tokenId,
            actionName,
            refId,
            jsonParams
        );

        require(success, "Transaction failed. Check error message below:");

        // Log the success message
        console.log("Action executed successfully!");
        vm.stopBroadcast();
    }
}
