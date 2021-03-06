-- SQL Manager Lite for SQL Server 4.3.0.47914
-- ---------------------------------------
-- Host      : DESKTOP-TMMTBSI\SQLEXPRESS
-- Database  : Organizer
-- Version   : Microsoft SQL Server 2016 (SP1) (KB3182545) 13.0.4001.0


CREATE DATABASE Organizer
ON PRIMARY
  ( NAME = Organizer,
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Organizer.mdf',
    SIZE = 8 MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 64 MB )
LOG ON
  ( NAME = Organizer_log,
    FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Organizer_log.ldf',
    SIZE = 8 MB,
    MAXSIZE = 2097152 MB,
    FILEGROWTH = 64 MB )
COLLATE Ukrainian_CI_AS
GO

USE Organizer
GO

--
-- Definition for table UsersGroups : 
--

CREATE TABLE dbo.UsersGroups (
  GroupID int IDENTITY(0, 1) NOT NULL,
  GroupName varchar(100) COLLATE Ukrainian_CI_AS NOT NULL,
  CONSTRAINT UsersGroups_pk PRIMARY KEY CLUSTERED (GroupID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table Users : 
--

CREATE TABLE dbo.Users (
  UserID int IDENTITY(0, 1) NOT NULL,
  UserName varchar(100) COLLATE Ukrainian_CI_AS NOT NULL,
  GroupID int NOT NULL,
  IsAdmin bit CONSTRAINT DefasAdmin DEFAULT 0 NULL,
  CONSTRAINT Users_pk PRIMARY KEY CLUSTERED (UserID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table Issues : 
--

CREATE TABLE dbo.Issues (
  IssueID int IDENTITY(1, 1) NOT NULL,
  IssueName varchar(50) COLLATE Ukrainian_CI_AS NOT NULL,
  IssueDescription varchar(300) COLLATE Ukrainian_CI_AS NOT NULL,
  UserID int NOT NULL,
  PRIMARY KEY CLUSTERED (IssueID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table Tickets : 
--

CREATE TABLE dbo.Tickets (
  TicketID int IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
  TicketName varchar(50) COLLATE Ukrainian_CI_AS NOT NULL,
  IssueID int NOT NULL,
  SprintTime datetime NULL,
  GroupID int NOT NULL,
  TicketDescription varchar(300) COLLATE Ukrainian_CI_AS NULL,
  CONSTRAINT Tickets_pk PRIMARY KEY CLUSTERED (TicketID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table ChildTickets : 
--

CREATE TABLE dbo.ChildTickets (
  ChildTicketID int IDENTITY(1, 1) NOT NULL,
  TicketID int NOT NULL,
  SprintTime datetime NULL,
  TicketDescription varchar(300) COLLATE Ukrainian_CI_AS NOT NULL,
  PRIMARY KEY CLUSTERED (ChildTicketID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table Assign : 
--

CREATE TABLE dbo.Assign (
  ChildTicketID int NOT NULL,
  UserID int NOT NULL,
  AssignID int IDENTITY(1, 1) NOT NULL,
  CONSTRAINT Assign_pk PRIMARY KEY CLUSTERED (AssignID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table ProblemStatus : 
--

CREATE TABLE dbo.ProblemStatus (
  StatusID int IDENTITY(1, 1) NOT NULL,
  StatusName varchar(30) COLLATE Ukrainian_CI_AS NOT NULL,
  PRIMARY KEY CLUSTERED (StatusID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table IssueStatusStory : 
--

CREATE TABLE dbo.IssueStatusStory (
  StoryID int IDENTITY(1, 1) NOT NULL,
  UserID int NOT NULL,
  IssueID int NOT NULL,
  StatusID int NOT NULL,
  Comments varchar(150) COLLATE Ukrainian_CI_AS NULL,
  CONSTRAINT IssueStatusStory_pk PRIMARY KEY CLUSTERED (StoryID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table TeamLeads : 
--

CREATE TABLE dbo.TeamLeads (
  UserId int NOT NULL,
  CONSTRAINT GroupsTeamLeads_pk PRIMARY KEY CLUSTERED (UserId)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table TicketStatus : 
--

CREATE TABLE dbo.TicketStatus (
  TStatusID int IDENTITY(1, 1) NOT NULL,
  TStatusName varchar(30) COLLATE Ukrainian_CI_AS NOT NULL,
  PRIMARY KEY CLUSTERED (TStatusID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table TicketStatusStory : 
--

CREATE TABLE dbo.TicketStatusStory (
  UserID int NOT NULL,
  TicketID int NOT NULL,
  StatusID int NOT NULL,
  Comments varchar(150) COLLATE Ukrainian_CI_AS NULL,
  StoryID int IDENTITY(1, 1) NOT NULL,
  CONSTRAINT StatusStory_pk PRIMARY KEY CLUSTERED (StoryID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table UserReports : 
--

CREATE TABLE dbo.UserReports (
  UserID int NOT NULL,
  ChieldTicketID int NOT NULL,
  Report varchar(200) COLLATE Ukrainian_CI_AS NULL,
  ReportID int IDENTITY(1, 1) NOT NULL,
  CONSTRAINT UserReports_pk PRIMARY KEY CLUSTERED (ReportID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for stored procedure AssignChieldTicket : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Assign User for Chield Ticket*/
CREATE PROCEDURE dbo.AssignChieldTicket
@ChildTicketID int,
@UserID int --User, who is assigned for Chield Ticket
AS
BEGIN
  	Insert into Assign
    (
		ChildTicketID,
		UserID		
    )
    values
    (
		@ChildTicketID,
		@UserID
    )
END
GO

--
-- Definition for stored procedure ChieldTicketsDelete : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Delete chield ticket*/
CREATE PROCEDURE dbo.ChieldTicketsDelete
@ChieldTicketID int-- Chield ticket for delete
AS
BEGIN
  delete from ChieldTickets_tr_SprintDate
  	where ChildTickets.ChildTicketID = @ChieldTicketID
END
GO

--
-- Definition for stored procedure ChildTicketInsert : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Create new chield ticket for parent*/
CREATE PROCEDURE dbo.ChildTicketInsert
@TicketID int, -- ParentTicketID
@TicketDescription Varchar(300) -- ChieldticketDescription
AS
BEGIN
	Insert into ChildTickets
    (
    	TicketID,
        TicketDescription		
    )
    values
    (
    	@TicketID,
        @TicketDescription
    )
END
GO

--
-- Definition for stored procedure IssuesInsert : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Insert new Isuue*/
CREATE PROCEDURE dbo.IssuesInsert
	@IssueName Varchar(50),
	@IssueDescription Varchar(300),
	@UserID int--User, who is autor of issue
AS
BEGIN
	Insert into Issues (IssueName, IssueDescription, UserID)
		values(@IssueName, @IssueDescription, @UserID)
END
GO

--
-- Definition for stored procedure IssuesUpdate : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.IssuesUpdate
@IssueID int,
@IssueName varchar (50),
@IssueDescription varchar(300),
@UserID int,
@StatusID int
AS
BEGIN
    Update Issues 
    	set IssueName = @IssueName,
        IssueDescription = @IssueDescription ,
		UserID = @UserID,
		StatusID = @StatusID 
    where IssueID = @IssueID
END
GO

--
-- Definition for stored procedure ProblemStatusDel : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Delete problem status*/
CREATE PROCEDURE dbo.ProblemStatusDel
@StatusID int --Status ID for delete
AS
BEGIN
  Delete from ProblemStatus
     where StatusID = @StatusID
END
GO

--
-- Definition for stored procedure ProblemStatusIns : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Insert new kind of Problem Status*/
CREATE PROCEDURE dbo.ProblemStatusIns
@StatusName varchar(30) --new issue StatusName
AS
BEGIN
	Insert into ProblemStatus (StatusName) values (@StatusName) 
END
GO

--
-- Definition for stored procedure ProblemStatusUpd : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Edit kind of Issue Status*/
CREATE PROCEDURE dbo.ProblemStatusUpd
@StatusID int, --Status ID for edit Name
@StatusName Varchar (30) --New StatusName
AS
BEGIN
  Update ProblemStatus
  	Set StatusName = @StatusName
     where StatusID = @StatusID
END
GO

--
-- Definition for stored procedure SelectAllIssues : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.SelectAllIssues
AS
BEGIN
	Select Issues.IssueID
    , Issues.IssueName
    , Issues.IssueDescription
    , Users.UserName
    from Issues, Users
    where Users.UserID = Issues.UserID
END
GO

--
-- Definition for stored procedure SetChTicketSprintTime : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Set Sprint time for chield ticket*/
CREATE PROCEDURE dbo.SetChTicketSprintTime
@ChildTicketID int,  
@SprintTime Datetime
AS
BEGIN
  Update ChildTickets set SprintTime = @SprintTime
  	where ChildTickets.ChildTicketID = @ChildTicketID
END
GO

--
-- Definition for stored procedure SetIssueStatus : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*User insert's new status for set current*/
CREATE PROCEDURE dbo.SetIssueStatus
@UserID int, --User, who changed the status
@IssueID int, --Issue, which status is changed
@StatusID int, --Status Id from -ProblemStatus-
@Comments varchar(150) 
AS
BEGIN
  Insert into IssueStatusStory
  (
	UserID,
	IssuEID,
	StatusID,
	Comments    
  )
  VALUES
  (
  	@UserID,
	@IssuEID,
	@StatusID,
	@Comments
  )
  
  
  
END
GO

--
-- Definition for stored procedure SetTeamLead : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Set new team lead from group*/
CREATE PROCEDURE dbo.SetTeamLead
@UserID int -- New TeamLead
AS
BEGIN
  Insert into TeamLeads (UserID) values (@UserID)
END
GO

--
-- Definition for stored procedure SetTicketSprintTime : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Set Sprint time for ticket*/
CREATE PROCEDURE dbo.SetTicketSprintTime
@TicketID int, --TicketID for setting time 
@SprintTime Datetime --New SprintTime
AS
BEGIN
  Update Tickets set SprintTime = @SprintTime
  	where Tickets.TicketID = @TicketID
END
GO

--
-- Definition for stored procedure TicketIns : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*Insert new group ticket*/
CREATE PROCEDURE dbo.TicketIns
@TicketName Varchar(50),  -- TicketName
@IssueID int, --PromlemID from ProblemStatus
@GroupID int, --Assigned group for this ticket 
@TicketDescription Varchar(300) -- TicketDescription
AS
BEGIN
	Insert into Tickets
    (
    	TicketName,
		IssueID,
		GroupID,
		TicketDescription
    )
    values
    (
    	@TicketName,
		@IssueID,
		@GroupID,
		@TicketDescription
    )
end
GO

--
-- Definition for stored procedure UsersSelectAll : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.UsersSelectAll 
	
AS
BEGIN
	Select UserID, UserName from Users
END
GO

--
-- Definition for indices : 
--

ALTER TABLE dbo.UsersGroups
ADD CONSTRAINT UsersGroups_uq 
UNIQUE NONCLUSTERED (GroupName)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Users_idx ON dbo.Users
  (UserName)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Issues_idx ON dbo.Issues
  (UserID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.Issues
ADD CONSTRAINT Issues_uq 
UNIQUE NONCLUSTERED (IssueName)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.Issues
ADD CONSTRAINT Issues_uq2 
UNIQUE NONCLUSTERED (IssueDescription)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Tickets_idx ON dbo.Tickets
  (IssueID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Tickets_idx2 ON dbo.Tickets
  (SprintTime)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Tickets_idx3 ON dbo.Tickets
  (GroupID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Tickets_idx4 ON dbo.Tickets
  (IssueID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Tickets_idx5 ON dbo.Tickets
  (SprintTime)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Tickets_idx6 ON dbo.Tickets
  (GroupID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_uq 
UNIQUE NONCLUSTERED (TicketName)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX ChildTickets_idx ON dbo.ChildTickets
  (TicketID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX ChildTickets_idx2 ON dbo.ChildTickets
  (SprintTime)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Assign_idx ON dbo.Assign
  (ChildTicketID, UserID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX Assign_idx_Ticket ON dbo.Assign
  (ChildTicketID, UserID)
WITH (
  PAD_INDEX = OFF,
  DROP_EXISTING = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  SORT_IN_TEMPDB = OFF,
  ONLINE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.Assign
ADD CONSTRAINT Assign_uq 
UNIQUE NONCLUSTERED (ChildTicketID, UserID)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.ProblemStatus
ADD CONSTRAINT ProblemStatus_uq 
UNIQUE NONCLUSTERED (StatusName)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.TicketStatus
ADD UNIQUE NONCLUSTERED (TStatusName)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE dbo.UserReports
ADD CONSTRAINT UserReports_uq 
UNIQUE NONCLUSTERED (UserID, ChieldTicketID)
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

--
-- Definition for foreign keys : 
--

ALTER TABLE dbo.Users
ADD CONSTRAINT Users_fk_GroupID FOREIGN KEY (GroupID) 
  REFERENCES dbo.UsersGroups (GroupID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Issues
ADD CONSTRAINT Issues_fk_UserID FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_fk_GroupID FOREIGN KEY (GroupID) 
  REFERENCES dbo.UsersGroups (GroupID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_fk2_IssueID FOREIGN KEY (IssueID) 
  REFERENCES dbo.Issues (IssueID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.ChildTickets
ADD CONSTRAINT ChieldTickets_fk_TicketID FOREIGN KEY (TicketID) 
  REFERENCES dbo.Tickets (TicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Assign
ADD CONSTRAINT Assign_fk_ChieldTicket FOREIGN KEY (ChildTicketID) 
  REFERENCES dbo.ChildTickets (ChildTicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Assign
ADD CONSTRAINT Assign_fk_UserID FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.IssueStatusStory
ADD CONSTRAINT IssueStatusStory_fk_IssueID FOREIGN KEY (IssueID) 
  REFERENCES dbo.Issues (IssueID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.IssueStatusStory
ADD CONSTRAINT IssueStatusStory_fk_Status FOREIGN KEY (StatusID) 
  REFERENCES dbo.ProblemStatus (StatusID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.IssueStatusStory
ADD CONSTRAINT IssueStatusStory_fk_Users FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.TeamLeads
ADD CONSTRAINT GroupsTeamLeads_fk_UserID FOREIGN KEY (UserId) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.TicketStatusStory
ADD CONSTRAINT StatusStory_fk_Tickets FOREIGN KEY (TicketID) 
  REFERENCES dbo.ChildTickets (ChildTicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.TicketStatusStory
ADD CONSTRAINT StatusStory_fk_TStatus FOREIGN KEY (StatusID) 
  REFERENCES dbo.TicketStatus (TStatusID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.TicketStatusStory
ADD CONSTRAINT StatusStory_fk_Users FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.UserReports
ADD CONSTRAINT UserReports_fk_UserID FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.UserReports
ADD CONSTRAINT UserReports_fk2_TicketID FOREIGN KEY (ChieldTicketID) 
  REFERENCES dbo.ChildTickets (ChildTicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

--
-- Definition for triggers : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.Tickets_tr_SringChieldTime ON dbo.Tickets
WITH EXECUTE AS CALLER
INSTEAD OF UPDATE
AS
BEGIN
	/*Check Sprint time of child tickets before update*/
    if ((select Max(ChildTickets.SprintTime) 
    			from ChildTickets where TicketID = (Select TicketID from Inserted))
                	> (Select SprintTime from Inserted))
	Begin
    	THROW 60500, 'Your can''t set SpringTime less then for children tickets', 1; 
    End else begin 
    	Update Tickets Set SprintTime = (Select SprintTime from Inserted)
        where  Tickets.TicketID = (Select TicketID from Inserted)
    end  
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.Tickets_tr_Update ON dbo.Tickets
WITH EXECUTE AS CALLER
INSTEAD OF INSERT
AS
BEGIN
  BEGIN
	/*Check Sprint time of child tickets before update*/
    if ((select Max(ChildTickets.SprintTime) 
    			from ChildTickets where TicketID = (Select TicketID from Inserted))
                	> (Select SprintTime from Inserted))
	Begin
    	THROW 60500, 'Your can''t set SpringTime less then for children tickets', 1; 
    End else begin 
    	insert into Tickets Select TicketName, IssueID, SprintTime, GroupID, TicketDescription from Inserted
    end  
END
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.ChieldTickets_tr_SprintDate ON dbo.ChildTickets
WITH EXECUTE AS CALLER
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	/*Check if chield sprint date more then parent*/
    if ( (select SprintTime from INSERTED)>=
    	(select SprintTime from Tickets where TicketID = (select TicketID from INSERTED)))
    Begin
    	/*Throw exception if Yes*/
    	THROW 60100, 'Chield ticket Sprint date is too late!', 1; 
    End else Begin
    	/*Insert new data if No*/
    	insert into ChildTickets (TicketID, SprintTime, TicketDescription) 
        	Select TicketID, SprintTime, TicketDescription from Inserted 
    End   
  
  
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.Assign_tr_UpdDel ON dbo.Assign
WITH EXECUTE AS CALLER
INSTEAD OF UPDATE, DELETE
AS
BEGIN
  BEGIN
	THROW 60900, 'You can''t Update or delete Assign. Only insert.', 1; 
END
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.Assign_tri_UserGroup ON dbo.Assign
WITH EXECUTE AS CALLER
INSTEAD OF INSERT
AS
BEGIN
	/*Check is User from parent ticket''s group */
	IF((Select Users.GroupID from Users
	where Users.UserID = (Select UserID from Inserted)) in
		(select Tickets.GroupID from Tickets
		where Tickets.TicketID in 
		(Select ChildTickets.TicketID
		from ChildTickets Where ChildTickets.ChildTicketID 
        =(Select TicketID from Inserted))))
Begin
	/*Insert if Yes*/
	Insert Into Assign (ChildTicketID, UserID)
    select ChildTicketID, UserID from Inserted
End else begin
	/*Exception if No*/
	THROW 60200, 'User is not from parent ticket''s group ', 1; 
end

END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.IssueStatusStory_tr_Ins ON dbo.IssueStatusStory
WITH EXECUTE AS CALLER
INSTEAD OF INSERT
AS
BEGIN
declare 
@UserID_ int,
@IssueID_ int           
Set @IssueID_ = (select IssueID from Inserted)
	/*Check for existing ticket with SprintTime for this issue*/
	if exists (Select Tickets.IssueID from Tickets
    	where Tickets.IssueID = @IssueID_
            	and Tickets.SprintTime is not null )
        BEGIN
        	/*Throw exception if exists*/
        	THROW 60400, 'You can''t change status after sprint time is set in ticket.  ', 1; 
        end  else begin
        	/*Insert if No*/
        	Insert into  IssueStatusStory select UserID ,IssueID, StatusID, Comments from inserted
        end 
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.IssueStatusStory_tr_Upd ON dbo.IssueStatusStory
WITH EXECUTE AS CALLER
INSTEAD OF UPDATE, DELETE
AS
BEGIN
	THROW 60600, 'You can''t Update or delete status. Only insert.', 1; 
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.TeamLeads_triu ON dbo.TeamLeads
WITH EXECUTE AS CALLER
INSTEAD OF INSERT, UPDATE
AS
BEGIN  
/*Delete existing teamlead for this group*/                    
	delete from TeamLeads where UserID in  
    	(Select Users.UserID from Users
			where Users.GroupID = 
				(select Users.GroupID from Users
               		where Users.UserID = (Select UserID from Inserted)))     
    /*Insert new teamlead when nobody teamlead for this group*/
    insert into TeamLeads (UserID) 
    Select UserID from Inserted 

END
GO

