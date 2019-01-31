pragma solidity >=0.4.21 <0.6.0;

contract FutureCoin{
    uint sellerMargin; 
    uint buyerMargin;
    uint sellerAddedMar;
    uint buyerAddedMar;
    uint price = 200;
    uint constant MAINTENANCE_MARGIN = 10;
    uint marginLevel;
    uint time;

}