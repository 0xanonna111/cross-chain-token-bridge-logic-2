// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title BridgeBase
 * @dev Core logic for cross-chain token transfers.
 */
contract BridgeBase is AccessControl, Pausable {
    using SafeERC20 for IERC20;

    bytes32 public constant RELAYER_ROLE = keccak256("RELAYER_ROLE");
    IERC20 public immutable token;

    event BridgeInitiated(address indexed user, uint256 amount, uint256 timestamp);
    event BridgeFinalized(address indexed user, uint256 amount, uint256 timestamp);

    constructor(address _token, address _admin) {
        token = IERC20(_token);
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    /**
     * @dev User locks tokens on the source chain to bridge out.
     */
    function bridgeOut(uint256 amount) external whenNotPaused {
        require(amount > 0, "Amount must be > 0");
        token.safeTransferFrom(msg.sender, address(this), amount);
        emit BridgeInitiated(msg.sender, amount, block.timestamp);
    }

    /**
     * @dev Relayer calls this on the destination chain to release tokens.
     */
    function bridgeIn(address user, uint256 amount) external onlyRole(RELAYER_ROLE) whenNotPaused {
        token.safeTransfer(user, amount);
        emit BridgeFinalized(user, amount, block.timestamp);
    }

    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }
}
