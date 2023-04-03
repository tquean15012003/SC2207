DROP DATABASE SC2207Lab5;
CREATE DATABASE SC2207Lab5;

USE SC2207Lab5;

CREATE TABLE Bookstore(
	storeID INT NOT NULL AUTO_INCREMENT,
    storeName VARCHAR(100) NOT NULL,
    PRIMARY KEY (storeID)
);

------------------------------------------

CREATE TABLE StorePublication(
	storePublicationID INT NOT NULL AUTO_INCREMENT,
	quantity INT NOT NULL,
	publicationID INT NOT NULL,
    storeID INT NOT NULL,
    PRIMARY KEY (storePublicationID),
	FOREIGN KEY (storeID) REFERENCES Bookstore(storeID)
);

------------------------------------------

CREATE TABLE PriceHistory(
	storePublicationID INT NOT NULL AUTO_INCREMENT,
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
    price FLOAT NOT NULL,
    PRIMARY KEY (storePublicationID, startDate),
	FOREIGN KEY (storePublicationID) REFERENCES StorePublication(storePublicationID)
);

------------------------------------------

CREATE TABLE Magazine(
	publicationID INT NOT NULL,
	issueNumber INT NOT NULL,
	yearOfPublication YEAR NOT NULL,
    title VARCHAR(100) NOT NULL,
	publisher VARCHAR(100) NOT NULL,
    UNIQUE(issueNumber),
    PRIMARY KEY (publicationID)
);

------------------------------------------

CREATE TABLE Book(
	publicationID INT NOT NULL,
	yearOfPublication YEAR NOT NULL,
    title VARCHAR(100) NOT NULL,
	publisher VARCHAR(100) NOT NULL,
    PRIMARY KEY (publicationID)
);

------------------------------------------

CREATE TABLE Customer(
	customerID INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
    PRIMARY KEY (customerID)
);

------------------------------------------

CREATE TABLE OrderMade (
	orderID INT NOT NULL AUTO_INCREMENT,
	address VARCHAR(100) NOT NULL,
	shippingCost FLOAT NOT NULL,
	timeCreated DATETIME NOT NULL, 
    customerID INT NOT NULL,
	FOREIGN KEY (customerID) REFERENCES Customer(customerID),
    PRIMARY KEY (orderID)
);

CREATE TABLE ItemPurchased (
	itemPurchasedID INT NOT NULL AUTO_INCREMENT,
	price FLOAT NOT NULL,
	quantity INT NOT NULL,
	storePublicationID INT NOT NULL, 
    orderID INT NOT NULL,
	FOREIGN KEY (storePublicationID) REFERENCES StorePublication(storePublicationID),
	FOREIGN KEY (orderID) REFERENCES OrderMade(orderID),
    PRIMARY KEY (itemPurchasedID)
);

CREATE TABLE ItemPurchasedStatus (
	itemPurchasedID INT NOT NULL,
	timeCreated DATETIME NOT NULL,
	statusDescription VARCHAR(100) NOT NULL,
	FOREIGN KEY (itemPurchasedID) REFERENCES ItemPurchased(itemPurchasedID),
    PRIMARY KEY (itemPurchasedID, timeCreated)
);

CREATE TABLE Review (
	itemPurchasedID INT NOT NULL,
	timeCreated DATETIME NOT NULL,
	commentDescription VARCHAR(100) NOT NULL,
    rating INT NOT NULL,
	FOREIGN KEY (itemPurchasedID) REFERENCES ItemPurchased(itemPurchasedID),
    PRIMARY KEY (itemPurchasedID, timeCreated)
)