import { TokenboundClient, TBAccountParams } from "@tokenbound/sdk";
import { JsonRpcProvider, Wallet, formatEther } from "ethers";
import { CONSTANTS } from "./constants";
const {
  RPC,
} = CONSTANTS;

export const provider = new JsonRpcProvider(RPC);
import dotenv from "dotenv";
dotenv.config()

if (!process.env.TEST_ACCOUNT) {
  console.error("TEST_ACCOUNT private key undefined in .env");
  process.exit();
}

export const wallet = new Wallet(process.env.TEST_ACCOUNT, provider);
