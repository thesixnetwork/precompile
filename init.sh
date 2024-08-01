source .env

forge script script/FactoryDeploy.s.sol:DeployERC721Factory --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY --broadcast --slow;

forge script script/FactoryDeploy.s.sol:DeployRouterFactory --rpc-url http://localhost:8545 --private-key $PRIVATE_KEY --broadcast --slow;