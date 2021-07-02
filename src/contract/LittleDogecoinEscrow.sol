/**
 *Submitted for verification at BscScan.com on 2021-06-09
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'SafeMath: addition overflow');

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, 'SafeMath: subtraction overflow');
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, 'SafeMath: multiplication overflow');

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, 'SafeMath: division by zero');
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, 'SafeMath: modulo by zero');
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }

    function min(uint256 x, uint256 y) internal pure returns (uint256 z) {
        z = x < y ? x : y;
    }

    // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}

interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address _owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since a proxied contract can't have a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 */
abstract contract Initializable {

    /**
     * @dev Indicates that the contract has been initialized.
     */
    bool private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Modifier to protect an initializer function from being invoked twice.
     */
    modifier initializer() {
        require(_initializing || !_initialized, "Initializable: contract is already initialized");

        bool isTopLevelCall = !_initializing;
        if (isTopLevelCall) {
            _initializing = true;
            _initialized = true;
        }

        _;

        if (isTopLevelCall) {
            _initializing = false;
        }
    }
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract ContextUpgradeable is Initializable {
    function __Context_init() internal initializer {
        __Context_init_unchained();
    }

    function __Context_init_unchained() internal initializer {
    }
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
    uint256[50] private __gap;
}


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract OwnableUpgradeable is Initializable, ContextUpgradeable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    function __Ownable_init() internal initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
    }

    function __Ownable_init_unchained() internal initializer {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
    uint256[49] private __gap;
}


