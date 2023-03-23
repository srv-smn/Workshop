## Steps to deploy

## Contracts
- ERC 20 token Contract
- NFT Contract
- Auction/Realstate contract

For this current example we will take 3 Accounts.Let’s call them as Account 1, Account 2, Account 3.

Steps to deploy:

1. Deploy `ERC20`(from Account 1)
2. Deploy `NFT`(from Account 1)
3. Mint a `NFT` (from Account 1) to Account 1.
    
    Steps:
    
    a. Call `safeMint` function of ERC721
    b. in `to` argument pass the address of Account 1
    c. in `tokenId` argument pass the tokenId 1
    d. in `uri` pass any string , since you are deploying it on local network.
    
 4. Deploy the `Auction` contract by passing the required arguments:
    
    Steps:
    
    a. pass the address of `ERC20` contract in `_ERC20` parameter
    b. pass the address of `ERC721` contract in `_ERC721` parameter 
    c. pass the NFT index (ie. 1) in `NFTID` parameter 
    d. pass the `1000000000000000000`  (1 eth denomination)in `_HIGHESTBID` paramenter.
 
 Now We want Account 2 and Account 3 to participate in the bidding process. But to get started with the biding process Account 2 and Account 3 should have ERC20 token into their wallet.

so lets see the further process:

5. Mint ERC20 token from Account 1(as this account is the owner of ERC20) to Account 2.
    
    Steps to mint:
    
    a. call `mint` function of ERC20 and pass Account’s 2 address in `to` argument and `1000000000000000000000` (1000 token) in `amount` argument.
    b. call `mint` function of ERC20 and pass Account’s 3 address in `to` argument and `1000000000000000000000` (1000 token) in `amount` argument.

Before we can bid we need to start the bidding process. As we know in `start()` function we will transfer NFT from Account 1 to Auction Contract. so before calling Start we need to give approval to Auction contract to access Account’s 1 NFT .

6. call `approve` function from Account 1 of NFT contract. pass `Auction` contract address in `to` argument and `1` in `tokenId` argument.
To start the bidding process we need follow the below steps:
7. call `start()` function from Account 1 (as  he is the owner of Auction)

Now we are all set to start the Bidding process, Since Account 2 and Account 3 will participate in bidding. we need to give approval to `Auction` contract from Account 2 and Account 3 of ERC20 contract. Here is the steps to do so.
    

8. call `approve()` function from Account 2 of ERC20 contract, pass `Auction` contract address in `spender` parameter and `1000000000000000000000` in `amount` parameter.
Note we had provided approval `1000000000000000000000` (ie 1000) token. We had passed large number because we don’t want to call `approve()` function before calling `bid()` function every time.
9. call `approve()` function from Account 3 of ERC20 contract, pass `Auction` contract address in `spender` parameter and `1000000000000000000000` in `amount` parameter.
Note we had provided approval `1000000000000000000000` (ie 1000) token. We had passed large number because we don’t want to call `approve()` function before calling `bid()` function every time.

Now we can `bid()` function from Account 2 and Account 3. and play around it.
once time is over for bidding you can call `end()` function so that NFT will be transfered to Highest Bidder and Money will be transfered to seller.
    
Note: to check the balance ofERC20 token you can call balanceOf function of ERC20.    

    
