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
