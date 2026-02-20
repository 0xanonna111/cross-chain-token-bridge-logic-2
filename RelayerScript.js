// Simple Node.js snippet to listen for Bridge events
const { ethers } = require("ethers");

async function watchBridge() {
    const provider = new ethers.JsonRpcProvider("SOURCE_CHAIN_RPC");
    const bridgeAddress = "0x...";
    const abi = ["event BridgeInitiated(address indexed user, uint256 amount, uint256 timestamp)"];
    
    const contract = new ethers.Contract(bridgeAddress, abi, provider);

    contract.on("BridgeInitiated", (user, amount, timestamp) => {
        console.log(`Bridge detected: ${user} is sending ${ethers.formatEther(amount)} tokens.`);
        // In a real app, you would now trigger bridgeIn on the destination chain.
    });
}

watchBridge();
