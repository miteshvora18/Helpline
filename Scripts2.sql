create table MstGroups
(
intid int identity(1,1),
GroupName varchar(200),
CreatedBy int,
ctime datetime,
memberlistid varchar(300),
icon varchar(200),
IsActive bit default(1)
)
GO

create table GroupCommunication
(
intid int identity(1,1),
intGroupId int,
content varchar(max),
fromuid int,
ctime datetime,
IsActive bit default(1)
)
GO

--INSERT INTO MstGroups(GroupName,CreatedBy,memberlistid,icon.IsActive) VALUES(@GroupName,@CreatedBy,@memberlist,@icon,1)

--select intid,icon,GroupName
--from MstGroups
--where CreatedBy = 3 or 3 in((select item from splitstring(memberlistid,',') where item in(3)))


--select * from splitstring('3,4',',')

CREATE FUNCTION SplitString
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END
GO


ALTER PROCEDURE usp_Helpline_GetGroupUserList --6,5
	@groupID int,
	@uid int,
	@Type varchar(20) = 'GetUser' 
AS
-- =============================================
-- Author:		<Author,,Mitesh Vora>
-- Create date: <Create Date,,>
-- Description:	<Description,,Get Group User List>
-- =============================================
BEGIN
	IF(@Type = 'GetUser')
	BEGIN
		SELECT uimage,name,uonline,uid from Users WHERE uid IN
		(
			SELECT * FROM dbo.splitstring(
			(SELECT memberlistid + ',' + cast(CreatedBy as varchar) FROM MstGroups WHERE intid = @groupId),',')
		)
		--AND uid NOT IN(@uid) 
		ORDER BY Name
	END
	ELSE IF(@Type = 'Delete')
	BEGIN
		Update Mstgroups
		set isactive = 0
		where intid = @groupId
	END
END
GO

--Part 3
CREATE TABLE GroupRead
(
id int identity(1,1),
gid int,
gcid int,
uid int,
IsRead bit default(1)
)

CREATE PROCEDURE usp_Helpline_GetUnreadGroupMsg --3
	@uid int 
AS
BEGIN
	SELECT count(content), g.GroupName + ' (Group)' as fromuser,g.intid
	FROM GroupCommunication gc
	JOIN MstGroups g on g.intid = gc.intGroupId and @uid IN(
					SELECT * FROM dbo.splitstring(
								(SELECT memberlistid + ',' + cast(CreatedBy AS VARCHAR) FROM MstGroups WHERE intid = g.intid),',')
					) and gc.fromuid != @uid
	WHERE g.IsActive = 1 and gc.intid NOT IN(SELECT gr.gcid from groupread gr WHERE uid = @uid and gr.gcid = gc.intid and isread = 1)
	GROUP BY g.intid,g.GroupName
END
GO

CREATE PROCEDURE usp_Helpline_ReadGroupMsg --3,1
	@uid int,
	@gid int 
AS
BEGIN
	INSERT INTO GroupRead(gid,gcid,uid,IsRead)
	SELECT @gid,intid,@uid,1 
	FROM GroupCommunication gc
	WHERE intGroupId = @gid 
			AND intid NOT IN(SELECT gcid FROM GroupRead gr WHERE gr.gid = gc.intGroupId AND uid = @uid AND IsRead = 1) 
			AND fromuid != @uid
END
GO
------------------------------------------------
