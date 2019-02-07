pragma solidity >=0.4.21 <0.6.0;

// import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract FutureCoin{
    uint sellerMargin; 
    uint buyerMargin;
    uint sellerAddedMar;
    uint buyerAddedMar;
    uint price = 200;
    uint constant MAINTENANCE_MARGIN = 10;
    uint marginLevel;
    uint time;

    constructor(uint margin, uint t) public{
        sellerMargin = margin;
        buyerMargin = margin;
        marginLevel = margin;
        time = t;
        
    }

    /**
	 * When it is a new day of trading, set a new price and update margins.
	 */
    function newDay() internal {
        uint original = generatePrice();
        uint difference = price - original;

        buyerMargin += difference;
        sellerMargin -= difference;

        if (buyerMargin < MAINTENANCE_MARGIN) {
            buyerAddedMar += marginLevel - buyerMargin;
            addToMargin(1);
        }

        if(sellerMargin < MAINTENANCE_MARGIN) {
            sellerAddedMar += marginLevel - sellerMargin;
            addToMargin(0);
        }
    }

    /**
	 * If margin is below MAINTENANCE_MARGIN, add money up to the marginLevel
	 * from the buyer/seller's account to the margin account.
	 */
    function addToMargin(uint who) internal {
        if (who == 0){
            sellerMargin = marginLevel;
        }else
			buyerMargin = marginLevel;
    }

    /**
	 * Set a new price using random numbers from 0 to 9.
	 */
    function generatePrice() internal returns(uint){
        uint sign = uint(blockhash(block.number-1))%10;
        uint original = price;
        if(sign % 2 == 0)
			price += uint(blockhash(block.number-1))%10;
		else
			price -= uint(blockhash(block.number-1))%10;
        return original;
    }
}