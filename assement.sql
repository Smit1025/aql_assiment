-- Create Bank table
CREATE TABLE Bank (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(255),
    branch_city VARCHAR(255)
);

-- Create AccountHolder table
CREATE TABLE AccountHolder (
    account_holder_id INT PRIMARY KEY,
    account_no INT,
    account_holder_name VARCHAR(255),
    city VARCHAR(255),
    contact VARCHAR(15),
    date_of_account_created DATE,
    account_status VARCHAR(15),
    account_type VARCHAR(15),
    balance DECIMAL(10, 2)
);

-- Create Loan table
CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_id INT,
    account_holder_id INT,
    loan_amount DECIMAL(10, 2),
    loan_type VARCHAR(255),
    FOREIGN KEY (branch_id) REFERENCES Bank(branch_id),
    FOREIGN KEY (account_holder_id) REFERENCES AccountHolder(account_holder_id)
);



-- Deduct $100 from account A
UPDATE AccountHolder
SET balance = balance - 100
WHERE account_no = 1;

-- Add $100 to account B
UPDATE AccountHolder
SET balance = balance + 100
WHERE account_no = 2;

-- Commit the transaction
COMMIT;

SELECT *
FROM AccountHolder
WHERE city IN (SELECT city FROM AccountHolder GROUP BY city HAVING COUNT(*) > 1);

SELECT account_no, account_holder_name
FROM AccountHolder
WHERE DAY(date_of_account_created) > 15;

SELECT branch_city AS City, COUNT(*) AS Count_Branch
FROM Bank
GROUP BY branch_city;


SELECT AH.account_holder_id, AH.account_holder_name, L.branch_id, L.loan_amount
FROM AccountHolder AH
JOIN Loan L ON AH.account_holder_id = L.account_holder_id;
