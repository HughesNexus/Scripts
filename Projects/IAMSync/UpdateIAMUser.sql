CREATE PROCEDURE UpdateOrAddIAMUser
    @iam_user_id NVARCHAR(MAX),
    @SamAccountName NVARCHAR(MAX),
    @GivenName NVARCHAR(MAX),
    @SurName NVARCHAR(MAX),
    @DisplayName NVARCHAR(MAX),
    @Job_Title NVARCHAR(MAX),
    @Department NVARCHAR(MAX),
    @Company NVARCHAR(MAX),
    @StreetAddress NVARCHAR(MAX),
    @City NVARCHAR(MAX),
    @State NVARCHAR(MAX),
    @PostalCode NVARCHAR(50),
    @country NVARCHAR(MAX),
    @office NVARCHAR(MAX),
    @job NVARCHAR(MAX),
    @employeeNumber NVARCHAR(MAX),
    @employeeID NVARCHAR(MAX),
    @EmployeeType NVARCHAR(MAX),
    @relation_ship_status NVARCHAR(MAX),
    @UserPrincipalName NVARCHAR(MAX),
    @manager NVARCHAR(MAX),
    @division NVARCHAR(MAX),
    @facility_short_name NVARCHAR(MAX),
    @region NVARCHAR(MAX)
AS
BEGIN
    -- Check if the IAM user exists based on iam_user_id
    IF EXISTS (SELECT 1 FROM IAMUsers WHERE iam_user_id = @iam_user_id)
    BEGIN
        -- Update the existing user
        UPDATE IAMUsers
        SET
            SamAccountName = @SamAccountName,
            GivenName = @GivenName,
            SurName = @SurName,
            DisplayName = @DisplayName,
            Job_Title = @Job_Title,
            Department = @Department,
            Company = @Company,
            StreetAddress = @StreetAddress,
            City = @City,
            State = @State,
            PostalCode = @PostalCode,
            country = @country,
            office = @office,
            job = @job,
            employeeNumber = @employeeNumber,
            employeeID = @employeeID,
            EmployeeType = @EmployeeType,
            relation_ship_status = @relation_ship_status,
            UserPrincipalName = @UserPrincipalName,
            manager = @manager,
            division = @division,
            facility_short_name = @facility_short_name,
            region = @region
        WHERE iam_user_id = @iam_user_id;
    END
    ELSE
    BEGIN
        -- Insert a new user if it doesn't exist
        INSERT INTO IAMUsers (
            iam_user_id,
            SamAccountName,
            GivenName,
            SurName,
            DisplayName,
            Job_Title,
            Department,
            Company,
            StreetAddress,
            City,
            State,
            PostalCode,
            country,
            office,
            job,
            employeeNumber,
            employeeID,
            EmployeeType,
            relation_ship_status,
            UserPrincipalName,
            manager,
            division,
            facility_short_name,
            region
        )
        VALUES (
            @iam_user_id,
            @SamAccountName,
            @GivenName,
            @SurName,
            @DisplayName,
            @Job_Title,
            @Department,
            @Company,
            @StreetAddress,
            @City,
            @State,
            @PostalCode,
            @country,
            @office,
            @job,
            @employeeNumber,
            @employeeID,
            @EmployeeType,
            @relation_ship_status,
            @UserPrincipalName,
            @manager,
            @division,
            @facility_short_name,
            @region
        );
    END
END;
