USE [master]
GO
/****** Object:  Database [Uber]    Script Date: 01-04-2021 19:38:10 ******/
CREATE DATABASE [Uber]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Uber', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Uber.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Uber_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Uber_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Uber] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Uber].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Uber] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Uber] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Uber] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Uber] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Uber] SET ARITHABORT OFF 
GO
ALTER DATABASE [Uber] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Uber] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Uber] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Uber] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Uber] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Uber] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Uber] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Uber] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Uber] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Uber] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Uber] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Uber] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Uber] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Uber] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Uber] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Uber] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Uber] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Uber] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Uber] SET  MULTI_USER 
GO
ALTER DATABASE [Uber] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Uber] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Uber] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Uber] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Uber] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Uber] SET QUERY_STORE = OFF
GO
USE [Uber]
GO
/****** Object:  Schema [Admins]    Script Date: 01-04-2021 19:38:10 ******/
CREATE SCHEMA [Admins]
GO
/****** Object:  Schema [Drivers]    Script Date: 01-04-2021 19:38:10 ******/
CREATE SCHEMA [Drivers]
GO
/****** Object:  Schema [Riders]    Script Date: 01-04-2021 19:38:10 ******/
CREATE SCHEMA [Riders]
GO
/****** Object:  Table [Riders].[Riders]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Riders].[Riders](
	[RiderID] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[EmailVerified] [bit] NOT NULL,
	[IsNew] [bit] NOT NULL,
	[ContactNumber] [decimal](10, 0) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
	[InviteCode] [varchar](20) NOT NULL,
	[Country] [varchar](50) NULL,
	[IsBlocked] [bit] NULL,
	[IsLoggedIn] [bit] NULL,
	[SessionExpiresIn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RiderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Riders].[vRiders]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [Riders].[vRiders]
AS
SELECT 
RiderID, 
FirstName,
LastName,
Email,
EmailVerified,
IsNew,
ContactNumber,
InviteCode,
Country,
IsBlocked,
IsLoggedIn,
SessionExpiresIn,
CreatedAt,
ModifiedAt
FROM Riders.Riders
GO
/****** Object:  Table [dbo].[Trips]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trips](
	[TripID] [bigint] IDENTITY(1,1) NOT NULL,
	[RiderID] [bigint] NOT NULL,
	[DriverID] [bigint] NOT NULL,
	[SourceLocationID] [bigint] NOT NULL,
	[DestinationLocationID] [bigint] NOT NULL,
	[RideTypeID] [bigint] NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Status] [varchar](20) NOT NULL,
	[EstimatedFairAmount] [float] NULL,
	[ActualFairAmount] [float] NULL,
	[PaymentMethod] [varchar](50) NULL,
	[CancelledBy] [varchar](20) NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TripID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vCurrentTrips]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[vCurrentTrips]
AS
SELECT 
TripID,
RiderID, 
DriverID, 
SourceLocationID, 
DestinationLocationID,
RideTypeID,
StartTime,
EndTime,
Status,
EstimatedFairAmount,
ActualFairAmount,
CancelledBy,
CreatedAt, 
ModifiedAt
FROM Trips WHERE Status='Current'
GO
/****** Object:  Table [Drivers].[Drivers]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Drivers].[Drivers](
	[DriverID] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[EmailVerified] [bit] NOT NULL,
	[ContactNumber] [decimal](10, 0) NOT NULL,
	[TotalRidesDone] [int] NOT NULL,
	[TotalRidesCancelled] [int] NOT NULL,
	[Salary] [float] NULL,
	[IsBlocked] [bit] NULL,
	[IsLoggedIn] [bit] NULL,
	[SessionExpiresIn] [datetime] NULL,
	[Password] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DriverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Drivers].[vDrivers]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [Drivers].[vDrivers]
AS
SELECT 
DriverID, 
FirstName,
LastName,
Email,
EmailVerified,
ContactNumber,
TotalRidesDone,
TotalRidesCancelled,
Salary,
IsBlocked,
IsLoggedIn,
SessionExpiresIn,
CreatedAt,
ModifiedAt
FROM Drivers.Drivers
GO
/****** Object:  View [Riders].[RiderCredentials]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [Riders].[RiderCredentials]
AS
SELECT
RiderID,
Password,
IsBlocked,
IsLoggedIn,
SessionExpiresIn
FROM Riders.Riders;
GO
/****** Object:  View [Drivers].[DriverCredentials]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- view to access Credentials of Driver
CREATE   VIEW [Drivers].[DriverCredentials]
AS
SELECT
DriverID,
Password,
IsBlocked,
IsLoggedIn,
SessionExpiresIn
FROM Drivers.Drivers;
GO
/****** Object:  Table [Admins].[Admins]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Admins].[Admins](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[ContactNumber] [decimal](10, 0) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [bigint] IDENTITY(1,1) NOT NULL,
	[LocationName] [varchar](max) NOT NULL,
	[Longitude] [float] NOT NULL,
	[Latitude] [float] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RideTypes]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RideTypes](
	[RideTypeID] [bigint] IDENTITY(1,1) NOT NULL,
	[RideName] [varchar](50) NOT NULL,
	[PricePerKm] [float] NOT NULL,
	[SeatingCapacity] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RideTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Drivers].[ApplicableIncentives]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Drivers].[ApplicableIncentives](
	[DriverID] [bigint] NOT NULL,
	[IncentiveID] [bigint] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Drivers].[DriverDetails]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Drivers].[DriverDetails](
	[DriverID] [bigint] NULL,
	[DrivingLicense] [varchar](max) NULL,
	[AadharCard] [varchar](max) NULL,
	[PanCard] [varchar](max) NULL,
	[OtherDocument] [varchar](max) NULL,
	[CurrentAddress] [varchar](max) NULL,
	[PermenantAddress] [varchar](max) NULL,
	[Country] [varchar](20) NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Drivers].[Incentives]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Drivers].[Incentives](
	[IncentiveID] [bigint] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IncentiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Drivers].[Ratings]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Drivers].[Ratings](
	[RatingID] [bigint] IDENTITY(1,1) NOT NULL,
	[RiderID] [bigint] NOT NULL,
	[DriverID] [bigint] NOT NULL,
	[TripID] [bigint] NOT NULL,
	[Comments] [varchar](max) NULL,
	[MediaAttached] [varchar](max) NULL,
	[Rating] [float] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Drivers].[Vehicles]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Drivers].[Vehicles](
	[VehicleID] [bigint] IDENTITY(1,1) NOT NULL,
	[DriverID] [bigint] NOT NULL,
	[CurrentRideTypeID] [bigint] NULL,
	[VehicleBrand] [varchar](max) NOT NULL,
	[VehicleName] [varchar](max) NOT NULL,
	[RegistrationNo] [varchar](max) NOT NULL,
	[VehicleDocument] [varchar](max) NOT NULL,
	[VehicleType] [varchar](max) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Riders].[ApplicableOffers]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Riders].[ApplicableOffers](
	[RiderID] [bigint] NOT NULL,
	[OfferID] [bigint] NOT NULL,
	[IsDisabled] [bit] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Riders].[Offers]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Riders].[Offers](
	[OfferID] [bigint] IDENTITY(1,1) NOT NULL,
	[OfferCode] [varchar](50) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OfferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Riders].[Ratings]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Riders].[Ratings](
	[RatingID] [bigint] IDENTITY(1,1) NOT NULL,
	[RiderID] [bigint] NOT NULL,
	[DriverID] [bigint] NOT NULL,
	[TripID] [bigint] NOT NULL,
	[Comments] [varchar](max) NULL,
	[MediaAttached] [varchar](max) NULL,
	[Rating] [float] NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Riders].[SavedPaymentModes]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Riders].[SavedPaymentModes](
	[RiderID] [bigint] NULL,
	[PaymentMode] [varchar](20) NOT NULL,
	[CardNumber] [decimal](16, 0) NOT NULL,
	[CardDate] [datetime] NOT NULL,
	[CardName] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[ModifiedAt] [datetime] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Admins].[Admins] ON 

INSERT [Admins].[Admins] ([ID], [FirstName], [LastName], [Email], [ContactNumber], [Password], [CreatedAt], [ModifiedAt]) VALUES (1, N'Milit', N'Panchasara', N'milit6116@gmail.com', CAST(7990349033 AS Decimal(10, 0)), N'Secret@123', CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [Admins].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationID], [LocationName], [Longitude], [Latitude], [CreatedAt], [ModifiedAt]) VALUES (1, N'DA-IICT, Gandhinagar, Gujarat', 72.6279837718273, 23.18899005518514, CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Locations] ([LocationID], [LocationName], [Longitude], [Latitude], [CreatedAt], [ModifiedAt]) VALUES (6, N'Radixweb, S. G. Highway, Ahmedabad', 72.547188661474934, 23.120455827022017, CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Locations] ([LocationID], [LocationName], [Longitude], [Latitude], [CreatedAt], [ModifiedAt]) VALUES (10, N'Nirma University, Ahmedabad', 72.548393, 23.035891, CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Locations] ([LocationID], [LocationName], [Longitude], [Latitude], [CreatedAt], [ModifiedAt]) VALUES (11, N'Iscon Crossroad, Ahmedabad', 72.507549, 23.027236, CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Locations] OFF
GO
SET IDENTITY_INSERT [dbo].[RideTypes] ON 

INSERT [dbo].[RideTypes] ([RideTypeID], [RideName], [PricePerKm], [SeatingCapacity], [CreatedAt], [ModifiedAt]) VALUES (3, N'UberMoto', 5, 1, CAST(N'2021-04-01T14:37:14.420' AS DateTime), CAST(N'2021-04-01T18:19:19.427' AS DateTime))
INSERT [dbo].[RideTypes] ([RideTypeID], [RideName], [PricePerKm], [SeatingCapacity], [CreatedAt], [ModifiedAt]) VALUES (8, N'UberAuto', 10, 2, CAST(N'2021-04-01T14:37:14.420' AS DateTime), NULL)
INSERT [dbo].[RideTypes] ([RideTypeID], [RideName], [PricePerKm], [SeatingCapacity], [CreatedAt], [ModifiedAt]) VALUES (9, N'UberGo', 20, 4, CAST(N'2021-04-01T14:37:14.420' AS DateTime), NULL)
INSERT [dbo].[RideTypes] ([RideTypeID], [RideName], [PricePerKm], [SeatingCapacity], [CreatedAt], [ModifiedAt]) VALUES (10, N'UberXL', 25, 6, CAST(N'2021-04-01T14:37:14.420' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[RideTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Trips] ON 

INSERT [dbo].[Trips] ([TripID], [RiderID], [DriverID], [SourceLocationID], [DestinationLocationID], [RideTypeID], [StartTime], [EndTime], [Status], [EstimatedFairAmount], [ActualFairAmount], [PaymentMethod], [CancelledBy], [CreatedAt], [ModifiedAt]) VALUES (4, 12, 1, 1, 6, 3, CAST(N'2021-04-01T14:37:27.630' AS DateTime), CAST(N'2021-04-01T14:43:00.127' AS DateTime), N'Cancelled', 150, NULL, NULL, N'Rider', CAST(N'2021-04-01T14:37:27.630' AS DateTime), CAST(N'2021-04-01T14:43:00.127' AS DateTime))
INSERT [dbo].[Trips] ([TripID], [RiderID], [DriverID], [SourceLocationID], [DestinationLocationID], [RideTypeID], [StartTime], [EndTime], [Status], [EstimatedFairAmount], [ActualFairAmount], [PaymentMethod], [CancelledBy], [CreatedAt], [ModifiedAt]) VALUES (5, 12, 1, 1, 6, 3, CAST(N'2021-04-01T14:46:06.417' AS DateTime), CAST(N'2021-04-01T14:59:57.883' AS DateTime), N'Completed', 150, 155.5, N'Cash', NULL, CAST(N'2021-04-01T14:38:41.397' AS DateTime), CAST(N'2021-04-01T14:59:57.883' AS DateTime))
SET IDENTITY_INSERT [dbo].[Trips] OFF
GO
INSERT [Drivers].[ApplicableIncentives] ([DriverID], [IncentiveID], [IsDisabled], [CreatedAt], [ModifiedAt]) VALUES (1, 1, 0, CAST(N'2021-04-02T00:00:00.000' AS DateTime), NULL)
GO
INSERT [Drivers].[DriverDetails] ([DriverID], [DrivingLicense], [AadharCard], [PanCard], [OtherDocument], [CurrentAddress], [PermenantAddress], [Country], [CreatedAt], [ModifiedAt]) VALUES (1, N'-', N'-', N'-', N'-', N'Ahmedabad', N'Rajkot', N'India', NULL, NULL)
GO
SET IDENTITY_INSERT [Drivers].[Drivers] ON 

INSERT [Drivers].[Drivers] ([DriverID], [FirstName], [LastName], [Email], [EmailVerified], [ContactNumber], [TotalRidesDone], [TotalRidesCancelled], [Salary], [IsBlocked], [IsLoggedIn], [SessionExpiresIn], [Password], [CreatedAt], [ModifiedAt]) VALUES (1, N'John', N'K', N'johnk@gmail.com', 0, CAST(7990349033 AS Decimal(10, 0)), 2, 1, NULL, 0, 1, CAST(N'2021-04-01T15:04:34.907' AS DateTime), N'john', CAST(N'2021-04-01T12:04:34.907' AS DateTime), CAST(N'2021-04-01T12:05:38.677' AS DateTime))
SET IDENTITY_INSERT [Drivers].[Drivers] OFF
GO
SET IDENTITY_INSERT [Drivers].[Incentives] ON 

INSERT [Drivers].[Incentives] ([IncentiveID], [Description], [StartDate], [EndDate], [CreatedAt], [ModifiedAt]) VALUES (1, N'10% extra reward on trips longer than 5 kms.', CAST(N'2021-04-01T00:00:00.000' AS DateTime), CAST(N'2021-04-16T00:00:00.000' AS DateTime), CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [Drivers].[Incentives] OFF
GO
SET IDENTITY_INSERT [Drivers].[Ratings] ON 

INSERT [Drivers].[Ratings] ([RatingID], [RiderID], [DriverID], [TripID], [Comments], [MediaAttached], [Rating], [CreatedAt], [ModifiedAt]) VALUES (1, 12, 1, 5, N'Nice Customer', NULL, 5, NULL, NULL)
SET IDENTITY_INSERT [Drivers].[Ratings] OFF
GO
SET IDENTITY_INSERT [Drivers].[Vehicles] ON 

INSERT [Drivers].[Vehicles] ([VehicleID], [DriverID], [CurrentRideTypeID], [VehicleBrand], [VehicleName], [RegistrationNo], [VehicleDocument], [VehicleType], [CreatedAt], [ModifiedAt]) VALUES (1, 1, 3, N'Hyundai', N'i20', N'GJ-03 KM 0012', N'-', N'Hatchback', CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [Drivers].[Vehicles] OFF
GO
INSERT [Riders].[ApplicableOffers] ([RiderID], [OfferID], [IsDisabled], [CreatedAt], [ModifiedAt]) VALUES (12, 2, 0, NULL, NULL)
INSERT [Riders].[ApplicableOffers] ([RiderID], [OfferID], [IsDisabled], [CreatedAt], [ModifiedAt]) VALUES (12, 3, 0, NULL, NULL)
GO
SET IDENTITY_INSERT [Riders].[Offers] ON 

INSERT [Riders].[Offers] ([OfferID], [OfferCode], [Description], [StartDate], [EndDate], [CreatedAt], [ModifiedAt]) VALUES (2, N'NEW100', N'Flat 100 rs. off o the first ride.', CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [Riders].[Offers] ([OfferID], [OfferCode], [Description], [StartDate], [EndDate], [CreatedAt], [ModifiedAt]) VALUES (3, N'ICICI10', N'10% Cashback by using ICICI Credit Card', CAST(N'2021-04-01T00:00:00.000' AS DateTime), CAST(N'2021-05-01T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [Riders].[Offers] OFF
GO
SET IDENTITY_INSERT [Riders].[Ratings] ON 

INSERT [Riders].[Ratings] ([RatingID], [RiderID], [DriverID], [TripID], [Comments], [MediaAttached], [Rating], [CreatedAt], [ModifiedAt]) VALUES (1, 12, 1, 5, N'A nice ride', NULL, 4, CAST(N'2021-04-01T15:30:07.830' AS DateTime), NULL)
SET IDENTITY_INSERT [Riders].[Ratings] OFF
GO
SET IDENTITY_INSERT [Riders].[Riders] ON 

INSERT [Riders].[Riders] ([RiderID], [FirstName], [LastName], [Email], [EmailVerified], [IsNew], [ContactNumber], [Password], [CreatedAt], [ModifiedAt], [InviteCode], [Country], [IsBlocked], [IsLoggedIn], [SessionExpiresIn]) VALUES (12, N'John', N'Abraham', N'john@gmail.com', 0, 1, CAST(7878787878 AS Decimal(10, 0)), N'secret123', CAST(N'2021-04-01T14:25:14.750' AS DateTime), NULL, N'johnab12', N'India', 0, 0, NULL)
INSERT [Riders].[Riders] ([RiderID], [FirstName], [LastName], [Email], [EmailVerified], [IsNew], [ContactNumber], [Password], [CreatedAt], [ModifiedAt], [InviteCode], [Country], [IsBlocked], [IsLoggedIn], [SessionExpiresIn]) VALUES (15, N'Anil', N'Khan', N'anil@gmail.com', 0, 1, CAST(4848484848 AS Decimal(10, 0)), N'mmmmm', NULL, NULL, N'anilk123', N'India', 0, 1, NULL)
INSERT [Riders].[Riders] ([RiderID], [FirstName], [LastName], [Email], [EmailVerified], [IsNew], [ContactNumber], [Password], [CreatedAt], [ModifiedAt], [InviteCode], [Country], [IsBlocked], [IsLoggedIn], [SessionExpiresIn]) VALUES (19, N'MEHUL', N'kapoor', N'meh@gmail.com', 1, 0, CAST(4828484848 AS Decimal(10, 0)), N'jjjjjj12', NULL, NULL, N'mehul123', N'India', 0, 0, NULL)
INSERT [Riders].[Riders] ([RiderID], [FirstName], [LastName], [Email], [EmailVerified], [IsNew], [ContactNumber], [Password], [CreatedAt], [ModifiedAt], [InviteCode], [Country], [IsBlocked], [IsLoggedIn], [SessionExpiresIn]) VALUES (20, N'SANDIP', N'S', N'SANDIP@gmail.com', 0, 1, CAST(7777777777 AS Decimal(10, 0)), N'SANDIP', NULL, NULL, N'SANDIP123', N'India', 1, 0, NULL)
SET IDENTITY_INSERT [Riders].[Riders] OFF
GO
INSERT [Riders].[SavedPaymentModes] ([RiderID], [PaymentMode], [CardNumber], [CardDate], [CardName], [CreatedAt], [ModifiedAt]) VALUES (12, N'CreditCard', CAST(1515151515151515 AS Decimal(16, 0)), CAST(N'2022-04-03T00:00:00.000' AS DateTime), N'XYZ', CAST(N'2021-04-01T00:00:00.000' AS DateTime), NULL)
GO
/****** Object:  Index [uk_Locations_Coordinates]    Script Date: 01-04-2021 19:38:10 ******/
ALTER TABLE [dbo].[Locations] ADD  CONSTRAINT [uk_Locations_Coordinates] UNIQUE NONCLUSTERED 
(
	[Longitude] ASC,
	[Latitude] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uk_Drivers_ContactNumber]    Script Date: 01-04-2021 19:38:10 ******/
