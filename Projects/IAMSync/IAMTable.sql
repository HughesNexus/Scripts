CREATE TABLE IAMUsers (
    iam_user_id NVARCHAR(MAX) PRIMARY KEY,
    SamAccountName NVARCHAR(MAX),
    GivenName NVARCHAR(MAX),
    SurName NVARCHAR(MAX),
    DisplayName NVARCHAR(MAX),
    Job_Title NVARCHAR(MAX),
    Department NVARCHAR(MAX),
    Company NVARCHAR(MAX),
    StreetAddress NVARCHAR(MAX),
    City NVARCHAR(MAX),
    State NVARCHAR(MAX),
    PostalCode NVARCHAR(50),
    country NVARCHAR(MAX),
    office NVARCHAR(MAX),
    job NVARCHAR(MAX),
    employeeNumber NVARCHAR(MAX),
    employeeID NVARCHAR(MAX),
    EmployeeType NVARCHAR(MAX),
    relation_ship_status NVARCHAR(MAX),
    UserPrincipalName NVARCHAR(MAX),
    manager NVARCHAR(MAX),
    division NVARCHAR(MAX),
    facility_short_name NVARCHAR(MAX),
    region NVARCHAR(MAX)
);

