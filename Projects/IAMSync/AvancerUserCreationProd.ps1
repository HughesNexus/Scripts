
function Get-AvancerToken {
    [CmdletBinding()]
    param (
        
    )

    
    process {


        $response = Invoke-RestMethod 'https://identitybridgeapi.phsi.primehealthcare.com/idmcontroller/oauth2/token?grant_type=client_credentials&client_id=NjgxMDliNzQtOGI2NC00MTQ0LTg4NzYtNWE3NjdlZGJmNTU5&client_secret=AJqeuSdUi7wGFzYX73RReQBi8-hjXMRCAVtlJk54JIdU8C5qElc212MJCnV1iD_tx2vbZNg-bjfehqFNoNQZ-58' -Method 'POST' -Headers $headers
        $response | ConvertTo-Json
        
    }
    
    end {
        
    }
}


function Update-AvancerUser {
    [CmdletBinding()]
    param (
        $accesstoken,
        $givenname,
        $surname,
        $department,
        $Division,
        $EmployeeNumber,
        $EmployeeType,
        $EmployeeID,
        $Company,
        $Office,
        $Title,
        $StreetAddress,
        $City,
        $PostalCode,
        $Manager,
        $Description,
        $PhysicalDeliveryOfficeName,
        $extensionattribute15,
        $country,
        $extensionattribute12,
        $c,
        $co,
        $countrycode,
        $state

    )
    Process{
    $Headers = @{
        PublicKey = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqt6yOiI/wCoCVlGO0MySsez0VkSqhPvDl3rfabOslx35mYEO+n4ABfIT5Gn2zN+CeIcOZ5ugAXvIIRWv5H55+tzjFazi5IKkOIMCiz5//MtsdxKCqGlZu2zt+BLpqTOAPiflNPpM3RUAlxKAhnYEqNha6+allPnFQupnW/eTYoyuzuedT7dSp90ry0ZcQDimntXWeaSbrYKCj9Rr9W1jn2uTowUuXaScKXTCjAmJVnsD75JNzQfa8DweklTyWQF+Y5Ky039I0VIu+0CIGhXY48GAFe2EFb8VpNhf07DP63p138RWQ1d3KPEM9mYJVpQC68j3wzDQYSljpLf9by7TGwIDAQAB'
        "Content-Type" = 'application/json ; charset=UTF-8'
    }

$body = @"

{
        "sourceSystemId": "IAM HR",
        "scimPerson": {
            "profileUrl": "",
            "entitlements": [],
            "x509Certificates": [],
            "addresses": [
                {

                    "streetAddress": "$($StreetAddress)",
                    "formatted": "",
                    "postalCode": "$($PostalCode)",
                    "locality": "$($City)",
                    "type": "",
                    "region": "$($State)",
                    "country": "$($country)"
                }
            ],
            "nickName": "",
            "roles": [],
            "externalId": "",
            "groups": [],
            "active": "active",
            "userName": "",
            "title": "$($Title)",
            "locale": "",
            "photos": [],
            "phoneNumbers": [],
            "ims": [],
            "emails": [
                {
                    "type": "primary",
                    "value": "",
                    "primary": "true"
                }
            ],
            "password": "",
            "meta": {
                "created": "",
                "location": "",
                "lastModified": "",
                "version": ""
            },
            "schemas": [],
            "customAttributes": [
                {
                    "values": [
                        "$($department)"
                    ],
                    "name": "departmentName"
                },
                {
                    "values": [
                        "$($extensionattribute15)"
                    ],
                    "name": "Site"
                },
                {
                    "values": [
                        ""
                    ],
                    "name": "Description"
                },
                {
                    "values": [
                        ""
                    ],
                    "name": "endDate"
                },
                {
                    "values": [
                        ""
                    ],
                    "name": "Comments"
                },
                {
                    "values": [
                        ""
                    ],
                    "name": "departmentID"
                },
                {
                    "values": [
                        "$($MgrSamAccountName)"
                    ],
                    "name": "managerDisplayName"
                },
                {
                    "values": [
                        ""
                    ],
                    "name": "Alias"
                },
                {
                    "values": [
                        ""
                    ],
                    "name": "startDate"
                },
                {
                    "values": [
                        "$($MgrEmail)"
                    ],
                    "name": "ManagerEmailAddress"
                },
                {
                    "name": "Company",
                    "values": [
                        "Prime Healthcare Management"
                    ]
                },
                {
                    "name": "ApplicationName",
                    "values": [
                        "ActiveDirectory"
                    ]
                },
                {
                    "name": "AccountType",
                    "values": [
                        "Employee"
                    ]
                },
                {
                    "name": "EmployeeType",
                    "values": [
                        "NonExempt"
                    ]
                },
                {
                    "name": "externalId",
                    "values": [
                        "$($EmployeeID)"
                    ]
                },
                {
                    "name": "PreferredFirstname",
                    "values": [
                        "$($GivenName)"
                    ]
                },
                {
                    "name": "HospitalShortName",
                    "values": [
                        "$($extensionattribute15)"
                    ]
                },
                {
                    "name": "JobCode",
                    "values": [
                        "$($extensionattribute12)"
                    ]
                },
                {
                    "name": "Division",
                    "values": [
                        "$($Division)"
                    ]
                },
                {
                    "name": "EmployeeNumber",
                    "values": [
                        "$($EmployeeNumber)"
                    ]
                },
                {
                    "name": "office",
                    "values": [
                        "$($PhysicalDeliveryOfficeName)"
                    ]
                },
                {
                    "name": "CountryFullName",
                    "values": [
                        "$($co)"
                    ]
                },
                {
                    "name": "CountryCode",
                    "values": [
                        "$($countrycode)"
                    ]
                },
                {
                    "name": "employeerefid",
                    "values": [
                        ""
                    ]
                }


            ],
            "name": {
                "honorificSuffix": "",
                "givenName": "$($GivenName)",
                "familyName": "$($SurName)",
                "honorificPrefix": "",
                "middleName": ""
            },
            "id": "",
            "userType": "NonExempt"
        },
        "action": "update_user",
        "destinationSystemId": "Active Directory",
        "provisionedUserId": ""
}
"@

$invokeRestMethodSplat = @{
    Method = 'POST'
    Headers = $headers
    Body = $body
    Uri = "https://identitybridgeapi.phsi.primehealthcare.com/idmcontroller/connector/controller/api/v3/request?token=$($accesstoken)&scope=application function"
}
$body
#Invoke-RestMethod @invokeRestMethodSplat 

    }
}


$Token = (Get-AvancerToken | ConvertFrom-Json).access_token

$User = Get-ADUser -Identity MPattabi -properties * 

$Params = @{
    accesstoken = $Token
    givenname = $User.givenName
    surname = $User.surname  
    department = $User.department
    Division = $User.Division
    EmployeeNumber = $User.EmployeeNumber
    EmployeeType = $User.EmployeeType
    EmployeeID = $User.EmployeeID
    Company = 'Prime Healthcare Services'
    Office = $User.PhysicalDeliveryOfficeName
    Title = $User.Title
    StreetAddress = $User.streetAddress
    City = $User.City
    PostalCode = $User.postalCode
    Manager = $User.manager
    Description = $User.Description
    PhysicalDeliveryOfficeName = $User.PhysicalDeliveryOfficeName
    extensionattribute15 = $User.extensionattribute15
   # counter = $Counter
    extensionattribute12 = $user.extensionattribute12
    c = $user.c
    co = $user.co
    countrycode = $user.countrycode
    state = $user.State
    country = $user.Country
}

Update-AvancerUser @Params