USE [master]
GO
/****** Object:  Database [IndigoDB]    Script Date: 10-01-2018 10:35:48 ******/
CREATE DATABASE [IndigoDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IndigoDB', FILENAME = N'F:\MSSQL12.MSSQLSERVER\MSSQL\Data\IndigoDB.mdf' , SIZE = 765952KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
ALTER DATABASE [IndigoDB] SET AUTO_CREATE_STATISTICS ON 
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
USE [IndigoDB]
GO
/****** Object:  User [NagiosUser]    Script Date: 10-01-2018 10:35:48 ******/
CREATE USER [NagiosUser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [indigo_user]    Script Date: 10-01-2018 10:35:48 ******/
CREATE USER [indigo_user] FOR LOGIN [indigo_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [indigo]    Script Date: 10-01-2018 10:35:48 ******/
CREATE USER [indigo] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IG\actionscom]    Script Date: 10-01-2018 10:35:48 ******/
CREATE USER [IG\actionscom] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [indigo_user]
GO
/****** Object:  UserDefinedTableType [dbo].[UT_QuestionResponse]    Script Date: 10-01-2018 10:35:48 ******/
CREATE TYPE [dbo].[UT_QuestionResponse] AS TABLE(
	[QuestionId] [varchar](20) NOT NULL,
	[QuestionText] [varchar](max) NULL,
	[NumberInput] [int] NULL,
	[TextInput] [varchar](100) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[GetAllActiveCalls]    Script Date: 10-01-2018 10:35:48 ******/
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
	where ExtensionNo= @Extension and  CallDiversion.CallStatus='A'
    
	update A set CallStatus='D',AgentId=@AgentId from tbl_Call_Diversion A with(nolock) Join @temp B on A.ID = B.Id 

	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp

END


GO
/****** Object:  StoredProcedure [dbo].[GetAllActiveCallsTest]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[GetCallerHistory]    Script Date: 10-01-2018 10:35:48 ******/
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
	DECLARE @temp table(AgentId varchar(20),AgentName varchar(200) ,CallIncomingDateTime datetime,CallStatus varchar(1),ExtensionNo varchar(10),CallEstablishedDateTime datetime2,CallEndDateTime datetime2)

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime from tbl_Call_Diversion as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile like '%' + right(@CallerMobile,10) + '%' and a.CallStatus='C'
	order by a.CallIncomingDateTime desc

	insert into @temp(AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime)
	select ISNULL(Convert(varchar,a.AgentId),'UnKnown') as AgentId,ISNULL(b.AgentName,'UnKnown') as AgentName,a.CallIncomingDateTime,a.CallStatus,a.ExtensionNo,a.CallEstablishedDateTime,a.CallEndDateTime from tbl_call_Diversion_01Aug17 as  a left outer join tbl_ScreenPopup_Agent as b with (nolock)  on 
	a.AgentId=b.AgentId   
	where Convert(date,a.CallIncomingDateTime) >= Convert(Date, DATEADD(D,-3,Getdate()))
	and a.CallerMobile like '%' + right(@CallerMobile,10) + '%' and a.CallStatus='C'
	order by a.CallIncomingDateTime desc


	select AgentId,AgentName,CallIncomingDateTime,CallStatus,ExtensionNo,CallEstablishedDateTime,CallEndDateTime from @temp

END



GO
/****** Object:  StoredProcedure [dbo].[GetCallerHistoryTest]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[GetLastActiveCallInfo]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertLog]    Script Date: 10-01-2018 10:35:48 ******/
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
	AdditionalInfo
)
values
(
	@level,
	@callSite,
	@type,
	@message,
	@stackTrace,
	@innerException,
	@additionalInfo
)



GO
/****** Object:  StoredProcedure [dbo].[ScreenPopupDataMigration]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ScreenPopupDataMigration] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
	Insert into tbl_call_Diversion_01Aug17
	(CallerId,CallerName,CallerMobile,CallerEmail,CallStatus,
	CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime,AgentId,ExtensionNo, LastEnter,QuickPopAgentId)
	Select CallerId,CallerName,CallerMobile,CallerEmail,CallStatus,
	CallIncomingDateTime,CallEstablishedDateTime,CallEndDateTime,AgentId,ExtensionNo, LastEnter,QuickPopAgentId
	from tbl_Call_Diversion where Convert(Date,CallIncomingDateTime) < Convert(Date,GetDate()) 

	Delete A from tbl_Call_Diversion A Inner Join tbl_call_Diversion_01Aug17 B 
	on A.CallerId=b.CallerId and A.ExtensionNo = B.ExtensionNo and A.CallerMobile=B.CallerMobile
	where Convert(Date,A.CallIncomingDateTime) < Convert(Date,GetDate()) 

	return 1;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_AddDropCalls]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AddDropCalls] 
(
	@CallerName varchar(200),
	@CallerMobile varchar(200),
	@CallerEmail varchar(200),
	@PaxCount int,
	@PaxNames varchar(200),
	@LostPageName varchar(200),
	@FlightDetails varchar(200),
	@Priority varchar(3) = NULL,
	@IsValidRecord bit
)
as
BEGIN
Declare @CallerId int
Select @CallerId = ISNULL(Max(CallerId),0) from dbo.[tbl_AutoDial_DropOut_Call]
Set @CallerId = @CallerId + 1

insert into dbo.[tbl_AutoDial_DropOut_Call]
(
	CallerId,CallerName,CallerMobile,CallerEmail,PaxCount,PaxNames,LostPageName,FlightDetails,CreatedOn,IsAllocated,Priority,IsValidRecord
)
values
(
	@CallerId,@CallerName,@CallerMobile,@CallerEmail,
	@PaxCount,@PaxNames,@LostPageName,@FlightDetails,GETDATE(),'N',@Priority,@IsValidRecord
)

END

GO
/****** Object:  StoredProcedure [dbo].[sp_AddNewCall]    Script Date: 10-01-2018 10:35:48 ******/
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
 IF @ExtensionNo not in (15001,15002,15003,15004,15005,15006,15007,15008,
15009,15010,15011,15012,15013,15014,15015,15016,15017,15018,15019,15020,15021,15022,15023,15024,15025,15026,15027,15028,15029,15030,15031,15032,15033,15034,
15035,15036,15037,15038,15039,15040,15041,15042,15043,15044,15045,15046,15047,15048,15049,15050,15051,15052,15053,15054,15055,15056,15057,15058,15059,15060,
15061,15062,15063,15064,15065,15066,15067,15068,15069,15070,15071,15072,15073,15074,15075,15076,15077,15078,15079,15080,15081,15082,15083,15084,15085,15086,
15087,15088,15089,15090,15091,15092,15093,15094,15095,15096,15097,15098,15099,15109,15111)
	begin
	
  Insert into tbl_Call_Diversion(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile) values  
  (@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile)  
  end
 END  
COMMIT  
GO
/****** Object:  StoredProcedure [dbo].[sp_AddNewCallTest]    Script Date: 10-01-2018 10:35:48 ******/
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
 @CallerMobile varchar(max)  
)  
as  
BEGIN TRAN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion_Test with (updlock, rowlock, holdlock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile 
)  
 BEGIN  
 IF @ExtensionNo not in (15001,15002,15003,15004,15005,15006,15007,15008,
15009,15010,15011,15012,15013,15014,15015,15016,15017,15018,15019,15020,15021,15022,15023,15024,15025,15026,15027,15028,15029,15030,15031,15032,15033,15034,
15035,15036,15037,15038,15039,15040,15041,15042,15043,15044,15045,15046,15047,15048,15049,15050,15051,15052,15053,15054,15055,15056,15057,15058,15059,15060,
15061,15062,15063,15064,15065,15066,15067,15068,15069,15070,15071,15072,15073,15074,15075,15076,15077,15078,15079,15080,15081,15082,15083,15084,15085,15086,
15087,15088,15089,15090,15091,15092,15093,15094,15095,15096,15097,15098,15099,15109,15111)
	begin
	
  Insert into tbl_Call_Diversion_Test(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile) values  
  (@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile)  
  end
 END  
COMMIT  
GO
/****** Object:  StoredProcedure [dbo].[sp_AllocateDropCaseToActiveAgents]    Script Date: 10-01-2018 10:35:48 ******/
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
					Order By Priority 

			
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
/****** Object:  StoredProcedure [dbo].[sp_CheckExtensionAvailability]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_CheckExtensionAvailability] 
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
/****** Object:  StoredProcedure [dbo].[sp_CloseCurrentCall]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_CloseCurrentCall] 
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
/****** Object:  StoredProcedure [dbo].[sp_CreateAgent]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CreateExtension]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_CreateLoginLog]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_CreateLoginLog] 
(
	@AgentId int,
	@ExtensionNo int,
	@AgentLoggedInType varchar(100),
	@SessionId varchar(100)
)
as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Insert into tbl_AutoDial_Login (AgentId,ExtensionNo,LoginType,LoginStatus,SessionId,LoginDateTime)Values
	(@AgentId,@ExtensionNo,@AgentLoggedInType,'A',@SessionId,GETDATE())

	return 0;
END




GO
/****** Object:  StoredProcedure [dbo].[sp_CreateToken]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_DeActivateAgentLogin]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_DeActivateAgentLogin] 
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
	
	Update tbl_AutoDial_Login Set LoginStatus='C' Where AgentId=@AgentId and LoginStatus IN ('A','D') and ExtensionNo=@ExtensionNo
	and SessionId=@SessionId

	return 0;
END





GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUserAllToken]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetActiveOutgoingCalls]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetActiveOutgoingCalls] 
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
	Select CallDiversion.Id as Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	where CallDiversion.CallStatus='A'
    
	update A set CallStatus='I' from tbl_AutoDial_Call_Diversion A 
	with(nolock) Join @temp B on A.ID = B.Id
	
	insert into @temp(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select CallDiversion.Id as Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	where CallDiversion.CallStatus='D'
    
	--Get All Establish call and Change status to 'P' (Processing) after inserting in a temp table-----
	insert into @temp1(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select CallDiversion.Id as Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	where CallDiversion.CallStatus='E'
    
	update A set CallStatus='P' from tbl_AutoDial_Call_Diversion A 
	with(nolock) Join @temp1 B on A.ID = B.Id  

	--Get All Cleared call and Change status to 'F' (Finished) after inserting in a temp table-----
	insert into @temp2(Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId) 
	Select CallDiversion.Id as Id,CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId,AgentId
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	where CallDiversion.CallStatus = 'C'
    
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
/****** Object:  StoredProcedure [dbo].[sp_GetAgentActiveOutgoingCall]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetAgentActiveOutgoingCall] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExtensionNo int 

	Select CallerId,CallerName,CallerMobile,ExtensionNo,CallOutgoingDateTime,CallEstablishedDateTime,CallEndDateTime,CallStatus,DropOutId
	from tbl_AutoDial_Call_Diversion As CallDiversion with(nolock) 
	where CallDiversion.CallStatus in ('A','D') and ExtensionNo=@ExtensionNo

END







GO
/****** Object:  StoredProcedure [dbo].[sp_GetAgentInfo]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetAgentLoggedInExtension]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_GetAgentLoggedInExtension] 
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
/****** Object:  StoredProcedure [dbo].[sp_GetAllActiveCalls]    Script Date: 10-01-2018 10:35:48 ******/
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
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @temp table(Id int,CallerId int ,CallerMobile varchar(20),ExtensionNo varchar(5),AgentId int,TodayCallCount int,IsTravelAgentCall bit)
	
	insert into @temp(Id,CallerId,CallerMobile,ExtensionNo,AgentId,IsTravelAgentCall,TodayCallCount) 
	Select CallDiversion.Id as Id,CallerId,CallerMobile,CallDiversion.ExtensionNo as ExtensionNo,loggedAgent.AgentId as AgentId,ISNULL(travelAgent.IsActive,0) as IsTravelAgentCall,
	(Select Count(CallerId) from tbl_Call_Diversion where CallStatus='C' and CallerMobile=CallDiversion.CallerMobile And CONVERT(date,CallIncomingDateTime) = CONVERT(date,GETDATE())) As NoOfCall
	from tbl_Call_Diversion As CallDiversion with(nolock) 
	left outer join  tbl_ScreenPopup_TravelAgent  as travelAgent
	on CallDiversion.CallerMobile = travelAgent.ContactNo 
	left outer join  tbl_ScreenPopup_Login  as loggedAgent 
	on CallDiversion.ExtensionNo = loggedAgent.ExtensionNo and loggedAgent.LoginStatus = 'A'  and Convert(Date,loggedAgent.LoginDateTime)  = Convert(DAte,(Select top 1 CallIncomingDateTime from tbl_Call_Diversion where ExtensionNo=loggedAgent.ExtensionNo and LoginStatus='A' order by LoginDateTime desc)) 
	WHERE CallDiversion.CallStatus = 'A' 
    
	update A set CallStatus='D',QuickPopAgentId=B.AgentId from tbl_Call_Diversion A with(nolock) Join @temp B on A.ID = B.Id 

	select CallerId,CallerMobile,ExtensionNo,TodayCallCount,IsTravelAgentCall from @temp

END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllActiveCallsTest]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetCustomerVoiceSurvey]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetDeviceOutgoingCalls]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetDropCallerInfo]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDropCallerInfo] 
(
	@DropOutId int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @ExtensionNo int 

	Select CallerId,CallerName,CallerMobile,CallerEmail,PaxNames,PaxCount,FlightDetails,LostPageName,Priority
	from tbl_AutoDial_DropOut_Call As CallDiversion with(nolock) 
	where Id=@DropOutId

END






GO
/****** Object:  StoredProcedure [dbo].[sp_GetExtensionInfo]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetUnAllocatedWebsiteDropoutCalls]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_GetWebApiUser]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertNewIncomingCall]    Script Date: 10-01-2018 10:35:48 ******/
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
  
 IF NOT EXISTS(Select CallerId from tbl_Call_Diversion with (updlock, rowlock, holdlock) where CallerId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile)  
 BEGIN 
	IF @ExtensionNo = 51114
		begin 
			Insert into tbl_AutoDial_Premium_Call(CallerId,CallerName,CallerNumber,CreatedOn,IsAllocated) values  
			  (@CallerId,@CallerName,@CallerMobile,GETDATE(),'N')  
		end 
	else IF @ExtensionNo not in (15001,15002,15003,15004,15005,15006,15007,15008,
		15009,15010,15011,15012,15013,15014,15015,15016,15017,15018,15019,15020,15021,15022,15023,15024,15025,15026,15027,15028,15029,15030,15031,15032,15033,15034,
		15035,15036,15037,15038,15039,15040,15041,15042,15043,15044,15045,15046,15047,15048,15049,15050,15051,15052,15053,15054,15055,15056,15057,15058,15059,15060,
		15061,15062,15063,15064,15065,15066,15067,15068,15069,15070,15071,15072,15073,15074,15075,15076,15077,15078,15079,15080,15081,15082,15083,15084,15085,15086,
		15087,15088,15089,15090,15091,15092,15093,15094,15095,15096,15097,15098,15099,15109,15110,15111)
		begin
		  Insert into tbl_Call_Diversion(CallerId,CallerName,ExtensionNo,CallStatus,CallerMobile,AgentId) values  
		  (@CallerId,@CallerName,@ExtensionNo,@CallStatus,@CallerMobile,@AgentId)  
		end
	
  END  
  
COMMIT  


GO
/****** Object:  StoredProcedure [dbo].[sp_KillToken]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_LogoutAgentExistingSession]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_LogoutAgentExistingSession] 
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
/****** Object:  StoredProcedure [dbo].[sp_ReActivateAgentLogin]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_ReActivateAgentLogin] 
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
	
	Update tbl_AutoDial_Login Set LoginStatus='A' Where AgentId=@AgentId and LoginStatus='C' and ExtensionNo=@ExtensionNo
	and SessionId=@SessionId

	return 0;
END




GO
/****** Object:  StoredProcedure [dbo].[sp_ReAssignCurrentCall]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_ReAssignCurrentCall] 
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
		Update tbl_AutoDial_DropOut_Call Set IsAllocated='R' Where Id = @DropOutId
	end
	return 0;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_AgentWise_Call_Summary]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_Cummulative_Count]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_Get_Agent_Calls]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Report_ScreenPop_Get_Agent_LoggedIn_History]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveCustomerSurveyResponse]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveDispositionForActiveCall]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SaveQuickPopDisposition]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentIdInCall]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentMonitorCrossRefId]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentMonitorInvokeId]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentStateForCallAllocation]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_UpdateAgentStateForCallAllocation] 
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateAgentUnprocessedCalls]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_UpdateAgentUnprocessedCalls] 
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallStatus]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToCleared]    Script Date: 10-01-2018 10:35:48 ******/
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
	

	update tbl_Call_Diversion set CallStatus = 'C',CallEndDateTime=GETDATE() where CallerId = @CallerId and CallerMobile=@CallerNumber

	IF(@CallerNumber  LIKE ('919%') OR @CallerNumber   LIKE  ('918%') OR @CallerNumber   LIKE  ('917%') OR @CallerNumber   LIKE  ('916%') OR @CallerNumber  LIKE ('09%') 
	OR @CallerNumber   LIKE  ('08%') OR @CallerNumber   LIKE  ('07%') OR @CallerNumber   LIKE  ('06%') OR @CallerNumber  LIKE ('9%') 
	OR @CallerNumber   LIKE  ('8%') OR @CallerNumber   LIKE  ('7%') OR @CallerNumber   LIKE  ('6%') )
	BEGIN
		Select  CallerId from tbl_Call_Diversion with(nolock) where  CallerMobile = @CallerNumber and Convert(Date,CallIncomingDateTime) = Convert(Date,GETDATE())
		if(@@ROWCOUNT = 1)
		BEGIN
			Declare @CampaignId numeric
			Declare @AgentId int
			Declare @ExtensionNo int
			Select  @AgentId = AgentId,@ExtensionNo = ExtensionNo 
			from tbl_Call_Diversion with(nolock) where CallerId = @CallerId and CallerMobile = @CallerNumber
			IF(@AgentId IS NULL)
				SET @AgentId = 00000 --Not a Valid Agent Id
			
			if(@ExtensionNo is not null)
			begin
				Select @CampaignId = ISNULL(MAX(CampaignId),0) from tbl_SMS_Survey_Campaign
	
				SET @CampaignId = @CampaignId + 1

				Insert into tbl_SMS_Survey_Campaign(CampaignId,CallerId,CallerCountryCode,CallerNumber,IsIncomingCall,AgentId,ExtensionNo,CreatedOn,CreatedIpAddress,Status) 
				Values (@CampaignId,@CallerId,'IN',@CallerNumber,'Y',@AgentId, @ExtensionNo,GETDATE(),'121.0.0.1','A')
			end
		END
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToDelivered]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToEstablished]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ValidateToken]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-57bad994-c1ee-4239-8329-2678e90c90f4]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-57bad994-c1ee-4239-8329-2678e90c90f4] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-57bad994-c1ee-4239-8329-2678e90c90f4]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-57bad994-c1ee-4239-8329-2678e90c90f4] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-57bad994-c1ee-4239-8329-2678e90c90f4') > 0)   DROP SERVICE [SqlQueryNotificationService-57bad994-c1ee-4239-8329-2678e90c90f4]; if (OBJECT_ID('SqlQueryNotificationService-57bad994-c1ee-4239-8329-2678e90c90f4', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-57bad994-c1ee-4239-8329-2678e90c90f4]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-57bad994-c1ee-4239-8329-2678e90c90f4]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[SqlQueryNotificationStoredProcedure-b7cf0d80-c820-40de-b4fa-d307457b3121]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SqlQueryNotificationStoredProcedure-b7cf0d80-c820-40de-b4fa-d307457b3121] AS BEGIN BEGIN TRANSACTION; RECEIVE TOP(0) conversation_handle FROM [SqlQueryNotificationService-b7cf0d80-c820-40de-b4fa-d307457b3121]; IF (SELECT COUNT(*) FROM [SqlQueryNotificationService-b7cf0d80-c820-40de-b4fa-d307457b3121] WHERE message_type_name = 'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer') > 0 BEGIN if ((SELECT COUNT(*) FROM sys.services WHERE name = 'SqlQueryNotificationService-b7cf0d80-c820-40de-b4fa-d307457b3121') > 0)   DROP SERVICE [SqlQueryNotificationService-b7cf0d80-c820-40de-b4fa-d307457b3121]; if (OBJECT_ID('SqlQueryNotificationService-b7cf0d80-c820-40de-b4fa-d307457b3121', 'SQ') IS NOT NULL)   DROP QUEUE [SqlQueryNotificationService-b7cf0d80-c820-40de-b4fa-d307457b3121]; DROP PROCEDURE [SqlQueryNotificationStoredProcedure-b7cf0d80-c820-40de-b4fa-d307457b3121]; END COMMIT TRANSACTION; END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCallStatus]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateCallStatusTest]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  Table [dbo].[customer]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_AutoDial_Call_Diversion]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
 CONSTRAINT [PK_AutoDialCallDiversions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_AutoDial_DropOut_Call]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
 CONSTRAINT [PK_AutoDialDropOutCalls] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_AutoDial_Login]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
 CONSTRAINT [PK_AutoDial_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_AutoDial_Premium_Call]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Call_Diversion]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Call_Diversion](
	[Id] [int] IDENTITY(794354,1) NOT NULL,
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
	[UniqueCallId] [bigint] NULL,
	[QuickPopAgentId] [int] NULL,
	[DispositionId] [int] NULL,
	[Remarks] [varchar](200) NULL,
 CONSTRAINT [PK_CallDiversions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_call_Diversion_01Aug17]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[QuickPopAgentId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Call_Diversion_Test]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Mst_Disposition]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Mst_HuntGroup]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  Table [dbo].[tbl_Mst_VDN]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  Table [dbo].[tbl_ScreenPopup_Agent]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_CallDiversion]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Extension]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Logger]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_Login]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ScreenPopup_Login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AgentId] [int] NOT NULL,
	[ExtensionNo] [int] NOT NULL,
	[LoginStatus] [varchar](1) NOT NULL,
	[LoginDateTime] [datetime] NOT NULL,
	[SessionId] [varchar](100) NULL,
 CONSTRAINT [PK_ScreenPopup_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ScreenPopup_TravelAgent]    Script Date: 10-01-2018 10:35:48 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Agent_Exclusion]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Application]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign_001_Log]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Credential]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Customer_Response]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Customer_Response_Question]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Logger]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Questionaire]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Questionaire_Filter]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Template]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_WebApiToken]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_WebApiToken](
	[TokenId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[AuthToken] [varchar](200) NOT NULL,
	[IssuedOn] [datetime] NOT NULL,
	[ExpiredOn] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_WebApiUser]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_WebApiUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[Name] [varchar](100) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[x]    Script Date: 10-01-2018 10:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[x](
	[id] [int] NULL,
	[value] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tbl_AutoDial_Call_Diversion] ADD  CONSTRAINT [DF_tbl_AutoDial_Call_Diversion_CallOutgoingDateTime]  DEFAULT (getdate()) FOR [CallOutgoingDateTime]
GO
ALTER TABLE [dbo].[tbl_AutoDial_DropOut_Call] ADD  CONSTRAINT [DF_tbl_AutoDial_DropOut_Call_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tbl_AutoDial_DropOut_Call] ADD  DEFAULT ((0)) FOR [IsValidRecord]
GO
ALTER TABLE [dbo].[tbl_AutoDial_Premium_Call] ADD  CONSTRAINT [DF_tbl_AutoDial_Premium_Call_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tbl_Call_Diversion] ADD  DEFAULT (getdate()) FOR [CallIncomingDateTime]
GO
ALTER TABLE [dbo].[tbl_Call_Diversion_Test] ADD  DEFAULT (getdate()) FOR [CallIncomingDateTime]
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
USE [master]
GO
ALTER DATABASE [IndigoDB] SET  READ_WRITE 
GO
