USE [master]
GO
/****** Object:  Database [IndigoDB]    Script Date: 08-05-2018 21:16:33 ******/
CREATE DATABASE [IndigoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IndigoDB', FILENAME = N'F:\MSSQL12.MSSQLSERVER\MSSQL\Data\IndigoDB.mdf' , SIZE = 1631232KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'IndigoDB_log', FILENAME = N'G:\MSSQL12.MSSQLSERVER\MSSQL\Data\IndigoDB_log.ldf' , SIZE = 427392KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [IndigoDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IndigoDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IndigoDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IndigoDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IndigoDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IndigoDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IndigoDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [IndigoDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IndigoDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IndigoDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IndigoDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IndigoDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IndigoDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IndigoDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IndigoDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IndigoDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IndigoDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [IndigoDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IndigoDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IndigoDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IndigoDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IndigoDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IndigoDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IndigoDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IndigoDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [IndigoDB] SET  MULTI_USER 
GO
ALTER DATABASE [IndigoDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IndigoDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IndigoDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IndigoDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [IndigoDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [IndigoDB]
GO
/****** Object:  User [NagiosUser]    Script Date: 08-05-2018 21:16:33 ******/
CREATE USER [NagiosUser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [indigo_user]    Script Date: 08-05-2018 21:16:33 ******/
CREATE USER [indigo_user] FOR LOGIN [indigo_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [indigo]    Script Date: 08-05-2018 21:16:33 ******/
CREATE USER [indigo] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IG\actionscom]    Script Date: 08-05-2018 21:16:33 ******/
CREATE USER [IG\actionscom] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [indigo_user]
GO
/****** Object:  UserDefinedTableType [dbo].[UT_QuestionResponse]    Script Date: 08-05-2018 21:16:33 ******/
CREATE TYPE [dbo].[UT_QuestionResponse] AS TABLE(
	[QuestionId] [varchar](20) NOT NULL,
	[QuestionText] [varchar](max) NULL,
	[NumberInput] [int] NULL,
	[TextInput] [varchar](100) NULL
)
GO
/****** Object:  Table [dbo].[customer]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerFirstName] [varchar](100) NOT NULL,
	[CustomerSecondName] [varchar](100) NOT NULL,
	[PNR] [varchar](100) NOT NULL,
	[CustomerNumber] [varchar](50) NOT NULL,
	[DateAdded] [datetime] NOT NULL,
	[ExchangeId] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_AutoDial_Agent]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoDial_Agent](
	[AgentId] [int] NOT NULL,
	[AgentPassword] [varchar](100) NOT NULL,
	[AgentName] [varchar](200) NULL,
	[SkillSet] [varchar](50) NULL,
	[Designation] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[EmployeeId] [bigint] NULL,
 CONSTRAINT [PK_AutoDial_Agents] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_AutoDial_Call_Diversion]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoDial_Call_Diversion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[ExtensionNo] [varchar](20) NULL,
	[LastEnter] [datetime2](7) NULL,
	[CallStatus] [nvarchar](max) NOT NULL,
	[CallerMobile] [nvarchar](max) NULL,
	[CallerEmail] [varchar](200) NULL,
	[CallOutgoingDateTime] [datetime2](7) NOT NULL,
	[AgentId] [int] NULL,
	[CallEndDateTime] [datetime2](7) NULL,
	[CallEstablishedDateTime] [datetime2](7) NULL,
	[DropOutId] [int] NULL,
	[DispositionId] [int] NULL,
	[IsValidRecord] [bit] NULL,
	[IsFailed] [bit] NULL,
	[FailedCause] [nvarchar](200) NULL,
	[UCID] [nvarchar](20) NULL,
	[CallDeliveredDateTime] [datetime] NULL,
	[CallFailedDateTime] [datetime] NULL,
	[HostIpAddress] [varchar](20) NULL,
 CONSTRAINT [PK_AutoDialCallDiversions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_AutoDial_DropOut_Call]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoDial_DropOut_Call](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[IsAllocated] [varchar](1) NOT NULL,
	[CallerNumber] [nvarchar](max) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[ModifiedOn] [datetime2](7) NULL,
	[FlightDetails] [varchar](200) NULL,
	[PaxNames] [varchar](max) NULL,
	[LostPageName] [varchar](200) NULL,
	[CallerEmail] [varchar](200) NULL,
	[PaxCount] [int] NULL,
	[CallerMobile] [varchar](20) NULL,
	[Priority] [varchar](2) NULL,
	[IsValidRecord] [bit] NOT NULL,
	[ProcessCount] [int] NULL,
	[Delflag] [bit] NULL,
	[IsAutoDialed] [bit] NULL,
	[IsCallback] [bit] NULL,
	[CallbackDateTime] [datetime] NULL,
	[IsCallbackCompleted] [bit] NULL,
	[IsCallbackCompletedOn] [datetime] NULL,
	[CaseType] [varchar](10) NULL,
	[AllocatedOn] [datetime] NULL,
 CONSTRAINT [PK_AutoDialDropOutCalls] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_AutoDial_Login]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoDial_Login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AgentId] [int] NOT NULL,
	[ExtensionNo] [int] NOT NULL,
	[LoginStatus] [varchar](1) NOT NULL,
	[LoginDateTime] [datetime] NULL,
	[SessionId] [varchar](100) NULL,
	[MonitorStartInvokeId] [int] NULL,
	[MonitorCrossRefInvokeId] [int] NULL,
	[LoginType] [varchar](100) NULL,
	[HostIpAddress] [varchar](50) NULL,
	[IpAddress] [varchar](50) NULL,
	[LogoutDateTime] [datetime] NULL,
	[StationMonitorStartedOn] [datetime] NULL,
	[IsStationOnMonitor] [bit] NULL,
	[StationMonitorStoppedOn] [datetime] NULL,
 CONSTRAINT [PK_AutoDial_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_AutoDial_Mst_Disposition]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoDial_Mst_Disposition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DispositionId] [int] NOT NULL,
	[DispositionCode] [varchar](50) NULL,
	[Status] [varchar](1) NULL,
	[DispositionName] [varchar](200) NULL,
 CONSTRAINT [PK_AutoDial_Dispositions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_AutoDial_Premium_Call]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_AutoDial_Premium_Call](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[IsAllocated] [varchar](1) NOT NULL,
	[CallerNumber] [nvarchar](max) NULL,
	[CreatedOn] [datetime2](7) NULL,
	[ModifiedOn] [datetime2](7) NULL,
 CONSTRAINT [PK_AutoDialPremiumCalls] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Call_Diversion]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Call_Diversion](
	[Id] [int] IDENTITY(794354,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[ExtensionNo] [varchar](20) NULL,
	[LastEnter] [datetime] NULL,
	[CallStatus] [nvarchar](max) NOT NULL,
	[CallerMobile] [nvarchar](20) NOT NULL,
	[CallerEmail] [varchar](200) NULL,
	[CallIncomingDateTime] [datetime] NOT NULL,
	[AgentId] [int] NULL,
	[CallEndDateTime] [datetime2](7) NULL,
	[CallEstablishedDateTime] [datetime2](7) NULL,
	[UniqueCallId] [bigint] NULL,
	[QuickPopAgentId] [int] NULL,
	[DispositionId] [int] NULL,
	[Remarks] [varchar](200) NULL,
	[IsTransfered] [bit] NULL,
	[UCID] [nvarchar](20) NULL,
	[UserEnteredCode] [nvarchar](200) NULL,
 CONSTRAINT [PK_CallDiversions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_call_Diversion_01Aug17]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_call_Diversion_01Aug17](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[ExtensionNo] [varchar](20) NULL,
	[LastEnter] [datetime] NULL,
	[CallStatus] [nvarchar](max) NOT NULL,
	[CallerMobile] [nvarchar](max) NULL,
	[CallerEmail] [varchar](200) NULL,
	[CallIncomingDateTime] [datetime] NOT NULL,
	[AgentId] [int] NULL,
	[CallEndDateTime] [datetime2](7) NULL,
	[CallEstablishedDateTime] [datetime2](7) NULL,
	[QuickPopAgentId] [int] NULL,
	[DispositionId] [int] NULL,
	[Remarks] [varchar](200) NULL,
	[UCID] [nvarchar](20) NULL,
	[UserEnteredCode] [nvarchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Call_Diversion_Test]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Call_Diversion_Test](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[ExtensionNo] [varchar](20) NULL,
	[LastEnter] [datetime] NULL,
	[CallStatus] [nvarchar](max) NOT NULL,
	[CallerMobile] [nvarchar](max) NULL,
	[CallerEmail] [varchar](200) NULL,
	[CallIncomingDateTime] [datetime] NOT NULL,
	[AgentId] [int] NULL,
	[CallEndDateTime] [datetime2](7) NULL,
	[CallEstablishedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CallDiversionTests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_Customer_Spcl]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_Customer_Spcl](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[MiddleName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[PhoneNumber1] [varchar](15) NOT NULL,
	[PhoneNumber2] [varchar](15) NOT NULL,
	[PhoneNumber3] [varchar](15) NOT NULL,
	[CustomerType] [varchar](10) NOT NULL,
	[Delflag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_Mst_Customer_Spcls] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_Disposition]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_Disposition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DispositionId] [int] NOT NULL,
	[DispositionCode] [varchar](50) NULL,
	[Status] [varchar](1) NULL,
	[DispositionName] [varchar](200) NULL,
	[ApplicationCode] [varchar](20) NULL,
 CONSTRAINT [PK_Dispositions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_Disposition_Group]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_Disposition_Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Status] [varchar](1) NULL,
	[Delflag] [varchar](1) NOT NULL,
	[OrderBy] [int] NULL,
 CONSTRAINT [PK_Mst_Disposition_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_Disposition_QueryTypes]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_Disposition_QueryTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](200) NULL,
	[GroupId] [int] NULL,
	[SubGroupId] [int] NULL,
	[Status] [varchar](1) NULL,
	[Delflag] [varchar](1) NOT NULL,
 CONSTRAINT [PK_Mst_Disposition_QueryTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_Disposition_SubGroup]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_Disposition_SubGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Status] [varchar](1) NULL,
	[GroupId] [int] NOT NULL,
	[Delflag] [varchar](1) NOT NULL,
	[OrderBy] [int] NULL,
 CONSTRAINT [PK_Mst_Disposition_SubGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_HuntGroup]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_HuntGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_HuntGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Mst_VDN]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mst_VDN](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_VDNs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Agent]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_Agent](
	[AgentId] [int] NOT NULL,
	[AgentPassword] [varchar](100) NOT NULL,
	[AgentName] [varchar](200) NULL,
	[SkillSet] [varchar](50) NULL,
	[Designation] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[EmployeeId] [bigint] NULL,
 CONSTRAINT [PK_Agents] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_CallDiversion]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_CallDiversion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerName] [varchar](200) NULL,
	[ExtensionNo] [varchar](20) NULL,
	[LastEnter] [datetime] NULL,
	[CallStatus] [nvarchar](max) NOT NULL,
	[CallerMobile] [nvarchar](max) NULL,
	[CallerEmail] [varchar](200) NULL,
	[CallIncomingDateTime] [datetime] NOT NULL,
	[AgentId] [int] NULL,
	[CallEndDateTime] [datetime2](7) NULL,
	[CallEstablishedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ScreenPopup_CallDiversions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Extension]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_Extension](
	[ExtensionNo] [int] NOT NULL,
	[Status] [varchar](1) NOT NULL,
 CONSTRAINT [PK_ScreenPopup_Extension] PRIMARY KEY CLUSTERED 
(
	[ExtensionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Logger]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_Logger](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Level] [varchar](max) NOT NULL,
	[CallSite] [varchar](max) NOT NULL,
	[Type] [varchar](max) NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[StackTrace] [varchar](max) NOT NULL,
	[InnerException] [varchar](max) NOT NULL,
	[AdditionalInfo] [varchar](max) NOT NULL,
	[LoggedOnDate] [datetime] NOT NULL,
 CONSTRAINT [pk_logs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Login]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_Login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AgentId] [int] NOT NULL,
	[ExtensionNo] [int] NOT NULL,
	[LoginStatus] [varchar](1) NOT NULL,
	[LoginDateTime] [datetime] NOT NULL,
	[SessionId] [varchar](100) NULL,
	[IpAddress] [varchar](50) NULL,
	[HostIpAddress] [varchar](50) NULL,
	[LogoutDateTime] [datetime] NULL,
 CONSTRAINT [PK_ScreenPopup_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Login_Archive]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_Login_Archive](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AgentId] [int] NOT NULL,
	[ExtensionNo] [int] NOT NULL,
	[LoginStatus] [varchar](1) NOT NULL,
	[LoginDateTime] [datetime] NOT NULL,
	[SessionId] [varchar](100) NULL,
	[IpAddress] [varchar](50) NULL,
	[HostIpAddress] [varchar](50) NULL,
	[LogoutDateTime] [datetime] NULL,
 CONSTRAINT [PK_ScreenPopup_Login_Archive] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_TravelAgent]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_TravelAgent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[ContactNo] [nvarchar](20) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_ScreenPopup_TravelAgent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Agent_Exclusion]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Agent_Exclusion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AgentId] [int] NOT NULL,
	[Status] [varchar](1) NULL,
 CONSTRAINT [PK_SMS_Survey_Agent_Exclusions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Application]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Application](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationCode] [varchar](20) NOT NULL,
	[ApplicationName] [varchar](200) NULL,
	[BrandName] [varchar](100) NULL,
	[BrandCountry] [varchar](4) NULL,
	[Status] [varchar](1) NULL,
	[CreatedOn] [varchar](20) NULL,
	[VersionNo] [varchar](20) NULL,
 CONSTRAINT [PK_CTI_App_001_Applications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Campaign](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[CampaignId] [numeric](18, 0) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerCountryCode] [varchar](3) NOT NULL,
	[CallerNumber] [varchar](15) NOT NULL,
	[AgentId] [int] NOT NULL,
	[ExtensionNo] [int] NOT NULL,
	[IsIncomingCall] [varchar](1) NOT NULL,
	[CreatedOn] [varchar](20) NOT NULL,
	[CreatedIpAddress] [varchar](20) NOT NULL,
	[Status] [varchar](1) NULL,
	[IsMessageSent] [varchar](1) NULL,
	[MessageAckGuid] [varchar](200) NULL,
	[SubmitDate] [varchar](200) NULL,
	[ErrorCode] [bigint] NULL,
	[ErrorDescription] [varchar](200) NULL,
 CONSTRAINT [PK_SMS_Survey_Campaign] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign_001_Log]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Campaign_001_Log](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[CampaignId] [numeric](18, 0) NOT NULL,
	[CallerId] [int] NOT NULL,
	[CallerCountryCode] [varchar](3) NOT NULL,
	[CallerNumber] [varchar](10) NOT NULL,
	[AgentId] [int] NOT NULL,
	[ExtensionNo] [int] NOT NULL,
	[IsIncomingCall] [varchar](1) NOT NULL,
	[CreatedOn] [varchar](20) NOT NULL,
	[CreatedIpAddress] [varchar](20) NOT NULL,
	[Status] [varchar](1) NULL,
	[IsMessageSent] [varchar](1) NULL,
	[MessageAckGuid] [varchar](200) NULL,
	[SubmitDate] [varchar](200) NULL,
	[ErrorCode] [bigint] NULL,
	[ErrorDescription] [varchar](200) NULL,
 CONSTRAINT [PK_SMS_Survey_Campaign_001_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign_Starter]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Campaign_Starter](
	[Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Application_Code] [nvarchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[StartedOn] [datetime] NOT NULL,
	[EndedOn] [datetime] NULL,
 CONSTRAINT [PK_SMS_Survey_Campaign_Starter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Credential]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Credential](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[Url] [varchar](200) NULL,
	[UserName] [varchar](200) NULL,
	[Password] [varchar](20) NULL,
	[CreatedOn] [varchar](20) NULL,
	[Status] [varchar](1) NULL,
 CONSTRAINT [PK_SMS_Survey_Credentials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Customer_Response]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Customer_Response](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TokenNo] [numeric](18, 0) NOT NULL,
	[User] [varchar](20) NOT NULL,
	[ResponseDateTime] [datetime] NOT NULL,
	[SurveyClient] [varchar](50) NULL,
	[ResponseDuration] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedIpAddress] [varchar](50) NOT NULL,
	[ResponseId] [int] NULL,
 CONSTRAINT [PK_tbl_SMS_Survey_Customer_Responses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Customer_Response_Question]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Customer_Response_Question](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResponseId] [int] NOT NULL,
	[QuestionId] [varchar](20) NOT NULL,
	[QuestionText] [varchar](max) NOT NULL,
	[NumberInput] [int] NULL,
	[TextInput] [varchar](50) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedIpAddress] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SMS_Survey_Customer_Response_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Logger]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Logger](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[Level] [varchar](max) NOT NULL,
	[CallSite] [varchar](max) NOT NULL,
	[Type] [varchar](max) NOT NULL,
	[Message] [varchar](max) NOT NULL,
	[StackTrace] [varchar](max) NOT NULL,
	[InnerException] [varchar](max) NOT NULL,
	[AdditionalInfo] [varchar](max) NOT NULL,
	[LoggedOnDate] [datetime] NOT NULL,
 CONSTRAINT [pk_tbl_CTI_SMS_Feedback_009_Loggers] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Questionaire]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Questionaire](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[User] [varchar](20) NOT NULL,
	[Text] [varchar](max) NOT NULL,
	[DisplayType] [varchar](20) NOT NULL,
	[MultiSelect] [varchar](100) NULL,
	[EndOfSurvey] [bit] NULL,
	[EndOfSurveyMessage] [varchar](100) NULL,
	[ConditionalFilter] [varchar](100) NULL,
	[PresentationMode] [varchar](20) NULL,
	[IsRequired] [bit] NULL,
	[QuestionTags] [varchar](200) NULL,
	[Status] [varchar](1) NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_SMS_Survey_Questionaires] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Questionaire_Filter]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Questionaire_Filter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[FilterQuestionId] [int] NOT NULL,
	[Answer] [varchar](20) NULL,
 CONSTRAINT [PK_SMS_Survey_Questionaire_Filters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Template]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Template](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[ApplicationCode] [varchar](20) NOT NULL,
	[LogoURL] [varchar](100) NULL,
	[BackgroundURL] [varchar](100) NULL,
	[BrandName] [varchar](50) NULL,
	[BrandCountry] [varchar](4) NULL,
	[ColorCode1] [varchar](10) NULL,
	[ColorCode2] [varchar](10) NULL,
	[ColorCode3] [varchar](10) NULL,
	[WelcomeText] [varchar](200) NULL,
	[WelcomeImage] [varchar](100) NULL,
	[ThankyouText] [varchar](200) NULL,
	[ThankyouImage] [varchar](100) NULL,
	[PartialResponseId] [varchar](100) NULL,
	[SurveyMessage] [varchar](100) NULL,
	[SkipWelcome] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[Status] [varchar](1) NULL,
 CONSTRAINT [PK_SMS_Survey_Templates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_WebApiToken]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_WebApiToken](
	[TokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[AuthToken] [varchar](200) NOT NULL,
	[IssuedOn] [datetime] NOT NULL,
	[ExpiredOn] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_WebApiUser]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_WebApiUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[Name] [varchar](100) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[x]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[x](
	[id] [int] NULL,
	[value] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx1]    Script Date: 08-05-2018 21:16:33 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[tbl_Call_Diversion]
(
	[CallerId] ASC
)
INCLUDE ( 	[CallStatus],
	[CallerMobile]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx2]    Script Date: 08-05-2018 21:16:33 ******/
CREATE NONCLUSTERED INDEX [idx2] ON [dbo].[tbl_Call_Diversion]
(
	[CallerId] ASC,
	[ExtensionNo] ASC,
	[CallerMobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx3]    Script Date: 08-05-2018 21:16:33 ******/
CREATE NONCLUSTERED INDEX [idx3] ON [dbo].[tbl_Call_Diversion]
(
	[CallIncomingDateTime] ASC
)
INCLUDE ( 	[ExtensionNo],
	[CallerMobile],
	[AgentId],
	[QuickPopAgentId],
	[DispositionId],
	[Remarks]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx1]    Script Date: 08-05-2018 21:16:33 ******/
CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[tbl_ScreenPopup_Login]
(
	[LoginDateTime] ASC
)
INCLUDE ( 	[AgentId],
	[ExtensionNo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_AutoDial_Call_Diversion] ADD  CONSTRAINT [DF_tbl_AutoDial_Call_Diversion_CallOutgoingDateTime]  DEFAULT (getdate()) FOR [CallOutgoingDateTime]
GO
ALTER TABLE [dbo].[tbl_AutoDial_Call_Diversion] ADD  DEFAULT ((0)) FOR [IsFailed]
GO
ALTER TABLE [dbo].[tbl_AutoDial_DropOut_Call] ADD  CONSTRAINT [DF_tbl_AutoDial_DropOut_Call_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tbl_AutoDial_DropOut_Call] ADD  DEFAULT ((0)) FOR [IsValidRecord]
GO
ALTER TABLE [dbo].[tbl_AutoDial_DropOut_Call] ADD  DEFAULT ((0)) FOR [Delflag]
GO
ALTER TABLE [dbo].[tbl_AutoDial_Premium_Call] ADD  CONSTRAINT [DF_tbl_AutoDial_Premium_Call_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tbl_Call_Diversion] ADD  DEFAULT (getdate()) FOR [CallIncomingDateTime]
GO
ALTER TABLE [dbo].[tbl_Call_Diversion_Test] ADD  DEFAULT (getdate()) FOR [CallIncomingDateTime]
GO
ALTER TABLE [dbo].[tbl_Mst_Disposition_Group] ADD  DEFAULT ('N') FOR [Delflag]
GO
ALTER TABLE [dbo].[tbl_Mst_Disposition_QueryTypes] ADD  CONSTRAINT [DF__tbl_Mst_D__Delfl__28A2FA0E]  DEFAULT ('N') FOR [Delflag]
GO
ALTER TABLE [dbo].[tbl_Mst_Disposition_SubGroup] ADD  DEFAULT ('N') FOR [Delflag]
GO
ALTER TABLE [dbo].[tbl_Mst_HuntGroup] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_Mst_VDN] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_ScreenPopup_CallDiversion] ADD  DEFAULT (getdate()) FOR [CallIncomingDateTime]
GO
ALTER TABLE [dbo].[tbl_ScreenPopup_Logger] ADD  CONSTRAINT [df_logs_loggedondate]  DEFAULT (getutcdate()) FOR [LoggedOnDate]
GO
ALTER TABLE [dbo].[tbl_ScreenPopup_TravelAgent] ADD  CONSTRAINT [DF_tbl_ScreenPopup_TravelAgent_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_SMS_Survey_Logger] ADD  CONSTRAINT [df_tbl_SMS_Survey_Logger_loggedondate]  DEFAULT (getdate()) FOR [LoggedOnDate]
GO
/****** Object:  StoredProcedure [dbo].[GetAllActiveCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllActiveCalls] 
	@Extension varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @AgentId int 

	Select @AgentId = AgentId  from tbl_ScreenPopup_Login where LoginStatus='A' and ExtensionNo=@Extension
	DECLARE @temp table(Id int,CallerId int ,CallerMobile varchar(20),ExtensionNo varchar(5),TodayCallCount int,IsTravelAgentCall bit)
	
	insert into @temp(Id,CallerId,CallerMobile,ExtensionNo,IsTravelAgentCall,TodayCallCount) 
	Select CallDiversion.Id as Id,CallerId,CallerMobile,ExtensionNo,ISNULL(travelAgent.IsActive,0) as IsTravelAgentCall,
	(Select Count(CallerId) from tbl_Call_Diversion where CallStatus='C' and CallerMobile=CallDiversion.CallerMobile And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())) As NoOfCall
	from tbl_Call_Diversion As CallDiversion with(nolock) 
	left outer join  tbl_ScreenPopup_TravelAgent  as travelAgent
	on CallDiversion.CallerMobile = travelAgent.ContactNo 
	where ExtensionNo= @Extension  and  CallDiversion.CallStatus in ('A','E') and Convert(Date,CallIncomingDateTime) = CONVERT(Date,GETDATE())
    
	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp

END




GO
/****** Object:  StoredProcedure [dbo].[GetAllActiveCallsTest]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllActiveCallsTest] 
	@Extension varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @AgentId int 

	Select @AgentId = AgentId  from tbl_ScreenPopup_Login where LoginStatus='A' and ExtensionNo=@Extension
	DECLARE @temp table(Id int,CallerId int ,CallerMobile varchar(20),ExtensionNo varchar(5),TodayCallCount int,IsTravelAgentCall bit)
	
	insert into @temp(Id,CallerId,CallerMobile,ExtensionNo,IsTravelAgentCall,TodayCallCount) 
	Select CallDiversion.Id as Id,CallerId,CallerMobile,ExtensionNo,ISNULL(travelAgent.IsActive,0) as IsTravelAgentCall,
	(Select Count(CallerId) from tbl_Call_Diversion_Test where CallStatus='C' and CallerMobile=CallDiversion.CallerMobile And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())) As NoOfCall
	from tbl_Call_Diversion_Test As CallDiversion with(nolock) 
	left outer join  tbl_ScreenPopup_TravelAgent  as travelAgent
	on CallDiversion.CallerMobile = travelAgent.ContactNo 
	where ExtensionNo= @Extension and  CallDiversion.CallStatus='A'
    
	update A set CallStatus='D',AgentId=@AgentId from tbl_Call_Diversion_Test A with(nolock) Join @temp B on A.ID = B.Id 

	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp

END




GO
/****** Object:  StoredProcedure [dbo].[GetCallerHistory]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCallerHistory] 
	@CallerMobile varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @temp table(AgentId varchar(20),AgentName varchar(200) ,CallIncomingDateTime datetime,CallStatus varchar(1),ExtensionNo varchar(10),CallEstablishedDateTime datetime2,CallEndDateTime datetime2,Disposition varchar(200) NUll)

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime,Disposition)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime,e.Description + ' -> ' + d.Description + ' -> ' + c.Description as Disposition  from tbl_Call_Diversion as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	left outer Join tbl_Mst_Disposition_QueryTypes c on a.DispositionId=C.Id 
	left outer Join tbl_Mst_Disposition_SubGroup d on d.Id=c.SubGroupId 
	left outer Join tbl_Mst_Disposition_Group e on e.Id=d.GroupId
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile like '%' + right(@CallerMobile,10) + '%' and a.CallStatus='C'
	order by a.CallIncomingDateTime desc

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime,Disposition)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime,e.Description + ' -> ' + d.Description + ' -> ' + c.Description as Disposition from tbl_call_Diversion_01Aug17 as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	left outer Join tbl_Mst_Disposition_QueryTypes c on a.DispositionId=C.Id 
	left outer Join tbl_Mst_Disposition_SubGroup d on d.Id=c.SubGroupId 
	left outer Join tbl_Mst_Disposition_Group e on e.Id=d.GroupId
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile like '%' + right(@CallerMobile,10) + '%' and a.CallStatus='C'
	order by a.CallIncomingDateTime desc


	select AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime,ISNULL(Disposition,'NA') As Disposition from @temp
	order by CallIncomingDateTime desc

	Select CustomerType,Title + ' ' + FirstName + ' ' + MiddleName + ' ' + LastName    from tbl_Mst_Customer_Spcl where PhoneNumber1 like ('%'+ @CallerMobile +'%') or PhoneNumber2 like ('%'+ @CallerMobile +'%') 
	or PhoneNumber3 like ('%'+ @CallerMobile +'%') and Delflag = 'N'

END





GO
/****** Object:  StoredProcedure [dbo].[GetCallerHistoryTest]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCallerHistoryTest] 
	@CallerMobile varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @temp table(AgentId varchar(20),AgentName varchar(200) ,CallIncomingDateTime datetime,CallStatus varchar(1),ExtensionNo varchar(10),CallEstablishedDateTime datetime2,CallEndDateTime datetime2)

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime from tbl_Call_Diversion_Test as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile=@CallerMobile and a.CallStatus='C'
	order by a.CallIncomingDateTime desc

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime from tbl_Call_Diversion_01Aug17 as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile=@CallerMobile and a.CallStatus='C'
	order by a.CallIncomingDateTime desc


	select AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime from @temp

END





GO
/****** Object:  StoredProcedure [dbo].[GetLastActiveCallInfo]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetLastActiveCallInfo] 
	@Extension varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Select CallerId,CallerMobile,ExtensionNo,CONVERT(DATETIME, CallIncomingDateTime, 0) as CallIncomingDateTime ,
	(Select Count(CallerId) from tbl_Call_Diversion  with (nolock) where CallStatus='C' and CallerMobile=CallDiversion.CallerMobile And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())) As NoOfCall
	from tbl_Call_Diversion As CallDiversion  with (nolock) where ExtensionNo=@Extension and CallStatus In ('A','D') 
END




GO
/****** Object:  StoredProcedure [dbo].[InsertLog]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[InsertLog] 
(
	@level varchar(max),
	@callSite varchar(max),
	@type varchar(max),
	@message varchar(max),
	@stackTrace varchar(max),
	@innerException varchar(max),
	@additionalInfo varchar(max)
)
as

insert into dbo.tbl_ScreenPopup_Logger
(
	[Level],
	CallSite,
	[Type],
	[Message],
	StackTrace,
	InnerException,
	AdditionalInfo,
   LoggedOnDate
)
values
(
	@level,
	@callSite,
	@type,
	@message,
	@stackTrace,
	@innerException,
	@additionalInfo,
	GetDate()
)





GO
/****** Object:  StoredProcedure [dbo].[sp_AddDropCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AddDropCalls] 
(
	@CallerName varchar(200),
	@CallerMobile varchar(20),
	@CallerEmail varchar(200),
	@PaxCount int,
	@PaxNames varchar(200),
	@LostPageName varchar(200),
	@FlightDetails varchar(200),
	@CaseType varchar(10) = 'EXP',
	@Priority varchar(3) = NULL,
	@IsValidRecord bit
)
as
BEGIN
Declare @CallerId int
declare @plus varchar(100) = '+'

Select @CallerId = ISNULL(Max(CallerId),0) from dbo.[tbl_AutoDial_DropOut_Call]
Set @CallerId = @CallerId + 1

If Len(@CallerMobile) <= 5
	Set @IsValidRecord = 0

--Set @CallerMobile = '919958574015'
--if (charindex(@plus, @CallerMobile) > 0)
--begin
--	Set @CallerMobile = REPLACE(@CallerMobile,@plus,'')
--    Set @IsValidRecord = 1
--end

insert into dbo.[tbl_AutoDial_DropOut_Call]
(
	CallerId,CallerName,CallerMobile,CallerEmail,PaxCount,PaxNames,LostPageName,FlightDetails,CaseType,CreatedOn,IsAllocated,Priority,IsValidRecord,Delflag,IsAutoDialed
)
values
(
	@CallerId,@CallerName,@CallerMobile,@CallerEmail,
	@PaxCount,@PaxNames,@LostPageName,@FlightDetails,@CaseType,GETDATE(),'N',@Priority,@IsValidRecord,0,1
)

END




GO
/****** Object:  StoredProcedure [dbo].[sp_AddNewCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE procedure [dbo].[sp_AddNewCall]   
(  
 @CallerId int,  
 @CallerName varchar(200),  
 @ExtensionNo varchar(20),  
 @CallStatus varchar(1),  
 @CallerMobile varchar(max)  
)  
as  
BEGIN TRAN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion with (updlock, rowlock, holdlock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile 
)  
 BEGIN  
	Select * from tbl_Mst_VDN where Code = @ExtensionNo
	IF @@ROWCOUNT > 0 
	begin
	  Insert into tbl_Call_Diversion(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile) values  
	  (@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile)  
     end
 END  
COMMIT  


GO
/****** Object:  StoredProcedure [dbo].[sp_AddNewCallTest]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE procedure [dbo].[sp_AddNewCallTest]   
(  
 @CallerId int,  
 @CallerName varchar(200),  
 @ExtensionNo varchar(20),  
 @CallStatus varchar(1),  
 @CallerMobile varchar(max)  ,
  @Ucid varchar(50)  ,
   @Uec varchar(50)
)  
as  
BEGIN TRAN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 

 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion with (updlock, rowlock, holdlock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile 
)  
 BEGIN  
	Select * from tbl_Mst_VDN where Code = @ExtensionNo
	IF @@ROWCOUNT = 0 
	begin
	
	  Insert into tbl_Call_Diversion(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile) values  
	  (@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile)  
     end
 END  
COMMIT 

Select * from x

GO
/****** Object:  StoredProcedure [dbo].[sp_AllocateDropCaseToActiveAgents]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AllocateDropCaseToActiveAgents] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select AgentId,ExtensionNo,LoginType into #ActiveLoginUsers from tbl_AutoDial_Login 
	where LoginStatus='D' order by LoginDateTime
	
	while exists(select * from #ActiveLoginUsers)
	begin
		declare @AgentId int,@ExtensionNo int,@LoginType varchar(100)

		select top 1 @AgentId = AgentId,@ExtensionNo = ExtensionNo,@LoginType = LoginType from #ActiveLoginUsers

		--Update tbl_AutoDial_Call_Diversion set CallStatus='S' where AgentId=@AgentId and ExtensionNo=@ExtensionNo and CallStatus='F'
		
		if not exists(select * from tbl_AutoDial_Call_Diversion where AgentId=@AgentId and ExtensionNo=@ExtensionNo and CallStatus != 'S')
		begin
			declare @CallerId int,@CallerName nvarchar(200),@CallerNumber nvarchar(20),@DropOutId int
			if @LoginType = 'WEB_DROP'
				begin
					select top 1  @CallerId = CallerId,@CallerName = CallerName,@CallerNumber = CallerMobile,@DropOutId=Id
					from tbl_AutoDial_DropOut_Call where IsAllocated='N' and IsValidRecord = 1
					Order By CreatedOn 

					if @CallerId > 0
						begin
							if left(@CallerNumber, 1) = '0'
								begin 
									Set @CallerNumber = '90' + substring( @CallerNumber, 2, LEN(@CallerNumber) - 1 )
								end
							else
								 begin
									Set @CallerNumber = '90' + @CallerNumber
								 end

							Insert into tbl_AutoDial_Call_Diversion(CallerId,CallerName,CallStatus,CallerMobile,AgentId,ExtensionNo,DropOutId)
							values(@CallerId,@CallerName,'A',@CallerNumber,@AgentId,@ExtensionNo,@DropOutId)

							Update tbl_AutoDial_DropOut_Call set IsAllocated = 'Y' where IsAllocated = 'N'
							and Id=@DropOutId 
						end
					else
						begin
							--print 'Get Failed Records'

							--Select @CallerId = A.CallerId,@CallerName = A.CallerName,@CallerNumber = A.CallerMobile,@DropOutId=A.DropOutId from tbl_AutoDial_Call_Diversion A Join tbl_AutoDial_DropOut_Call B on A.DropOutId=B.Id Where  
							--A.IsFailed=1 
							--and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5 and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 6
							--and B.ProcessCount< 2

							update A Set A.CallStatus='A',A.AgentId=@AgentId From tbl_AutoDial_Call_Diversion A Join tbl_AutoDial_DropOut_Call B on A.DropOutId=B.Id  Where  
							A.IsFailed=1 
							and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5 and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 6
							and B.ProcessCount< 2

							update B Set B.ProcessCount = B.ProcessCount + 1 From tbl_AutoDial_Call_Diversion A Join tbl_AutoDial_DropOut_Call B on A.DropOutId=B.Id  Where  
							A.IsFailed=1 
							and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5 and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 6
							and B.ProcessCount< 2

							--update tbl_AutoDial_Call_Diversion Set 
							--Insert into tbl_AutoDial_Call_Diversion(CallerId,CallerName,CallStatus,CallerMobile,AgentId,ExtensionNo,DropOutId)
							--values(@CallerId,@CallerName,'A',@CallerNumber,@AgentId,@ExtensionNo,@DropOutId)
	
						end
				end 
			else if @LoginType = 'CALLBACK_MNGR'
				begin
					select top 1  @CallerId = CallerId,@CallerName = CallerName,@CallerNumber = CallerNumber,@DropOutId=Id
					from tbl_AutoDial_Premium_Call where IsAllocated='N'
					Order By CreatedOn desc 

			
					if left(@CallerNumber, 1) = '0'
						begin 
							Set @CallerNumber = '90' + substring( @CallerNumber, 2, LEN(@CallerNumber) - 1 )
						end
					else
						 begin
							Set @CallerNumber = '90' + @CallerNumber
						 end

					Insert into tbl_AutoDial_Call_Diversion(CallerId,CallerName,CallStatus,CallerMobile,AgentId,ExtensionNo,DropOutId)
					values(@CallerId,@CallerName,'A',@CallerNumber,@AgentId,@ExtensionNo,@DropOutId)

					Update tbl_AutoDial_DropOut_Call set IsAllocated = 'Y' where IsAllocated = 'N'
					and Id=@DropOutId 
				end

		end 
		delete from #ActiveLoginUsers where AgentId = @AgentId and ExtensionNo=@ExtensionNo
	end

END



GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_ActiveCallCount]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoDial_ActiveCallCount] 
	@HostIpAddress varchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select count(*) from tbl_AutoDial_Call_Diversion a inner join tbl_AutoDial_Login b 
	on a.ExtensionNo=b.ExtensionNo 
	where CallStatus='A' and DATEDIFF(MI,CallOutgoingDateTime,GETDATE()) < 10 
	and Convert(Date,GETDATE())=Convert(DAte,LoginDateTime)
	and HostIpAddress = @HostIpAddress 


END


GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_CheckExtensionAvailability]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_CheckExtensionAvailability] 
(
	@AgentId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select AgentId from tbl_AutoDial_Login Where AgentId=@AgentId and LoginStatus='A'

END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_CheckNewCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_AutoDial_CheckNewCalls] 
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Call table(DropOutId int,CallerId int,CallerName varchar(200),CallerMobile varchar(20),CallType varchar(20))
	Declare @FailedCallCount int, @CallBackCount int ,@NewCallCount int
	
	Select @FailedCallCount = Count(A.CallerId)  From tbl_AutoDial_Call_Diversion A Join tbl_AutoDial_DropOut_Call B on A.DropOutId=B.Id  
	Where  A.IsFailed=1 and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5  And B.IsAllocated = 'Y'  And B.Delflag=0 And B.IsAutoDialed=1
	and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 8 and B.ProcessCount< 2

	Select @CallBackCount= Count(CallerId) From  
	tbl_AutoDial_DropOut_Call where 
	IsCallback = 1 and Convert(Date,CallbackDateTime) = Convert(Date,GETDATE()) 
	and DATEDIFF(MI,CallbackDateTime,GETDATE()) > 0 and (IsCallbackCompleted = 0 or IsCallbackCompleted IS NULL)

	Select @NewCallCount =  Count(*) from tbl_AutoDial_DropOut_Call with(nolock) where IsAllocated='N' and IsValidRecord=1  And Delflag=0 And IsAutoDialed=1 
	And DATEDIFF(MI,CreatedOn,GETDATE()) < 360 and IsValidRecord = 1
	and CallerMobile Not IN (Select CallerMobile from tbl_AutoDial_DropOut_Call A with (nolock) Where Convert(DAte,A.CreatedOn) = Convert(DAte,GETDATE()) 
	and A.IsAllocated IN('Y','I')
	) 
	and LOWER(CallerEmail) not Like '%travel%'
	and LOWER(CallerEmail) not Like '%trip%'
	and LOWER(CallerEmail) not Like '%holiday%' 
	and LOWER(CallerEmail) not Like '%trvl%'   
	and LOWER(CallerEmail) not Like '%tour%'  
	and LOWER(CallerEmail) not Like '%globe%' 
	and LOWER(CallerEmail) not Like '%thomas%' 
	and LOWER(CallerEmail) not Like '%ticket%'  
	and LOWER(CallerEmail) not Like '%victoria%'  
	and LOWER(CallerEmail) not Like '%domestic%'  
	and LOWER(CallerName) not Like '%travel%'
	and LOWER(CallerName) not Like '%trip%'
	and LOWER(CallerName) not Like '%holiday%' 
	and LOWER(CallerName) not Like '%trvl%'   
	and LOWER(CallerName) not Like '%tour%'  

	
	Select @FailedCallCount + @CallBackCount + @NewCallCount as CallCount
END



GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_CloseCurrentCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_AutoDial_CloseCurrentCall] 
(
	@CallerId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @CallStatus varchar(2)
	Select @CallStatus = CallStatus from tbl_AutoDial_Call_Diversion Where CallerId = @CallerId
	
	if @CallStatus = 'A' OR @CallStatus = 'D'
	begin
		Update tbl_AutoDial_Call_Diversion Set CallStatus='S',DispositionId=101 Where CallerId = @CallerId
	end
	else
		begin
			Update tbl_AutoDial_Call_Diversion Set CallStatus='S' Where CallerId = @CallerId
		end

	return 0;
END





GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_CreateLoginLog]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_CreateLoginLog] 
(
	@AgentId int,
	@ExtensionNo int,
	@AgentLoggedInType varchar(100),
	@SessionId varchar(100),
	@IpAddress varchar(50),
	@HostIpAddress varchar(50)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Update tbl_AutoDial_Login Set LoginStatus='C' where AgentId=@AgentId and ExtensionNo=@ExtensionNo and LoginStatus in ('A','D') 

	Insert into tbl_AutoDial_Login (AgentId,ExtensionNo,LoginType,LoginStatus,SessionId,LoginDateTime,IpAddress,HostIpAddress)Values
	(@AgentId,@ExtensionNo,@AgentLoggedInType,'A',@SessionId,GETDATE(),@IpAddress,@HostIpAddress)

	return 0;
END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_DeActivateAgentLogin]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_DeActivateAgentLogin] 
(
	@AgentId int,
	@ExtensionNo int,
	@SessionId varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_AutoDial_Login Set LoginStatus='C',LogoutDateTime=GETDATE() Where AgentId=@AgentId and LoginStatus IN ('A','D') and ExtensionNo=@ExtensionNo
	and SessionId=@SessionId

	return 0;
END










GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetActiveLoggedinAgent]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_GetActiveLoggedinAgent] 
	@HostIpAddress varchar(20)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select AgentId,ExtensionNo from tbl_AutoDial_Login Where  LoginStatus='D' and HostIpAddress=@HostIpAddress and  IsStationOnMonitor = 1
	and MonitorCrossRefInvokeId is not null

END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetActiveMonitoringStations]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoDial_GetActiveMonitoringStations]
(
	@DropOutId int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExtensionNo int 

	Select ExtensionNo from tbl_AutoDial_Login where CONVERT(Date,LoginDateTime)= CONVERT(Date,Getdate()) 
	and LoginStatus = 'D' 
	and MonitorCrossRefInvokeId is not null and IsStationOnMonitor = 1
	order by Id

END










GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetActiveOutgoingCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoDial_GetActiveOutgoingCalls]
	@HostIpAddress varchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @AgentId int 
	Declare @PendingCallCount int

	DECLARE @temp table(Id int,CallerId int,CallerName varchar(200),CallerMobile varchar(20),ExtensionNo varchar(10),CallOutgoingDateTime datetime2,CallEstablishedDateTime datetime2,CallEndDateTime datetime2,CallStatus varchar(1),DropOutId int,AgentId int)
	DECLARE @temp1 table(Id int,CallerId int,CallerName varchar(200),CallerMobile varchar(20),ExtensionNo varchar(10),CallOutgoingDateTime datetime2,CallEstablishedDateTime datetime2,CallEndDateTime datetime2,CallStatus varchar(1),DropOutId int,AgentId int)
	DECLARE @temp2 table(Id int,CallerId int,CallerName varchar(200),CallerMobile varchar(20),ExtensionNo varchar(10),CallOutgoingDateTime datetime2,CallEstablishedDateTime datetime2,CallEndDateTime datetime2,CallStatus varchar(1),DropOutId int,AgentId int)
	

	insert into @temp(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select a.Id as Id,CallerId,CallerName,CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	where a.CallStatus='A'
	and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) and b.LoginStatus='D'
	and b.HostIpAddress=@HostIpAddress
    
	update A set CallStatus='I' from tbl_AutoDial_Call_Diversion A 
	with(nolock) Join @temp B on A.ID = B.Id
	
	insert into @temp(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select a.Id as Id,CallerId,CallerName,CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId 
	where a.CallStatus='D' and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) and b.LoginStatus='D'
	and b.HostIpAddress=@HostIpAddress
    
	--Get All Establish call and Change status to 'P' (Processing) after inserting in a temp table-----
	insert into @temp1(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select a.Id as Id,CallerId,CallerName,CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	where a.CallStatus='E'
	and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) and b.LoginStatus='D'
	and b.HostIpAddress=@HostIpAddress 
    
	update A set CallStatus='P' from tbl_AutoDial_Call_Diversion A 
	with(nolock) Join @temp1 B on A.ID = B.Id  

	--Get All Cleared call and Change status to 'F' (Finished) after inserting in a temp table-----
	insert into @temp2(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select a.Id as Id,CallerId,CallerName,CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	where a.CallStatus='C'
	and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) and b.LoginStatus='D'
	and b.HostIpAddress=@HostIpAddress
    
	update A set CallStatus='U' from tbl_AutoDial_Call_Diversion A 
	with(nolock) Join @temp2 B on A.ID = B.Id  

	select @PendingCallCount = Sum(CallerId)
	from tbl_AutoDial_DropOut_Call where IsAllocated='N' and IsValidRecord = 1

	select CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId,@PendingCallCount as  PendingCallCount from @temp
	Union
	select CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId,@PendingCallCount as  PendingCallCount  from @temp1
	Union
	select CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId,@PendingCallCount as  PendingCallCount  from @temp2

END









GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetAgentActiveOutgoingCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoDial_GetAgentActiveOutgoingCall] 
	@ExtensionNo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Select top 1 CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	where CallDiversion.CallStatus in ('D','E','F','A') and ExtensionNo=@ExtensionNo
	And DATEDIFF(MI,CallOutgoingDateTime,GETDATE()) < 10 
	order by Id desc
END











GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetAgentInfo]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_GetAgentInfo] 
(
	@AgentId int,
	@AgentPassword varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT AgentId,AgentPassword,AgentName,SkillSet From tbl_AutoDial_Agent where AgentId=@AgentId
	and AgentPassword=@AgentPassword
END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetAgentLoggedInExtension]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_GetAgentLoggedInExtension] 
(
	@AgentId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select ExtensionNo from tbl_AutoDial_Login Where AgentId=@AgentId and LoginStatus='A'

END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetAgentWithNoActiveCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_GetAgentWithNoActiveCall] 
	@HostIpAddress varchar(20)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select Distinct A.AgentId,A.ExtensionNo,A.LoginType,A.LoginDateTime,(select count(CallerId) from tbl_AutoDial_Call_Diversion  with(nolock) where 
	ExtensionNo=A.ExtensionNo and Convert(Date,CallOutgoingDateTime) = Convert(Date,GETDATE()) 
	and CallStatus NOT IN ('C','S')) As CallCount,
	(select  top 1 DateDiff(S,CallEndDateTime,GETDATE()) from tbl_AutoDial_Call_Diversion  with(nolock) where 
	ExtensionNo=A.ExtensionNo and AgentId=A.AgentId 
	and Convert(Date,CallOutgoingDateTime) = Convert(Date,GETDATE()) 
	and CallStatus = 'C' order by CallOutgoingDateTime desc) As IdleTimeout from tbl_AutoDial_Login As A with (nolock)
	where HostIpAddress = @HostIpAddress and LoginStatus='D'  and MonitorCrossRefInvokeId>0
	and Convert(Date,LoginDateTime) = Convert(Date,GETDATE()) 
	and IsStationOnMonitor = 1 order by IdleTimeout desc
END


GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetDropCallerInfo]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoDial_GetDropCallerInfo] 
(
	@DropOutId int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExtensionNo int 

	Select CallerId,CallerName,CallerMobile,CallerEmail,PaxNames,PaxCount,FlightDetails,LostPageName,Priority,CaseType
	from tbl_AutoDial_DropOut_Call As CallDiversion with(nolock) 
	where Id=@DropOutId

END










GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetLoginUnMonitoredAgents]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_GetLoginUnMonitoredAgents] 
	@HostIpAddress varchar(20)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select AgentId,ExtensionNo from tbl_AutoDial_Login Where HostIpAddress =@HostIpAddress and LoginStatus In ('A','D') and (IsStationOnMonitor = 0 or IsStationOnMonitor IS NULL)
	order by Id

	return 0;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetLogoutMonitoredAgents]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_AutoDial_GetLogoutMonitoredAgents] 
	@HostIpAddress varchar(20)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select AgentId,ExtensionNo,MonitorCrossRefInvokeId, (select count(CallerId) from tbl_AutoDial_Call_Diversion  with(nolock) where 
	ExtensionNo=A.ExtensionNo and Convert(Date,CallOutgoingDateTime) = Convert(Date,GETDATE()) and DateDiff(MI,CallOutgoingDateTime,GETDATE()) < 30
	and CallStatus NOT IN ('C','S') ) As ActiveCallCount from tbl_AutoDial_Login A Where HostIpAddress= @HostIpAddress and LoginStatus In ('C') 
	and IsStationOnMonitor = 1 and StationMonitorStartedOn is not null 
	order by Id

	return 0;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetUnAllocatedCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_GetUnAllocatedCall] 
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Call table(DropOutId int,CallerId int,CallerName varchar(200),CallerMobile varchar(20),CallType varchar(20))
	
	insert into @Call(CallerId,CallerName,CallerMobile,DropOutId,CallType)
	Select top 1 CallerId,CallerName,CallerMobile,Id As DropOutId,'CALLBACK_CALL' as CallType From  
	tbl_AutoDial_DropOut_Call with (nolock) where  IsAllocated='Y' and
	IsCallback = 1 and IsValidRecord = 1 and Convert(Date,CallbackDateTime) = Convert(Date,GETDATE()) 
	and DATEDIFF(MI,CallbackDateTime,GETDATE()) > 0 and (IsCallbackCompleted = 0 or IsCallbackCompleted IS NULL)

	if(@@ROWCOUNT = 0)
	begin
		Declare @CallCount int
		Select @CallCount = Count(A.CallerId)  From tbl_AutoDial_Call_Diversion A Join tbl_AutoDial_DropOut_Call B on A.DropOutId=B.Id  
		Where  A.IsFailed=1  And B.IsAllocated = 'Y' And B.Delflag=0 and B.IsValidRecord = 1  and B.IsAutoDialed = 1 and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5 
		and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 8 and B.ProcessCount< 2

		if(@CallCount>0)
			begin
				insert into @Call(CallerId,CallerName,CallerMobile,DropOutId,CallType)
				Select top 1 A.CallerId,A.CallerName,B.CallerMobile,A.DropOutId As DropOutId,'FAILED_CALL' as CallType  From tbl_AutoDial_Call_Diversion A with (nolock) Join tbl_AutoDial_DropOut_Call B with (nolock) on A.DropOutId=B.Id  
				Where  A.IsFailed=1 and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5 And B.IsAllocated = 'Y' And B.Delflag=0  and B.IsAutoDialed = 1
				and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 8 and B.ProcessCount< 2  Order By Priority,CreatedOn asc

				update A set A.IsAllocated='I',ProcessCount = ProcessCount + 1 from tbl_AutoDial_DropOut_Call A inner join @Call B on a.Id = b.DropOutId
			end
		else
			begin
			
				insert into @Call(CallerId,CallerName,CallerMobile,DropOutId,CallType)
				select top 1 CallerId,CallerName,CallerMobile,Id As DropOutId,'NEW_CALL' as CallType  from 
				tbl_AutoDial_DropOut_Call with(nolock) where IsAllocated='N' And Delflag=0 and IsAutoDialed = 1 
				And DATEDIFF(MI,CreatedOn,GETDATE()) < 360 and IsValidRecord = 1
				and CallerMobile Not IN (Select CallerMobile from tbl_AutoDial_DropOut_Call A with (nolock) Where Convert(DAte,A.CreatedOn) = Convert(DAte,GETDATE()) 
				and A.IsAllocated IN('Y','I')
				) 
				and LOWER(CallerEmail) not Like '%travel%'
				and LOWER(CallerEmail) not Like '%trip%'
				and LOWER(CallerEmail) not Like '%holiday%' 
				and LOWER(CallerEmail) not Like '%trvl%'   
				and LOWER(CallerEmail) not Like '%tour%'  
				and LOWER(CallerEmail) not Like '%globe%' 
				and LOWER(CallerEmail) not Like '%thomas%' 
				and LOWER(CallerEmail) not Like '%ticket%'  
				and LOWER(CallerEmail) not Like '%victoria%'  
				and LOWER(CallerEmail) not Like '%domestic%'  

				and LOWER(CallerName) not Like '%travel%'
				and LOWER(CallerName) not Like '%trip%'
				and LOWER(CallerName) not Like '%holiday%' 
				and LOWER(CallerName) not Like '%trvl%'   
				and LOWER(CallerName) not Like '%tour%'  
				Order By Priority,PaxCount desc,CreatedOn desc

				update A set A.IsAllocated='I' from tbl_AutoDial_DropOut_Call A inner join @Call B on a.Id = b.DropOutId
			end
	end
	else
	begin
		update A set A.IsAllocated='I' from tbl_AutoDial_DropOut_Call A inner join @Call B on a.Id = b.DropOutId
	end	
		
	
	IF Exists(Select CallerMobile from @Call)
		BEGIN
			Declare @CallerMobileWithPrefix nvarchar(20)
			Declare @CallerMobile nvarchar(20)
			Select @CallerMobile = CallerMobile from @Call
			
			--if(LEN(@CallerMobile) = 12 and left(@CallerMobile, 2) = '91')
			--	Set @CallerMobile = '90' + Right(@CallerMobile, 10)
			--else 
			if(LEN(@CallerMobile) = 12 and (left(@CallerMobile, 3) = '919' or left(@CallerMobile, 3) = '918' or left(@CallerMobile, 3) = '917' or left(@CallerMobile, 3) = '916'))
				Set @CallerMobileWithPrefix = '90' + Right(@CallerMobile, 10)
			else if(LEN(@CallerMobile) = 11 and left(@CallerMobile, 1) = '0')
				Set @CallerMobileWithPrefix = '90' + Right(@CallerMobile, 10)
			else if(LEN(@CallerMobile) = 14 and left(@CallerMobile, 4) = '0091')
				Set @CallerMobileWithPrefix = '90' + Right(@CallerMobile, 10)
			else if(LEN(@CallerMobile) = 10 and (left(@CallerMobile, 1) = '9' or left(@CallerMobile, 1) = '8' or left(@CallerMobile, 1) = '7'))
				Set @CallerMobileWithPrefix = '90' + @CallerMobile
			else if(LEN(@CallerMobile) = 13 and left(@CallerMobile, 3) = '910')
				Set @CallerMobileWithPrefix = '90' + Right(@CallerMobile, 10)
			else if(LEN(@CallerMobile) = 14 and left(@CallerMobile, 5) = '00971')
				Set @CallerMobileWithPrefix = '9000' +   Right(@CallerMobile, 12)
			else if(LEN(@CallerMobile) = 12 and left(@CallerMobile, 3) = '971')
				Set @CallerMobileWithPrefix = '9000' + @CallerMobile
			else if(LEN(@CallerMobile) = 11 and left(@CallerMobile, 3) = '971')
				Set @CallerMobileWithPrefix = '9000' + @CallerMobile
			else if(LEN(@CallerMobile) = 13 and left(@CallerMobile, 4) = '9710')
				Set @CallerMobileWithPrefix = '9000' + '971' + Right(@CallerMobile, 9)
			else if(LEN(@CallerMobile) = 9 and left(@CallerMobile, 1) = '5')
				Set @CallerMobileWithPrefix = '9000' + '971' + Right(@CallerMobile, 9)
			else if(LEN(@CallerMobile) = 10 and left(@CallerMobile, 2) = '05')
				Set @CallerMobileWithPrefix = '9000' + '971' + Right(@CallerMobile, 9)
			else if(LEN(@CallerMobile) = 10 and left(@CallerMobile, 2) = '65')
				Set @CallerMobileWithPrefix = '9000' +  Right(@CallerMobile, 10)
			else 
				Set @CallerMobileWithPrefix = '90' + @CallerMobile

			Select CallerId,CallerName,@CallerMobile As CallerMobile,@CallerMobileWithPrefix As CallerMobileWithPrefix,DropOutId,CallType from @Call
		END
	ELSE
		BEGIN
			Select CallerId,CallerName,CallerMobile,null as CallerMobileWithPrefix,DropOutId,CallType from @Call
		END
		
		
END



GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetUnAllocatedWebsiteDropoutCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AutoDial_GetUnAllocatedWebsiteDropoutCalls] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--Declare @CallCount int
	DECLARE @CaseType TABLE
	(
	  Priority varchar(2), 
	  CaseCount int
	)
	Insert into @CaseType(Priority,CaseCount)Values('P1',0)
	Insert into @CaseType(Priority,CaseCount)Values('P2',0)
	Insert into @CaseType(Priority,CaseCount)Values('P3',0)

	Select X.Priority,Sum(X.CaseCount)  as CaseCount from
	(
		select Priority, Count(CallerId) As CaseCount
		from tbl_AutoDial_DropOut_Call where IsAllocated='N' And Delflag=0  and IsAutoDialed = 1 
		and IsValidRecord = 1 
		And DATEDIFF(MI,CreatedOn,GETDATE()) < 360
		and CallerMobile Not IN (Select CallerMobile from tbl_AutoDial_DropOut_Call A with (nolock) Where Convert(DAte,A.CreatedOn) = Convert(DAte,GETDATE()) 
		and A.IsAllocated IN('Y','I')
		) 
		and LOWER(CallerEmail) not Like '%travel%'
		and LOWER(CallerEmail) not Like '%trip%'
		and LOWER(CallerEmail) not Like '%holiday%' 
		and LOWER(CallerEmail) not Like '%trvl%'   
		and LOWER(CallerEmail) not Like '%tour%'  
		and LOWER(CallerEmail) not Like '%globe%' 
		and LOWER(CallerEmail) not Like '%thomas%' 
		and LOWER(CallerEmail) not Like '%ticket%'  
		and LOWER(CallerEmail) not Like '%victoria%'  
		and LOWER(CallerEmail) not Like '%domestic%'  

		and LOWER(CallerName) not Like '%travel%'
		and LOWER(CallerName) not Like '%trip%'
		and LOWER(CallerName) not Like '%holiday%' 
		and LOWER(CallerName) not Like '%trvl%'   
		and LOWER(CallerName) not Like '%tour%'  
		Group By Priority
		UNION ALL
		Select Priority, Count(A.CallerId)  As CaseCount  From tbl_AutoDial_Call_Diversion A with (nolock) Join tbl_AutoDial_DropOut_Call B with (nolock)
		on A.DropOutId=B.Id  
		Where  A.IsFailed=1 
		And B.IsAllocated = 'Y' And B.Delflag=0  and B.IsAutoDialed = 1
		and DATEDIFF(MI,A.CallEndDateTime, GetDate()) >= 5  
		and DATEDIFF(MI,A.CallEndDateTime, GetDate()) <= 8 and B.ProcessCount< 2
		Group By Priority 
		Union All
		Select Priority,CaseCount from @CaseType
	
	) As X
	Group By X.Priority
	

	

END










GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_GetUnProcessedCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_GetUnProcessedCalls] 
	@HostIpAddress varchar(20)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @UnProcessedCalls table
		(CallerId int,CallerMobile varchar(20),ExtensionNo int,AgentId int)

 --   Update A Set A.IsAllocated = 'N' from
 --   tbl_AutoDial_DropOut_Call A left outer join tbl_AutoDial_Call_Diversion B 
 --   on A.Id=B.DropOutId
 --   where 
	--IsAllocated='I' and Convert(Date,CreatedOn) = Convert(Date,Getdate()) 
	--and DATEDIFF(HH,CreatedOn,GETDATE()) <= 1

	Insert into @UnProcessedCalls(CallerId,CallerMobile,ExtensionNo,AgentId)
	Select CallerId,CallerMobile,ExtensionNo,AgentId from tbl_AutoDial_Call_Diversion  
	where CallStatus  = 'A' and HostIpAddress = @HostIpAddress
	and DATEDIFF(MI,CallOutgoingDateTime,GETDATE()) > 1
	order by CallOutgoingDateTime desc

	Insert into @UnProcessedCalls(CallerId,CallerMobile,ExtensionNo,AgentId)
	Select CallerId,CallerMobile,ExtensionNo,AgentId from tbl_AutoDial_Call_Diversion  
	where CallStatus  = 'D' and HostIpAddress = @HostIpAddress
	and DATEDIFF(MI,CallDeliveredDateTime,GETDATE()) > 1
	order by CallOutgoingDateTime desc

	Insert into @UnProcessedCalls(CallerId,CallerMobile,ExtensionNo,AgentId)
	Select CallerId,CallerMobile,ExtensionNo,AgentId from tbl_AutoDial_Call_Diversion  
	where CallStatus  = 'F' and HostIpAddress = @HostIpAddress
	and DATEDIFF(MI,CallFailedDateTime,GETDATE()) > 1
	order by CallOutgoingDateTime desc

	Insert into @UnProcessedCalls(CallerId,CallerMobile,ExtensionNo,AgentId)
	Select CallerId,CallerMobile,ExtensionNo,AgentId from tbl_AutoDial_Call_Diversion  
	where CallStatus  = 'E' and HostIpAddress = @HostIpAddress
	and DATEDIFF(MI,CallEstablishedDateTime,GETDATE()) > 5
	order by CallOutgoingDateTime desc

	
	Select CallerId,CallerMobile,ExtensionNo,AgentId from @UnProcessedCalls
END

--Select * from x
GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_IsAgentLoggedIn]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_IsAgentLoggedIn] 
(
	@AgentId int,
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	If Exists( Select AgentId from tbl_AutoDial_Login Where AgentId=@AgentId and ExtensionNo=@ExtensionNo and IsStationOnMonitor = 1 and LoginStatus='D')
	begin 
		select 1
		return 1
	end
	else
	begin
		select 0
		return 0
	end

END









GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_LogoutAgentExistingSession]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_LogoutAgentExistingSession] 
(
	@AgentId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_AutoDial_Login Set LoginStatus='C' Where AgentId=@AgentId and LoginStatus='A'

	return 0;
END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_ReActivateAgentLogin]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_ReActivateAgentLogin] 
(
	@AgentId int,
	@ExtensionNo int,
	@SessionId varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_AutoDial_Login Set LoginStatus='D',LogoutDateTime=NULL Where AgentId=@AgentId and ExtensionNo=@ExtensionNo
	and SessionId=@SessionId

	return 0;
END









GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_ReAllocateCurrentCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_AutoDial_ReAllocateCurrentCall] 
(
	@DropOutId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_AutoDial_DropOut_Call Set IsAllocated = 'N' 
    where 
	IsAllocated='I' and Convert(Date,CreatedOn) = Convert(Date,Getdate()) 
	and Id=@DropOutId

END





GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_ReAssignCurrentCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_AutoDial_ReAssignCurrentCall] 
(
	@CallerId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @CallStatus varchar(2)
	Declare @DropOutId int
	Select @CallStatus = CallStatus,@DropOutId = DropOutId  from tbl_AutoDial_Call_Diversion with(nolock) Where CallerId = @CallerId
	if @CallStatus != 'S'
	begin
		Update tbl_AutoDial_Call_Diversion Set CallStatus='S' Where CallerId = @CallerId
		Update tbl_AutoDial_DropOut_Call Set IsAllocated='N' Where Id = @DropOutId
	end
	return 0;
END





GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_SaveDialCallLog]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_SaveDialCallLog] 
(
    @CallType nvarchar(20),
	@UCID nvarchar(20),
	@CallerId int,
	@CallerName nvarchar(200),
	@CallerNumber nvarchar(20),
	@AgentId int,
	@ExtensionNo int,
	@RecordId int,
	@HostIpAddress nvarchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF (@CallType = 'NEW_CALL')
		BEGIN
			 Insert into tbl_AutoDial_Call_Diversion(UCID,CallerId,CallerName,CallStatus,CallerMobile,AgentId,
			 ExtensionNo,DropOutId,CallOutgoingDateTime,HostIpAddress) values (@UCID,@CallerId,@CallerName,'A',@CallerNumber,@AgentId,@ExtensionNo,@RecordId, GETDATE(),@HostIpAddress)
        
			  Update tbl_AutoDial_DropOut_Call set IsAllocated = 'Y',AllocatedOn = GETDATE() where IsAllocated = 'I' 
			  and Id=@RecordId
		END
	ELSE IF (UPPER(@CallType) = 'CALLBACK_CALL')
		BEGIN
			 Insert into tbl_AutoDial_Call_Diversion(UCID,CallerId,CallerName,CallStatus,CallerMobile,AgentId,
			 ExtensionNo,DropOutId,CallOutgoingDateTime,HostIpAddress) values (@UCID,@CallerId,@CallerName,'A',@CallerNumber,@AgentId,@ExtensionNo,@RecordId, GETDATE(),@HostIpAddress)
        
			  Update tbl_AutoDial_DropOut_Call set IsCallbackCompleted = 1,IsCallbackCompletedOn = GETDATE(), IsAllocated = 'Y',AllocatedOn = GETDATE() where IsAllocated = 'I' 
			  and Id=@RecordId
		END
    ELSE
		BEGIN
			Insert into tbl_AutoDial_Call_Diversion(UCID,CallerId,CallerName,CallStatus,CallerMobile,AgentId,
			 ExtensionNo,DropOutId,CallOutgoingDateTime,HostIpAddress) values (@UCID,@CallerId,@CallerName,'A',@CallerNumber,@AgentId,@ExtensionNo,@RecordId, GETDATE(),@HostIpAddress)
        
			update tbl_AutoDial_DropOut_Call Set IsAllocated = 'Y',AllocatedOn = GETDATE() Where  Id = @RecordId
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_SaveDispositionForActiveCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_AutoDial_SaveDispositionForActiveCall] 
(
	@DispositionId int,
	@CallerId int,
	@CallbackRequestDateTime datetime =null
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @DispositionId = 16
		begin
			Update tbl_AutoDial_Call_Diversion Set  DispositionId=@DispositionId Where CallerId = @CallerId
			update A set  A.IsCallback = 1, A.CallbackDateTime = @CallbackRequestDateTime from tbl_AutoDial_DropOut_Call A Inner Join tbl_AutoDial_Call_Diversion B on 
			A.Id = B.DropOutId where B.CallerId = @CallerId   
		end
	else
		begin 
			Update tbl_AutoDial_Call_Diversion Set DispositionId=@DispositionId Where CallerId = @CallerId
		end

	return 0;
END







GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_StopActiveAgentMonitoring]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_StopActiveAgentMonitoring] 
(
	@MonitorCrossRefId int,
	@AgentId int,
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 update tbl_AutoDial_Login Set LoginStatus = 'C' , IsStationOnMonitor = 0 , StationMonitorStoppedOn = GETDATE()
	 where AgentId = @AgentId  and ExtensionNo = @ExtensionNo and MonitorCrossRefInvokeId = @MonitorCrossRefId
	 and LoginStatus = 'D' and IsStationOnMonitor =1 

end







GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateAgentMonitorCrossRefId]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_UpdateAgentMonitorCrossRefId] 
(
	@MonitorCrossRefId int,
	@AgentId int,
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 update tbl_AutoDial_Login Set IsStationOnMonitor = 1 ,StationMonitorStartedOn = GETDATE(), MonitorCrossRefInvokeId=@MonitorCrossRefId 
	 where AgentId = @AgentId  and ExtensionNo = @ExtensionNo and LoginStatus In ('A','D')

end










GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateAgentMonitorToStart]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_UpdateAgentMonitorToStart] 
(
	@MonitorCrossRefId int,
	@AgentId int,
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 update tbl_AutoDial_Login Set IsStationOnMonitor = 1 ,StationMonitorStartedOn = GETDATE(), MonitorCrossRefInvokeId=@MonitorCrossRefId 
	 where AgentId = @AgentId  and ExtensionNo = @ExtensionNo and LoginStatus In ('A','D')

end







GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateAgentMonitorToStop]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_UpdateAgentMonitorToStop] 
(
	@MonitorCrossRefId int,
	@AgentId int,
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 update tbl_AutoDial_Login Set IsStationOnMonitor = 0 , StationMonitorStoppedOn = GETDATE()
	 where AgentId = @AgentId  and ExtensionNo = @ExtensionNo and LoginStatus In ('C') and MonitorCrossRefInvokeId = @MonitorCrossRefId

end







GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateAgentStateForCallAllocation]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_UpdateAgentStateForCallAllocation] 
(
	@AgentId int,
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_AutoDial_Login Set LoginStatus='D' Where AgentId=@AgentId and ExtensionNo=@ExtensionNo and LoginStatus='A'

	return 0;
END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateAgentUnprocessedCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_AutoDial_UpdateAgentUnprocessedCalls] 
(
	@AgentId int,
	@ExtensionNo varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_AutoDial_Call_Diversion set CallStatus = 'S' where AgentId = @AgentId and ExtensionNo=@ExtensionNo and CallStatus  != 'S'

end






GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateCallToCleared]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_AutoDial_UpdateCallToCleared] 
(
	@CallerId bigint,
	@ExtensionNo nvarchar(10),
	@IsFailed bit,
	@FailureCause nvarchar(200) =null,
	@HostIpAddress varchar(20)
)
as
BEGIN 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if(@IsFailed=1)
		begin
			update tbl_AutoDial_Call_Diversion with(updlock, rowlock, holdlock) set 
			CallEndDateTime=GETDATE(),CallStatus = 'C' , IsFailed =@IsFailed ,FailedCause =  @FailureCause,CallFailedDateTime=GETDATE()
			where CallerId = @CallerId and HostIpAddress = @HostIpAddress  and CallStatus != 'C'

			update tbl_AutoDial_Call_Diversion with(updlock, rowlock, holdlock) set 
			 IsFailed =@IsFailed ,FailedCause =  @FailureCause,CallFailedDateTime=GETDATE()
			where CallerId = @CallerId and HostIpAddress = @HostIpAddress and FailedCause IS NULL  and CallStatus != 'C'

		end
	else
		begin
			update tbl_AutoDial_Call_Diversion with(updlock, rowlock, holdlock) set 
			CallEndDateTime=GETDATE(),CallStatus = 'C' 
			where CallerId = @CallerId  and HostIpAddress = @HostIpAddress and CallStatus != 'C'
			--and CallerMobile = (Select top 1 CallerMobile from tbl_AutoDial_Call_Diversion with (nolock) where Convert(Date,CallOutgoingDateTime)  = Convert(Date,GETDATE())  and  CallerId=@CallerId order by CallOutgoingDateTime desc )
			-- and ExtensionNo= @ExtensionNo
			--and CallerMobile = @CallerMobile
			--and CallerMobile=@CallerMobile
		end

	Select a.Id as Id,CallerId,CallerName,CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	where a.CallerId=@CallerId  and a.HostIpAddress = @HostIpAddress and  a.CallStatus='C' and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) 
	and b.LoginStatus='D'

END








GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateCallToDelivered]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_UpdateCallToDelivered] 
(
	@UCID varchar(20),
	@CallerId int,
	@ExtensionNo varchar(20),
	@CallerMobile varchar(20),
	@HostIpAddress varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update tbl_AutoDial_Call_Diversion set CallStatus = 'D',CallDeliveredDateTime=GETDATE() 
	where UCID=@UCID and HostIpAddress = @HostIpAddress
	--update tbl_AutoDial_Call_Diversion set CallStatus = 'D',CallDeliveredDateTime=GETDATE() 
	--where CallerId=@CallerId and ExtensionNo=@ExtensionNo and HostIpAddress = @HostIpAddress

	Select a.Id as Id,a.CallerId as CallerId,a.CallerName as CallerName, c.CallerMobile as CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	inner join tbl_AutoDial_DropOut_Call c on a.DropOutId = c.Id
	where UCID=@UCID and a.HostIpAddress = @HostIpAddress  and  a.CallStatus='D' and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) 
	and b.LoginStatus='D'

end









GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateCallToEstablished]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AutoDial_UpdateCallToEstablished] 
(
	@UCID varchar(20),
	@CallerId bigint,
	@ExtensionNo nvarchar(10),
	@HostIpAddress varchar(20)
)
as
BEGIN TRAN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--update tbl_AutoDial_Call_Diversion with(updlock, rowlock, holdlock) set CallEstablishedDateTime=GETDATE(),CallStatus = 'E' where CallerId = @CallerId 
	--and ExtensionNo = @ExtensionNo and HostIpAddress = @HostIpAddress
	update tbl_AutoDial_Call_Diversion with(updlock, rowlock, holdlock) set CallEstablishedDateTime=GETDATE(),CallStatus = 'E' where UCID=@UCID and HostIpAddress = @HostIpAddress

	Select a.Id as Id,a.CallerId as CallerId,a.CallerName as CallerName,c.CallerMobile as CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	inner join tbl_AutoDial_DropOut_Call c on a.DropOutId = c.Id
	where UCID=@UCID  and a.HostIpAddress = @HostIpAddress and  a.CallStatus='E' and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) 
	and b.LoginStatus='D'
COMMIT









GO
/****** Object:  StoredProcedure [dbo].[sp_AutoDial_UpdateCallToFailed]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AutoDial_UpdateCallToFailed] 
(
	@CallerId int,
	@ExtensionNo nvarchar(10),
	@CallerNumber nvarchar(20),
	@Cause nvarchar(200),
	@HostIpAddress varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @DropOutId int
	Select @DropOutId = DropOutId from tbl_AutoDial_Call_Diversion where CallerId = @CallerId  and HostIpAddress = @HostIpAddress --and CallerMobile = @CallerNumber

	update tbl_AutoDial_DropOut_Call set ProcessCount = ISNULL(ProcessCount,0) + 1 where Id=@DropOutId

	update tbl_AutoDial_Call_Diversion set IsFailed = 1,FailedCause = @Cause, CallStatus = 'F',
	CallFailedDateTime=GETDATE() where CallerId = @CallerId and HostIpAddress = @HostIpAddress and CallerMobile = (Select top 1 CallerMobile from tbl_AutoDial_Call_Diversion with (nolock) where Convert(Date,CallOutgoingDateTime)  = Convert(Date,GETDATE())  and  CallerId=@CallerId order by CallOutgoingDateTime desc ) --and CallerMobile = @CallerNumber

	Select a.Id as Id,a.CallerId as CallerId,a.CallerName as CallerName,c.CallerMobile as CallerMobile,a.ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,a.AgentId
	from tbl_AutoDial_Call_Diversion As a with(nolock) inner join tbl_AutoDial_Login b
	on a.ExtensionNo=b.ExtensionNo and a.AgentId=b.AgentId
	inner join tbl_AutoDial_DropOut_Call c on a.DropOutId = c.Id
	where a.CallerId=@CallerId  and a.HostIpAddress = @HostIpAddress and  a.CallStatus='F' and Convert(Date,b.LoginDateTime)  = Convert(Date,GETDATE()) 
	and b.LoginStatus='D'
END






GO
/****** Object:  StoredProcedure [dbo].[sp_CreateAgent]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_CreateAgent] 
(
	@AgentId int,
	@AgentPassword varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Insert into tbl_ScreenPopup_Agent (AgentId,AgentPassword,AgentName)Values(@AgentId,@AgentPassword,@AgentId)
	return 0;
END






GO
/****** Object:  StoredProcedure [dbo].[sp_CreateExtension]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_CreateExtension] 
(
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Insert into tbl_ScreenPopup_Extension(ExtensionNo,Status)Values(@ExtensionNo,'A')
	return 0;
END






GO
/****** Object:  StoredProcedure [dbo].[sp_CreateToken]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_CreateToken] 
(
	@UserId int,
	@AuthToken varchar(100),
	@IssuedOn datetime,
	@ExpiredOn datetime
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Insert into tbl_WebApiToken(UserId,AuthToken,IssuedOn,ExpiredOn)Values
	(@UserId,@AuthToken,@IssuedOn,@ExpiredOn)
	return 1;
END







GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUserAllToken]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_DeleteUserAllToken] 
(
	@UserId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExpiredOn datetime
	Delete from tbl_WebApiToken where  UserId = @UserId
	if Exists(select UserId from tbl_WebApiToken where  UserId = @UserId)
		BEGIN
			return 0;
		END 
	return 1;

END







GO
/****** Object:  StoredProcedure [dbo].[sp_GetAgentInfo]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_GetAgentInfo] 
(
	@AgentId int,
	@AgentPassword varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT AgentId,AgentPassword,AgentName,SkillSet From tbl_ScreenPopup_Agent where AgentId=@AgentId
	and AgentPassword=@AgentPassword
END






GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllActiveCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllActiveCalls] 
	@IpAddress varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @temp table(Id int,CallerId int ,CallerMobile varchar(20),ExtensionNo varchar(5),AgentId int,TodayCallCount int,IsTravelAgentCall bit)
	
	insert into @temp(Id,CallerId,CallerMobile,ExtensionNo,AgentId,IsTravelAgentCall,TodayCallCount) 
	Select a.Id,a.CallerId,a.CallerMobile,a.ExtensionNo,c.AgentId,ISNULL(b.IsActive,0) as IsTravelAgentCall,
	(Select Count(CallerId) from tbl_Call_Diversion where CallStatus='C' and CallerMobile=a.CallerMobile And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())) As NoOfCall 
	from tbl_Call_Diversion As a with (nolock)
	left outer join tbl_ScreenPopup_TravelAgent As b
	on a.CallerMobile = b.ContactNo 
	inner join  tbl_ScreenPopup_Login  as c on a.ExtensionNo = c.ExtensionNo  
	Where a.CallStatus='A' 
	and DatePart(HH,a.CallIncomingDateTime) = DAtePArt(HH,GETDATE())
	and DatePart(MI,a.CallIncomingDateTime) = DAtePArt(MI,GETDATE())
	and Convert(Date,c.LoginDateTime)  = Convert(Date,GETDATE())
	and c.HostIpAddress=@IpAddress

	update A set CallStatus='D',QuickPopAgentId=B.AgentId from tbl_Call_Diversion A with(nolock) Join @temp B on A.ID = B.Id 

	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllActiveCallsTest]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAllActiveCallsTest] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @temp table(Id int,CallerId int ,CallerMobile varchar(20),ExtensionNo varchar(5),AgentId int,TodayCallCount int,IsTravelAgentCall bit)
	
	insert into @temp(Id,CallerId,CallerMobile,ExtensionNo,AgentId,IsTravelAgentCall,TodayCallCount) 
	Select CallDiversion.Id as Id,CallerId,CallerMobile,CallDiversion.ExtensionNo as ExtensionNo,loggedAgent.AgentId as AgentId,ISNULL(travelAgent.IsActive,0) as IsTravelAgentCall,
	(Select Count(CallerId) from tbl_Call_Diversion_Test where CallStatus='C' and CallerMobile=CallDiversion.CallerMobile And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())) As NoOfCall
	from tbl_Call_Diversion_Test As CallDiversion with(nolock) 
	left outer join  tbl_ScreenPopup_TravelAgent  as travelAgent
	on CallDiversion.CallerMobile = travelAgent.ContactNo 
	left outer join  tbl_ScreenPopup_Login  as loggedAgent 
	on CallDiversion.ExtensionNo = loggedAgent.ExtensionNo and loggedAgent.LoginStatus = 'A' 
	WHERE CallDiversion.CallStatus = 'A'
    
	update A set CallStatus='D',AgentId=B.AgentId from tbl_Call_Diversion_Test A with(nolock) Join @temp B on A.ID = B.Id 

	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp

END




GO
/****** Object:  StoredProcedure [dbo].[sp_GetCustomerVoiceSurvey]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCustomerVoiceSurvey] 
  @TokenNo bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @CallerId int 
	Declare @AgentId int
	Declare @IsMessageSent varchar(1)
	Declare @AgentName varchar(200)
	If (Exists(Select Id from tbl_SMS_Survey_Customer_Response where TokenNo = @TokenNo ))
		return

	Select @AgentId= AgentId, @CallerId = CallerId,@IsMessageSent= IsMessageSent from tbl_SMS_Survey_Campaign Where CampaignId = @TokenNo
	
	If (@CallerId is not null)
	BEGIN
		Select @AgentName = AgentName from tbl_ScreenPopup_Agent where AgentId=@AgentId
		If @AgentName Is null
		BEGIN
			Set @AgentName = 'us'
		END

		Select  LogoURL,BackgroundURL,BrandName,BrandCountry,ColorCode1,ColorCode2,ColorCode3,REPLACE(WelcomeText, '<AGENT_NAME>', @AgentName) As WelcomeText,WelcomeImage,
		ThankyouText,ThankyouImage,PartialResponseId,SurveyMessage,SkipWelcome 
		from tbl_SMS_Survey_Template where ApplicationCode='IGT_CUST_VOICE'
	
		Select B.Id as QuestionId, B.TemplateId As TemplateId,B.[User] As [User],B.Text As Text,B.DisplayType As DisplayType,B.MultiSelect As MultiSelect,
		B.Sequence As Sequence, B.EndOfSurvey As EndOfSurvey,
		B.EndOfSurveyMessage As EndOfSurveyMessage,B.PresentationMode As PresentationMode
		,B.IsRequired As IsRequired,B.QuestionTags As QuestionTags
		from tbl_SMS_Survey_Template A INNER JOIN tbl_SMS_Survey_Questionaire B On A.Id=B.TemplateId
		where A.ApplicationCode='IGT_CUST_VOICE' AND A.Status='A' and B.Status='A'
		order by B.Sequence

		Select C.QuestionId, C.FilterQuestionId,C.Answer
		from tbl_SMS_Survey_Template A INNER JOIN tbl_SMS_Survey_Questionaire B On A.Id=B.TemplateId
		INNER JOIN tbl_SMS_Survey_Questionaire_Filter C On B.Id=C.QuestionId
		where A.ApplicationCode='IGT_CUST_VOICE' AND A.Status='A' and B.Status='A'
		order by B.Sequence
	END
END



GO
/****** Object:  StoredProcedure [dbo].[sp_GetDeviceOutgoingCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDeviceOutgoingCalls] 
	@Extension varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @AgentId int 

	Select @AgentId = AgentId  from tbl_AutoDial_Login where LoginStatus = 'A' and ExtensionNo=@Extension
	DECLARE @temp table(Id int,CallerId int ,CallerMobile varchar(20),ExtensionNo varchar(5),TodayCallCount int,IsTravelAgentCall bit)
	
	insert into @temp(Id,CallerId,CallerMobile,ExtensionNo,IsTravelAgentCall,TodayCallCount) 
	Select CallDiversion.Id as Id,CallerId,CallerMobile,ExtensionNo,ISNULL(travelAgent.IsActive,0) as IsTravelAgentCall,
	(Select Count(CallerId) from tbl_AutoDial_Call_Diversion where CallStatus='C' and CallerMobile=CallDiversion.CallerMobile And CONVERT(date,CallOutgoingDateTime) = CONVERT(date,GETDATE())) As NoOfCall
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	left outer join  tbl_ScreenPopup_TravelAgent  as travelAgent
	on CallDiversion.CallerMobile = travelAgent.ContactNo 
	where ExtensionNo= @Extension and  CallDiversion.CallStatus='A'
    
	update A set CallStatus='D',AgentId=@AgentId from tbl_AutoDial_Call_Diversion A with(nolock) Join @temp B on A.ID = B.Id 

	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp

END





GO
/****** Object:  StoredProcedure [dbo].[sp_GetExtensionInfo]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_GetExtensionInfo] 
(
	@ExtensionNo int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT ExtensionNo,Status From tbl_ScreenPopup_Extension where ExtensionNo=@ExtensionNo
END






GO
/****** Object:  StoredProcedure [dbo].[sp_GetQuickpopActiveCallCount]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetQuickpopActiveCallCount] 
	@HostIpAddress varchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select count(*) from tbl_Call_Diversion a inner join tbl_ScreenPopup_Login b 
	on a.ExtensionNo=b.ExtensionNo 
	where CallStatus='A' and DATEDIFF(MI,CallIncomingDateTime,GETDATE()) < 10 
	and Convert(Date,GETDATE())=Convert(DAte,LoginDateTime)
	and HostIpAddress = @HostIpAddress 


END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetScreenPopDispositions]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetScreenPopDispositions] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select A.Id as GroupId,A.Description As GroupDescription,B.Id as SubGroupId,B.Description as SubGroupDescription ,C.Id as DispositionId,C.Description as DispositionDescription from tbl_Mst_Disposition_Group A Join tbl_Mst_Disposition_SubGroup B 
	On A.Id = B.GroupId
	Join tbl_Mst_Disposition_QueryTypes C on B.GroupId=C.GroupId and B.Id = C.SubGroupId
	Where 
	 A.Delflag = 'N' and B.Delflag='N' and A.Status='A' and B.Status='A'
	 order by A.OrderBy,B.OrderBy,C.Id

END











GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnAllocatedWebsiteDropoutCalls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnAllocatedWebsiteDropoutCalls] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select Count(CallerId)
	from tbl_AutoDial_DropOut_Call where IsAllocated='N' and IsValidRecord = 1
END







GO
/****** Object:  StoredProcedure [dbo].[sp_GetWebApiUser]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_GetWebApiUser] 
(
	@UserName varchar(100),
	@Password varchar(200)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT UserId,Password,UserName,Name From tbl_WebApiUser where UserName=@UserName
	and Password=@Password
END







GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNewIncomingCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
  
CREATE procedure [dbo].[sp_InsertNewIncomingCall]   
(  
 
 @CallerId int,  
 @CallerName varchar(200), 
 @CallStatus varchar(1),  
 @ExtensionNo varchar(20), 
 @CallerMobile varchar(max),
 @AgentId int
)  
as  
BEGIN TRAN

 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion with (nolock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile)  
 BEGIN 
	IF @ExtensionNo = 51114
		begin 
			Insert into tbl_AutoDial_Premium_Call(CallerId,CallerName,CallerNumber,CreatedOn,IsAllocated) values  
			  (@CallerId,@CallerName,@CallerMobile,GETDATE(),'N')  
		end 
	else
		begin
			Select * from tbl_Mst_VDN where Code = @ExtensionNo
			IF @@ROWCOUNT = 0 
			begin
			  Insert into tbl_Call_Diversion(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile,AgentId) values  
			  (@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile,@AgentId)  
			end
		end
	
  END  
  COMMIT

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertQuickpopLoginLog]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_InsertQuickpopLoginLog] 
(
	@AgentId int,
	@ExtensionNo int,
	@SessionId varchar(100),
	@IpAddress varchar(50),
	@HostIpAddress varchar(50)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Insert into tbl_ScreenPopup_Login_Archive (AgentId,ExtensionNo,LoginStatus,SessionId,LoginDateTime,IpAddress,HostIpAddress,LogoutDateTime)
	Select AgentId,ExtensionNo,LoginStatus,SessionId,LoginDateTime,IpAddress,HostIpAddress,LogoutDateTime from tbl_ScreenPopup_Login
	Where ExtensionNo = @ExtensionNo

	Delete from tbl_ScreenPopup_Login Where ExtensionNo = @ExtensionNo

	Insert into tbl_ScreenPopup_Login (AgentId,ExtensionNo,LoginStatus,SessionId,LoginDateTime,IpAddress,HostIpAddress)Values
	(@AgentId,@ExtensionNo,'A',@SessionId,GETDATE(),@IpAddress,@HostIpAddress)

	return 0;
END


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTransferCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


  
  
CREATE procedure [dbo].[sp_InsertTransferCall]   
(  
--@Ucid nvarchar(20),
 @CallerId int,  
 @CallerName varchar(200), 
 @CallStatus varchar(1),  
 @ExtensionNo varchar(20), 
 @CallerMobile varchar(max),
 @AgentId int
-- @UserEnteredCode nvarchar(200)
)  
as  
BEGIN TRAN
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion with (updlock, rowlock, holdlock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile)  
 BEGIN 	
	Select * from tbl_Mst_VDN where Code = @ExtensionNo
		IF @@ROWCOUNT = 0 
		begin
			Insert into tbl_Call_Diversion(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile,AgentId,IsTransfered) values  
			(@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile,@AgentId,1)  
		end
  END  
COMMIT TRAN

GO
/****** Object:  StoredProcedure [dbo].[sp_KillToken]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_KillToken] 
(
	@AuthToken varchar(200)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExpiredOn datetime
	Delete from tbl_WebApiToken where  AuthToken = @AuthToken
	if Exists(select * from tbl_WebApiToken where  AuthToken = @AuthToken)
		BEGIN
			return 0;
		END 
	return 1;

END







GO
/****** Object:  StoredProcedure [dbo].[sp_LogoutQuickpopAgent]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_LogoutQuickpopAgent] 
(
	@AgentId int,
	@ExtensionNo int,
	@SessionId varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_ScreenPopup_Login Set LoginStatus='C' ,LogoutDateTime=GETDATE() where AgentId = @AgentId 
	and ExtensionNo =  @ExtensionNo and SessionId=@SessionId

	return 0;
END




GO
/****** Object:  StoredProcedure [dbo].[sp_Quickpop_AgentWiseDispositionReport]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Quickpop_AgentWiseDispositionReport] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Select UCID,AgentId,AgentName,AgentLocation,ExtensionNo,CallerNumber,CallIncomingDateTime,CaseType,SubDivision,QueryType,Remarks from 
	(
		Select distinct UCID, Case When a.QuickPopAgentId IS NULL THEN a.AgentId else a.QuickPopAgentId end As AgentId,
		Case When a.QuickPopAgentId IS NULL THEN (Select AgentName from tbl_ScreenPopup_Agent where AgentId=a.AgentId) else (Select AgentName from tbl_ScreenPopup_Agent where AgentId=a.QuickPopAgentId) end As AgentName,
		Case When a.QuickPopAgentId IS NULL THEN (Select Location from tbl_ScreenPopup_Agent where AgentId=a.AgentId) else (Select Location from tbl_ScreenPopup_Agent where AgentId=a.QuickPopAgentId) end As AgentLocation,
		a.ExtensionNo as ExtensionNo,
		a.CallerMobile As CallerNumber,
		a.CallIncomingDateTime as CallIncomingDateTime, 
		REPLACE(REPLACE(d.Description, CHAR(13), ''), CHAR(10), '') as CaseType,REPLACE(REPLACE(c.Description, CHAR(13), ''), CHAR(10), '') as SubDivision,
		REPLACE(REPLACE(b.Description, CHAR(13), ''), CHAR(10), '') as QueryType,REPLACE(REPLACE(a.Remarks, CHAR(13), ''), CHAR(10), '') as Remarks,
		d.Id As QueryTypeId,c.Id As SubDivisionId,b.Id As CaseTypeId  from tbl_call_Diversion_01Aug17 a inner join tbl_Mst_Disposition_QueryTypes b on a.DispositionId=b.Id 
		inner Join tbl_Mst_Disposition_SubGroup c on c.Id=b.SubGroupId
		inner Join tbl_Mst_Disposition_Group d on d.Id=c.GroupId
		left outer join tbl_ScreenPopup_Agent e on a.QuickPopAgentId=e.AgentId
		Where Convert(Date,CallIncomingDateTime)=Convert(Date,DATEADD(DD,-1,GETDATE())) and DispositionId is not null 
	) as SubQuery
	order by QueryTypeId,SubDivisionId,CaseTypeId,CallIncomingDateTime desc
END




GO
/****** Object:  StoredProcedure [dbo].[sp_Quickpop_DataMigration]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Quickpop_DataMigration] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
	Insert into tbl_call_Diversion_01Aug17
	(CallerId,CallerName,CallerMobile,CallerEmail,CallStatus,
	CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime,AgentId,ExtensionNo, LastEnter,QuickPopAgentId,DispositionId,Remarks,UCID,UserEnteredCode)
	Select CallerId,CallerName,CallerMobile,CallerEmail,CallStatus,
	CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime,AgentId,ExtensionNo, LastEnter,QuickPopAgentId,DispositionId,Remarks,UCID,UserEnteredCode
	from tbl_Call_Diversion with (nolock) where Convert(Date,CallIncomingDateTime) < Convert(Date,GetDate()) 

	Delete A from tbl_Call_Diversion A Inner Join tbl_call_Diversion_01Aug17 B 
	on A.CallerId=b.CallerId and A.ExtensionNo = B.ExtensionNo and A.CallerMobile=B.CallerMobile
	where Convert(Date,A.CallIncomingDateTime) < Convert(Date,GetDate()) 

	return 1;
END


 
GO
/****** Object:  StoredProcedure [dbo].[sp_Quickpop_GetCallerData]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Quickpop_GetCallerData] 
	@CallerMobile varchar(20) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @temp table(AgentId varchar(20),AgentName varchar(200) ,CallIncomingDateTime datetime,CallStatus varchar(1),ExtensionNo varchar(10),CallEstablishedDateTime datetime2,CallEndDateTime datetime2,Disposition varchar(200) NUll)

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime,Disposition)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime,e.Description + ' -> ' + d.Description + ' -> ' + c.Description as Disposition  from tbl_Call_Diversion as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	left outer Join tbl_Mst_Disposition_QueryTypes c on a.DispositionId=C.Id 
	left outer Join tbl_Mst_Disposition_SubGroup d on d.Id=c.SubGroupId 
	left outer Join tbl_Mst_Disposition_Group e on e.Id=d.GroupId
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile like '%' + right(@CallerMobile,10) + '%' and a.CallStatus='C'
	order by a.CallIncomingDateTime desc

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime,Disposition)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime,e.Description + ' -> ' + d.Description + ' -> ' + c.Description as Disposition from tbl_call_Diversion_01Aug17 as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	left outer Join tbl_Mst_Disposition_QueryTypes c on a.DispositionId=C.Id 
	left outer Join tbl_Mst_Disposition_SubGroup d on d.Id=c.SubGroupId 
	left outer Join tbl_Mst_Disposition_Group e on e.Id=d.GroupId
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile like '%' + right(@CallerMobile,10) + '%' and a.CallStatus='C'
	order by a.CallIncomingDateTime desc

	select AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime,ISNULL(Disposition,'NA') As Disposition from @temp
	order by CallIncomingDateTime desc

	Select CustomerType,Title + ' ' + FirstName + ' ' + MiddleName + ' ' + LastName    from tbl_Mst_Customer_Spcl where PhoneNumber1 like '%' + right(@CallerMobile,10) + '%' or PhoneNumber2 like '%' + right(@CallerMobile,10) + '%' 
	or PhoneNumber3 like '%' + right(@CallerMobile,10) + '%' and Delflag = 'N'

	Select Count(CallerId) As CallCount from tbl_Call_Diversion with (nolock) where CallStatus='C' and CallerMobile like '%' + right(@CallerMobile,10) + '%' And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())
	
	Select  CAse When Count(Id) > 0 then 1 else 0 end As IsTravelAgentCall from tbl_ScreenPopup_TravelAgent Where ContactNo like '%' + right(@CallerMobile,10) + '%' 

END







GO
/****** Object:  StoredProcedure [dbo].[sp_Quickpop_InsertNewIncomingCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



  
  
CREATE procedure [dbo].[sp_Quickpop_InsertNewIncomingCall]   
(  
 @Ucid nvarchar(20),
 @CallerId int,  
 @CallerName varchar(200), 
 @CallStatus varchar(1),  
 @ExtensionNo varchar(20), 
 @CallerMobile varchar(max),
 @AgentId int,
 @UserEnteredCode nvarchar(200)
)  
as  
BEGIN TRAN

 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion with (nolock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile)  
 BEGIN 
	IF @ExtensionNo = 51114
		begin 
			Insert into tbl_AutoDial_Premium_Call(CallerId,CallerName,CallerNumber,CreatedOn,IsAllocated) values  
			  (@CallerId,@CallerName,@CallerMobile,GETDATE(),'N')  
		end 
	else
		begin
			Select * from tbl_Mst_VDN where Code = @ExtensionNo
			IF @@ROWCOUNT = 0 
			begin
			  Insert into tbl_Call_Diversion(UCID,CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile,AgentId,UserEnteredCode) values  
			  (@Ucid, @CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile,@AgentId,@UserEnteredCode)  
			end
		end
	
  END  
  COMMIT



GO
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_AgentWise_Call_Summary]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Report_ScreenPop_AgentWise_Call_Summary] 
@CalledDate DateTime 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	---Day wise call count------------
	select  count(*) as CallCount,QuickPopAgentId As AgentId,Convert(Date, CallIncomingDateTime) as CallIncomingDate  from tbl_call_Diversion 
	Where Convert(Date, CallIncomingDateTime) = Convert(Date,@CalledDate)
	Group by Convert(Date, CallIncomingDateTime),QuickPopAgentId
	union 
	select  count(*) as CallCount,QuickPopAgentId As AgentId,Convert(Date, CallIncomingDateTime) as CallIncomingDate from tbl_call_Diversion_01Aug17 
	Where Convert(Date, CallIncomingDateTime) = Convert(Date,@CalledDate)
	Group by Convert(Date, CallIncomingDateTime),QuickPopAgentId
	order by Convert(Date, CallIncomingDateTime) desc,QuickPopAgentId

END





GO
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_Cummulative_Count]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Report_ScreenPop_Cummulative_Count] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	---Day wise call count------------
	Select A.CallIncomingDate As CallIncomingDate,A.TotalCallCount as TotalCalls,B.AgentCount as TotalLoggedInAgents,C.CallCount as TotalAgentAttendedCalls from 
	(select count(*) As TotalCallCount,Convert(Date,CallIncomingDateTime) As CallIncomingDate from tbl_call_Diversion_01Aug17
	group by Convert(Date,CallIncomingDateTime) 
	having Convert(Date,CallIncomingDateTime) >= DATEADD(D,-6,Convert(Date,GETDATE())) 
	union 
	select count(*) As CallCount,Convert(Date,CallIncomingDateTime) As CallIncomingDate from   tbl_Call_Diversion 
	group by Convert(Date,CallIncomingDateTime)
	--order by Convert(Date,CallIncomingDateTime) desc
	) as A

	Inner Join
	----No of Agent Login..............
	(select count(distinct(AgentId))  As AgentCount,Convert(Date,LoginDateTime)  As LoginDate from tbl_ScreenPopup_Login
	group by Convert(Date,LoginDateTime)
	having Convert(Date,LoginDateTime) >= DATEADD(D,-6,Convert(Date,GETDATE())) 
	--order by Convert(Date,LoginDateTime) desc
	) as B 
	
	On A.CallIncomingDate = B.LoginDate

	-----Call Attend By Agent(s).........
	inner join
	(
	select count(Distinct(ExtensionNo)) As CallCount,Convert(Date,CallIncomingDateTime) As CallIncomingDate  from tbl_call_Diversion_01Aug17
	--Where AgentId is not null
	group by Convert(Date,CallIncomingDateTime)
	having Convert(Date,CallIncomingDateTime) >= DATEADD(D,-6,Convert(Date,GETDATE())) 
	union
	select count(Distinct(ExtensionNo)) As CallCount,Convert(Date,CallIncomingDateTime) As CallIncomingDate from tbl_call_Diversion
	--Where AgentId is not null
	group by Convert(Date,CallIncomingDateTime)
	--order by Convert(Date,CallIncomingDateTime) desc
	) as C
	on  A.CallIncomingDate = C.CallIncomingDate
	order by CallIncomingDate desc

END





GO
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_Get_Agent_Calls]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Report_ScreenPop_Get_Agent_Calls] 
@CalledDate DateTime ,
@AgentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@AgentId IS NULL OR @AgentId = 0)
	BEGIN
		if(Convert(Date,GetDate()) = @CalledDate)
		begin
			Select CallerId,AgentId,ExtensionNo,CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime from tbl_call_Diversion
			where  Convert(Date, CallIncomingDateTime) = Convert(Date,@CalledDate)
			and QuickPopAgentId IS NULL
		end
		else
		begin
			Select CallerId,AgentId,ExtensionNo,CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime from tbl_call_Diversion_01Aug17 
			where  Convert(Date, CallIncomingDateTime) = Convert(Date,@CalledDate)
			and QuickPopAgentId IS NULL
		end
	END
	ELSE
	BEGIN
		if(Convert(Date,GetDate()) = @CalledDate)
		begin
			Select CallerId,AgentId,ExtensionNo,CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime from tbl_call_Diversion
			where  Convert(Date, CallIncomingDateTime) = Convert(Date,@CalledDate)
			and QuickPopAgentId=@AgentId
		end
		else
		begin
			Select CallerId,AgentId,ExtensionNo,CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime from tbl_call_Diversion_01Aug17 
			where  Convert(Date, CallIncomingDateTime) = Convert(Date,@CalledDate)
			and QuickPopAgentId=@AgentId
		end
	END
END






GO
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_Get_Agent_LoggedIn_History]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Report_ScreenPop_Get_Agent_LoggedIn_History] 
@LoggedInDate DateTime ,
@AgentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select AgentId,ExtensionNo,LoginDateTime,LoginStatus from tbl_ScreenPopup_Login
	 where AgentId=@AgentId
	and Convert(Date,LoginDateTime) =  Convert(Date,@LoggedInDate)
	order by LoginDateTime desc
END





GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCustomerSurveyResponse]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[sp_SaveCustomerSurveyResponse] 
 @TokenNo bigint,
 @ResponseDateTime datetime,
 @User varchar(20),
 @SurveyClient varchar(50),
 @ResponseDuration int,
 @CreatedIpAddress varchar(50),
 @QuestionResponses [UT_QuestionResponse] ReadOnly
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @ResponseId int
	Select @ResponseId = ISNULL(MAX(ResponseId),0) from tbl_SMS_Survey_Customer_Response 
	SET @ResponseId = @ResponseId + 1

	Insert into tbl_SMS_Survey_Customer_Response(ResponseId,TokenNo,[User],ResponseDateTime,ResponseDuration,SurveyClient,CreatedOn,CreatedIpAddress)
	Values(@ResponseId,@TokenNo,@User,@ResponseDateTime,@ResponseDuration,@SurveyClient,GETDATE(),@CreatedIpAddress)


	Insert into tbl_SMS_Survey_Customer_Response_Question(ResponseId,QuestionId,QuestionText,NumberInput,TextInput,CreatedOn,CreatedIpAddress)
	Select @ResponseId,QuestionId,QuestionText,NumberInput,TextInput,GETDATE(),@CreatedIpAddress from @QuestionResponses


END




GO
/****** Object:  StoredProcedure [dbo].[sp_SaveDispositionForActiveCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_SaveDispositionForActiveCall] 
(
	@DispositionId int,
	@CallerId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_AutoDial_Call_Diversion Set DispositionId=@DispositionId Where CallerId = @CallerId

	return 0;
END





GO
/****** Object:  StoredProcedure [dbo].[sp_SaveQuickPopDisposition]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_SaveQuickPopDisposition] 
(
	@DispositionId int,
	@Remarks varchar(200),
	@CallerId int,
	@CallerMobile varchar(20),
	@ExtensionNo varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Update tbl_Call_Diversion Set DispositionId=@DispositionId,Remarks=@Remarks Where CallerId = @CallerId  and ExtensionNo=@ExtensionNo

	return 1;
END







GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentIdInCall]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_UpdateAgentIdInCall] 
(
	@AgentId int,
	@CallerId int,
	@ExtensionNo varchar(20),
	@CallerNumber varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	update tbl_Call_Diversion set AgentId = @AgentId where CallerId = @CallerId and CallerMobile=@CallerNumber and ExtensionNo = @ExtensionNo

	IF(@CallerNumber  LIKE ('919%') OR @CallerNumber   LIKE  ('918%') OR @CallerNumber   LIKE  ('917%') OR @CallerNumber   LIKE  ('916%') OR @CallerNumber  LIKE ('09%') 
	OR @CallerNumber   LIKE  ('08%') OR @CallerNumber   LIKE  ('07%') OR @CallerNumber   LIKE  ('06%') OR @CallerNumber  LIKE ('9%') 
	OR @CallerNumber   LIKE  ('8%') OR @CallerNumber   LIKE  ('7%') OR @CallerNumber   LIKE  ('6%') )
	BEGIN
		Select  CallerId from tbl_Call_Diversion with(nolock) where  CallerMobile = @CallerNumber and Convert(Date,CallIncomingDateTime) = Convert(Date,GETDATE())
		if(@@ROWCOUNT = 1)
		BEGIN
			Declare @CampaignId numeric
			
			IF(@AgentId IS NULL)
				SET @AgentId = 00000 --Not a Valid Agent Id
			
			Select @CampaignId = ISNULL(MAX(CampaignId),0) from tbl_SMS_Survey_Campaign
	
			SET @CampaignId = @CampaignId + 1

			Insert into tbl_SMS_Survey_Campaign(CampaignId,CallerId,CallerCountryCode,CallerNumber,IsIncomingCall,AgentId,ExtensionNo,CreatedOn,CreatedIpAddress,Status) 
			Values (@CampaignId,@CallerId,'IN',@CallerNumber,'Y',@AgentId, @ExtensionNo,GETDATE(),'121.0.0.1','A')
			
		END
	END
END




GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentMonitorCrossRefId]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_UpdateAgentMonitorCrossRefId] 
(
	@CrossRefId int,
	@InvokeId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	insert into x (value) Values (@CrossRefId)
	insert into x (value) Values (@InvokeId)
	
	Declare @EndDate DateTime 
	Set @EndDate = DATEADD(SECOND, 10, GETDATE())
	WHILE (GETDATE() < @EndDate)
	BEGIN
		-- Logic goes here: The loop can be broken with the BREAK command.
		if(Exists(Select Id from tbl_AutoDial_Login where MonitorStartInvokeId = @InvokeId and LoginStatus='A'))
		BEGIN
			update tbl_AutoDial_Login set MonitorCrossRefInvokeId=@CrossRefId where MonitorStartInvokeId = @InvokeId 
			and LoginStatus='A' 
			BREAK;
		END
END
	
end





GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentMonitorInvokeId]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_UpdateAgentMonitorInvokeId] 
(
	@InvokeId int,
	@AgentId varchar(20),
	@ExtensionNo varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_AutoDial_Login set MonitorStartInvokeId=@InvokeId where AgentId = Cast( @AgentId as int)  
	and ExtensionNo = Cast( @ExtensionNo as int) and LoginStatus='A'

end







GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallStatus]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_UpdateCallStatus] 
(
	@CallerId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_ScreenPopup_CallDiversion set CallStatus = 'C',CallEndDateTime=GETDATE() where CallerId = @CallerId

end




GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToCleared]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_UpdateCallToCleared] 
(
	@CallerId int,
	@CallerNumber varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	update tbl_Call_Diversion with(updlock, rowlock, holdlock) set CallStatus = 'C',CallEndDateTime=GETDATE() where CallerId = @CallerId and CallerMobile=@CallerNumber

	--IF(@CallerNumber  LIKE ('919%') OR @CallerNumber   LIKE  ('918%') OR @CallerNumber   LIKE  ('917%') OR @CallerNumber   LIKE  ('916%') OR @CallerNumber  LIKE ('09%') 
	--OR @CallerNumber   LIKE  ('08%') OR @CallerNumber   LIKE  ('07%') OR @CallerNumber   LIKE  ('06%') OR @CallerNumber  LIKE ('9%') 
	--OR @CallerNumber   LIKE  ('8%') OR @CallerNumber   LIKE  ('7%') OR @CallerNumber   LIKE  ('6%') )
	--BEGIN
	--	Select  CallerId from tbl_Call_Diversion with(nolock) where  CallerMobile = @CallerNumber and Convert(Date,CallIncomingDateTime) = Convert(Date,GETDATE())
	--	if(@@ROWCOUNT = 1)
	--	BEGIN
	--		Declare @CampaignId numeric
	--		Declare @AgentId int
	--		Declare @ExtensionNo int
	--		Select  @AgentId = AgentId,@ExtensionNo = ExtensionNo 
	--		from tbl_Call_Diversion with(nolock) where CallerId = @CallerId and CallerMobile = @CallerNumber
	--		IF(@AgentId IS NULL)
	--			SET @AgentId = 00000 --Not a Valid Agent Id
			
	--		if(@ExtensionNo is not null)
	--		begin
	--			Select @CampaignId = ISNULL(MAX(CampaignId),0) from tbl_SMS_Survey_Campaign
	
	--			SET @CampaignId = @CampaignId + 1

	--			Insert into tbl_SMS_Survey_Campaign(CampaignId,CallerId,CallerCountryCode,CallerNumber,IsIncomingCall,AgentId,ExtensionNo,CreatedOn,CreatedIpAddress,Status) 
	--			Values (@CampaignId,@CallerId,'IN',@CallerNumber,'Y',@AgentId, @ExtensionNo,GETDATE(),'121.0.0.1','A')
	--		end
	--	END
	--END
END



GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToDelivered]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_UpdateCallToDelivered] 
(
	@CallerId int,
	@ExtensionNo varchar(20),
	@CallerMobile varchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_AutoDial_Call_Diversion set CallerId=@CallerId,CallStatus = 'D',CallOutgoingDateTime=GETDATE() where CallStatus = 'I' and ExtensionNo=@ExtensionNo 
	--and CallerMobile=@CallerMobile

end




GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToEstablished]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_UpdateCallToEstablished] 
(
	@CallerId bigint,
	@ExtensionNo nvarchar(20)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_Call_Diversion set CallEstablishedDateTime=GETDATE() where CallerId = @CallerId 
	and CallerMobile = @ExtensionNo
	--and CallerMobile=@CallerMobile

end





GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToFailed]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_UpdateCallToFailed] 
(
	@CallerId int
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @DropOutId int
	Select @DropOutId = DropOutId from tbl_AutoDial_Call_Diversion where CallerId = @CallerId

	update tbl_AutoDial_DropOut_Call set ProcessCount = ISNULL(ProcessCount,0) + 1 where Id=@DropOutId

	update tbl_AutoDial_Call_Diversion set IsFailed = 1, CallStatus = 'F',CallEndDateTime=GETDATE() where CallerId = @CallerId
END




GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateToken]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_ValidateToken] 
(
	@AuthToken varchar(200),
	@AuthTokenExpiry numeric
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExpiredOn datetime
	SELECT @ExpiredOn = ExpiredOn FROM tbl_WebApiToken where AuthToken = @AuthToken and ExpiredOn > GETDATE()

	if @ExpiredOn IS NOT NULL and NOT(GETDATE() > @ExpiredOn)
	BEGIN
		SET @ExpiredOn = DATEADD(SECOND,@AuthTokenExpiry, @ExpiredOn)

		Update tbl_WebApiToken set ExpiredOn = @ExpiredOn where  AuthToken = @AuthToken and ExpiredOn > GETDATE()
		return 1
	END
	return 0

END







GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-28366bba-bdd6-4908-bf21-b4276470116e]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-28366bba-bdd6-4908-bf21-b4276470116e] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-28366bba-bdd6-4908-bf21-b4276470116e]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-28366bba-bdd6-4908-bf21-b4276470116e] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-28366bba-bdd6-4908-bf21-b4276470116e') > 0)   DROP SERVICE [SqlQueryNotificationService-28366bba-bdd6-4908-bf21-b4276470116e]; if (OBJECT_ID('SqlQueryNotificationService-28366bba-bdd6-4908-bf21-b4276470116e', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-28366bba-bdd6-4908-bf21-b4276470116e]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-28366bba-bdd6-4908-bf21-b4276470116e]; END COMMIT TRANSACTION; END


GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-cb8bd702-62c7-4e4f-ac5d-15a1573f4035]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-cb8bd702-62c7-4e4f-ac5d-15a1573f4035] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-cb8bd702-62c7-4e4f-ac5d-15a1573f4035]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-cb8bd702-62c7-4e4f-ac5d-15a1573f4035] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-cb8bd702-62c7-4e4f-ac5d-15a1573f4035') > 0)   DROP SERVICE [SqlQueryNotificationService-cb8bd702-62c7-4e4f-ac5d-15a1573f4035]; if (OBJECT_ID('SqlQueryNotificationService-cb8bd702-62c7-4e4f-ac5d-15a1573f4035', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-cb8bd702-62c7-4e4f-ac5d-15a1573f4035]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-cb8bd702-62c7-4e4f-ac5d-15a1573f4035]; END COMMIT TRANSACTION; END


GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-d8ad7377-9367-4e9b-86b3-66a7a3e0884d]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-d8ad7377-9367-4e9b-86b3-66a7a3e0884d] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-d8ad7377-9367-4e9b-86b3-66a7a3e0884d]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-d8ad7377-9367-4e9b-86b3-66a7a3e0884d] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-d8ad7377-9367-4e9b-86b3-66a7a3e0884d') > 0)   DROP SERVICE [SqlQueryNotificationService-d8ad7377-9367-4e9b-86b3-66a7a3e0884d]; if (OBJECT_ID('SqlQueryNotificationService-d8ad7377-9367-4e9b-86b3-66a7a3e0884d', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-d8ad7377-9367-4e9b-86b3-66a7a3e0884d]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-d8ad7377-9367-4e9b-86b3-66a7a3e0884d]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCallStatus]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCallStatus]
(
	@CallerId int,
	@ExtensionNo nvarchar(20),
	@CallStatus nvarchar(1)
)
AS
BEGIN
	

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_Call_Diversion with(rowlock) set CallStatus = @CallStatus where CallerId=@CallerId
	and ExtensionNo = @ExtensionNo AND CallStatus = 'A'
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateCallStatusTest]    Script Date: 08-05-2018 21:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCallStatusTest]
(
	@CallerId int,
	@ExtensionNo nvarchar(20),
	@CallStatus nvarchar(1)
)
AS
BEGIN
	

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	update tbl_Call_Diversion_Test with(rowlock) set CallStatus = @CallStatus where CallerId=@CallerId
	and ExtensionNo = @ExtensionNo AND CallStatus = 'A'
END



GO
USE [master]
GO
ALTER DATABASE [IndigoDB] SET  READ_WRITE 
GO
