// THIS FILE IS GENERATED AUTOMATICALLY. DO NOT MODIFY.


import { StdFee, SigningStargateClient, SigningStargateClientOptions} from "@cosmjs/stargate";
import { Registry, OfflineSigner, EncodeObject, DirectSecp256k1HdWallet } from "@cosmjs/proto-signing";
import { Api } from "./rest";
import { MsgRevokePermission } from "./types/nftadmin/tx";
import { MsgGrantPermission } from "./types/nftadmin/tx";


const types = [
  ["/thesixnetwork.sixnft.nftadmin.MsgRevokePermission", MsgRevokePermission],
  ["/thesixnetwork.sixnft.nftadmin.MsgGrantPermission", MsgGrantPermission],
  
];
export const MissingWalletError = new Error("wallet is required");

export const registry = new Registry(<any>types);

const defaultFee = {
  amount: [],
  gas: "200000",
};

interface TxClientOptions {
  addr: string
}

export interface SignAndBroadcastOptions {
  fee: StdFee | "auto",
  memo?: string
}

const txClient = async (wallet: OfflineSigner, { addr: addr }: TxClientOptions = { addr: "http://localhost:26657" }, options?: SigningStargateClientOptions) => {
  if (!wallet) throw MissingWalletError;
  let client;
  if (addr) {
    client = await SigningStargateClient.connectWithSigner(addr, wallet, { registry, ...options});
  }else{
    client = await SigningStargateClient.offline( wallet, { registry });
  }
  const { address } = (await wallet.getAccounts())[0];

  return {
    signAndBroadcast: (msgs: EncodeObject[], { fee, memo }: SignAndBroadcastOptions = {fee: defaultFee, memo: ""}) => client.signAndBroadcast(address, msgs, fee,memo),
    msgRevokePermission: (data: MsgRevokePermission): EncodeObject => ({ typeUrl: "/thesixnetwork.sixnft.nftadmin.MsgRevokePermission", value: MsgRevokePermission.fromPartial( data ) }),
    msgGrantPermission: (data: MsgGrantPermission): EncodeObject => ({ typeUrl: "/thesixnetwork.sixnft.nftadmin.MsgGrantPermission", value: MsgGrantPermission.fromPartial( data ) }),
    
  };
};

interface QueryClientOptions {
  addr: string
}

const queryClient = async ({ addr: addr }: QueryClientOptions = { addr: "http://localhost:1317" }) => {
  return new Api({ baseUrl: addr });
};

export {
  txClient,
  queryClient,
};