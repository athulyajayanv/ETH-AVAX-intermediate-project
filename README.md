# METACRAFTERS ETH-AVAX INTERMEDIATE PROJECT 1

This Solidity program defines a simple library system contract that demonstrates basic features and syntax of the Solidity programming language.

## Description

This Solidity contract demonstrates a simple library system, using require(), assert(), and revert() to handle book registrations, issuances, and returns, ensuring valid operations and internal consistency.

## Getting Started

### Executing program

1. To run this program, you can use Remix at https://remix.ethereum.org/.
2. Create a new file by clicking on the "+" icon in the left-hand sidebar.
3. Save the file with a .sol extension.

```javascript
// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
contract librarySystem{
    //creating enum to represent the status of the book
    enum BookStatus {Available, Taken}

    // Creating a structure to represent a book
    struct Book{ 
        string title;
        BookStatus status;
    } 

    //Mapping to store books with their ids
    mapping(uint => Book) public books;

    //Mapping to store the book ID taken by each person
    mapping(address => uint256) public takenBooks;

    //Address of contract owner
    address public owner;


    //Constructor to set the contract deployer as the owner
    constructor(){
        owner = msg.sender;
    }

    //Function access restricted to owner only
    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can access this function");
        _;
    }

    //To register new book
    function registerBook(uint _bookId, string memory _title) public onlyOwner{
        books[_bookId] = Book(_title, BookStatus.Available);
    }

    //To issue a book
    function issueBook(uint _bookId) public{
        require(books[_bookId].status == BookStatus.Available, "Book is not available");
        require(takenBooks[msg.sender] == 0, "You have already borrowed a book"); 

        books[_bookId].status = BookStatus.Taken;
        takenBooks[msg.sender] = _bookId;
    }

    //To return the book
    function returnBook() public{
        uint bookId = takenBooks[msg.sender];
        if (bookId == 0){
            revert("No book to return");
        }

        books[bookId].status = BookStatus.Available;
        takenBooks[msg.sender] = 0;

        assert(takenBooks[msg.sender] == 0);
    }
}
```
To compile the code,

1. Go to the 'Solidity Compiler' tab on the left.
2. Set the Compiler to 0.8.7 or a compatible version, and click Compile.
   
Once compiled,

1. Go to the 'Deploy & Run Transactions' tab on the left.
2. click Deploy.

After deploying, you can interact with the contract.

## Authors

Athulya Jayan V


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
