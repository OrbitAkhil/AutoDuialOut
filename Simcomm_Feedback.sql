USE [master]
GO
/****** Object:  Database [Simcomm_Feedback]    Script Date: 05-08-2018 14:44 ******/
CREATE DATABASE [Simcomm_Feedback]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Simcomm_Feedback', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Simcomm_Feedback.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Simcomm_Feedback_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Simcomm_Feedback_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Simcomm_Feedback] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Simcomm_Feedback].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Simcomm_Feedback] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET ARITHABORT OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Simcomm_Feedback] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Simcomm_Feedback] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Simcomm_Feedback] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Simcomm_Feedback] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Simcomm_Feedback] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Simcomm_Feedback] SET  MULTI_USER 
GO
ALTER DATABASE [Simcomm_Feedback] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Simcomm_Feedback] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Simcomm_Feedback] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Simcomm_Feedback] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Simcomm_Feedback]
GO
/****** Object:  UserDefinedTableType [dbo].[UDTT_Questionnaire]    Script Date: 05-08-2018 14:44 ******/
CREATE TYPE [dbo].[UDTT_Questionnaire] AS TABLE(
	[QuestionText] [varchar](500) NULL,
	[VDNNo] [varchar](50) NULL,
	[SubBusinessId] [varchar](50) NULL,
	[IsActive] [varchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyBy] [varchar](50) NULL,
	[RangeType] [varchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UDTT_SMSFeedback]    Script Date: 05-08-2018 14:44 ******/
CREATE TYPE [dbo].[UDTT_SMSFeedback] AS TABLE(
	[TemplateId] [varchar](50) NULL,
	[User] [varchar](50) NULL,
	[Text] [varchar](50) NULL,
	[DisplayType] [varchar](50) NULL,
	[MultiSelect] [varchar](50) NULL,
	[EndOfSurvey] [varchar](50) NULL,
	[EndOfSurveyMessage] [varchar](50) NULL,
	[ConditionalFilter] [varchar](50) NULL,
	[PresentationMode] [varchar](50) NULL,
	[IsRequired] [varchar](50) NULL,
	[QuestionTags] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[Sequence] [varchar](50) NULL,
	[SubBusinessId] [varchar](50) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[sp_EditBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_EditBusiness]

(@BusinessName varchar(100), @Location varchar(100), @ContactNumber varchar(20),

@Address varchar(max), @ContactPerson varchar(50),

@BusinessId varchar(50),@Status varchar(20),@ERROR VARCHAR(100) OUT)

as

begin

update [dbo].[tblmst_business] set BusinessName=@BusinessName,Location=@Location,ContactNumber = @ContactNumber,

ContactPerson=@ContactPerson,AddressOfContact=@Address,UpdateBy='',UpdateDate=getdate(),Status=@Status

where id=@BusinessId

set @ERROR = 'Done'

end













GO
/****** Object:  StoredProcedure [dbo].[sp_EditSubBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EditSubBusiness]

(@SubBusinessName varchar(100),

@SubBusinessId varchar(50),@ERROR VARCHAR(100) OUT)
as
begin
IF exists(select 1 from [dbo].tblmst_subbusinessmaster where subbusinessname=@SubBusinessName and id!=@SubBusinessId )
BEGIN
set @ERROR = 'Sub Business name already exist in system please choose another name.'

return 

END

update [dbo].tblmst_subbusinessmaster set

 subbusinessname=@SubBusinessName--,

--UpdateBy='',UpdateDate=getdate()
where id=@subBusinessId

set @ERROR = 'Done'

end



GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllBusinessSubBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_GetAllBusinessSubBusiness] -- exec sp_GetAllSurveyDetails 'S001'

@SurveyId nvarchar(10)

as

begin

select b.businessname ,c.subbusinessname,a.SurveyId,c.id,c.businessid from tbl_mst_SurveyDetails a with(nolock) 

join tblmst_business  b on a.BusinessId = b.id

join tblmst_subbusinessmaster c on a.SubBusinessId=c.id

where SurveyId=@SurveyId

end

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllFeedBackOption]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetAllFeedBackOption]
as
begin
select Id,Name from tblmst_OptionFeedBack
end 
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllSurveyDetailsSMS]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_GetAllSurveyDetailsSMS] -- exec sp_GetAllSurveyDetailsS

as

begin

select b.businessname ,c.subbusinessname,a.SurveyId,a.SurveyType from tbl_mst_SurveyDetails a with(nolock) 

join tblmst_business  b on a.BusinessId = b.id

join tblmst_subbusinessmaster c on a.SubBusinessId=c.id

where  SurveyType='SMS'

end

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllSurveyDetailsTelephony]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_GetAllSurveyDetailsTelephony] -- exec sp_GetAllSurveyDetails 'Telephony'

as
begin
select b.businessname ,c.subbusinessname,a.SurveyId,a.SurveyType from tbl_mst_SurveyDetails a with(nolock) 
join tblmst_business  b on a.BusinessId = b.id
join tblmst_subbusinessmaster c on a.SubBusinessId=c.id
where  SurveyType='Telephony'
end

GO
/****** Object:  StoredProcedure [dbo].[sp_GetRouter]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_GetRouter]

as 

begin

create table #temp(ID int, RouterIP varchar(50))



insert into #temp

select 0,'---Select Router IP ---'



insert into #temp

select distinct ID, RouterIP from [dbo].[tblmst_routermaster] order by 2



select * from #temp

end





GO
/****** Object:  StoredProcedure [dbo].[sp_getSBlistbyUserID]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_getSBlistbyUserID](

@id varchar(50)

)

as



begin



SELECT DISTINCT  USR.ID , USERLOGINID, BUSINESSID , BUSINESSNAME ,SUBBUSINESSID ,SUBBUSINESSNAME,1 as Checked

Into #Temp  

FROM TBLMST_SUBBUSINESSMASTER SBM 

left JOIN TBLTRN_USERSBUSINESSMAPPING SBUM with (nolock) ON SBM.Id = SBUM.SubBusinessID

left join TBLMST_USER USR with (nolock) ON USR.ID = SBUM.USERID 

LEFT JOIN TBLMST_BUSINESS BM with (nolock) ON SBM.BUSINESSID = BM.ID 

WHERE USR.ID = @ID





declare @BUM varchar(40), @USerID varchar(10), @LoginID varchar(50)

set @USerID = (Select distinct ID from #Temp)

set @LoginID = (Select distinct UserLoginID from #Temp)

set @BUM = (Select distinct BusinessID from #Temp)



select * from #Temp

union

Select @ID as ID, @LoginID as UserLoginID, SBM.BUSinessID, BM.businessname, SBM.ID, SBM.SubBusinessName, 0 

from TBLMST_SUBBUSINESSMASTER SBM with (nolock) 

LEFT JOIN TBLMST_BUSINESS BM with (nolock) ON SBM.BUSINESSID = BM.ID 

LEFT JOIN tbltrn_USerBusinessMapping UBUM with(nolock) on SBM.businessid = UBUM.BusinessID and UBUM.UserId = @id

--LEFT JOIN #Temp TMP on SBM.ID = TMP.SubBusinessID

where SBM.ID not in (select subbusinessid from #Temp) and UBUM.UserID = @ID

end



GO
/****** Object:  StoredProcedure [dbo].[sp_GetSMSFeedBack]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetSMSFeedBack]
@Text nvarchar(500),
@DisplayType varchar(20),
@MultiSelect varchar(100),
@EndOfSurveyMessage varchar(100),
@WelcomeText varchar(200)

as
begin
insert into tbl_SMS_Survey_Questionaire(Text,DisplayType,MultiSelect,EndOfSurveyMessage)values(@Text,@DisplayType,@MultiSelect,@EndOfSurveyMessage)
insert into tbl_SMS_Survey_Template(WelcomeText)values(@WelcomeText) 
end

--insert into tblmst_user(userloginid,username,useremail,userpass,active,insertby,insertdate,usertype)
--select 'RCM', @userName ,@useremail ,'',1, @updatedby , getdate(),cast(@usertype as int) where @userId=0
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNewIncomingCall]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_InsertNewIncomingCall]   
(  
@CallerId varchar(10)=null, 
@ExtensionNo varchar(20),
@CallStatus varchar(1)=null,  
@CallerMobile varchar(max),
@UCID varchar(50) = null,
@UEC nvarchar(50) = null,
@LastVDN varchar(20) = null,
@AgentID varchar(20) =1001
)  
as  
BEGIN TRAN  
 SET NOCOUNT ON;  
 declare @Count int
 set @Count = (Select Count(*) from tbl_Call_AllIncomingCall with(nolock))

 if (@Count % 2 <> 0)
 set @AgentID =  '1001'
 else
 set @AgentID =  '1002'

 if(@ExtensionNo = '4458')
 begin
 insert into tbl_Call_AllIncomingCall(CallId,ExtensionNo,CallStatus,CallerMobile,CallIncomingDateTime,AgentID,UCID,UEC,LastVDN,CallEstablishedDatetime,CallEndDateTime)
 select @CallerId,@ExtensionNo,@CallStatus,@CallerMobile,getdate(),@AgentID,@UCID,@UEC,4443,GETDATE(),dateadd(minute,10,getdate())
 end

IF NOT EXISTS(Select CallId from tbl_Feedback_CallDetails with (updlock, rowlock, holdlock) 
where CallId=@CallerId and ExtensionNo=@ExtensionNo and CallerMobile=@CallerMobile and CallIncomingdatetime >= GETDATE())  
 BEGIN  
		Insert into tbl_Feedback_CallDetails(CallId, ExtensionNo, CallStatus, CallerMobile, UCID, LastVDN,CallType,CallerNumber,UEC,AgentId) 
		values(@CallerId,  @ExtensionNo, @CallStatus, @CallerMobile, @UCID, @LastVDN,'I',@CallerMobile,@UEC,@AgentID)  
end


COMMIT  

GO
/****** Object:  StoredProcedure [dbo].[sp_ITUserCheckExistance]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ITUserCheckExistance]

@Id int=NULL,

@QuestionText nvarchar(3000)=NUll,

@VDNNo varchar(50)=NULL,

@SubBusinessId int=NULL,

@IsActive char(10)=NULL,

@CreatedDate datetime=NUll,

@CreatedBy varchar(50)=NULL,

@ModifyDate datetime=NULL,

@ModifyBy varchar(50)=NULL



AS  

BEGIN  

IF exists(select SubBusinessId from tbl_MST_Questionnaire with(nolock) where  SubBusinessId = @SubBusinessId )

BEGIN

		UPDATE tbl_MST_Questionnaire  

		SET QuestionText = @QuestionText ,

		VDNNo = @VDNNo, 

		SubBusinessId=@SubBusinessId,

		IsActive=@IsActive,

		CreatedDate=@CreatedDate,
		CreatedBy=@CreatedBy,

		ModifyDate=@ModifyDate,

		ModifyBy=@ModifyBy


		WHERE SubBusinessId = @SubBusinessId 



SELECT 'Update'

return 

END

else

begin

INSERT INTO tbl_MST_Questionnaire(QuestionText,VDNNo,SubBusinessId,IsActive,CreatedDate,CreatedBy,ModifyDate,ModifyBy) 

VALUES (  

@QuestionText, @VDNNo, @SubBusinessId,@IsActive,@CreatedDate, @CreatedBy,@ModifyDate,@ModifyBy

)  

IF (@@ROWCOUNT > 0)  

BEGIN  

SELECT SCOPE_IDENTITY()   

END  



end



end



GO
/****** Object:  StoredProcedure [dbo].[sp_QuestionCRUD]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_QuestionCRUD]
@Id int=NULL,
@QuestionText nvarchar(3000)=NUll,
@VDNNo varchar(50)=NULL,
@SubBusinessId int=NULL,
@businessname nvarchar(50)=NULL,
@SurveyId nvarchar(50)=NULL,
@IsActive char(10)=NULL,
@RangeType char(10)=NULL,
@CreatedBy varchar(50)=NULL,
@ModifyBy varchar(50)=NULL,
@Query INT 
AS  
BEGIN  
IF (@Query = 1)  
BEGIN     
INSERT INTO tbl_MST_Questionnaire(QuestionText,VDNNo,SubBusinessId,IsActive,CreatedDate,CreatedBy,ModifyDate,ModifyBy)  
VALUES (  
@QuestionText, @VDNNo, @SubBusinessId,@IsActive,getdate(),@CreatedBy,getdate(),@ModifyBy
)  
IF scope_identity() < 10 
  BEGIN 
    set  @SurveyId='S00' + cast (scope_identity() as varchar(10)) 
  END 
  ELSE if scope_identity() < 100 
    BEGIN 
	 set  @SurveyId='S0' + cast (scope_identity() as varchar(10)) 
  END 
    ELSE if scope_identity() < 1000
  BEGIN 
   set  @SurveyId='S' + cast (scope_identity() as varchar(10)) 
     END 
	     ELSE if scope_identity() < 10000
  BEGIN 
   set  @SurveyId='S' + cast (scope_identity() as varchar(10)) 
       END 

  ELSE

    BEGIN 

 set  @SurveyId='S' 
   END 
     END
IF (@Query = 2)  
BEGIN  
UPDATE tbl_MST_Questionnaire
SET QuestionText = @QuestionText ,
RangeType=@RangeType,
VDNNo = @VDNNo
from  tbl_MST_Questionnaire a
JOIN tbl_MST_SurveyDetails b
    ON a.SubBusinessId = a.SubBusinessId
WHERE SurveyId = @SurveyId  
SELECT 'Update'  
END  
end
--IF (@Query = 3)  



--BEGIN  



--DELETE  



--FROM tbl_MST_Questionnaire  



--WHERE Id = @Id 



--SELECT 'Deleted'  



--END  











--IF (@Query = 4)  



--BEGIN  



----SELECT id,businessname,Location, CASE WHEN Status = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END    as status



--Select d.Id,QuestionText,VDNNo,SubBusinessId=(select subbusinessname from tblmst_subbusinessmaster a where a.id = SubBusinessId),IsActive,d.CreatedDate,d.CreatedBy,ModifyDate,ModifyBy,c.businessname,SurveyId  FROM tbl_MST_Questionnaire d with(nolock)  

--join tblmst_subbusinessmaster b  on  d.SubBusinessId = b.id

--join tblmst_business c on b.businessid = c.id

--END  



--END  











--IF (@Query = 5)  



--BEGIN  



----SELECT id,businessname,Location, CASE WHEN Status = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END as status



--Select QuestionText,VDNNo  FROM tbl_MST_Questionnaire a  with(nolock) where SurveyId=@SurveyId

----join tblmst_subbusinessmaster b  on  a.SubBusinessId = b.id

----join tblmst_business c on b.businessid = c.id

----WHERE a.Id = @Id  



--END   







--IF (@Query = 6)  



--BEGIN  



----SELECT id,businessname,Location, CASE WHEN Status = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END    as status



----Select distinct SurveyId ,SubBusinessId=(select subbusinessname from tblmst_subbusinessmaster a where a.id = SubBusinessId),IsActive,c.businessname FROM tbl_MST_Questionnaire d with(nolock)  

----join tblmst_subbusinessmaster b  on  d.SubBusinessId = b.id

----join tblmst_business c on b.businessid = c.id

--select BusinessName,SubBusinessName,SurveyId from tbl_mst_SurveyDetails

--END  























 

















GO
/****** Object:  StoredProcedure [dbo].[sp_selectAllsubBusinessBySurveyId]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_selectAllsubBusinessBySurveyId]
@surveyId varchar(10)
as 
begin 
select QuestionText,VDNNo from tbl_MST_Questionnaire where SurveyId=@surveyId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectOptionType]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectOptionType](@id int)
as
begin
select Id,RangeName+'('+Value+')' as RangeName from tblmst_Optiontype where FeedBackOption =@id
end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectQuestionBySurveyId]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectQuestionBySurveyId]

@surveyId nvarchar(10)=NULL 

as

begin
--create table #FinalData (id int ,QuestionText varchar(200))
select a.id, QuestionText,VDNNo 
into #Temp 
from tbl_MST_Questionnaire a join tbl_MST_SurveyDetails b  on  a.SubBusinessId = b.SubBusinessId where SurveyId=@surveyId -- exec sp_SelectQuestionBySurveyId 'S0012'
--select * from  #Temp

declare @max int
declare @min int

set @min =(select min(id) from #Temp)
set @max =(select max(id) from #Temp)

Select QuestionText,VDNNo from #temp  WHERE id NOT IN (@min, @max)
--drop table #Temp
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectQuestionBySurveyIdSMS]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectQuestionBySurveyIdSMS]

@surveyId nvarchar(10)=NULL

as

begin

select Text from tbl_SMS_Survey_Questionaire a join tbl_MST_SurveyDetails b  on  a.SubBusinessId = b.SubBusinessId where SurveyId=@surveyId --exec sp_SelectQuestionBySurveyId 'S001'

end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectQuesVDNRangeTypeBySurveyId]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectQuesVDNRangeTypeBySurveyId]
@surveyId nvarchar(10)
as
begin
select a.Id,QuestionText,VDNNo,RangeType from tbl_MST_Questionnaire a join tbl_MST_SurveyDetails b  on  a.SubBusinessId = b.SubBusinessId where SurveyId=@surveyId
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectQuesVDNRangeTypeBySurveyIdSMS]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_SelectQuesVDNRangeTypeBySurveyIdSMS]
@surveyId nvarchar(10)
as
begin
select distinct a.Id,Text,DisplayType,WelcomeText,EndOfSurveyMessage from tbl_SMS_Survey_Questionaire a
join tbl_SMS_Survey_Template c on a.SubBusinessId=c.SubBusinessId
 join tbl_MST_SurveyDetails b  on  a.SubBusinessId = b.SubBusinessId where SurveyId=@surveyId
end

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectSMSOptionType]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_SelectSMSOptionType]
@OptionType int=NULL

as



begin

select Id,RangeName+'('+ Value+')' as DisplayType  from tblmst_Optiontype where FeedBackOption =2

end

GO
/****** Object:  StoredProcedure [dbo].[sp_Subbusinessname]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Subbusinessname]
as 
begin 

select id,subbusinessname from tblmst_subbusinessmaster
end
GO
/****** Object:  StoredProcedure [dbo].[sp_SurveyCRUD]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_SurveyCRUD]

@Id int=NULL,

@businessname nvarchar(50)=NULL,
@SubBusinessName nvarchar(50)=NULL,
@SurveyId nvarchar(50)=NULL,


@Query INT 

AS  

BEGIN  

--IF (@Query = 1)  

--BEGIN     

--INSERT INTO tbl_MST_SurveyDetails(BusinessName,SubBusinessName,SurveyId)  

--VALUES (  

--@businessname, @SubBusinessName, @SurveyId

--)  
--IF scope_identity() < 10 
--  BEGIN 
--  set  @SurveyId='S00' + cast (scope_identity() as varchar(10)) 
   
--  END 
--ELSE if scope_identity() < 100 
--  BEGIN 
-- set  @SurveyId='S0' + cast (scope_identity() as varchar(10)) 

--  END 
--  ELSE if scope_identity() < 1000
--  BEGIN 
-- set  @SurveyId='S' + cast (scope_identity() as varchar(10)) 
 
--  END 
--    ELSE if scope_identity() < 10000
--  BEGIN 
-- set  @SurveyId='S' + cast (scope_identity() as varchar(10)) 
 
--  END 
--  ELSE
--    BEGIN 
-- set  @SurveyId='S' 
 
--  END 
--  END

--IF (@Query = 2)  

--BEGIN  

--UPDATE tbl_MST_SurveyDetails 

--SET BusinessName = @businessname ,

--SubBusinessName = @SubBusinessName, 

--SurveyId=@SurveyId
--WHERE id = @id  

--SELECT 'Update'  

--END  

--IF (@Query = 3)  

--BEGIN  

--DELETE  

--FROM tbl_MST_Questionnaire  

--WHERE Id = @Id 

--SELECT 'Deleted'  

--END  

IF (@Query = 6)  

BEGIN  

--SELECT id,businessname,Location, CASE WHEN Status = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END    as status

--Select distinct SurveyId ,SubBusinessId=(select subbusinessname from tblmst_subbusinessmaster a where a.id = SubBusinessId),IsActive,c.businessname FROM tbl_MST_Questionnaire d with(nolock)  
--join tblmst_subbusinessmaster b  on  d.SubBusinessId = b.id
--join tblmst_business c on b.businessid = c.id
select b.businessname ,c.subbusinessname,SurveyId from tbl_mst_SurveyDetails a with(nolock) 
join tblmst_business  b on a.BusinessId = b.id
join tblmst_subbusinessmaster c on a.SubBusinessId=c.id
END  

END








GO
/****** Object:  StoredProcedure [dbo].[sp_UDDTQuestionnaire]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UDDTQuestionnaire]

--(@UserId varchar(50), @SubBusiID varchar(50), @CreatedBy varchar(50), @ERROR VARCHAR(100) OUT)

@UDTT_Questionnaire [UDTT_Questionnaire] READONLY ,  @ERROR VARCHAR(100) OUT

AS  

BEGIN  










Declare @id varchar(100)

declare  @SubBusinessId int
declare  @BusinessId int

set @SubBusinessId = (select top 1 SubBusinessID from @UDTT_Questionnaire)
set @BusinessId = (select top 1 BusinessID from tblmst_subbusinessmaster where id = @SubBusinessId )
if Not exists (select SubBusinessId from tbl_MST_Questionnaire with(nolock) where SubBusinessId = @SubBusinessId)

	begin

		Insert into tbl_MST_SurveyDetails (SurveyId,SubBusinessId,BusinessId,SurveyType)
        select 'S00', @SubBusinessId ,@BusinessId ,'Telephony'
		set  @id='S00' + cast (scope_identity() as varchar(10)) 
		update tbl_MST_SurveyDetails set SurveyId=@id where id=scope_identity()
	end

if exists (select SubBusinessId from tbl_MST_Questionnaire with(nolock) where SubBusinessId = @SubBusinessId)

	begin

		delete from tbl_MST_Questionnaire where  SubBusinessId = @SubBusinessId

	end



INSERT INTO dbo.tbl_MST_Questionnaire 

select QuestionText, VDNNo, SubBusinessId, IsActive,CreatedDate,CreatedBy,ModifyDate,ModifyBy,RangeType from @UDTT_Questionnaire

set @ERROR = 'ok'



END

GO
/****** Object:  StoredProcedure [dbo].[sp_UDDTSMSFeedBack]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UDDTSMSFeedBack]
--(@UserId varchar(50), @SubBusiID varchar(50), @CreatedBy varchar(50), @ERROR VARCHAR(100) OUT)
@UDTT_SMSFeedback [UDTT_SMSFeedback] READONLY ,@Welcome varchar(50),  @ERROR VARCHAR(100) OUT
AS 
BEGIN  
Declare @id varchar(100)
Declare @WelcomeText varchar(100)
declare  @SubBusinessId int
declare  @BusinessId int
--declare  @SurveyId varchar(50)
--declare  @MinId int
--set @TemplateId = (select top 1 TemplateId from @UDTT_SMSFeedback)
--set @MinId = (select Min(Id) from  @UDTT_SMSFeedback )

set @SubBusinessId = (select top 1 SubBusinessId from @UDTT_SMSFeedback)
set @BusinessId = (select top 1 BusinessID from tblmst_subbusinessmaster where id = @SubBusinessId )

if Not exists (select SubBusinessId from tbl_SMS_Survey_Questionaire with(nolock) where SubBusinessId = @SubBusinessId)
	begin
	--set @SurveyId = (select top 1 SurveyId from  tbl_MST_SurveyDetails where SubBusinessId =@SubBusinessId )
	--if(@SurveyId !='')
		--begin
		Insert into tbl_MST_SurveyDetails (SurveyId,SubBusinessId,BusinessId,SurveyType)
        select 'S00', @SubBusinessId ,@BusinessId ,'SMS'
		set  @id='S00' + cast (scope_identity() as varchar(10)) 
		update tbl_MST_SurveyDetails set SurveyId=@id where id=scope_identity()
	 -- end
	end
if Not exists (select id from tbl_SMS_Survey_Template with(nolock) where SubBusinessId = @SubBusinessId)
	begin
		Insert into tbl_SMS_Survey_Template (WelcomeText,SubBusinessId)
        select  @Welcome,@SubBusinessId  
		--set  @id='S00' + cast (scope_identity() as varchar(10)) 
		--update tbl_SMS_Survey_Template set ApplicationId=@TemplateId where id=scope_identity()
	end
if exists (select SubBusinessId from tbl_SMS_Survey_Questionaire with(nolock) where SubBusinessId = @SubBusinessId)
	begin
		delete from tbl_SMS_Survey_Questionaire where  SubBusinessId = @SubBusinessId
	end
INSERT INTO dbo.tbl_SMS_Survey_Questionaire 
select TemplateId,User, Text, DisplayType, MultiSelect,EndOfSurvey,EndOfSurveyMessage,ConditionalFilter,PresentationMode,IsRequired,QuestionTags,Status,Sequence,SubBusinessId from @UDTT_SMSFeedback

set @ERROR = 'ok'
END



GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAllDataTelephony]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UpdateAllDataTelephony]
@SurveyId nvarchar(10),
@QuestionText nvarchar(300),
@VDNNo int,
@RangeType char(10)
as
begin
declare @SubbusinessId varchar(50);

Delete tbl_MST_Questionnaire from tbl_MST_Questionnaire 

INNER JOIN tbl_MST_SurveyDetails  on  tbl_MST_SurveyDetails.SubBusinessId = tbl_MST_Questionnaire.SubBusinessId where surveyID=@SurveyId

UPDATE a
SET a.QuestionText = @QuestionText,a.VDNNo=@VDNNo,a.RangeType=@RangeType from  tbl_MST_Questionnaire a
join tbl_MST_SurveyDetails b  on  a.SubBusinessId = b.SubBusinessId
WHERE SurveyId=@SurveyId;
 
end


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToCleared]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UpdateCallToCleared](@CallerId varchar(50),@CallerNumber Varchar(20))
as
begin

update tbl_Feedback_CallDetails set CallStatus='C' where CallId = @CallerId and CallerMobile = @CallerNumber

end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCallToEstablished]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UpdateCallToEstablished](@CallerId varchar(50),@ExtensionNo Varchar(20))
as
begin
update tbl_Feedback_CallDetails set CallStatus ='E' where CallId = @CallerId  
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_AddBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE proc [dbo].[sp_UTOM_AddBusiness](@BusinessName varchar(100), @Location varchar(100), @Address varchar(max), @ContPerson varchar(50),@CreatedBy varchar(50),@Status varchar(20),@Contactnumber varchar(20),@ERROR VARCHAR(100) OUT)

as

begin

set @ERROR = 'Add Business Successful.'

insert into [dbo].[tblmst_business] (BusinessName,Location,ContactPerson,AddressOfContact,CreatedBy,CreatedDate,Status,ContactNumber)

Select @BusinessName,@Location,@ContPerson,@Address,@CreatedBy,getdate(),@Status,@ContactNumber

end















GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_AddSubBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_UTOM_AddSubBusiness](@SubBusiName varchar(100),@BusinessName int, @CreatedBy varchar(50),@ERROR varchar(100) Out)

as

Begin

if (@BusinessName = 0)

begin

set @ERROR = 'Please Select Business!!!'

end

else

Begin

insert into dbo.tblmst_subbusinessmaster(SubBusinessName,BusinessID,CreatedBy,CreatedDate)

Select @SubBusiName, @BusinessName, @CreatedBy, Getdate()


set @ERROR = 'Sub Business added successfully.'
End
end

GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_DNISPRILOBMapping]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_UTOM_DNISPRILOBMapping](@RID int, @PortNo varchar(50), @CircuitID varchar(50), @ServiceProvider varchar(100), @DNISType int, @PRIno varchar(100), 

@DNIS varchar(50), @LOB int, @CreatedBy varchar(50), @ERROR varchar(250) out )

as

Begin

Insert into tblmst_PRIBusinessMappingMaster(RouterID,PortNo,CircuitID,ServiceProviderName,TypeOfService,TFDIDNo,DNISNo,SubBusinessID,CreatedBy,CreatedDate)

select @RID, @PortNo, @CircuitID, @ServiceProvider, @DNISType, @PRIno, @DNIS, @LOB, @CreatedBy, Getdate()


Set @ERROR = 'Mapping added successfully.'

end







GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_GetDNISType]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_UTOM_GetDNISType]



as

 begin

 create table #Temp(Id int, Name varchar(50))

 insert into #Temp

 Select 0,'---Select DNIS TYPE ---'



 insert into #Temp

 Select ID, NAME from DNIS_TYpe where Status = 'Active' order by 2



 Select * from #Temp

 end





GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_ReturnLOB]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_UTOM_ReturnLOB]

as

Begin

create table #temp(LOBID int, LOBName varchar(250))



insert into #temp



Select 0 as BusinessID, '------Select LOB------' as BusinessName 



insert into #temp



select ID as BusinessID, SubBusinessName from dbo.tblmst_subbusinessmaster with(nolock) order by SubBusinessName



select * from #temp 

end





GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_SelectBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_UTOM_SelectBusiness]

as

begin

create table #temp(BusinessID int, BusinessName varchar(250),Location  varchar(250) ,ContactPerson  varchar(250),

AddressOfContact  varchar(250),ContactNumber varchar(20),Status varchar(10))

insert into #temp

Select 0 as BusinessID, '------Select Business------' as BusinessName,'','','','',''

insert into #temp

select ID as BusinessID, BusinessName , Location ,ContactPerson ,

AddressOfContact,ContactNumber, CASE WHEN status = '1' THEN 'ACTIVE' ELSE 'INACTIVE' END  from dbo.tblmst_business with(nolock) order by BusinessName

select * from #temp

end

























GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_SelectSubBusiness]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[sp_UTOM_SelectSubBusiness]

(@businessid int = null)



as



if @businessid is null

set @businessid = 0



begin

create table #temp(id int, subbusinessname varchar(50),businessid varchar(50))







insert into #temp

select id as ID, subbusinessname as SubBusinessName ,businessid as BusinessID    from dbo.tblmst_subbusinessmaster where businessid = @businessid



select * from #temp

end

GO
/****** Object:  StoredProcedure [dbo].[sp_UTOM_SelectUserType]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_UTOM_SelectUserType]

as

begin

create table #temp(ID int, UserType varchar(50))

insert into #temp

Select 0 as ID, '------Select UserType------' as UserType

insert into #temp

select ID, UserType  from dbo.tbl_UserType where Status =1 and ID <>1 order by ID

select * from #temp

end























GO
/****** Object:  StoredProcedure [dbo].[usp_deletednis]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_deletednis](@dnis varchar(max),@ERROR VARCHAR(100) OUT)

as 



begin 

delete from tblmst_PRIBusinessMappingMaster where DNISNo=@dnis

set @ERROR = 'ok' 

end

GO
/****** Object:  StoredProcedure [dbo].[usp_getallDNISdetails]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_getallDNISdetails]

as begin 

 select DNISNo as DNIS , TFDIDNo as pNumber ,subbusinessname  

 from tblmst_subbusinessmaster S with(nolock)

 join tblmst_PRIBusinessMappingMaster  B with(nolock) on subbusinessid=s.id

END







GO
/****** Object:  StoredProcedure [dbo].[usp_getallSubBusinessdetails]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_getallSubBusinessdetails](@subbusinessid int )

as begin 

 select s.id  as subbusinessid ,B.id as businessid , subbusinessname , businessname from tblmst_subbusinessmaster S with(nolock)

 join tblmst_business  B with(nolock) on businessid=B.id

 where s.id = case  when @subbusinessid = 0 then s.id  else @subbusinessid end 

END

GO
/****** Object:  StoredProcedure [dbo].[usp_getalluserdetails]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Exec [usp_getalluserdetails] '1',1
CREATE proc [dbo].[usp_getalluserdetails](@loginid as varchar(50)= null ,@userid int = null)

as

BEGIN 



SELECT DISTINCT USR.ID, USR.USERLOGINID, USR.USERNAME, USR.USEREMAIL, USR.USERPASS, USR.USERTYPE AS USERTYPEID , CASE WHEN USR.ACTIVE = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END AS ACTIVE,

USR.ISADMIN, USR.INSERTBY, USR.INSERTDATE, USR.UPDATEBY , UT.USERTYPE AS USERTYPETEXT, USR.UPDATEDATE 
FROM TBLMST_USER USR WITH(NOLOCK)  JOIN  TBL_USERTYPE UT WITH(NOLOCK)  ON  USR.USERTYPE = UT.ID 

LEFT JOIN TBLTRN_USERSBUSINESSMAPPING SBUM WITH(NOLOCK) ON USR.ID = SBUM.USERID

LEFT JOIN TBLMST_SUBBUSINESSMASTER SBM WITH(NOLOCK) ON SBUM.SUBBUSINESSID = SBM.ID

LEFT JOIN TBLMST_BUSINESS BUM WITH(NOLOCK) ON SBM.BUSINESSID = BUM.ID

WHERE  USR.ID = CASE WHEN @USERID=1 THEN USR.ID ELSE @USERID END



END




GO
/****** Object:  StoredProcedure [dbo].[usp_getdashboard]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec usp_getdashboard 
CREATE procedure [dbo].[usp_getdashboard](@USerId int=1)

as

begin

declare @SBID int
set @sbid = (Select top 1 BusinessID from tbltrn_UserBusinessMapping with(nolock) where UserId = @USerId)
 
declare @QuestionCount int
set @QuestionCount = (Select count(Id) from tbl_MST_Questionnaire with(nolock) where SubBusinessId = @sbid and IsActive = 1)


create table #FinalData(BusinessId int, BusinessName varchar(500),SubBusId int, SubBusName varchar(500), TotalCall int,FeedbackOffered int,CompletedFeedback int, InCompleteFeedback int)

select distinct Bs.Id as BusinessId,BusinessName,SB.Id as SubbusinessId,SubBusinessName,DnisNo,
Cal.Extensionno,Cal.CallId,Cal.CallerMobile,Cal.CallinComingdateTime,Cal.AgentId,Cal.lastVDN
into #TempTotal from [tblmst_PRIBusinessMappingMaster] PBM with(nolock)
join tblmst_subbusinessmaster SB with(nolock) on PBM.SubBusinessID =sb.id
join tblmst_Business BS with(nolock) on SB.BusinessId = BS.ID
join tbl_Call_AllIncomingCall Cal with(nolock) on Cal.LastVDN = PBM.DNISNo
join tbltrn_UserBusinessMapping map with(nolock) on SB.id = map.BusinessID


insert into #FinalData(BusinessId,BusinessName,SubBusId,SubBusName,TotalCall,FeedbackOffered,CompletedFeedback,InCompleteFeedback)
select BusinessId,BusinessName,SubbusinessId,SubBusinessName,count(*),0,0,0 from #TempTotal group by BusinessId,BusinessName,SubbusinessId,SubBusinessName

select CallId,Count(*)NoOfRecord,Convert(Date,CallIncomingDatetime) FeedbackDate,case when Count(*) = 6 then 'Complete' else 'InComplete' end FeedbackStatus
into #Fedbk from tbl_Feedback_CallDetails  with(nolock)
group by CallId,Convert(Date,CallIncomingDatetime)

update #FinalData set FeedbackOffered = (Select Count(distinct CallId) from #Fedbk)
update #FinalData set CompletedFeedback = (select count(FeedbackStatus) from #Fedbk where FeedbackStatus = 'Complete')
update #FinalData set InCompleteFeedback = (select count(FeedbackStatus) from  #Fedbk where FeedbackStatus = 'InComplete')

select * from #FinalData

select BusinessId,Businessname,SubBusinessId,SubBusinessName,A.Id as QID,QuestionText,Count(distinct B.CallId)FeedbackCount,sum(cast(UEC as int)),
cast(avg(cast(UEC as decimal)) as decimal(20,2))  FdAvg
--case when A.RangeType = 3 then cast(cast(Sum(cast(UEC as int)) as decimal(20,2))/2 as decimal(20,2)) else cast(cast(Sum(cast(UEC as int)) as decimal(20,2))/5 as decimal(20,2)) end as FdAvg
from tblmst_subbusinessmaster SB with(nolock)
join tblmst_Business BS with(nolock) on SB.BusinessId = BS.Id
join tbl_MST_Questionnaire A with(nolock) On A.SubBusinessId = SB.ID
join tbl_Feedback_CallDetails B with(nolock) on A.VDNNo+1 = B.Extensionno
join #Fedbk C On B.CallId = C.CallId
where C.FeedbackStatus = 'Complete'
group by BusinessId,Businessname,SubBusinessId,SubBusinessName,A.Id ,QuestionText,RangeType
order by Businessname

select BusinessId,Businessname,SubBusinessId,SubBusinessName,A.Id as QID,QuestionText,Count(uec)UEC,
case when A.RangeType = 1 and UEC >=3 then 'Positive' when A.RangeType = 2 and UEC >= 3 then 'Positive' when A.RangeType = 3 and UEC = 1 then 'Positive' else 'Negative' end as Stat
into #Temp1
from tblmst_subbusinessmaster SB with(nolock)
join tblmst_Business BS with(nolock) on SB.BusinessId = BS.Id
join tbl_MST_Questionnaire A with(nolock) On A.SubBusinessId = SB.ID
join tbl_Feedback_CallDetails B with(nolock) on A.VDNNo+1 = B.Extensionno
join #Fedbk C On B.CallId = C.CallId
where C.FeedbackStatus = 'Complete'
group by BusinessId,Businessname,SubBusinessId,SubBusinessName,A.RangeType ,A.Id,QuestionText,uec
order by Businessname


select BusinessId,BusinessName,SubBusinessId,SubBusinessName, QID,QuestionText,
sum(UEC)UEC,sum(case when Stat='Positive' then uec else 0 end)as Positive,
sum(case when  Stat='Negative' then uec else 0 end)as  Negative
from #temp1 group by BusinessId,BusinessName,SubBusinessId,SubBusinessName,QID,QuestionText

select BusinessId,BusinessName,SubBusinessId,SubBusinessName,A.ID as QID,Count(case when UEC = 1 then 1 else null end) as Rating1,
Count(case when UEC = 2 then 1 else null end) Rating2, Count(case when UEC = 3 then 1 else null end) Rating3,Count(case when UEC=4 then 1 else null end)Rating4,
Count(Case when UEC = 5 then 1 else null end)Rating5
from tblmst_subbusinessmaster SB with(nolock)
join tblmst_Business BS with(nolock) on SB.BusinessId = BS.Id
join tbl_MST_Questionnaire A with(nolock) On A.SubBusinessId = SB.ID
join tbl_Feedback_CallDetails B with(nolock) on A.VDNNo+1 = B.Extensionno
join #Fedbk C On B.CallId = C.CallId
where C.FeedbackStatus = 'Complete' 
group by BusinessId,Businessname,SubBusinessId,SubBusinessName,A.Id ,QuestionText
order by Businessname

select Bs.Id as BusinessId,BusinessName,SB.Id as SubbusinessId,SubBusinessName,DnisNo,
B.CallId,B.UEC,B.AgentId, agent.AgentName,B.LastVDN,QuestionText
into #tempTable
from [tblmst_PRIBusinessMappingMaster] PBM with(nolock)
join tblmst_subbusinessmaster SB with(nolock) on PBM.SubBusinessID =sb.id
join tblmst_Business BS with(nolock) on SB.BusinessId = BS.ID
join tbl_MST_Questionnaire A with(nolock) On A.SubBusinessId = SB.ID
join tbl_Feedback_CallDetails B with(nolock) on A.VDNNo+1 = B.Extensionno
join tbl_mst_AgentMaster agent with(nolock) on B.AgentId = agent.AgentID
join tbl_Call_AllIncomingCall TCal with(nolock) on B.CallId = TCal.CallId
group by Bs.Id,BusinessName,SB.Id,SubBusinessName,DnisNo,
B.CallId,B.UEC,B.AgentId, agent.AgentName,B.LastVDN ,QuestionText

select SubbusinessName,AgentName,Count(distinct CallId)TotalFeedback
,Count(case when LastVDN=4458 and UEC = 1 then 1 else null end) as Q1Rat1 
,Count(case when LastVDN=4458 and UEC = 2 then 1 else null end) as Q1Rat2
,Count(case when LastVDN=4458 and UEC = 3 then 1 else null end) as Q1Rat3
,Count(case when LastVDN=4458 and UEC = 4 then 1 else null end) as Q1Rat4
,Count(case when LastVDN=4458 and UEC = 5 then 1 else null end) as Q1Rat5 
,Count(case when LastVDN=4459 and UEC = 1 then 1 else null end) as Q2Rat1 
,Count(case when LastVDN=4459 and UEC = 2 then 1 else null end) as Q2Rat2
,Count(case when LastVDN=4459 and UEC = 3 then 1 else null end) as Q2Rat3
,Count(case when LastVDN=4459 and UEC = 4 then 1 else null end) as Q2Rat4
,Count(case when LastVDN=4459 and UEC = 5 then 1 else null end) as Q2Rat5 
,Count(case when LastVDN=4460 and UEC = 1 then 1 else null end) as Q3Rat1 
,Count(case when LastVDN=4460 and UEC = 2 then 1 else null end) as Q3Rat2
,Count(case when LastVDN=4460 and UEC = 3 then 1 else null end) as Q3Rat3
,Count(case when LastVDN=4460 and UEC = 4 then 1 else null end) as Q3Rat4
,Count(case when LastVDN=4460 and UEC = 5 then 1 else null end) as Q3Rat5 
,Count(case when LastVDN=4461 and UEC = 1 then 1 else null end) as Q4Rat1 
,Count(case when LastVDN=4461 and UEC = 2 then 1 else null end) as Q4Rat2
,Count(case when LastVDN=4461 and UEC = 3 then 1 else null end) as Q4Rat3
,Count(case when LastVDN=4461 and UEC = 4 then 1 else null end) as Q4Rat4
,Count(case when LastVDN=4461 and UEC = 5 then 1 else null end) as Q4Rat5 
,Count(case when LastVDN=4462 and UEC = 1 then 1 else null end) as Q5Rat1 
,Count(case when LastVDN=4462 and UEC = 2 then 1 else null end) as Q5Rat2 
,Count(case when LastVDN=0 and UEC = 1 then 1 else null end) as Q5Rat3
,Count(case when LastVDN=0 and UEC = 2 then 1 else null end) as Q5Rat4 
,Count(case when LastVDN=0 and UEC = 1 then 1 else null end) as Q5Rat5

from #tempTable where CallId not in (select CallID from tbl_Feedback_CallDetails group by callId having count(CallID) < 3)
group by SubbusinessName,AgentName


select @QuestionCount as QuestionCount


drop table #FinalData
drop table #TempTotal
drop table #temp1
drop table #Fedbk
drop table #tempTable

end











GO
/****** Object:  StoredProcedure [dbo].[usp_getuserdata]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_getuserdata]

	@user varchar(50) = 0,

	@pass  varchar(50)

AS

BEGIN



	SELECT top 1 id, userloginid, username ,useremail , usertype 

	from tblmst_user with(nolock) where userloginid= @user and userpass=@pass 



	SELECT top 1 isnull(B.businessname ,'Not Mapped')  businessname

	from 

	tblmst_user  U 

	JOIN tbl_UserType T with(nolock) ON U.usertype=T.ID

	LEFT JOIN tbltrn_userSBusinessMapping   M with(nolock) on U.Id=M.userID

	LEFT JOIN tblmst_subbusinessmaster S with(nolock) ON S.id =M.SubBusinessID 

	LEFT JOIN tblmst_business B with(nolock)   ON s.businessid = B.id 

	WHERE U.userloginid = @user and isBusinessDependent = 1



	END







GO
/****** Object:  StoredProcedure [dbo].[usp_updateuser]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[usp_updateuser]

(@userName varchar(100), @useremail varchar(100), @useractive varchar(10), @updatedby varchar(50), @userId int , @usertype varchar(20), @ERROR VARCHAR(100) OUT)

as
begin
Declare @userloginid varchar(100)
Declare @userPassword varchar(100)

IF exists(select 1 from [dbo].[tblmst_user] where username=@userName and id!=@userId )
BEGIN
set @ERROR = 'user name already exist in system please choose another name.'
return 
END

IF exists(select 1 from [dbo].[tblmst_user] where useremail=@useremail and id<>@userId)
BEGIN
set @ERROR = 'Email id already associated with another user in system please choose another email.'
return
END



update [dbo].[tblmst_user] set username=@userName,useremail=@useremail,insertby=@updatedby,insertdate=getdate(),active=cast(@useractive as int),usertype=cast(@usertype as int)
where id=@userId and @userId!=0



insert into tblmst_user(userloginid,username,useremail,userpass,active,insertby,insertdate,usertype)
select 'RCM', @userName ,@useremail ,'',1, @updatedby , getdate(),cast(@usertype as int) where @userId=0

IF scope_identity() < 10 
  BEGIN 
  set  @userloginid='RCM00' + cast (scope_identity() as varchar(10)) 
   
  END 
ELSE if scope_identity() < 100 
  BEGIN 
 set  @userloginid='RCM0' + cast (scope_identity() as varchar(10)) 

  END 
  ELSE if scope_identity() < 1000
  BEGIN 
 set  @userloginid='RCM' + cast (scope_identity() as varchar(10)) 
 
  END 
    ELSE if scope_identity() < 10000
  BEGIN 
 set  @userloginid='RCM' + cast (scope_identity() as varchar(10)) 
 
  END 
  ELSE
    BEGIN 
 set  @userloginid='RCM' 
 
  END 


update [dbo].[tblmst_user] set userloginid=@userloginid ,userpass =@userloginid+'@123'  where id=scope_identity()

IF scope_identity() != null
begin
set @ERROR = scope_identity()
return
end
else
begin

set @ERROR = scope_identity()
end






end







GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DNIS_TYPE]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DNIS_TYPE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [varchar](32) NOT NULL,
	[STATUS] [varchar](8) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OptionType] [nvarchar](max) NULL,
	[QuestionText] [nvarchar](max) NULL,
	[VDNNo] [nvarchar](max) NULL,
	[SubBusinessId] [nvarchar](max) NULL,
	[BusinessName] [nvarchar](max) NULL,
	[SubBusinessName] [nvarchar](max) NULL,
	[IsActive] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ModifyBy] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubBusinesses]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubBusinesses](
	[SubBusinessId] [nvarchar](128) NOT NULL,
	[SubBusinessName] [nvarchar](max) NOT NULL,
	[BusinessName] [nvarchar](max) NULL,
	[BusinessId] [nvarchar](max) NULL,
	[Checked] [nvarchar](max) NULL,
	[Question_Id] [int] NULL,
	[UserDetails_id] [int] NULL,
	[UserDetails_id1] [int] NULL,
 CONSTRAINT [PK_dbo.SubBusinesses] PRIMARY KEY CLUSTERED 
(
	[SubBusinessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Surveys]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surveys](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusinessName] [nvarchar](max) NULL,
	[SubBusinessName] [nvarchar](max) NULL,
	[SurveyId] [nvarchar](max) NULL,
	[SurveyType] [nvarchar](max) NULL,
	[BusinessId] [nvarchar](max) NULL,
	[SubBusinessId] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Surveys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Call_AllIncomingCall]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Call_AllIncomingCall](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallId] [varchar](50) NULL,
	[ExtensionNo] [varchar](50) NULL,
	[CallStatus] [char](10) NULL,
	[CallerMobile] [varchar](50) NULL,
	[CallIncomingDateTime] [datetime] NULL,
	[AgentID] [varchar](50) NULL,
	[UCID] [varchar](50) NULL,
	[UEC] [varchar](50) NULL,
	[LastVDN] [varchar](50) NULL,
	[CallEstablishedDatetime] [datetime] NULL,
	[CallEndDateTime] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Feedback_CallDetails]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[tbl_Feedback_CallDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CallId] [int] NOT NULL,
	[ExtensionNo] [varchar](20) NULL,
	[CallStatus] [nvarchar](max) NOT NULL,
	[CallerMobile] [nvarchar](max) NULL,
	[CallIncomingDateTime] [datetime] NOT NULL,
	[AgentId] [int] NULL,
	[IsAllocated] [char](4) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [UCID] [varchar](100) NULL
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [UEC] [nvarchar](250) NULL
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [CallType] [char](2) NULL
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [LastVDN] [varchar](20) NULL
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [CallerNumber] [varchar](50) NULL
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [CallEndDateTime] [datetime] NULL
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD [CallEstablishedDateTime] [datetime] NULL
 CONSTRAINT [PK_CallDiversions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_mst_AgentMaster]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_mst_AgentMaster](
	[AgentID] [int] NULL,
	[AgentName] [varchar](500) NULL,
	[SubBusinessId] [int] NULL,
	[isActive] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_MST_Questionnaire]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_MST_Questionnaire](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionText] [nvarchar](3000) NULL,
	[VDNNo] [varchar](50) NULL,
	[SubBusinessId] [int] NULL,
	[IsActive] [char](10) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyBy] [varchar](50) NULL,
	[RangeType] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_MST_Questionnaire] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_MST_Questionnairebkp]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_MST_Questionnairebkp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionText] [nvarchar](3000) NULL,
	[VDNNo] [varchar](50) NULL,
	[SubBusinessId] [int] NULL,
	[IsActive] [char](10) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyBy] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_MST_SurveyDetails]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_MST_SurveyDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [nvarchar](10) NULL,
	[SubBusinessId] [nvarchar](10) NULL,
	[BusinessId] [nvarchar](10) NULL,
	[SurveyType] [nvarchar](10) NULL,
 CONSTRAINT [PK_tbl_MST_SurveyDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_MST_VDN]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_MST_VDN](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[IsActive] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Agent_Exclusion]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Answer]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Answer](
	[AnswerId] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[TemplateId] [int] NULL,
	[QuestionId] [int] NULL,
	[AnswerDescription] [varchar](max) NULL,
	[Status] [varchar](1) NULL,
 CONSTRAINT [PK_SMS_Survey_Answers] PRIMARY KEY CLUSTERED 
(
	[AnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Application]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign_001_Log]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Campaign_Starter]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Credential]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Customer_Response]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Customer_Response_Question]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Feedback]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Feedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CampaignId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[Remarks] [varchar](200) NULL,
	[AgentId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedIpAddress] [int] NOT NULL,
	[Status] [varchar](1) NOT NULL,
 CONSTRAINT [PK_SMS_Survey_Feedbacks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Logger]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Questionaire]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Questionaire](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NULL,
	[User] [varchar](20) NULL,
	[Text] [varchar](max) NULL,
	[DisplayType] [varchar](20) NULL,
	[MultiSelect] [varchar](100) NULL,
	[EndOfSurvey] [bit] NULL,
	[EndOfSurveyMessage] [varchar](100) NULL,
	[ConditionalFilter] [varchar](100) NULL,
	[PresentationMode] [varchar](20) NULL,
	[IsRequired] [bit] NULL,
	[QuestionTags] [varchar](200) NULL,
	[Status] [varchar](1) NULL,
	[Sequence] [int] NULL,
	[SubBusinessId] [varchar](50) NULL,
 CONSTRAINT [PK_SMS_Survey_Questionaires] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SMS_Survey_Questionaire_Filter]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_SMS_Survey_Template]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_SMS_Survey_Template](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationId] [int] NULL,
	[ApplicationCode] [varchar](20) NULL,
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
	[SubBusinessId] [varchar](50) NULL,
 CONSTRAINT [PK_SMS_Survey_Templates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_UserType]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_UserType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [varchar](50) NULL,
	[isBusinessDependent] [bit] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_tbl_UserType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_WebApiToken]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tbl_WebApiUser]    Script Date: 05-08-2018 14:44 ******/
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
/****** Object:  Table [dbo].[tblmst_business]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_business](
	[id] [int] IDENTITY(10000,1) NOT NULL,
	[businessname] [nvarchar](max) NOT NULL,
	[Location] [nvarchar](max) NULL,
	[ContactPerson] [nvarchar](max) NULL,
	[AddressOfContact] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[CreatedDate] [nvarchar](max) NULL,
	[UpdateBy] [nvarchar](max) NULL,
	[UpdateDate] [nvarchar](max) NULL,
	[Status] [varchar](10) NULL,
	[ContactNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblmst_business] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_OptionFeedBack]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_OptionFeedBack](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Status] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_Optiontype]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_Optiontype](
	[Id] [int] NULL,
	[RangeName] [nvarchar](50) NULL,
	[Value] [nvarchar](50) NULL,
	[Status] [char](10) NULL,
	[FeedBackOption] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_PRIBusinessMappingMaster]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_PRIBusinessMappingMaster](
	[ID] [bigint] IDENTITY(500,1) NOT NULL,
	[RouterID] [int] NOT NULL,
	[PortNo] [nvarchar](50) NULL,
	[CircuitID] [nvarchar](50) NULL,
	[ServiceProviderName] [varchar](50) NULL,
	[TypeOfService] [varchar](50) NULL,
	[TFDIDNo] [nvarchar](50) NULL,
	[DNISNo] [nvarchar](50) NULL,
	[SubBusinessID] [int] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_routermaster]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_routermaster](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[routerip] [varchar](20) NOT NULL,
	[routeruser] [varchar](20) NOT NULL,
	[routerpass] [varchar](20) NOT NULL,
	[DataCenterLocation] [varchar](max) NULL,
	[RackNo] [char](10) NULL,
	[NoOfInterfaceCard] [int] NULL,
	[OEMName] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_SMSOptionType]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_SMSOptionType](
	[Id] [int] NULL,
	[DisplayType] [varchar](20) NOT NULL,
	[MultiSelect] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_subbusinessmaster]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblmst_subbusinessmaster](
	[id] [int] IDENTITY(50000,1) NOT NULL,
	[subbusinessname] [nvarchar](max) NOT NULL,
	[businessid] [int] NOT NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblmst_user]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblmst_user](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[userloginid] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[useremail] [nvarchar](50) NULL,
	[userpass] [nvarchar](50) NULL,
	[usertype] [int] NULL,
	[active] [int] NULL,
	[isadmin] [int] NULL,
	[insertby] [nvarchar](50) NULL,
	[insertdate] [datetime] NULL,
	[updateby] [nvarchar](50) NULL,
	[updatedate] [datetime] NULL,
 CONSTRAINT [PK_tblmst_user_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbltrn_UserBusinessMapping]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbltrn_UserBusinessMapping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NULL,
	[BusinessID] [varchar](50) NULL,
	[chActive] [char](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbltrn_userSBusinessMapping]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbltrn_userSBusinessMapping](
	[ID] [bigint] IDENTITY(500,1) NOT NULL,
	[userID] [int] NOT NULL,
	[SubBusinessID] [int] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 05-08-2018 14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetails](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[username] [nvarchar](max) NOT NULL,
	[userloginid] [nvarchar](max) NULL,
	[useremail] [nvarchar](max) NOT NULL,
	[useractive] [nvarchar](max) NULL,
	[usertype] [nvarchar](max) NOT NULL,
	[usertypeid] [int] NOT NULL,
	[BusinessID] [int] NOT NULL,
	[BusinessName] [nvarchar](max) NULL,
	[SubBusinessID] [int] NOT NULL,
	[Question_Id] [int] NULL,
 CONSTRAINT [PK_dbo.UserDetails] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201808010957502_InitialCreate', N'FEEDBACK.Models.SurveyModel', 0x1F8B0800000000000400ED5CDD6EE33616BE5FA0EF20E8AABB48AD2473D306768BC44E16416792D9713AD8BB80916887A84479252A8851F4C97AD147DA575852BF1449C9A4FEE22C8A010609457E3C3C3C7FE4E1C97FFFF873FED36BE05B2F308A518817F6D9ECD4B62076430FE1EDC24EC8E6BBEFED9F7EFCE66FF36B2F78B5BE16FD3EB07E74248E17F63321BB0BC789DD671880781620370AE37043666E1838C00B9DF3D3D31F9CB3330752089B6259D6FC4B82090A60FA0BFD75196217EE4802FC4FA107FD386FA75FD629AA75070218EF800B17F6CDF5F5EAEA72F9F32CEB6A5B973E02948C35F437B605300E092094C88B5F62B8265188B7EB1D6D00FEC37E0769BF0DF06398137F5175D75DC7E9395B87530D2CA0DC242661600878F621678C230EEFC45EBB641C65DD356531D9B355A7EC5BD8FF4A609C418B935D2CFD887594B83B2BC69C58C59793520AA8B0B07F27D632F14912C105860989807F627D4E9E7CE4FE0CF70FE1AF102F70E2FB3C699438FAADD6409B3E47E10E4664FF056E72826F3DDB72EAE31C7160398C1B932DE516930FE7B6754727074F3E2C779E5BF69A8411FC27C43002047A9F012130C20C03A6BC936617E6BADF3114365B31271538AA38B6F509BC7E84784B9E1736FDD1B66ED02BF48A969C8E5F30A27A460791288187A62AF6E101BE92D127FBBABABB0B479F659D3C5D2531C2308EAB4D1B6DB6622AF6DB944B9B64BEDBF8D225E865FC899611649AB2A2FF1573B19F1F105BA4A4695A5857FBD1A9A6B60C6DF683109D418D41F31D7841DBD42C350B938F62AAFD5FA09FF68B9FD12EF37BA5997E943ADF4461F025F4391322F6795C8749E432D684073A3E80680B893EE5490CA3C32457BD14B4161F9B892C7BA8A89B3B95176CF58DDC524DDC2337EC4D3CA460434D9DA5AE093E3BFF5E4BA40D956978336948C0A4467A4267B77C86EEAF70E879B4958946DED10A12807C3D65BAFA38E386BC8922A10EDA83260C3599953B3CDF610CFC267A96DAE8708B301A5FF6D95CF4A484FCB75926982610635391610E1E1D16C966EE2B8DA5395C0D833375606F4C776398047C3F7E6A8C9338CBF8C8F5AC62256507295E52F7328DE834E96C275283C216F20C42BAE805EE751D50D6FBAF6B8E23D2B089E663FB3E414C964D34C965D18491E69897384D9A7E19C7A18B52D1166EC7A4E36F9DF66BEC59BA67E16C21FC4195AE871A00B4A32A4F895AD8A7B3D999C41E8D290AA3C64D513B7DD667F987C8136EF5ED4C513B8E26720F78918AD65A706FC491761734253B0C7831362326E6827CEB72507EE52B98E17443BABCD1E3AFEEFA33FBB10C3145A1DEAF6689D31B1C457440A7CD038438374AE22A18E61A1281A394C8CA5C49EC91585107E1F61AAA806AB27000ABC63709A9F6F520558C516A7AB2D84A00E0B64166907C37C9753F748F29465106A6BC5C556DAF9C0E8885907288C2C689615C9D211ACC6A88F6654E69587703FBCEADA845400CACF9442CD2E38F117386E5CC746C51DCA7B7E897DAFC6B3A80EE1A25D97B3DF6B6B0A308124B235FBD1D70B2C703C52303A7E195C1FC13D8ED68BCCABD3AC85BAC75F6E460F9DDDA3C1D1F64188E1B2BB2F225B5E54CF48806B650F84AA7A694DEA028262B40C0136011F3D20BA46EBC4B6BB0E9C54CA2D79277ADB0F5C508F67336AAE975800852B1F086AE2AA0C7CC7481502138F2D0F4D507F041A438F22E433F0970D3B1B96D349FABE751F8767DB47A3A9EC7AB7FD147CC73EE3C54DEA48F211CC678ACD644511B66FD30CE43D6BF74A25206953EEAE35649F09A9494ADFA48B52C370F56FB608CC7B2C60AB42B298E6AC3E273D93C18DF6E8A261256B5CA487347D06CD17E389201114CB96891B4EC55DD5BF6B1597C286D6EB65A474FA9976369D1F0FADEB4F46EEB2E539B354D2A1A8F465EF960A68FB4B6E068486BEBE8260E2381B9726AB46D7491A8E4118A3633142C4960D56A8654A61E45B0F283195E9E5E14D1F266332CA0F0597CBB191A91E29BAAD51C49C5B2A2BD83FEAF1AF47F7534F18848A2F0E968AC4B7131D3CF0FA657385D5CA07AE03871FBFB893FAB4C521DB068354592CF2A7CFB5BF9DF3EB1CCD8DA52BF24501F78E55BC8C3C75B798C4158C8AE411A4E8F4D579632E3B414AB8455719FF1AEA4A30789F9C58D2689DDA5A595DE65883D9466356E6396F82EB3899AEC10EF938CA5A9E19A562B8EE307F493A3D63B5DCD1D127D3C8FA9F2F38672D47A4BFC0E84A89D1D83CA9199100D2F4123888F9403EC253FEF5C78E484685FE9515CF96B38B3AAB3C171B1CD4588F98163725F62C2A1A3581B5BC2F13D9494F810BB94D156990011121DF33CE970B8E652CA42645D6C8B2EFF05796906621F1318CC5887D9FA3FFED24734BEAB3A7C02186DE86AB39772F6F9E9D9B950B9793C55944E1C7BBE2269A32AA5AC6FDA04CFFD102E14B7ED419FE11B5AB99011BF80C87D06D1B70178FD3B8FD7B558B11760AD20B11792F2BD5A2F44D56BC5A1481C0C532C10EC05A62802F4E8CF649022C05E94C9857E9D09130BFD0CE8EA5474D6C1908C51FC552C532EFF1AA6B6AB918D9DDFFA0FA2BC03D902A1EE6A1023FA28D87EE9C1DA2DF6E0EBC2FE2D1D7761DDFEFB911B7A62DD47D4FD5E58A7D6EFA61488671F3322EAA387A3E3AC1F2167FA9474AA77EBA0C7FD6ACF460908EAE566E9143D8BCDFA29BEA280AC9772494562FDC903C33958B1B8AB3F71F582AD2EFB29973DF541192358EA47D9D4E6D6B48CE9FFE3A0F12E8265B1246800B0C18E5603072C7D8F431394E80C516F507B3EDFA9C482C251C5A24E03B33F25B50C714C2280E40CD6E7086117ED802FAE42BE78D25158C6E11252FCB2823B8899262A56A933DD810BB7125E302187F8304589D24085386F2717EDEF7A7462C45145E370166862E9F84B348E533494199E0964C3BC8E6D083FD241CCDEA11F3115C0A9FD88BAAA4FAE941077515DB7D75AB697E53916B6F7C4AE9FB328A8B1E4A5ADAAEF504D9F6AA2F60AA11E657FAAC9CCEB025BCA02D5ABC98B098FA8665059CAD45AC9A4D85229EDFE3EAA003B95B64DBFFCE12BFC8E78E1A3D5F0990B7A07860D53A52727A5A9ABE0FE5C30755731DA56102CD58EA15B7312659F5BBC090B872550547411F33E746D1EF5209711411BE012FAD9A59B9BFE3D8BAFC04F6897EBE0097AB7F83E21BB84D025C3E0C9AFD5CA309FD7367F5A8A58A7799EA560E3219640C9442CEF758FAF12E47B25DD37F20D4D130473A6F9B50FDB4BC2AE7FB6FB12E92EC49A4039FBCA18E001063B9F82C5F7780DD875A9396D54023FC22D70F7C5DB826690C31B5167FB7C85C03602419C6354E3E9AF5486BDE0F5C7FF01FA959791355B0000, N'6.2.0-61023')
SET IDENTITY_INSERT [dbo].[tbl_Call_AllIncomingCall] ON 

INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (1, N'83', N'1002', N'A         ', N'9871194303', CAST(0x0000A90B00000000 AS DateTime), N'1002', N'00000000000000000000', N'1', N'4443', NULL, NULL)
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (2, N'100', N'1001', N'A         ', N'9650370856', CAST(0x0000A90B00000000 AS DateTime), N'1001', N'00000000000000000000', N'1', N'4443', NULL, NULL)
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (3, N'202', N'1001', N'A         ', N'9899774432', CAST(0x0000A90B00000000 AS DateTime), N'1001', N'00000000000000000000', N'1', N'4443', NULL, NULL)
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (4, N'102', N'1002', N'A         ', N'9891323256', CAST(0x0000A90C00000000 AS DateTime), N'1002', N'', N'1', N'4443', NULL, NULL)
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (5, N'93', N'1001', N'A         ', N'9695594202', CAST(0x0000A90B00FA791C AS DateTime), N'1001', N'00000000000000000000', N'', N'4443', NULL, NULL)
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (6, N'142', N'1001', N'A         ', N'9695594202', CAST(0x0000A90B00FA91F7 AS DateTime), N'1001', N'00000000000000000000', N'', N'4443', NULL, NULL)
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (7, N'83', N'4458', N'A         ', N'1001', CAST(0x0000A90C00FFEE30 AS DateTime), N'1002', N'00000000000000000000', N'1', N'4443', CAST(0x0000A90C00FFEE30 AS DateTime), CAST(0x0000A90C0102AD50 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (13, N'89', N'4458', N'A         ', N'1001', CAST(0x0000A90C0100B6E5 AS DateTime), N'1001', N'00000000000000000000', N'1', N'4443', CAST(0x0000A90C0100B6E5 AS DateTime), CAST(0x0000A90C01037605 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (14, N'504', N'4458', N'A         ', N'1001', CAST(0x0000A9150126EA38 AS DateTime), N'1002', N'00000000000000000000', N'1', N'4443', CAST(0x0000A9150126EA38 AS DateTime), CAST(0x0000A9150129A958 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (15, N'76', N'4458', N'A         ', N'1001', CAST(0x0000A9150150A38E AS DateTime), N'1001', N'00000000000000000000', N'1', N'4443', CAST(0x0000A9150150A38E AS DateTime), CAST(0x0000A915015362AE AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (16, N'593', N'4458', N'A         ', N'1001', CAST(0x0000A91700E0D274 AS DateTime), N'1002', N'00000000000000000000', N'1', N'4443', CAST(0x0000A91700E0D274 AS DateTime), CAST(0x0000A91700E39194 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (17, N'139', N'4458', N'A         ', N'1001', CAST(0x0000A9190106B959 AS DateTime), N'1001', N'00000000000000000000', N'1', N'4443', CAST(0x0000A9190106B959 AS DateTime), CAST(0x0000A91901097879 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (18, N'146', N'4458', N'A         ', N'1001', CAST(0x0000A91901079F43 AS DateTime), N'1002', N'00000000000000000000', N'1', N'4443', CAST(0x0000A91901079F43 AS DateTime), CAST(0x0000A919010A5E63 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (19, N'151', N'4458', N'A         ', N'1001', CAST(0x0000A919010813D5 AS DateTime), N'1001', N'00000000000000000000', N'1', N'4443', CAST(0x0000A919010813D5 AS DateTime), CAST(0x0000A919010AD2F5 AS DateTime))
INSERT [dbo].[tbl_Call_AllIncomingCall] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentID], [UCID], [UEC], [LastVDN], [CallEstablishedDatetime], [CallEndDateTime]) VALUES (20, N'417', N'4458', N'A         ', N'1001', CAST(0x0000A919012EB336 AS DateTime), N'1002', N'00000000000000000000', N'1', N'4443', CAST(0x0000A919012EB336 AS DateTime), CAST(0x0000A91901317256 AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_Call_AllIncomingCall] OFF
SET IDENTITY_INSERT [dbo].[tbl_Feedback_CallDetails] ON 

INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (2, 83, N'4458', N'A', N'1001', CAST(0x0000A90B00EBF8BB AS DateTime), 1002, NULL, CAST(0x0000A90B00EBF8BB AS DateTime), N'00000000000000000000', N'1', N'I ', N'4457', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (3, 83, N'4459', N'A', N'1001', CAST(0x0000A90B00EC0159 AS DateTime), 1002, NULL, CAST(0x0000A90B00EC0159 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (4, 83, N'4460', N'A', N'1001', CAST(0x0000A90B00EC0BD8 AS DateTime), 1002, NULL, CAST(0x0000A90B00EC0BD8 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (5, 83, N'4461', N'A', N'1001', CAST(0x0000A90B00EC1521 AS DateTime), 1002, NULL, CAST(0x0000A90B00EC1521 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (6, 83, N'4462', N'A', N'1001', CAST(0x0000A90B00EC1D0F AS DateTime), 1002, NULL, CAST(0x0000A90B00EC1D0F AS DateTime), N'00000000000000000000', N'5', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (7, 83, N'4463', N'A', N'1001', CAST(0x0000A90B00EC252A AS DateTime), 1002, NULL, CAST(0x0000A90B00EC252A AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (8, 93, N'4458', N'A', N'1001', CAST(0x0000A90B00ED6116 AS DateTime), 1001, NULL, CAST(0x0000A90B00ED6116 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (9, 93, N'4459', N'A', N'1001', CAST(0x0000A90B00ED6B9B AS DateTime), 1001, NULL, CAST(0x0000A90B00ED6B9B AS DateTime), N'00000000000000000000', N'3', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (10, 93, N'4460', N'A', N'1001', CAST(0x0000A90B00ED7357 AS DateTime), 1001, NULL, CAST(0x0000A90B00ED7357 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (11, 93, N'4461', N'A', N'1001', CAST(0x0000A90B00ED78AC AS DateTime), 1001, NULL, CAST(0x0000A90B00ED78AC AS DateTime), N'00000000000000000000', N'5', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (12, 93, N'4462', N'A', N'1001', CAST(0x0000A90B00ED7EC6 AS DateTime), 1001, NULL, CAST(0x0000A90B00ED7EC6 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (13, 93, N'4463', N'A', N'1001', CAST(0x0000A90B00ED8493 AS DateTime), 1001, NULL, CAST(0x0000A90B00ED8493 AS DateTime), N'00000000000000000000', N'2', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (14, 100, N'4458', N'A', N'1001', CAST(0x0000A90B00EE158D AS DateTime), 1001, NULL, CAST(0x0000A90B00EE158D AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (15, 100, N'4459', N'A', N'1001', CAST(0x0000A90B00EE1D54 AS DateTime), 1001, NULL, CAST(0x0000A90B00EE1D54 AS DateTime), N'00000000000000000000', N'2', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (16, 100, N'4460', N'A', N'1001', CAST(0x0000A90B00EE23AB AS DateTime), 1001, NULL, CAST(0x0000A90B00EE23AB AS DateTime), N'00000000000000000000', N'1', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (17, 100, N'4461', N'A', N'1001', CAST(0x0000A90B00EE27E9 AS DateTime), 1001, NULL, CAST(0x0000A90B00EE27E9 AS DateTime), N'00000000000000000000', N'3', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (18, 100, N'4462', N'A', N'1001', CAST(0x0000A90B00EE2D79 AS DateTime), 1001, NULL, CAST(0x0000A90B00EE2D79 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (19, 100, N'4463', N'A', N'1001', CAST(0x0000A90B00EE311A AS DateTime), 1001, NULL, CAST(0x0000A90B00EE311A AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (20, 142, N'4458', N'C', N'1001', CAST(0x0000A90B00F403DF AS DateTime), 1001, NULL, CAST(0x0000A90B00F403DF AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (21, 202, N'4458', N'A', N'1001', CAST(0x0000A90B00FC8A08 AS DateTime), 1001, NULL, CAST(0x0000A90B00FC8A08 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (22, 202, N'4459', N'A', N'1001', CAST(0x0000A90B00FC9575 AS DateTime), 1001, NULL, CAST(0x0000A90B00FC9575 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (23, 202, N'4460', N'A', N'1001', CAST(0x0000A90B00FC9D6F AS DateTime), 1001, NULL, CAST(0x0000A90B00FC9D6F AS DateTime), N'00000000000000000000', N'3', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (24, 202, N'4461', N'A', N'1001', CAST(0x0000A90B00FCA600 AS DateTime), 1001, NULL, CAST(0x0000A90B00FCA600 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (25, 202, N'4462', N'A', N'1001', CAST(0x0000A90B00FCAE6E AS DateTime), 1001, NULL, CAST(0x0000A90B00FCAE6E AS DateTime), N'00000000000000000000', N'3', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (26, 202, N'4463', N'A', N'1001', CAST(0x0000A90B00FCB688 AS DateTime), 1001, NULL, CAST(0x0000A90B00FCB688 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (27, 89, N'4458', N'C', N'1001', CAST(0x0000A90C0100B6E5 AS DateTime), 1001, NULL, CAST(0x0000A90C0100B6E5 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (28, 89, N'4459', N'C', N'1001', CAST(0x0000A90C0100BB17 AS DateTime), 1002, NULL, CAST(0x0000A90C0100BB17 AS DateTime), N'00000000000000000000', N'3', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (29, 504, N'4458', N'A', N'1001', CAST(0x0000A9150126EA38 AS DateTime), 1002, NULL, CAST(0x0000A9150126EA38 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (30, 504, N'4459', N'A', N'1001', CAST(0x0000A9150126F5BB AS DateTime), 1001, NULL, CAST(0x0000A9150126F5BB AS DateTime), N'00000000000000000000', N'5', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (31, 504, N'4460', N'A', N'1001', CAST(0x0000A9150126FB31 AS DateTime), 1001, NULL, CAST(0x0000A9150126FB31 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (32, 504, N'4461', N'A', N'1001', CAST(0x0000A915012703DE AS DateTime), 1001, NULL, CAST(0x0000A915012703DE AS DateTime), N'00000000000000000000', N'4', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (33, 504, N'4462', N'A', N'1001', CAST(0x0000A91501270BCA AS DateTime), 1001, NULL, CAST(0x0000A91501270BCA AS DateTime), N'00000000000000000000', N'4', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (34, 504, N'4463', N'A', N'1001', CAST(0x0000A91501271C0C AS DateTime), 1001, NULL, CAST(0x0000A91501271C0C AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (35, 76, N'4458', N'A', N'1001', CAST(0x0000A9150150A399 AS DateTime), 1001, NULL, CAST(0x0000A9150150A399 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (36, 76, N'4459', N'A', N'1001', CAST(0x0000A9150150ABEB AS DateTime), 1002, NULL, CAST(0x0000A9150150ABEB AS DateTime), N'00000000000000000000', N'4', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (37, 76, N'4460', N'A', N'1001', CAST(0x0000A9150150B440 AS DateTime), 1002, NULL, CAST(0x0000A9150150B440 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (38, 76, N'4461', N'A', N'1001', CAST(0x0000A9150150BA79 AS DateTime), 1002, NULL, CAST(0x0000A9150150BA79 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (39, 76, N'4462', N'A', N'1001', CAST(0x0000A9150150BE94 AS DateTime), 1002, NULL, CAST(0x0000A9150150BE94 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (40, 76, N'4463', N'A', N'1001', CAST(0x0000A9150150C480 AS DateTime), 1002, NULL, CAST(0x0000A9150150C480 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (41, 593, N'4458', N'A', N'1001', CAST(0x0000A91700E0D275 AS DateTime), 1002, NULL, CAST(0x0000A91700E0D275 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (42, 593, N'4459', N'A', N'1001', CAST(0x0000A91700E0DD48 AS DateTime), 1001, NULL, CAST(0x0000A91700E0DD48 AS DateTime), N'00000000000000000000', N'4', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (43, 593, N'4460', N'A', N'1001', CAST(0x0000A91700E0E738 AS DateTime), 1001, NULL, CAST(0x0000A91700E0E738 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (44, 593, N'4461', N'A', N'1001', CAST(0x0000A91700E0EF0D AS DateTime), 1001, NULL, CAST(0x0000A91700E0EF0D AS DateTime), N'00000000000000000000', N'4', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (45, 593, N'4462', N'A', N'1001', CAST(0x0000A91700E0F4A0 AS DateTime), 1001, NULL, CAST(0x0000A91700E0F4A0 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (46, 593, N'4463', N'A', N'1001', CAST(0x0000A91700E100F3 AS DateTime), 1001, NULL, CAST(0x0000A91700E100F3 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (47, 139, N'4458', N'A', N'1001', CAST(0x0000A9190106B959 AS DateTime), 1001, NULL, CAST(0x0000A9190106B959 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (48, 139, N'4459', N'A', N'1001', CAST(0x0000A9190106BF24 AS DateTime), 1002, NULL, CAST(0x0000A9190106BF24 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (49, 139, N'4460', N'A', N'1001', CAST(0x0000A9190106CA4F AS DateTime), 1002, NULL, CAST(0x0000A9190106CA4F AS DateTime), N'00000000000000000000', N'2', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (50, 139, N'4461', N'A', N'1001', CAST(0x0000A9190106D434 AS DateTime), 1002, NULL, CAST(0x0000A9190106D434 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (51, 139, N'4462', N'A', N'1001', CAST(0x0000A9190106DA7B AS DateTime), 1002, NULL, CAST(0x0000A9190106DA7B AS DateTime), N'00000000000000000000', N'2', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (52, 139, N'4463', N'A', N'1001', CAST(0x0000A9190106E204 AS DateTime), 1002, NULL, CAST(0x0000A9190106E204 AS DateTime), N'00000000000000000000', N'2', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (53, 146, N'4458', N'A', N'1001', CAST(0x0000A91901079F43 AS DateTime), 1002, NULL, CAST(0x0000A91901079F43 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (54, 146, N'4459', N'A', N'1001', CAST(0x0000A9190107A71A AS DateTime), 1001, NULL, CAST(0x0000A9190107A71A AS DateTime), N'00000000000000000000', N'3', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (55, 146, N'4460', N'A', N'1001', CAST(0x0000A9190107B0F4 AS DateTime), 1001, NULL, CAST(0x0000A9190107B0F4 AS DateTime), N'00000000000000000000', N'2', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (56, 146, N'4461', N'A', N'1001', CAST(0x0000A9190107B8C8 AS DateTime), 1001, NULL, CAST(0x0000A9190107B8C8 AS DateTime), N'00000000000000000000', N'2', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (57, 146, N'4462', N'A', N'1001', CAST(0x0000A9190107BD49 AS DateTime), 1001, NULL, CAST(0x0000A9190107BD49 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (58, 146, N'4463', N'A', N'1001', CAST(0x0000A9190107C145 AS DateTime), 1001, NULL, CAST(0x0000A9190107C145 AS DateTime), N'00000000000000000000', N'2', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (59, 151, N'4458', N'A', N'1001', CAST(0x0000A919010813D5 AS DateTime), 1001, NULL, CAST(0x0000A919010813D5 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (60, 151, N'4459', N'A', N'1001', CAST(0x0000A91901081A8E AS DateTime), 1002, NULL, CAST(0x0000A91901081A8E AS DateTime), N'00000000000000000000', N'1', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (61, 151, N'4460', N'A', N'1001', CAST(0x0000A91901081DCF AS DateTime), 1002, NULL, CAST(0x0000A91901081DCF AS DateTime), N'00000000000000000000', N'3', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (62, 151, N'4461', N'A', N'1001', CAST(0x0000A91901082565 AS DateTime), 1002, NULL, CAST(0x0000A91901082565 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (63, 151, N'4462', N'A', N'1001', CAST(0x0000A91901082F7F AS DateTime), 1002, NULL, CAST(0x0000A91901082F7F AS DateTime), N'00000000000000000000', N'2', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (64, 151, N'4463', N'A', N'1001', CAST(0x0000A9190108332A AS DateTime), 1002, NULL, CAST(0x0000A9190108332A AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (65, 417, N'4458', N'A', N'1001', CAST(0x0000A919012EB336 AS DateTime), 1002, NULL, CAST(0x0000A919012EB336 AS DateTime), N'00000000000000000000', N'1', N'I ', N'', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (66, 417, N'4459', N'A', N'1001', CAST(0x0000A919012EBA84 AS DateTime), 1001, NULL, CAST(0x0000A919012EBA84 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4458', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (67, 417, N'4460', N'A', N'1001', CAST(0x0000A919012EBEC2 AS DateTime), 1001, NULL, CAST(0x0000A919012EBEC2 AS DateTime), N'00000000000000000000', N'3', N'I ', N'4459', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (68, 417, N'4461', N'A', N'1001', CAST(0x0000A919012EC42E AS DateTime), 1001, NULL, CAST(0x0000A919012EC42E AS DateTime), N'00000000000000000000', N'3', N'I ', N'4460', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (69, 417, N'4462', N'A', N'1001', CAST(0x0000A919012EC880 AS DateTime), 1001, NULL, CAST(0x0000A919012EC880 AS DateTime), N'00000000000000000000', N'5', N'I ', N'4461', N'1001', NULL, NULL)
INSERT [dbo].[tbl_Feedback_CallDetails] ([Id], [CallId], [ExtensionNo], [CallStatus], [CallerMobile], [CallIncomingDateTime], [AgentId], [IsAllocated], [CreatedOn], [UCID], [UEC], [CallType], [LastVDN], [CallerNumber], [CallEndDateTime], [CallEstablishedDateTime]) VALUES (70, 417, N'4463', N'A', N'1001', CAST(0x0000A919012ECD03 AS DateTime), 1001, NULL, CAST(0x0000A919012ECD03 AS DateTime), N'00000000000000000000', N'1', N'I ', N'4462', N'1001', NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Feedback_CallDetails] OFF
INSERT [dbo].[tbl_mst_AgentMaster] ([AgentID], [AgentName], [SubBusinessId], [isActive]) VALUES (1001, N'Gaurav Verma', 50000, 1)
INSERT [dbo].[tbl_mst_AgentMaster] ([AgentID], [AgentName], [SubBusinessId], [isActive]) VALUES (1002, N'Vikas Singh', 50000, 1)
SET IDENTITY_INSERT [dbo].[tbl_MST_Questionnaire] ON 

INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1178, N'How you rate the agents knowledge to understand your concern.Rate on Scale of 1-5', N'4458', 50000, N'1         ', CAST(0x0000A90D00DB21B4 AS DateTime), N'1', CAST(0x0000A90D00DB21B4 AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1179, N'Was the agent courtous and polite.Rate on Scale of 1-5', N'4459', 50000, N'1         ', CAST(0x0000A90D00CC214F AS DateTime), N'1', CAST(0x0000A90D00CC214F AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1180, N'have your concern resolved in timely manner.Rate on Scale of 1-5', N'4460', 50000, N'1         ', CAST(0x0000A90B00F49F0D AS DateTime), N'1', CAST(0x0000A90B00F49F0D AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1223, N'how is your overall experience with our product and service.Rate on Scale of 1-5', N'4461', 50000, N'1         ', CAST(0x0000A90B00F4BD0D AS DateTime), N'1', CAST(0x0000A90B00F4BD0D AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1225, N'Would you recommend our product and services to your friends and colleagues.Press 1 for Yes Press 2 for No', N'4462', 50000, N'0         ', CAST(0x0000A90B00F526E1 AS DateTime), N'1', CAST(0x0000A90B00F526E1 AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1257, N'Welcome', N'1', 50001, N'1         ', CAST(0x0000A92300DDB1E8 AS DateTime), N'1', CAST(0x0000A92300DDB1E8 AS DateTime), N'1', N'0')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1258, N'Question1', N'4', 50001, N'1         ', CAST(0x0000A92300DDB1E8 AS DateTime), N'1', CAST(0x0000A92300DDB1E8 AS DateTime), N'1', N'2')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1259, N'ThankYou', N'6', 50001, N'1         ', CAST(0x0000A92300DDB1E8 AS DateTime), N'1', CAST(0x0000A92300DDB1E8 AS DateTime), N'1', N'0')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1260, N'Welcome', N'1455', 50002, N'1         ', CAST(0x0000A92300ED2F88 AS DateTime), N'1', CAST(0x0000A92300ED2F88 AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1261, N'How you rate the agents knowledge to understand your concern.Rate on Scale of 1-5', N'454', 50002, N'1         ', CAST(0x0000A92300ED2F88 AS DateTime), N'1', CAST(0x0000A92300ED2F88 AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (1262, N'ThankYoufdg 123', N'6445', 50002, N'1         ', CAST(0x0000A92300ED2F88 AS DateTime), N'1', CAST(0x0000A92300ED2F88 AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (2266, N'efsdf', N'4', 50003, N'1         ', CAST(0x0000A92E01239AC8 AS DateTime), N'1', CAST(0x0000A92E01239AC8 AS DateTime), N'1', N'0')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (2267, N'sdfsd', N'4', 50003, N'1         ', CAST(0x0000A92E01239F78 AS DateTime), N'1', CAST(0x0000A92E01239F78 AS DateTime), N'1', N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (2268, N'dsfsdf', N'4', 50003, N'1         ', CAST(0x0000A92E0123A1D0 AS DateTime), N'1', CAST(0x0000A92E0123A1D0 AS DateTime), N'1', N'0')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (2274, N'efsdf', N'4', NULL, NULL, NULL, NULL, NULL, NULL, N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (2275, N'sdfsd', N'4', NULL, NULL, NULL, NULL, NULL, NULL, N'1')
INSERT [dbo].[tbl_MST_Questionnaire] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy], [RangeType]) VALUES (2276, N'dsfsdf', N'4', NULL, NULL, NULL, NULL, NULL, NULL, N'1')
SET IDENTITY_INSERT [dbo].[tbl_MST_Questionnaire] OFF
SET IDENTITY_INSERT [dbo].[tbl_MST_Questionnairebkp] ON 

INSERT [dbo].[tbl_MST_Questionnairebkp] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy]) VALUES (26, N'How you rate the agents knowledge to understand your concern.Rate on Scale of 1-5', N'4458', 50000, N'1         ', CAST(0x0000A90D00DB21B4 AS DateTime), NULL, CAST(0x0000A90D00DB21B4 AS DateTime), NULL)
INSERT [dbo].[tbl_MST_Questionnairebkp] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy]) VALUES (27, N'Was the agent courtous and polite.Rate on Scale of 1-5', N'4459', 50000, N'1         ', CAST(0x0000A90D00CC214F AS DateTime), NULL, CAST(0x0000A90D00CC214F AS DateTime), NULL)
INSERT [dbo].[tbl_MST_Questionnairebkp] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy]) VALUES (28, N'have your concern resolved in timely manner.Rate on Scale of 1-5', N'4460', 50000, N'1         ', CAST(0x0000A90B00F49F0D AS DateTime), N'1', CAST(0x0000A90B00F49F0D AS DateTime), N'1')
INSERT [dbo].[tbl_MST_Questionnairebkp] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy]) VALUES (29, N'how is your overall experience with our product and service.Rate on Scale of 1-5', N'4461', 50000, N'1         ', CAST(0x0000A90B00F4BD0D AS DateTime), N'1', CAST(0x0000A90B00F4BD0D AS DateTime), N'1')
INSERT [dbo].[tbl_MST_Questionnairebkp] ([Id], [QuestionText], [VDNNo], [SubBusinessId], [IsActive], [CreatedDate], [CreatedBy], [ModifyDate], [ModifyBy]) VALUES (30, N'Would you recommend our product and services to your friends and colleagues.Press 1 for Yes Press 2 for No', N'4462', 50000, N'1         ', CAST(0x0000A90B00F526E1 AS DateTime), N'1', CAST(0x0000A90B00F526E1 AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[tbl_MST_Questionnairebkp] OFF
SET IDENTITY_INSERT [dbo].[tbl_MST_SurveyDetails] ON 

INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (1, N'S001', N'50000', N'10000', N'Telephony')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (14, N'S0014', N'50001', N'10001', N'Telephony')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (15, N'S0015', N'50002', N'10005', N'SMS')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (16, N'S0016', N'50001', N'10001', N'SMS')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (17, N'S0017', N'50002', N'10005', N'Telephony')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (18, N'S0018', N'50003', N'10006', N'Telephony')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (19, N'S0019', N'50003', N'10006', N'SMS')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (1018, N'S001018', N'50000', N'10000', N'SMS')
INSERT [dbo].[tbl_MST_SurveyDetails] ([Id], [SurveyId], [SubBusinessId], [BusinessId], [SurveyType]) VALUES (1019, N'S001019', N'51003', N'11006', N'SMS')
SET IDENTITY_INSERT [dbo].[tbl_MST_SurveyDetails] OFF
SET IDENTITY_INSERT [dbo].[tbl_MST_VDN] ON 

INSERT [dbo].[tbl_MST_VDN] ([Id], [Code], [IsActive]) VALUES (2, N'4458', N'1         ')
INSERT [dbo].[tbl_MST_VDN] ([Id], [Code], [IsActive]) VALUES (3, N'4459', N'1         ')
INSERT [dbo].[tbl_MST_VDN] ([Id], [Code], [IsActive]) VALUES (4, N'4460', N'1         ')
INSERT [dbo].[tbl_MST_VDN] ([Id], [Code], [IsActive]) VALUES (5, N'4461', N'1         ')
INSERT [dbo].[tbl_MST_VDN] ([Id], [Code], [IsActive]) VALUES (6, N'4462', N'1         ')
INSERT [dbo].[tbl_MST_VDN] ([Id], [Code], [IsActive]) VALUES (7, N'4463', N'1         ')
SET IDENTITY_INSERT [dbo].[tbl_MST_VDN] OFF
SET IDENTITY_INSERT [dbo].[tbl_SMS_Survey_Questionaire] ON 

INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (1, 2, N'Simcomm', N'How you rate your Interaction with the customer executive.', N'1', N'1', 0, N'Thanks for the feedback.', NULL, NULL, 1, N'NPS', N'A', 1, NULL)
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (2, 2, N'Simcomm', N'Have your concern resolved successfully and in timely manner.', N'1', N'1', 0, N'Thanks for the feedback.', NULL, NULL, 1, N'NPS', N'A', 2, NULL)
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (3, 2, N'Simcomm', N'How you rate your overall experience with Simcomm product and services.', N'1', N'1', 0, N'Thanks for the feedback.', NULL, NULL, 1, NULL, N'A', 3, NULL)
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (4, 2, N'Simcomm', N'Would your recommend our product and services to your friend and colleagues', N'1', N'1', 0, N'Thanks for your valuable feedback', NULL, NULL, 1, NULL, N'A', 4, NULL)
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (38, NULL, N'dbo', N'How you rate your Interaction with the customer executive.', N'5', N'', 0, N'ThankYou', N'', N'', 1, N'', N'A', 0, N'50002')
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (39, NULL, N'dbo', N'Would your recommend our product and services to your friend and colleagues', N'4', N'', 0, N'ThankYou', N'', N'', 1, N'', N'A', 0, N'50001')
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (40, NULL, N'dbo', N'How was your experience with Samsung services ', N'5', N'', 0, N'ThankYou', N'', N'', 1, N'', N'A', 0, N'50003')
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (1046, NULL, N'dbo', N'n', N'4', N'', 0, N'nm', N'', N'', 1, N'', N'A', 0, N'50000')
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (1047, NULL, N'dbo', N'nm', N'4', N'', 0, N'nm', N'', N'', 1, N'', N'A', 0, N'50000')
INSERT [dbo].[tbl_SMS_Survey_Questionaire] ([Id], [TemplateId], [User], [Text], [DisplayType], [MultiSelect], [EndOfSurvey], [EndOfSurveyMessage], [ConditionalFilter], [PresentationMode], [IsRequired], [QuestionTags], [Status], [Sequence], [SubBusinessId]) VALUES (1049, NULL, N'dbo', N'Question1', N'4', N'', 0, N'ThankYou', N'', N'', 1, N'', N'A', 0, N'51003')
SET IDENTITY_INSERT [dbo].[tbl_SMS_Survey_Questionaire] OFF
SET IDENTITY_INSERT [dbo].[tbl_SMS_Survey_Template] ON 

INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (1, 1, N'IGT_CUST_VOICE', N'/Images/IndiGo-logo.jpg', NULL, N'IndiGo', N'IN', N'#38469C', N'#38469C', N'#FFFFFF', N'Thank you for calling IndiGo, you just interacted with <AGENT_NAME>. We would love to know about your experience. Click on below link to share your feedback ', NULL, NULL, NULL, N'IndiGo-XXXX', N'Enrol now in IndiGo', 0, NULL, N'A', NULL)
INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (2, 2, N'SIM_CUST_VOICE', N'/Images/Simcomm-logo.jpg', NULL, N'Simcomm', N'IN', N'#33ACFF', N'#33ACFF', N'#FFFFFF', N'Thank you for calling Simcomm, you just interacted with <AGENT_NAME>. We would love to know about your experience. Click on below link to share your feedback.', NULL, NULL, NULL, NULL, N'Enrol now in Simcomm', 0, NULL, N'A', NULL)
INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Welcome', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'50002')
INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Welcome', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'50001')
INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Welcome', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'50003')
INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (1014, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Welcome', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'50000')
INSERT [dbo].[tbl_SMS_Survey_Template] ([Id], [ApplicationId], [ApplicationCode], [LogoURL], [BackgroundURL], [BrandName], [BrandCountry], [ColorCode1], [ColorCode2], [ColorCode3], [WelcomeText], [WelcomeImage], [ThankyouText], [ThankyouImage], [PartialResponseId], [SurveyMessage], [SkipWelcome], [CreatedOn], [Status], [SubBusinessId]) VALUES (1015, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Welcome', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'51003')
SET IDENTITY_INSERT [dbo].[tbl_SMS_Survey_Template] OFF
SET IDENTITY_INSERT [dbo].[tbl_UserType] ON 

INSERT [dbo].[tbl_UserType] ([ID], [UserType], [isBusinessDependent], [Status]) VALUES (1, N'Admin', 1, 0)
INSERT [dbo].[tbl_UserType] ([ID], [UserType], [isBusinessDependent], [Status]) VALUES (2, N'Business', 0, 1)
SET IDENTITY_INSERT [dbo].[tbl_UserType] OFF
SET IDENTITY_INSERT [dbo].[tblmst_business] ON 

INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10000, N'Avaya', N'NOIDA', N'VIVEK', N'NOIDA', N'1', N'Jun 26 2018  2:46PM', N'', N'Jul 30 2018  5:05PM', N'1', N'9871194303')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10001, N'Nokia', N'Noida', N'Mohit', N'Noida', N'1', N'Jul  2 2018  3:33PM', NULL, NULL, N'1', N'9871198711')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10002, N'Nokia', N'Noida', N'Mohit', N'Noida', N'1', N'Jul  2 2018  3:33PM', NULL, NULL, N'1', N'9871198711')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10003, N'Nokia', N'Noida', N'Mohit', N'Noida', N'1', N'Jul  2 2018  3:34PM', NULL, NULL, N'1', N'9871198711')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10004, N'Nokia', N'Noida', N'Mohit', N'Noida', N'1', N'Jul  2 2018  3:50PM', NULL, NULL, N'1', N'9871198711')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10005, N'Digital NPS Manager-India', N'Noida', N'sushil', N'india', N'1', N'Jul  2 2018  3:59PM', N'', N'Jul 12 2018 12:41PM', N'1', N'4434433434')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (10006, N'Samsung', N'Noida', N'Mohit', N'Noida', N'1', N'Jul 23 2018 11:23AM', NULL, NULL, N'1', N'9871198711')
INSERT [dbo].[tblmst_business] ([id], [businessname], [Location], [ContactPerson], [AddressOfContact], [CreatedBy], [CreatedDate], [UpdateBy], [UpdateDate], [Status], [ContactNumber]) VALUES (11006, N'LG', N'Noida', N'Mohit', N'Noida', N'1', N'Jul 30 2018 10:52AM', NULL, NULL, N'1', N'9871198711')
SET IDENTITY_INSERT [dbo].[tblmst_business] OFF
SET IDENTITY_INSERT [dbo].[tblmst_OptionFeedBack] ON 

INSERT [dbo].[tblmst_OptionFeedBack] ([Id], [Name], [Status]) VALUES (1, N'Telephony Feedback', N'1         ')
INSERT [dbo].[tblmst_OptionFeedBack] ([Id], [Name], [Status]) VALUES (2, N'FeedBack By SMS', N'1         ')
SET IDENTITY_INSERT [dbo].[tblmst_OptionFeedBack] OFF
INSERT [dbo].[tblmst_Optiontype] ([Id], [RangeName], [Value], [Status], [FeedBackOption]) VALUES (1, N'Range', N'1 to 5 1-Lowest,5-Highest', N'1         ', N'1')
INSERT [dbo].[tblmst_Optiontype] ([Id], [RangeName], [Value], [Status], [FeedBackOption]) VALUES (2, N'Range', N'1 to 3 1-Lowest,3-Highest', N'1         ', N'1')
INSERT [dbo].[tblmst_Optiontype] ([Id], [RangeName], [Value], [Status], [FeedBackOption]) VALUES (3, N'Yes/No', N'1-Yes,2-No', N'1         ', N'1')
INSERT [dbo].[tblmst_Optiontype] ([Id], [RangeName], [Value], [Status], [FeedBackOption]) VALUES (4, N'Smile-3', N'Good', N'1         ', N'2')
INSERT [dbo].[tblmst_Optiontype] ([Id], [RangeName], [Value], [Status], [FeedBackOption]) VALUES (5, N'Select', N'Yes|No', N'1         ', N'2')
SET IDENTITY_INSERT [dbo].[tblmst_PRIBusinessMappingMaster] ON 

INSERT [dbo].[tblmst_PRIBusinessMappingMaster] ([ID], [RouterID], [PortNo], [CircuitID], [ServiceProviderName], [TypeOfService], [TFDIDNo], [DNISNo], [SubBusinessID], [CreatedBy], [CreatedDate]) VALUES (500, 0, N'0', N'0', N'', N'0', N'1234', N'4443', 50000, N'1', CAST(0x0000A90C00F6B707 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblmst_PRIBusinessMappingMaster] OFF
INSERT [dbo].[tblmst_SMSOptionType] ([Id], [DisplayType], [MultiSelect]) VALUES (1, N'Smile-3', N'Good')
INSERT [dbo].[tblmst_SMSOptionType] ([Id], [DisplayType], [MultiSelect]) VALUES (2, N'Select', N'Yes|No')
SET IDENTITY_INSERT [dbo].[tblmst_subbusinessmaster] ON 

INSERT [dbo].[tblmst_subbusinessmaster] ([id], [subbusinessname], [businessid], [CreatedBy], [CreatedDate]) VALUES (50000, N'Simcomm', 10000, N'1', CAST(0x0000A90B00F3A98E AS DateTime))
INSERT [dbo].[tblmst_subbusinessmaster] ([id], [subbusinessname], [businessid], [CreatedBy], [CreatedDate]) VALUES (50001, N'NokiaLumia', 10001, N'1', CAST(0x0000A9110114F249 AS DateTime))
INSERT [dbo].[tblmst_subbusinessmaster] ([id], [subbusinessname], [businessid], [CreatedBy], [CreatedDate]) VALUES (50002, N'Digital', 10005, N'1', CAST(0x0000A91A0130A5A6 AS DateTime))
INSERT [dbo].[tblmst_subbusinessmaster] ([id], [subbusinessname], [businessid], [CreatedBy], [CreatedDate]) VALUES (50003, N'LCD', 10006, N'1', CAST(0x0000A92600BBC1CE AS DateTime))
INSERT [dbo].[tblmst_subbusinessmaster] ([id], [subbusinessname], [businessid], [CreatedBy], [CreatedDate]) VALUES (51003, N'LG LCD', 11006, N'1', CAST(0x0000A92D00B349D5 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblmst_subbusinessmaster] OFF
SET IDENTITY_INSERT [dbo].[tblmst_user] ON 

INSERT [dbo].[tblmst_user] ([Id], [userloginid], [username], [useremail], [userpass], [usertype], [active], [isadmin], [insertby], [insertdate], [updateby], [updatedate]) VALUES (1, N'1', N'Admin', N'admin@gmail.com', N'1', 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblmst_user] ([Id], [userloginid], [username], [useremail], [userpass], [usertype], [active], [isadmin], [insertby], [insertdate], [updateby], [updatedate]) VALUES (2, N'RCM002', N'Munna', N'munna@gmail.com', N'RCM002@123', 2, 1, 0, N'1', CAST(0x0000A90C00F148A1 AS DateTime), NULL, NULL)
INSERT [dbo].[tblmst_user] ([Id], [userloginid], [username], [useremail], [userpass], [usertype], [active], [isadmin], [insertby], [insertdate], [updateby], [updatedate]) VALUES (3, N'RCM003', N'Mahesh', N'mahesh@gmail.com', N'RCM003@123', 2, 1, 0, N'1', CAST(0x0000A90C00F395B9 AS DateTime), NULL, NULL)
INSERT [dbo].[tblmst_user] ([Id], [userloginid], [username], [useremail], [userpass], [usertype], [active], [isadmin], [insertby], [insertdate], [updateby], [updatedate]) VALUES (4, N'RCM004', N'Vivek', N'vivek@sim.com', N'RCM004@123', 2, 1, 0, N'1', CAST(0x0000A91B00D1C1CF AS DateTime), NULL, NULL)
INSERT [dbo].[tblmst_user] ([Id], [userloginid], [username], [useremail], [userpass], [usertype], [active], [isadmin], [insertby], [insertdate], [updateby], [updatedate]) VALUES (5, N'RCM005', N'vikas', N'vikas@gmail.com', N'RCM005@123', 2, 1, 0, N'1', CAST(0x0000A92D01165B40 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblmst_user] OFF
SET IDENTITY_INSERT [dbo].[tbltrn_UserBusinessMapping] ON 

INSERT [dbo].[tbltrn_UserBusinessMapping] ([id], [UserID], [BusinessID], [chActive]) VALUES (1, N'1', N'50000', N'1         ')
SET IDENTITY_INSERT [dbo].[tbltrn_UserBusinessMapping] OFF
/****** Object:  Index [IX_Question_Id]    Script Date: 05-08-2018 14:44 ******/
CREATE NONCLUSTERED INDEX [IX_Question_Id] ON [dbo].[SubBusinesses]
(
	[Question_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserDetails_id]    Script Date: 05-08-2018 14:44 ******/
CREATE NONCLUSTERED INDEX [IX_UserDetails_id] ON [dbo].[SubBusinesses]
(
	[UserDetails_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserDetails_id1]    Script Date: 05-08-2018 14:44 ******/
CREATE NONCLUSTERED INDEX [IX_UserDetails_id1] ON [dbo].[SubBusinesses]
(
	[UserDetails_id1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Question_Id]    Script Date: 05-08-2018 14:44 ******/
CREATE NONCLUSTERED INDEX [IX_Question_Id] ON [dbo].[UserDetails]
(
	[Question_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD  DEFAULT (getdate()) FOR [CallIncomingDateTime]
GO
ALTER TABLE [dbo].[tbl_Feedback_CallDetails] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[tbl_MST_Questionnaire] ADD  CONSTRAINT [DF_tbl_MST_Questionnaire_IsActive_1]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_MST_Questionnaire] ADD  CONSTRAINT [DF_tbl_MST_Questionnaire_CreatedDate_1]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_MST_Questionnaire] ADD  CONSTRAINT [DF_tbl_MST_Questionnaire_ModifyDate]  DEFAULT (getdate()) FOR [ModifyDate]
GO
ALTER TABLE [dbo].[tbl_MST_Questionnairebkp] ADD  CONSTRAINT [DF_tbl_MST_Questionnaire_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_MST_Questionnairebkp] ADD  CONSTRAINT [DF_tbl_MST_Questionnaire_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tbl_MST_VDN] ADD  CONSTRAINT [DF_tbl_MST_VDN_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[tbl_SMS_Survey_Logger] ADD  CONSTRAINT [df_tbl_SMS_Survey_Logger_loggedondate]  DEFAULT (getdate()) FOR [LoggedOnDate]
GO
ALTER TABLE [dbo].[tblmst_OptionFeedBack] ADD  CONSTRAINT [DF_tblmst_OptionFeedBack_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[tblmst_user] ADD  CONSTRAINT [DF_tblmst_user_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[tblmst_user] ADD  CONSTRAINT [DF_tblmst_user_isadmin]  DEFAULT ((0)) FOR [isadmin]
GO
ALTER TABLE [dbo].[SubBusinesses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SubBusinesses_dbo.Questions_Question_Id] FOREIGN KEY([Question_Id])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[SubBusinesses] CHECK CONSTRAINT [FK_dbo.SubBusinesses_dbo.Questions_Question_Id]
GO
ALTER TABLE [dbo].[SubBusinesses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SubBusinesses_dbo.UserDetails_UserDetails_id] FOREIGN KEY([UserDetails_id])
REFERENCES [dbo].[UserDetails] ([id])
GO
ALTER TABLE [dbo].[SubBusinesses] CHECK CONSTRAINT [FK_dbo.SubBusinesses_dbo.UserDetails_UserDetails_id]
GO
ALTER TABLE [dbo].[SubBusinesses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SubBusinesses_dbo.UserDetails_UserDetails_id1] FOREIGN KEY([UserDetails_id1])
REFERENCES [dbo].[UserDetails] ([id])
GO
ALTER TABLE [dbo].[SubBusinesses] CHECK CONSTRAINT [FK_dbo.SubBusinesses_dbo.UserDetails_UserDetails_id1]
GO
ALTER TABLE [dbo].[UserDetails]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserDetails_dbo.Questions_Question_Id] FOREIGN KEY([Question_Id])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[UserDetails] CHECK CONSTRAINT [FK_dbo.UserDetails_dbo.Questions_Question_Id]
GO
USE [master]
GO
ALTER DATABASE [Simcomm_Feedback] SET  READ_WRITE 
GO
