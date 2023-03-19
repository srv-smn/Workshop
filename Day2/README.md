# Workshop DAY 2 - Blockchain Basics

## Content
- Introduction to Ethereum
- Introduction to Remix
- Introduction to Solidity

## Introtuction to Remix: [Remix IDE](https://remix.ethereum.org/)

## Introductin to Solidity

### Doc
[Official Doc](https://docs.soliditylang.org/en/v0.8.19/)


### Sample Contract

```
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}
```

### define the Solidity version compiler

```
// Any compiler version from the 0.8 release (= 0.8.x)
pragma solidity ^0.8.0;
// Greater than version 0.7.6, less than version 0.8.4
pragma solidity >0.7.6 <0.8.4;
```

### define a contract
```
contract Score {
// You will start writing your code here =)
}
```

### variable in Solidity

```
contract Score {
uint score = 5;
}
```

## Data types

`bool` : The possible values are constants true and false.

`Integers` 

`uint`  : defines an unsigned integer of 256 bits by default.
You can also specify the number of bits, by range of 8 bits. Here are some examples below:
<img width="364" alt="image" src="https://user-images.githubusercontent.com/47235134/226115578-d0462425-fa51-4a62-bb4b-b405e3ac3658.png">


`int` : defines an signed integer of 256 bits by default.

`Address` : Holds a 20 byte value (size of an Ethereum address).

`address a = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;`

## Getter and Setter
` contract Score {
 
uint score = 5;
 
function getScore() returns (uint) {
 
return score;
 
}
 
function setScore(uint new_score) {
 
score = new_score;
 
}
} `

## Function visibility
<img width="721" alt="image" src="https://user-images.githubusercontent.com/47235134/226148568-93f00f09-b782-4501-8715-70000a8586cc.png">

## View vs Pure ?
view functions can only read from the contract storage. They can’t modify the contract
storage. Usually, you will use view for getters.
pure functions can neither read nor modify the contract storage. They are only used
for computation (like mathematical operations).
Because our function getScore() only reads from the contract state, it is a view function.
`
function getScore() public view returns (uint) {

return score;

} 
`

## Extra Info
Solidity provides a global variable msg , that refers to the address that interacts with the
contract’s functions. The msg variables offers two associated fields:

`msg.sender` : returns the address of the caller of the function.
`msg.value` : returns the value in Wei of the amount of Ether sent to the function.

## modifiers

A modifier is a special function that enables us to change the behaviour of
functions in Solidity. It is mostly used to automatically check a condition before executing a
function.

`

address owner;

modifier onlyOwner {

if (msg.sender == owner) {

_;

}

}

function setScore(uint new_score) public onlyOwner {

score = new_score;

}

`

The modifier works with the following flow:
1. Check that the address of the caller ( msg.sender ) is equal to owner address.
2. If 1) is true, it passes the check. The _; will be replaced by the function body where
the modifier is attached.
A modifier can receive arguments like functions. Here is an example of a modifier that
requires the caller to send a specific amount of Ether.

`
modifier Fee(uint fee) {

if (msg.value == fee) {

_;

}

}
`

## Constructor

` 
contract Score {

address owner;

constructor() {

owner = msg.sender;

}

} `

## Advance Data Types

### Mappings

Mappings are another important complex data type used in Solidity. They are useful for
association, such as associating an address with a balance or a score. You define a
mapping in Solidity as follow:

mapping(KeyType => ValueType) mapping_name;

<img width="352" alt="image" src="https://user-images.githubusercontent.com/47235134/226148712-6497e545-1d0d-4073-8177-7989cd0c4fbb.png">

You can access the value associated with a key in a mapping by specifing the key name
inside square brackets [] as follows: mapping_name[key] .
Our smart contract will store a mapping of all the user’s addresses and their associated
score. The function getUserScore(address _user) enables to retrieve the score
associated to a specific user’s address.

`
mapping(address => uint) score_list;

function getUserScore(address user) public view returns (uint) {

return score_list[user];

}
`

### Arrays

Arrays are also an important part of Solidity. You have two types of arrays ( T represents
the data type and k the maximum number of elements):
Fixed size array : T[k]
Dynamic size array : T[]

uint[] all_possible_number;
uint[9] one_digit_number;

In Solidity, arrays are ordered numerically. Array indices are zero based. So the index of the
1st element will be 0. You access an element in an array in the same way than you do for a
mapping:

` uint my_score = score_list[owner]; `

You can also used the following two methods to work with arrays:
array_name.length : returns the number of elements the array holds.
array_name.push(new_element) : adds a new element at the end of the array.

### Structs

We can build our own datatypes by combining simpler datatypes together into more complex
types using structs.
We use the keyword struct, followed by the structure name , then the fields that make up
the structure.
For example:

`

struct Funder {

address addr;

uint amount;

} `

Here we have created a datatype called Funder, that is composed of an address and a uint.
We can now declare a variable of that type

Funder giver;

and reference the elements using dot notation

giver.addr = address (0xBA7283457B0A138890F21DE2ebCF1AfB9186A2EF);
giver.amount = 2500;

The size of the structure has to be finite, this imposes restrictions on the elements that can
be included in the struct.

## For Reference 
[Solidity by example](https://solidity-by-example.org/)