ALTER TABLE [Drivers].[Drivers] ADD  CONSTRAINT [uk_Drivers_ContactNumber] UNIQUE NONCLUSTERED 
(
	[ContactNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [uk_Riders_ContactNumber]    Script Date: 01-04-2021 19:38:10 ******/
ALTER TABLE [Riders].[Riders] ADD  CONSTRAINT [uk_Riders_ContactNumber] UNIQUE NONCLUSTERED 
(
	[ContactNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [uk_Riders_InviteCode]    Script Date: 01-04-2021 19:38:10 ******/
ALTER TABLE [Riders].[Riders] ADD  CONSTRAINT [uk_Riders_InviteCode] UNIQUE NONCLUSTERED 
(
	[InviteCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [Drivers].[Drivers] ADD  DEFAULT ((0)) FOR [EmailVerified]
GO
ALTER TABLE [Drivers].[Drivers] ADD  DEFAULT ((0)) FOR [TotalRidesDone]
GO
ALTER TABLE [Drivers].[Drivers] ADD  DEFAULT ((0)) FOR [TotalRidesCancelled]
GO
ALTER TABLE [Drivers].[Drivers] ADD  DEFAULT ((0)) FOR [IsBlocked]
GO
ALTER TABLE [Drivers].[Drivers] ADD  DEFAULT ((0)) FOR [IsLoggedIn]
GO
ALTER TABLE [Riders].[Riders] ADD  DEFAULT ((0)) FOR [EmailVerified]
GO
ALTER TABLE [Riders].[Riders] ADD  DEFAULT ((1)) FOR [IsNew]
GO
ALTER TABLE [Riders].[Riders] ADD  DEFAULT ((0)) FOR [IsBlocked]
GO
ALTER TABLE [Riders].[Riders] ADD  DEFAULT ((0)) FOR [IsLoggedIn]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [fk_Trips_DestinationLocationID] FOREIGN KEY([DestinationLocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [fk_Trips_DestinationLocationID]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [fk_Trips_DriverID] FOREIGN KEY([DriverID])
REFERENCES [Drivers].[Drivers] ([DriverID])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [fk_Trips_DriverID]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [fk_Trips_RiderID] FOREIGN KEY([RiderID])
REFERENCES [Riders].[Riders] ([RiderID])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [fk_Trips_RiderID]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [fk_Trips_RideTypeID] FOREIGN KEY([RideTypeID])
REFERENCES [dbo].[RideTypes] ([RideTypeID])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [fk_Trips_RideTypeID]
GO
ALTER TABLE [dbo].[Trips]  WITH CHECK ADD  CONSTRAINT [fk_Trips_SourceLocationID] FOREIGN KEY([SourceLocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Trips] CHECK CONSTRAINT [fk_Trips_SourceLocationID]
GO
ALTER TABLE [Drivers].[ApplicableIncentives]  WITH CHECK ADD  CONSTRAINT [fk_ApplicableIncentives_DriverID] FOREIGN KEY([DriverID])
REFERENCES [Drivers].[Drivers] ([DriverID])
GO
ALTER TABLE [Drivers].[ApplicableIncentives] CHECK CONSTRAINT [fk_ApplicableIncentives_DriverID]
GO
ALTER TABLE [Drivers].[ApplicableIncentives]  WITH CHECK ADD  CONSTRAINT [fk_ApplicableIncentives_IncentiveID] FOREIGN KEY([IncentiveID])
REFERENCES [Drivers].[Incentives] ([IncentiveID])
GO
ALTER TABLE [Drivers].[ApplicableIncentives] CHECK CONSTRAINT [fk_ApplicableIncentives_IncentiveID]
GO
ALTER TABLE [Drivers].[DriverDetails]  WITH CHECK ADD  CONSTRAINT [fk_DriverDetails_DriverID] FOREIGN KEY([DriverID])
REFERENCES [Drivers].[Drivers] ([DriverID])
GO
ALTER TABLE [Drivers].[DriverDetails] CHECK CONSTRAINT [fk_DriverDetails_DriverID]
GO
ALTER TABLE [Drivers].[Ratings]  WITH CHECK ADD  CONSTRAINT [fk_Ratings_DriverID] FOREIGN KEY([DriverID])
REFERENCES [Drivers].[Drivers] ([DriverID])
GO
ALTER TABLE [Drivers].[Ratings] CHECK CONSTRAINT [fk_Ratings_DriverID]
GO
ALTER TABLE [Drivers].[Ratings]  WITH CHECK ADD  CONSTRAINT [fk_Ratings_RiderID] FOREIGN KEY([RiderID])
REFERENCES [Riders].[Riders] ([RiderID])
GO
ALTER TABLE [Drivers].[Ratings] CHECK CONSTRAINT [fk_Ratings_RiderID]
GO
ALTER TABLE [Drivers].[Ratings]  WITH CHECK ADD  CONSTRAINT [fk_Ratings_TripID] FOREIGN KEY([TripID])
REFERENCES [dbo].[Trips] ([TripID])
GO
ALTER TABLE [Drivers].[Ratings] CHECK CONSTRAINT [fk_Ratings_TripID]
GO
ALTER TABLE [Drivers].[Vehicles]  WITH CHECK ADD  CONSTRAINT [fk_Vehicles_CurrentRideTypeID] FOREIGN KEY([CurrentRideTypeID])
REFERENCES [dbo].[RideTypes] ([RideTypeID])
GO
ALTER TABLE [Drivers].[Vehicles] CHECK CONSTRAINT [fk_Vehicles_CurrentRideTypeID]
GO
ALTER TABLE [Drivers].[Vehicles]  WITH CHECK ADD  CONSTRAINT [fk_Vehicles_DriverID] FOREIGN KEY([DriverID])
REFERENCES [Drivers].[Drivers] ([DriverID])
GO
ALTER TABLE [Drivers].[Vehicles] CHECK CONSTRAINT [fk_Vehicles_DriverID]
GO
ALTER TABLE [Riders].[ApplicableOffers]  WITH CHECK ADD  CONSTRAINT [fk_ApplicableOffers_OfferID] FOREIGN KEY([OfferID])
REFERENCES [Riders].[Offers] ([OfferID])
GO
ALTER TABLE [Riders].[ApplicableOffers] CHECK CONSTRAINT [fk_ApplicableOffers_OfferID]
GO
ALTER TABLE [Riders].[ApplicableOffers]  WITH CHECK ADD  CONSTRAINT [fk_ApplicableOffers_RiderID] FOREIGN KEY([RiderID])
REFERENCES [Riders].[Riders] ([RiderID])
GO
ALTER TABLE [Riders].[ApplicableOffers] CHECK CONSTRAINT [fk_ApplicableOffers_RiderID]
GO
ALTER TABLE [Riders].[Ratings]  WITH CHECK ADD  CONSTRAINT [fk_Ratings_DriverID] FOREIGN KEY([DriverID])
REFERENCES [Drivers].[Drivers] ([DriverID])
GO
ALTER TABLE [Riders].[Ratings] CHECK CONSTRAINT [fk_Ratings_DriverID]
GO
ALTER TABLE [Riders].[Ratings]  WITH CHECK ADD  CONSTRAINT [fk_Ratings_RiderID] FOREIGN KEY([RiderID])
REFERENCES [Riders].[Riders] ([RiderID])
GO
ALTER TABLE [Riders].[Ratings] CHECK CONSTRAINT [fk_Ratings_RiderID]
GO
ALTER TABLE [Riders].[Ratings]  WITH CHECK ADD  CONSTRAINT [fk_Ratings_TripID] FOREIGN KEY([TripID])
REFERENCES [dbo].[Trips] ([TripID])
GO
ALTER TABLE [Riders].[Ratings] CHECK CONSTRAINT [fk_Ratings_TripID]
GO
ALTER TABLE [Riders].[SavedPaymentModes]  WITH CHECK ADD  CONSTRAINT [fk_SavedPaymentModes_RiderID] FOREIGN KEY([RiderID])
REFERENCES [Riders].[Riders] ([RiderID])
GO
ALTER TABLE [Riders].[SavedPaymentModes] CHECK CONSTRAINT [fk_SavedPaymentModes_RiderID]
GO
/****** Object:  StoredProcedure [Admins].[usp_BlockUnblockUser]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Admins.usp_BlockUnblockUser --
CREATE   PROCEDURE [Admins].[usp_BlockUnblockUser]
	@Action varchar(20),
	@UserType varchar(10),
	@UserID bigint
AS
SET NOCOUNT ON;
BEGIN TRY
	IF @Action = 'BLOCK'
	BEGIN
		IF(  @UserType = 'RIDER')
		BEGIN
			UPDATE Riders.vRiders SET IsBlocked = 1 WHERE RiderID = @UserID
		END
		ELSE IF @UserType = 'DRIVER'
		BEGIN
			UPDATE Drivers.vDrivers SET IsBlocked = 1 WHERE DriverID = @UserID
		END
		SELECT 1 AS Response, 'Success' AS Message
		RETURN
	END

	IF @Action = 'UNBLOCK'
	BEGIN
		IF(  @UserType = 'RIDER')
		BEGIN
			UPDATE Riders.vRiders SET IsBlocked = 0 WHERE RiderID = @UserID
		END
		ELSE IF @UserType = 'DRIVER'
		BEGIN
			UPDATE Drivers.vDrivers SET IsBlocked = 0 WHERE DriverID = @UserID
		END
		SELECT 1 AS Response, 'Success' AS Message
		RETURN
	END
END TRY
BEGIN CATCH
	SELECT 0 AS Response, ERROR_MESSAGE() AS Message
END CATCH
	SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [Admins].[usp_GetAllUsersData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- Admins.usp_GetAllUsersData --
CREATE   PROCEDURE [Admins].[usp_GetAllUsersData]
	@UserType varchar(10)
AS
	SET NOCOUNT ON;
	IF @UserType = 'RIDER'
	BEGIN
		SELECT 
			RiderID,
			FirstName,
			LastName,
			Email,
			EmailVerified,
			IsNew,
			ContactNumber,
			Country,
			InviteCode,
			IsBlocked,
			CreatedAt
		FROM Riders.vRiders;
	END
	ELSE IF @UserType = 'DRIVER'
	BEGIN
		SELECT 
			DriverID,
			FirstName,
			LastName,
			Email,
			EmailVerified,
			ContactNumber,
			TotalRidesDone,
			TotalRidesCancelled,
			IsBlocked,
			CreatedAt
		FROM Drivers.vDrivers;
	END
	
	SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteRideTypesData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_DeleteRideTypesData --
CREATE   PROCEDURE [dbo].[usp_DeleteRideTypesData]
	@ridetype_id bigint
AS
BEGIN TRY
	IF @ridetype_id IS NULL
	BEGIN
		SELECT 0 AS Response, 'RideTypeID cannot be NULL' AS Message
		RETURN
	END
	DELETE FROM RideTypes WHERE RideTypeID = @ridetype_id;
	SELECT 1 AS Response, 'Success' AS Message
END TRY
BEGIN CATCH
	SELECT 0 AS Response, ERROR_MESSAGE() AS Message
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_GetLocationData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_GetLocationData --
CREATE   PROCEDURE [dbo].[usp_GetLocationData]
	@location_id bigint
AS
	SELECT LocationID, LocationName, Longitude, Latitude, CreatedAt, ModifiedAt FROM Locations WHERE LocationID = @location_id;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetRideTypesData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_GetRideTypesData --
CREATE   PROCEDURE [dbo].[usp_GetRideTypesData]
AS
	SELECT RideTypeID, RideName, PricePerKm, SeatingCapacity, CreatedAt, ModifiedAt FROM RideTypes;
GO
/****** Object:  StoredProcedure [dbo].[usp_SaveLocationData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_SaveLocationData --
CREATE   PROCEDURE [dbo].[usp_SaveLocationData]
	@location_name varchar(50),
	@longitude float,
	@latitude float
AS
BEGIN TRY
	INSERT INTO Locations (LocationName, Latitude, Longitude, CreatedAt)
	VALUES (@location_name, @latitude, @longitude, GETDATE())
	SELECT 1 AS Response, 'Success' AS Message
END TRY
BEGIN CATCH
	SELECT 0 AS Response, ERROR_MESSAGE() AS Message
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_SaveNewTripData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_SaveNewTripData --
CREATE   PROCEDURE [dbo].[usp_SaveNewTripData]
	@RiderID bigint,
	@DriverID bigint,
	@SourceLocationID bigint,
	@DestinationLocationID bigint,
	@RideTypeID bigint,
	@Status varchar(20),
	@EstimatedFairAmount float
AS
BEGIN TRY
	INSERT INTO Trips 
	(RiderID, 
	DriverID, 
	SourceLocationID, 
	DestinationLocationID,
	RideTypeID,
	Status,
	EstimatedFairAmount,
	CreatedAt, 
	ModifiedAt) 
	VALUES 
	(@RiderID,
	@DriverID,
	@SourceLocationID,
	@DestinationLocationID,
	@RideTypeID, 
	@Status, 
	@EstimatedFairAmount,
	GETDATE(),
	NULL);
	SELECT 1 AS Response, 'Success' AS Message

END TRY
BEGIN CATCH
	SELECT 0 AS Response, ERROR_MESSAGE() AS Message
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_SaveRideTypesData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_SaveRideTypesData --
CREATE   PROCEDURE [dbo].[usp_SaveRideTypesData]
	@action varchar(10),
	@ridetype_id bigint = NULL,
	@ride_name varchar(50) = NULL,
	@price float = NULL,
	@seating_capacity int = NULL
AS
	BEGIN TRY
	IF @action = 'INSERT'
	BEGIN
		IF @ride_name IS NULL OR @price IS NULL OR @seating_capacity IS NULL
		BEGIN
		SELECT 0 AS Response, 'RideName, PricePerKm, SeatingCapacity cannot be NULL' AS Message
		RETURN
		END

		IF EXISTS (SELECT RideName FROM RideTypes WHERE RideName = @ride_name)
		BEGIN
		SELECT 0 AS Response, 'RideName already exists' AS Message
		RETURN
		END

		INSERT INTO RideTypes 
		(RideName, PricePerKm, SeatingCapacity, CreatedAt, ModifiedAt) 
		VALUES 
		(@ride_name, @price, @seating_capacity, GETDATE(), NULL);
		SELECT 1 AS Response, 'Success' AS Message
	END

	IF @action = 'UPDATE'
	BEGIN
		IF @ridetype_id IS NULL OR @ride_name IS NULL OR @price IS NULL OR @seating_capacity IS NULL
		BEGIN
		SELECT 0 AS Response, 'RideTypeID, RideName, PricePerKm, SeatingCapacity cannot be NULL' AS Message
		RETURN
		END

		UPDATE RideTypes SET 
		RideName = @ride_name,
		PricePerKm = @price,
		SeatingCapacity = @seating_capacity,
		ModifiedAt = GETDATE()
		WHERE RideTypeID = @ridetype_id;
		SELECT 1 AS Response, 'Success' AS Message
	END	

	END TRY
	BEGIN CATCH
		SELECT 0 AS Response, ERROR_MESSAGE() AS Message
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateTripData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- usp_UpdateTripData --
CREATE   PROCEDURE [dbo].[usp_UpdateTripData]
	@Action varchar(20),
	@TripID bigint,
	@Status varchar(20),
	@ActualFairAmount float,
	@PaymentMethod varchar(50),
	@CancelledBy varchar(20) = NULL
AS

BEGIN TRY

	IF @Action = 'TripCancelled'
	BEGIN
		UPDATE Trips SET 
		EndTime = GETDATE(),
		Status = @Status,
		ActualFairAmount = @ActualFairAmount,
		PaymentMethod = @PaymentMethod,
		CancelledBy = @CancelledBy,
		ModifiedAt = GETDATE()
		WHERE TripID = @TripID;
		SELECT 1 AS Response, 'Success' AS Message

		UPDATE Drivers.Drivers
		SET TotalRidesCancelled = TotalRidesCancelled + 1 
		WHERE DriverID = (SELECT DriverID FROM Trips WHERE TripID = @TripID)
			
	END

	IF @Action = 'TripCompleted'
	BEGIN
		UPDATE Trips SET 
		EndTime = GETDATE(),
		Status = @Status,
		ActualFairAmount = @ActualFairAmount,
		PaymentMethod = @PaymentMethod,
		CancelledBy = NULL,
		ModifiedAt = GETDATE()
		WHERE TripID = @TripID;
		SELECT 1 AS Response, 'Success' AS Message;

		UPDATE Drivers.Drivers
		SET TotalRidesDone = TotalRidesDone + 1 
		WHERE DriverID = (SELECT DriverID FROM Trips WHERE TripID = @TripID)
	END

	IF @Action = 'TripStarted'
	BEGIN
		UPDATE Trips SET 
		Status = @Status,
		StartTime = GETDATE(),
		ModifiedAt = GETDATE()
		WHERE TripID = @TripID;
		SELECT 1 AS Response, 'Success' AS Message
	END

END TRY
BEGIN CATCH
	SELECT 0 AS Response, ERROR_MESSAGE() AS Message
END CATCH
GO
/****** Object:  StoredProcedure [Drivers].[usp_GetDriverData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Drivers.usp_GetDriverData --
CREATE   PROCEDURE [Drivers].[usp_GetDriverData]
	@driver_id bigint
AS
	SELECT DriverID, FirstName, LastName, Email, EmailVerified, ContactNumber, TotalRidesCancelled, TotalRidesDone, Salary, CreatedAt, ModifiedAt
	FROM Drivers.vDrivers WHERE DriverID = @driver_id
GO
/****** Object:  StoredProcedure [Drivers].[usp_SaveDriverData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Drivers.usp_SaveDriverData --
CREATE   PROCEDURE [Drivers].[usp_SaveDriverData]
	@action varchar(10),
	@driver_id bigint = NULL,
	@first_name varchar(50),
	@last_name varchar(50),
	@email varchar(50),
	@email_verified bit = 0,
	@contact_number decimal(10,0) = NULL,
	@password varchar(100) = NULL
AS
	BEGIN TRY
	IF @action = 'INSERT'
	BEGIN
		IF @contact_number IS NULL OR @password IS NULL
		BEGIN
			SELECT 0 AS 'Response', 'ContactNumber,Password cannot be NULL' AS Message
			RETURN
		END
		INSERT INTO Drivers.Drivers 
		(FirstName, LastName, Email, EmailVerified, ContactNumber, TotalRidesCancelled, TotalRidesDone, Salary, Password, IsBlocked, IsLoggedIn, SessionExpiresIn, CreatedAt, ModifiedAt) 
		VALUES 
		(@first_name, @last_name, @email, @email_verified, @contact_number, 0, 0, NULL, @password, 0, 1, DATEADD(HOUR,3,GETDATE()), GETDATE(), NULL);
		SELECT 1 AS Response, 'Success' AS Message
	END

	IF @action = 'UPDATE' AND @driver_id IS NOT NULL
	BEGIN
		UPDATE Drivers.vDrivers SET 
		FirstName = @first_name,
		LastName = @last_name,
		Email = @email,
		EmailVerified = @email_verified,
		ModifiedAt = GETDATE()
		WHERE DriverID = @driver_id;
		SELECT 1 AS Response, 'Success' AS Message
	END
	END TRY
	BEGIN CATCH
		SELECT 0 AS Response, ERROR_MESSAGE() AS Message
	END CATCH
GO
/****** Object:  StoredProcedure [Drivers].[usp_SaveVehicleData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Drivers.usp_SaveVehicleData --
CREATE   PROCEDURE [Drivers].[usp_SaveVehicleData]
	@driver_id bigint,
	@vehicle_name varchar(50),
	@vehicle_brand varchar(50),
	@reg_no varchar(50),
	@ride_type varchar(10),
	@vehicle_type varchar(20),
	@documents varchar(MAX)
AS
	BEGIN TRY

		INSERT INTO Drivers.Vehicles 
		(DriverID, 
		CurrentRideTypeID,
		VehicleBrand,
		VehicleName,
		VehicleType,
		RegistrationNo,
		VehicleDocument,
		CreatedAt,
		ModifiedAt) 
		VALUES 
		(@driver_id,
		(SELECT RideTypeID FROM RideTypes WHERE RideName = @ride_type), 
		@vehicle_brand,
		@vehicle_name, 
		@vehicle_type,
		@reg_no,
		@documents,
		GETDATE(), 
		NULL);
		SELECT 1 AS Response, 'Success' AS Message

	END TRY
	BEGIN CATCH
		SELECT 0 AS Response, ERROR_MESSAGE() AS Message
	END CATCH
GO
/****** Object:  StoredProcedure [Riders].[usp_GetCurrentTripData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Riders.usp_GetCurrentTripData --
CREATE   PROCEDURE [Riders].[usp_GetCurrentTripData]
	@RiderID bigint
AS
SET NOCOUNT OFF
	SELECT 
		DR.FirstName + ' ' + DR.LastName AS DriverName,
		S.LocationName AS Source,
		D.LocationName AS Destination,
		V.VehicleBrand,
		V.VehicleName,
		V.RegistrationNo,
		T.StartTime,
		T.EndTime,
		T.Status,
		T.EstimatedFairAmount

	FROM vCurrentTrips T 
	JOIN Locations S ON S.LocationID = T.SourceLocationID
	JOIN Locations D ON D.LocationID = T.DestinationLocationID
	JOIN Drivers.Drivers DR ON DR.DriverID = T.DriverID
	JOIN RideTypes RT ON RT.RideTypeID = T.RideTypeID
	JOIN Drivers.Vehicles V ON V.DriverID = DR.DriverID
	WHERE T.RiderID = @RiderID
SET NOCOUNT ON
GO
/****** Object:  StoredProcedure [Riders].[usp_GetRiderData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Riders.usp_GetRiderData --
CREATE   PROCEDURE [Riders].[usp_GetRiderData]
	@rider_id bigint
AS
	SELECT RiderID, FirstName, LastName, Email, EmailVerified, IsNew, ContactNumber, InviteCode, Country, CreatedAt, ModifiedAt
	FROM Riders.vRiders WHERE RiderID = @rider_id
GO
/****** Object:  StoredProcedure [Riders].[usp_GetTripsData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Riders.usp_GetTripsData --
CREATE   PROCEDURE [Riders].[usp_GetTripsData]
	@RiderID bigint
AS
	SET NOCOUNT ON;
	SELECT 
		DR.FirstName + ' ' + DR.LastName AS DriverName,
		S.LocationName AS Source,
		D.LocationName AS Destination,
		V.VehicleBrand,
		V.VehicleName,
		V.RegistrationNo,
		T.StartTime,
		T.EndTime,
		T.Status,
		T.EstimatedFairAmount,
		T.ActualFairAmount,
		T.PaymentMethod,
		T.CancelledBy

	FROM Trips T 
	JOIN Locations S ON S.LocationID = T.SourceLocationID
	JOIN Locations D ON D.LocationID = T.DestinationLocationID
	JOIN Drivers.Drivers DR ON DR.DriverID = T.DriverID
	JOIN RideTypes RT ON RT.RideTypeID = T.RideTypeID
	JOIN Drivers.Vehicles V ON V.DriverID = DR.DriverID
	WHERE T.RiderID = @RiderID
	SET NOCOUNT OFF;
GO
/****** Object:  StoredProcedure [Riders].[usp_SaveRatingData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Riders.usp_SaveRatingData --
CREATE   PROCEDURE [Riders].[usp_SaveRatingData]
	@RiderID bigint,
	@DriverID bigint,
	@TripID bigint,
	@Comments varchar(MAX) = NULL,
	@MediaAttached varchar(MAX) = NULL,
	@Rating float
AS
BEGIN TRY
	INSERT INTO Riders.Ratings 
	(RiderID, 
	DriverID, 
	TripID, 
	Comments,
	MediaAttached,
	Rating,
	CreatedAt, 
	ModifiedAt) 
	VALUES 
	(@RiderID,
	@DriverID,
	@TripID,
	@Comments,
	@MediaAttached, 
	@Rating, 
	GETDATE(),
	NULL);
	SELECT 1 AS Response, 'Success' AS Message

END TRY
BEGIN CATCH
	SELECT 0 AS Response, ERROR_MESSAGE() AS Message
END CATCH
GO
/****** Object:  StoredProcedure [Riders].[usp_SaveRiderData]    Script Date: 01-04-2021 19:38:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Riders.usp_SaveRiderData --
CREATE   PROCEDURE [Riders].[usp_SaveRiderData]
	@action varchar(10),
	@rider_id bigint = NULL,
	@first_name varchar(50),
	@last_name varchar(50),
	@email varchar(50),
	@email_verified bit = 0,
	@is_new bit = 1,
	@contact_number decimal(10,0) = NULL,
	@password varchar(100) = NULL,
	@invite_code varchar(50) = NULL,
	@country varchar(50)
AS
	BEGIN TRY
	IF @action = 'INSERT'
	BEGIN
		IF @contact_number IS NULL OR @password IS NULL OR @invite_code IS NULL
		BEGIN
			SELECT 0 AS 'Response', 'ContactNumber, Password, InviteCode cannot be NULL' AS Message
			RETURN
		END
		INSERT INTO Riders.Riders 
		(FirstName, LastName, Email, EmailVerified, IsNew, ContactNumber, Password, InviteCode, Country, IsBlocked, IsLoggedIn, SessionExpiresIn, CreatedAt, ModifiedAt) 
		VALUES 
		(@first_name, @last_name, @email, @email_verified, @is_new, @contact_number, @password, @invite_code, @country, 0, 1, DATEADD(HOUR,3,GETDATE()), GETDATE(), NULL);
		SELECT 1 AS Response, 'Success' AS Message
	END

	IF @action = 'UPDATE' AND @rider_id IS NOT NULL
	BEGIN
		UPDATE Riders.vRiders SET  -- uses view to update
		FirstName = @first_name,
		LastName = @last_name,
		Email = @email,
		EmailVerified = @email_verified,
		IsNew = @is_new,
		ModifiedAt = GETDATE()
		WHERE RiderID = @rider_id;
		SELECT 1 AS Response, 'Success' AS Message
	END
	END TRY
	BEGIN CATCH
		SELECT 0 AS Response, ERROR_MESSAGE() AS Message
	END CATCH
GO
USE [master]
GO
ALTER DATABASE [Uber] SET  READ_WRITE 
GO
