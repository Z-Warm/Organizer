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
  IsTeamLeads bit NULL,
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
  TeamLead int NULL,
  CONSTRAINT Users_pk PRIMARY KEY CLUSTERED (UserID)
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
-- Definition for table Issues : 
--

CREATE TABLE dbo.Issues (
  IssueID int IDENTITY(1, 1) NOT NULL,
  IssueName varchar(50) COLLATE Ukrainian_CI_AS NOT NULL,
  IssueDescription varchar(150) COLLATE Ukrainian_CI_AS NULL,
  UserID int NOT NULL,
  StatusID int NOT NULL,
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
  SprintTime datetime NOT NULL,
  GroupID int NOT NULL,
  ParentTicket int NOT NULL,
  StatusID int NOT NULL,
  CodeReview bit CONSTRAINT Rewiew_Default DEFAULT 0 NOT NULL,
  CONSTRAINT Tickets_pk PRIMARY KEY CLUSTERED (TicketID)
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
  TicketID int NOT NULL,
  UserID int NOT NULL,
  Comments varchar(100) COLLATE Ukrainian_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table StatusStory : 
--

CREATE TABLE dbo.StatusStory (
  UserID int IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
  TicketID int NOT NULL,
  StatusID int NOT NULL,
  Comments varchar(150) COLLATE Ukrainian_CI_AS NULL,
  StoryID int NOT NULL,
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
  TicketID int NOT NULL,
  Report varchar(200) COLLATE Ukrainian_CI_AS NULL,
  Approve bit CONSTRAINT Approve_0 DEFAULT 0 NOT NULL,
  ReportID int IDENTITY(1, 1) NOT NULL,
  CONSTRAINT UserReports_pk PRIMARY KEY CLUSTERED (ReportID)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for stored procedure Select_All_Users : 
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
CREATE PROCEDURE dbo.Select_All_Users 
	
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

ALTER TABLE dbo.Assign
ADD CONSTRAINT Assign_uq 
UNIQUE NONCLUSTERED (TicketID, UserID)
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
UNIQUE NONCLUSTERED (UserID, TicketID)
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
ADD CONSTRAINT Users_fk FOREIGN KEY (GroupID) 
  REFERENCES dbo.UsersGroups (GroupID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Users
ADD CONSTRAINT Users_fk2 FOREIGN KEY (TeamLead) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Issues
ADD CONSTRAINT Issues_fk FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Issues
ADD CONSTRAINT Issues_fk2 FOREIGN KEY (StatusID) 
  REFERENCES dbo.ProblemStatus (StatusID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_fk FOREIGN KEY (GroupID) 
  REFERENCES dbo.UsersGroups (GroupID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_fk2 FOREIGN KEY (IssueID) 
  REFERENCES dbo.Issues (IssueID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_fk3 FOREIGN KEY (GroupID) 
  REFERENCES dbo.UsersGroups (GroupID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Tickets
ADD CONSTRAINT Tickets_fk4 FOREIGN KEY (ParentTicket) 
  REFERENCES dbo.Tickets (TicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Assign
ADD CONSTRAINT Assign_fk FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.Assign
ADD CONSTRAINT Assign_fk2 FOREIGN KEY (TicketID) 
  REFERENCES dbo.Tickets (TicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.StatusStory
ADD CONSTRAINT StatusStory_fk FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.StatusStory
ADD CONSTRAINT StatusStory_fk2 FOREIGN KEY (TicketID) 
  REFERENCES dbo.Tickets (TicketID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.StatusStory
ADD CONSTRAINT StatusStory_fk3 FOREIGN KEY (StatusID) 
  REFERENCES dbo.ProblemStatus (StatusID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.UserReports
ADD CONSTRAINT UserReports_fk FOREIGN KEY (UserID) 
  REFERENCES dbo.Users (UserID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO

ALTER TABLE dbo.UserReports
ADD CONSTRAINT UserReports_fk2 FOREIGN KEY (TicketID) 
  REFERENCES dbo.Tickets (TicketID) 
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

CREATE TRIGGER dbo.User_no_teamlead ON dbo.Users
WITH EXECUTE AS CALLER
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    if ( (select TeamLead from INSERTED) <>  (select UserID from INSERTED))
  	or ((select TeamLead from INSERTED) <>0)
    or ((select TeamLead from INSERTED) is not null)
  		BEGIN
  			if (select GroupID from INSERTED) in
    			(select GroupID from UsersGroups
        		where ISTeamLeads = 1)
    		THROW 60000, 'User couldn ''t be in teamlead group', 1;  
    		else BEGIN 
            	insert into Users (UserName, GroupID, TeamLead) 
                Select UserName, GroupID, TeamLead from Inserted         
            END
  		END
  	else BEGIN
    	insert into Users (UserName, GroupID, TeamLead) 
        Select UserName, GroupID, TeamLead from Inserted        
    END

END
GO

