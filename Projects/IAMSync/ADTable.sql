USE [AdUsers]
GO

/****** Object:  Table [dbo].[AllAdUsers]    Script Date: 3/7/2023 9:11:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AllAdUsers](
	[SamAccountName] [nvarchar](50) NOT NULL,
	[UserPrincipalName] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[GivenName] [nvarchar](max) NULL,
	[SurName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[Department] [nvarchar](max) NULL,
	[Division] [nvarchar](max) NULL,
	[EmployeeNumber] [nvarchar](max) NULL,
	[EmployeeType] [nvarchar](max) NULL,
	[EmployeeID] [nvarchar](max) NULL,
	[Company] [nvarchar](max) NULL,
	[Organization] [nvarchar](max) NULL,
	[Office] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[StreetAddress] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[PostalCode] [nvarchar](50) NULL,
	[Country] [nvarchar](max) NULL,
	[Manager] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[PhysicalDeliveryOfficeName] [nvarchar](max) NULL,
	[PasswordExpired] [bit] NULL,
	[PasswordLastSet] [datetime2](7) NULL,
	[ExtensionAttribute11] [nvarchar](max) NULL,
	[ExtensionAttribute12] [nvarchar](max) NULL,
	[ExtensionAttribute13] [nvarchar](max) NULL,
	[ExtensionAttribute15] [nvarchar](max) NULL,
 CONSTRAINT [PK_SamAccountName] PRIMARY KEY CLUSTERED 
(
	[SamAccountName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO