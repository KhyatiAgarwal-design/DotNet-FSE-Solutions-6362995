-- STEP 1: Use existing database
USE EmployeeDB;
GO

-- STEP 2: Add new departments if not already present
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 5, 'Operations'
WHERE NOT EXISTS (
    SELECT 1 FROM Departments WHERE DepartmentID = 5
);

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 6, 'Legal'
WHERE NOT EXISTS (
    SELECT 1 FROM Departments WHERE DepartmentID = 6
);
GO

-- STEP 3: Add new employees (use NEW EmployeeIDs to avoid duplicates)

-- Check the max EmployeeID
DECLARE @MaxID INT;
SELECT @MaxID = ISNULL(MAX(EmployeeID), 0) FROM Employees;

-- Insert new employees starting from next ID
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate)
VALUES
(@MaxID + 1, 'Robert', 'Brown', 1, 5200.00, '2022-04-10'),
(@MaxID + 2, 'Laura', 'Wilson', 2, 6400.00, '2021-06-18'),
(@MaxID + 3, 'David', 'Clark', 3, 7500.00, '2023-01-05'),
(@MaxID + 4, 'Sophia', 'Martinez', 5, 5800.00, '2023-10-21'),
(@MaxID + 5, 'Daniel', 'Lewis', 6, 5000.00, '2024-02-15');
GO

-- STEP 4: Create sp_GetEmployeesByDepartment

IF OBJECT_ID('sp_GetEmployeesByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetEmployeesByDepartment;
GO

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT 
        E.EmployeeID,
        E.FirstName,
        E.LastName,
        D.DepartmentName,
        E.Salary,
        E.JoinDate
    FROM 
        Employees E
    INNER JOIN 
        Departments D ON E.DepartmentID = D.DepartmentID
    WHERE 
        E.DepartmentID = @DeptID;
END;
GO

-- STEP 5: Create sp_InsertEmployee

IF OBJECT_ID('sp_InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE sp_InsertEmployee;
GO

CREATE PROCEDURE sp_InsertEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE
AS
BEGIN
    DECLARE @NewID INT;

    -- Find next available EmployeeID
    SELECT @NewID = ISNULL(MAX(EmployeeID),0) + 1 FROM Employees;

    INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate)
    VALUES (@NewID, @FirstName, @LastName, @DepartmentID, @Salary, @JoinDate);
END;
GO

EXEC sp_GetEmployeesByDepartment @DeptID = 3;
EXEC sp_InsertEmployee
    @FirstName = 'Nina',
    @LastName = 'Taylor',
    @DepartmentID = 4,
    @Salary = 6700.00,
    @JoinDate = '2025-06-25';
SELECT * FROM Employees WHERE DepartmentID = 4;
