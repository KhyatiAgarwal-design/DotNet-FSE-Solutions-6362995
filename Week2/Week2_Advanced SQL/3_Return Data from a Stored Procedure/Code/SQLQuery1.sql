USE EmployeeDB;
GO

-- Drop the procedure if it already exists (optional but good practice)
IF OBJECT_ID('sp_CountEmployeesByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_CountEmployeesByDepartment;
GO

CREATE PROCEDURE sp_CountEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT 
        D.DepartmentName,
        COUNT(E.EmployeeID) AS TotalEmployees
    FROM 
        Departments D
    LEFT JOIN 
        Employees E ON D.DepartmentID = E.DepartmentID
    WHERE 
        D.DepartmentID = @DeptID
    GROUP BY 
        D.DepartmentName;
END;
GO
SELECT 
    D.DepartmentName,
    COUNT(E.EmployeeID) AS TotalEmployees
FROM 
    Departments D
LEFT JOIN 
    Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY 
    D.DepartmentName;

