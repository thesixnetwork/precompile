# FACTORY AND PRECOMPILE CONTRACTs

## COMPILE

```bash
forge compile
```

## DEPLOY FACTORY

```bash
bash init.sh
```

## SIX SECTION
### Deploy NFT Token and MINT NFT
1.
```bash
forge script script/ERC721.s.sol:DeployScript --rpc-url http://35.247.160.241:8545 --private-key $PRIVATE_KEY --optimize --broadcast --slow 
```

### Deploy NFT Schema and Create metadata
1.
```bash
cd typescript
```

2. Deploy schema
```bash
yarn ts-node  ./scripts/CreateSchema.s.ts
```

3. Create Metadata
```bash
yarn ts-node  ./scripts/CreateMetadata.s.ts
```

### Perform Action

1. Deploy Action Router. You can deploy your action router or use existing router
```bash
forge script script/ActionRouter.s.sol:DeployRouter --rpc-url http://35.247.160.241:8545 --private-key $PRIVATE_KEY --broadcast --optimize 
```

2. Allow Action Router to perform action
```bash
forge script script/Executor.s.sol:AddRouterExecutor --rpc-url http://35.247.160.241:8545 --private-key $PRIVATE_KEY --broadcast 
```

(optional or use your own)
```bash
forge script script/Executor.s.sol:AddExecutor --rpc-url http://35.247.160.241:8545 --private-key $PRIVATE_KEY --broadcast 
```

3. Perfomr action
```bash
forge script script/ActionRouter.s.sol:ActionScript --rpc-url http:localhost:8545 --private-key $PRIVATE_KEY --broadcast
```