contract LittleDogecoinEscrow is OwnableUpgradeable {
    using SafeMath for uint256;

    address public wallet;
    IBEP20 public token;

    uint256 public depositFee;
    uint256 public withdrawFee;
    bool public allowReleaseRequest;
 
    enum PaymentStatus {Pending, Completed, Rejected, Cancelled, Refunded, Disputed, Resolved}
    enum PaymenentType {PersonalPayment, ProfessionalPayment}
    struct Payment {
        address buyer;
        address seller;
        uint256 amount;
        uint256 delay;
        uint releaseTime;
        bool isRecursive;
        string code;
        PaymentStatus status;
    }
    
    mapping(address => uint256) public balances; // token balances
    mapping(address => uint256) public lockedBalances;

    uint256 orderIndex;
    mapping(uint256 => Payment) public personalPayments;
    mapping(uint256 => Payment) public professionalPayments;

    struct LockedPayment {
        PaymenentType paymentType;
        PaymentStatus status;
        uint256 orderId;
        address sender;
        uint256 amount;
        string code;
        uint256 releasedTime;
    }
    mapping(address => LockedPayment[]) public lockedPayments;


    event Deposited(address indexed payee, uint256 tokenAmount);
    event Withdrawn(address indexed payee, uint256 tokenAmount);

    event PaymentCreated(uint256 orderId, uint paymentType, address indexed buyer, address indexed seller, uint256 tokenAmount, bool isRecursive, uint delay, string code, uint timestamp);
    event PaymentReleased(uint paymentType, address indexed seller, uint256 orderId, uint256 amount);
    event Paymentlocked(uint256 orderId, uint paymentType, address indexed seller, address indexed buyer, uint256 amount, uint releasedTime, string code);
    event PaymentUnlocked(address indexed unlocker, uint256 orderId, uint256 amount);
    event PaymentDisputed(address indexed disputer, uint256 orderId);
    event PaymentCancelled(address indexed buyer, uint256 orderId);
    event PaymentRejected(address indexed buyer, uint256 orderId);
    event DisputeResolved(uint256 orderId);
    
    function initialize(IBEP20 _token, address _wallet, uint256 _depositFee, uint256 _withdrawFee) public initializer {
        __Ownable_init();

        token = _token;
        wallet = _wallet;
        depositFee = _depositFee;
        withdrawFee = _withdrawFee;
        allowReleaseRequest = false;
    }
    function _authorizeUpgrade(address newImplementation) internal {}
    
    function deposit(uint256 _amount) external {
        require(_amount > 0, "Invalid amount");
        require(token.transferFrom(msg.sender, address(this), _amount));

        if(depositFee > 0) {
            uint256 fee = _amount.mul(depositFee).div(10000);
            token.transfer(wallet, fee);
            _amount = _amount.sub(fee);
        }

        balances[msg.sender] = balances[msg.sender].add(_amount);
        
        emit Deposited(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external {
        require(balances[msg.sender] >= _amount && _amount > 0);
        
        if(depositFee > 0) {
            uint256 fee = _amount.mul(withdrawFee).div(10000);
            _amount = _amount.sub(fee);

            token.transfer(wallet, fee);
            balances[msg.sender] = balances[msg.sender].sub(fee);
        }

        token.transfer(msg.sender, _amount);
        balances[msg.sender] = balances[msg.sender].sub(_amount);

        emit Withdrawn(msg.sender, _amount);
    }

    function createPayment(uint _paymentType, address _seller, uint256 _amount, bool _recursive, uint256 _delay, string memory _code) external {
        require(_amount > 0, "Invalid Amount");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(_delay > 0, "delay should be greater than 0");
        require(_seller != address(0), "Invalid Address");

        uint256 _releaseTime = block.timestamp + _delay * 1 days;
        uint256 _orderId = orderIndex.add(1);

        PaymenentType paymentType = PaymenentType.PersonalPayment;
        bool isRecursive = _recursive;
        
        if(_paymentType == 0) {
            personalPayments[_orderId] = Payment(msg.sender, _seller, _amount, _delay, _releaseTime, _recursive, _code, PaymentStatus.Pending);
        } else {
            paymentType = PaymenentType.ProfessionalPayment;
            isRecursive = false;

            professionalPayments[_orderId] = Payment(msg.sender, _seller, _amount, _delay, _releaseTime, false, _code, PaymentStatus.Pending);
        }

        balances[msg.sender] = balances[msg.sender].sub(_amount);
        lockedBalances[msg.sender] = lockedBalances[msg.sender].add(_amount);
        
        orderIndex++;

        emit PaymentCreated(_orderId, _paymentType, msg.sender, _seller, _amount, isRecursive, _delay, _code, block.timestamp);
    }

    function disputePayment(uint256 _orderId) external {
        require(professionalPayments[_orderId].buyer != address(0), "OrderID is invalid");

        Payment memory _payment = professionalPayments[_orderId];
        require(msg.sender == _payment.buyer || msg.sender == _payment.seller, "Permission denied");
        require(_payment.status == PaymentStatus.Pending || _payment.releaseTime < block.timestamp, "Payment can not be disputed");

        professionalPayments[_orderId].status = PaymentStatus.Disputed;
        lockedBalances[_payment.buyer] = lockedBalances[_payment.buyer].sub(_payment.amount);

        token.transfer(wallet, _payment.amount);

        emit PaymentDisputed(msg.sender, _orderId);
    }

    function resolveDispute(uint256 _orderId) external onlyOwner returns (bool) {
        require(professionalPayments[_orderId].buyer != address(0), "OrderID is invalid");

        Payment  memory _payment = professionalPayments[_orderId];
        require(_payment.status == PaymentStatus.Disputed, "Not disputed payment");

        professionalPayments[_orderId].status = PaymentStatus.Resolved;

        emit DisputeResolved(_orderId);

        return true;
    }

    function cancelPayment(uint256 _orderId) external {
        require(personalPayments[_orderId].buyer != address(0), "OrderID is invalid");

        Payment memory _payment = personalPayments[_orderId];
        require(msg.sender == _payment.buyer, "Permission denied");
        require(_payment.status == PaymentStatus.Pending, "Payment can not be cancelled");

        personalPayments[_orderId].status = PaymentStatus.Cancelled;

        lockedBalances[_payment.buyer] = lockedBalances[_payment.buyer].sub(_payment.amount);
        balances[_payment.buyer] = balances[_payment.buyer].add(_payment.amount);

        emit PaymentCancelled(_payment.buyer, _orderId);
    }

    function releasePayment(uint256 _orderId, uint _paymentType) external {
        require(_paymentType < 2, "Invalid request");

        if(_paymentType == 0) {
            require(personalPayments[_orderId].buyer == msg.sender, "Permission denied");
            require(personalPayments[_orderId].status == PaymentStatus.Pending, "Payment can not be released");
            // require(personalPayments[_orderId].releaseTime < block.timestamp, "Payment can not be released");
        } else {
            require(professionalPayments[_orderId].buyer == msg.sender, "Permission denied");
            require(professionalPayments[_orderId].status == PaymentStatus.Pending, "Payment can not be released");
            // require(professionalPayments[_orderId].releaseTime < block.timestamp, "Payment can not be released");
        }

        _paymentRelease(_orderId, _paymentType);
    }

    function releasePaymentRequest(uint256 _orderId, uint _paymentType) external {
        require(allowReleaseRequest == true, "Request to release a payment is denied");
        require(_paymentType < 2, "Invalid request");

        if(_paymentType == 0) {
            require(personalPayments[_orderId].seller == msg.sender || msg.sender == owner(), "Permission denied");
            require(personalPayments[_orderId].status == PaymentStatus.Pending, "Payment can not be released");
            require(personalPayments[_orderId].releaseTime < block.timestamp, "Payment can not be released");
        } else {
            require(professionalPayments[_orderId].seller == msg.sender || msg.sender == owner(), "Permission denied");
            require(professionalPayments[_orderId].status == PaymentStatus.Pending, "Payment can not be released");
            require(professionalPayments[_orderId].releaseTime < block.timestamp, "Payment can not be released");
        }

        _paymentRelease(_orderId, _paymentType);
    }

    function _paymentRelease(uint256 _orderId, uint _paymentType) internal {
        if(_paymentType == 0) {
            Payment memory _payment = personalPayments[_orderId];

            lockedBalances[_payment.buyer] = lockedBalances[_payment.buyer].sub(_payment.amount);
            lockedPayments[_payment.seller].push(LockedPayment(PaymenentType.PersonalPayment, PaymentStatus.Pending, _orderId, _payment.buyer, _payment.amount, _payment.code, block.timestamp));

            emit PaymentReleased(0, _payment.seller, _orderId, _payment.amount);
            emit Paymentlocked(_orderId, 0, _payment.seller, _payment.buyer, _payment.amount, block.timestamp, _payment.code);

            if(_payment.isRecursive) {
                if(balances[_payment.buyer] < _payment.amount) {
                    personalPayments[_orderId].status = PaymentStatus.Rejected;

                    emit PaymentRejected(_payment.buyer, _orderId);
                } else {
                    balances[_payment.buyer] = balances[_payment.buyer].sub(_payment.amount);
                    lockedBalances[_payment.buyer] = lockedBalances[_payment.buyer].add(_payment.amount);
                    personalPayments[_orderId].releaseTime = block.timestamp + _payment.delay * 1 days;
                }
            } else {
                personalPayments[_orderId].status = PaymentStatus.Completed;
            }
        } else {
            Payment memory _payment = professionalPayments[_orderId];

            professionalPayments[_orderId].status = PaymentStatus.Completed;
            lockedBalances[_payment.buyer] = lockedBalances[_payment.buyer].sub(_payment.amount);
            lockedPayments[_payment.seller].push(LockedPayment(PaymenentType.ProfessionalPayment, PaymentStatus.Pending, _orderId, _payment.buyer, _payment.amount, _payment.code, block.timestamp));

            emit PaymentReleased(1, _payment.seller, _orderId, _payment.amount);
            emit Paymentlocked(_orderId, 1, _payment.seller, _payment.buyer, _payment.amount, block.timestamp, _payment.code);
        }
    }

    function unlockPayment(uint256 _orderId, string memory _code) external {
        require(lockedPayments[msg.sender].length > 0, "Locked payment not found");

        for(uint i = 0; i < lockedPayments[msg.sender].length; i++) {
            LockedPayment memory _payment = lockedPayments[msg.sender][i];
            if(_payment.orderId == _orderId) {
                require(keccak256(bytes(_payment.code)) == keccak256(bytes(_code)), "Payment code is wrong");
                require(_payment.status == PaymentStatus.Pending, "Already unlocked");

                lockedPayments[msg.sender][i].status = PaymentStatus.Completed;
                balances[msg.sender] = balances[msg.sender].add(_payment.amount);

                emit PaymentUnlocked(msg.sender, _orderId, _payment.amount);

                for(uint j = i; j < lockedPayments[msg.sender].length - 1; j++) {
                    lockedPayments[msg.sender][i] = lockedPayments[msg.sender][j+1];
                }
                lockedPayments[msg.sender].pop();
                
                break;
            }
        }
    }

    function balanceOf(address _address) external view returns (uint256, uint256, uint256) {
        uint256 available = 0;
        if(balances[_address] != 0) {
            available = balances[_address];
        }

        uint256 locked = 0;
        if(lockedBalances[_address] != 0) {
            locked = lockedBalances[_address];
        }

        for(uint i = 0; i < lockedPayments[_address].length; i++) {
            if(lockedPayments[_address][i].status == PaymentStatus.Pending) {
                locked = locked.add(lockedPayments[_address][i].amount);
            }
        }
        
        uint256 disputed = 0;
        for(uint i = 1; i <= orderIndex; i++) {
            if(professionalPayments[i].status != PaymentStatus.Disputed) continue;
            if(professionalPayments[i].buyer != _address &&  professionalPayments[i].seller != _address) continue;

            disputed = disputed.add(professionalPayments[i].amount);
        }

        return (available, locked, disputed);
    }

    function balance() external view returns (uint256, uint256, uint256) {
        uint256 available = 0;
        if(balances[msg.sender] != 0) {
            available = balances[msg.sender];
        }

        uint256 locked = 0;
        if(lockedBalances[msg.sender] != 0) {
            locked = lockedBalances[msg.sender];
        }

        for(uint i = 0; i < lockedPayments[msg.sender].length; i++) {
            if(lockedPayments[msg.sender][i].status == PaymentStatus.Pending) {
                locked = locked.add(lockedPayments[msg.sender][i].amount);
            }
        }

        uint256 disputed = 0;
        for(uint i = 1; i <= orderIndex; i++) {
            if(professionalPayments[i].status != PaymentStatus.Disputed) continue;
            if(professionalPayments[i].buyer != msg.sender &&  professionalPayments[i].seller != msg.sender) continue;
            disputed = disputed.add(professionalPayments[i].amount);
        }

        return (available, locked, disputed);
    }
    
    function setFee(uint256 _depositFee, uint256 _withdrawFee) external onlyOwner {
        require(_depositFee >= 0 && _withdrawFee >= 0, "Invalid fee");
        
        depositFee = _depositFee;
        withdrawFee = _withdrawFee;
    }

    function setWallet(address _wallet) external {
        require(wallet == msg.sender, "setWallet: Forbidden");
        wallet = _wallet;
    }
    function setReleaseReqStatus(bool _allowable) external onlyOwner {
        allowReleaseRequest = _allowable;
    }
}
