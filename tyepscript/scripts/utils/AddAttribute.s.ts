import { ethers } from "ethers";
import NFTMngrABI from "../../../out/INFTManager.sol/INFTMNGR.json";
import { provider, wallet } from "../../client";
import dotenv from "dotenv";
dotenv.config();
import exmapleSchema from "../../../resources/nft-schema.json";
import newAttribute from "../../../resources/UpdateAttribute/new_attribute.json";

let schema_name = exmapleSchema.code;
const split_schema = schema_name.split(".");
const _name = split_schema[1];
const org_name = process.env.ORG_NAME;
let schemaCode: string;
schemaCode = `${org_name}.${_name}`;
exmapleSchema.code = schemaCode;

async function main() {
    
  const precompileContract = "0x0000000000000000000000000000000000000055";
  const encodeBase64NewAttribute = Buffer.from(JSON.stringify(newAttribute)).toString(
    "base64"
  );

  const nftmngr = new ethers.Contract(
    precompileContract,
    NFTMngrABI.abi,
    provider,
  );

  const location = 1


  // @ts-ignore
  const tx = await nftmngr.connect(wallet).addAttribute(schemaCode,location,encodeBase64NewAttribute)

  console.log("Transaction hash:", tx.hash);

  // Wait for the transaction to be mined
  const receipt = await tx.wait();

  // Get gas used
  const gasUsed = receipt.gasUsed;

  console.log(`Gas used: ${gasUsed.toString()}`);
  console.log("TX Info", tx);
}

main()
  .then(() => {
    console.log("Transaction complete.");
  })
  .catch((err) => {
    console.error(err);
  });
