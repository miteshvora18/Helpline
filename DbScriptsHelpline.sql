USE [master]
GO
/****** Object:  Database [Helpline]    Script Date: 03/09/2014 01:34:04 ******/
CREATE DATABASE [Helpline] ON  PRIMARY 
( NAME = N'Helpline', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Helpline.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Helpline_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Helpline_log.LDF' , SIZE = 576KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Helpline] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Helpline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Helpline] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Helpline] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Helpline] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Helpline] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Helpline] SET ARITHABORT OFF
GO
ALTER DATABASE [Helpline] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Helpline] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Helpline] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Helpline] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Helpline] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Helpline] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Helpline] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Helpline] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Helpline] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Helpline] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Helpline] SET  ENABLE_BROKER
GO
ALTER DATABASE [Helpline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Helpline] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Helpline] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Helpline] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Helpline] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Helpline] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Helpline] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Helpline] SET  READ_WRITE
GO
ALTER DATABASE [Helpline] SET RECOVERY FULL
GO
ALTER DATABASE [Helpline] SET  MULTI_USER
GO
ALTER DATABASE [Helpline] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Helpline] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'Helpline', N'ON'
GO
USE [Helpline]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 03/09/2014 01:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[uid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[email] [varchar](90) NULL,
	[dob] [varchar](90) NULL,
	[college] [varchar](90) NULL,
	[branch] [varchar](50) NULL,
	[gender] [varchar](10) NULL,
	[username] [varchar](100) NULL,
	[pass] [varchar](80) NULL,
	[uimage] [varchar](200) NULL,
	[ustatus] [varchar](300) NULL,
	[ustatustime] [datetime] NULL,
	[uonline] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([uid], [name], [email], [dob], [college], [branch], [gender], [username], [pass], [uimage], [ustatus], [ustatustime], [uonline]) VALUES (1, N'Mitesh', N'miteshvora18@gmail.com', N'8-7-1989', N'rgreg', N'BE EXTC', N'Male', N'miteshvora18', N'mitesh', N'1600FG100_2_079.jpg', N'yjvfyj', CAST(0x0000A2E900181FF0 AS DateTime), 0)
INSERT [dbo].[Users] ([uid], [name], [email], [dob], [college], [branch], [gender], [username], [pass], [uimage], [ustatus], [ustatustime], [uonline]) VALUES (2, N'Amish Vora', N'amishvora7018@rediffmail.com', N'26-3-1993', N'UPG', N'Bsc IT', N'Male', N'amishvora', N'amish', N'amish2.jpg', N'ghfthf..', CAST(0x0000A2E90017CFF2 AS DateTime), 0)
INSERT [dbo].[Users] ([uid], [name], [email], [dob], [college], [branch], [gender], [username], [pass], [uimage], [ustatus], [ustatustime], [uonline]) VALUES (3, N'test', N'test@test.com', N'20-1-2010', N'test', N'BE IT', N'Male', N'test', N'test', N'wyt_aslaq2d1.jpg', N'gjnfyhj', CAST(0x0000A2E90017E101 AS DateTime), 0)
INSERT [dbo].[Users] ([uid], [name], [email], [dob], [college], [branch], [gender], [username], [pass], [uimage], [ustatus], [ustatustime], [uonline]) VALUES (4, N'abc', N'abc@abc.com', N'1-1-2010', N'vdv', N'BE IT', N'Male', N'abc', N'abc', N'3d0099.jpg', N'bvnvn', CAST(0x0000A2E8016A30B7 AS DateTime), 0)
INSERT [dbo].[Users] ([uid], [name], [email], [dob], [college], [branch], [gender], [username], [pass], [uimage], [ustatus], [ustatustime], [uonline]) VALUES (5, N'test2', N'test2@test2.com', N'31-1-2010', N'fbb', N'BE EXTC', N'Male', N'test2', N'test2', N'005.jpg', N'', CAST(0x0000000000000000 AS DateTime), 0)
INSERT [dbo].[Users] ([uid], [name], [email], [dob], [college], [branch], [gender], [username], [pass], [uimage], [ustatus], [ustatustime], [uonline]) VALUES (6, N'test3', N'test2@test2.com', N'20-1-2010', N'fxb', N'BE IT', N'Male', N'test3', N'test3', N'011.jpg', N'', CAST(0x0000000000000000 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Table [dbo].[communication]    Script Date: 03/09/2014 01:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[communication](
	[comid] [int] IDENTITY(1,1) NOT NULL,
	[fromUser] [int] NULL,
	[toUser] [int] NULL,
	[content] [varchar](500) NULL,
	[unread] [bit] NULL,
	[ctime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[comid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[communication] ON
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (3, 3, 1, N'msg.', 1, CAST(0x0000A2E5009723D8 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (4, 3, 1, N'test..', 1, CAST(0x0000A2E600936D35 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (5, 1, 3, N'reply..', 1, CAST(0x0000A2E600943C73 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (6, 1, 3, N'hi..', 1, CAST(0x0000A2E8000D0DF0 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (7, 3, 1, N'hi..', 1, CAST(0x0000A2E8001D1E88 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (8, 3, 1, N'vg', 1, CAST(0x0000A2E8001D3723 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (9, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D3A7B AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (10, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D3B3A AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (11, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D3C6D AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (12, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D3DAC AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (13, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D3EDE AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (14, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D4095 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (15, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D420C AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (16, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D437B AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (17, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D44F6 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (18, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D4666 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (19, 3, 1, N'vbnvbn', 1, CAST(0x0000A2E8001D4A71 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (20, 3, 1, N'hi..', 1, CAST(0x0000A2E8001E39D2 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (21, 3, 1, N'hi..', 1, CAST(0x0000A2E8001E5DCF AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (22, 3, 1, N'cbcfb', 1, CAST(0x0000A2E8001EEBF2 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (23, 1, 2, N'hi..', 1, CAST(0x0000A2E800EF5C9F AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (24, 1, 2, N'new message..', 1, CAST(0x0000A2E800EF74B9 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (25, 1, 2, N'edgf', 1, CAST(0x0000A2E800EF85BA AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (26, 1, 2, N'gnfvnj', 1, CAST(0x0000A2E800F04CD2 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (27, 1, 2, N'hi..', 1, CAST(0x0000A2E800F25D1D AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (28, 1, 2, N'hi..', 1, CAST(0x0000A2E800F2607B AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (29, 3, 2, N'test', 1, CAST(0x0000A2E800FBD5FB AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (30, 3, 2, N'demo..', 1, CAST(0x0000A2E800FBFD9F AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (31, 3, 4, N'test..', 1, CAST(0x0000A2E8015C829C AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (32, 3, 4, N'hello..', 1, CAST(0x0000A2E8015C95AF AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (33, 3, 4, N' xc', 1, CAST(0x0000A2E8015CB8AC AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (34, 3, 4, N'fvjmg', 1, CAST(0x0000A2E8015D13C2 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (35, 3, 4, N'hgefzsegfv', 1, CAST(0x0000A2E8015F6D3A AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (36, 4, 3, N'test..', 1, CAST(0x0000A2E801605A02 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (37, 3, 4, N'test..', 1, CAST(0x0000A2E8016067E8 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (38, 3, 4, N'efef', 1, CAST(0x0000A2E80162A11A AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (39, 3, 4, N'fbxfb', 1, CAST(0x0000A2E80162BDE1 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (40, 4, 3, N'hi..', 1, CAST(0x0000A2E801636884 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (41, 3, 4, N'hello..', 1, CAST(0x0000A2E801638183 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (42, 4, 3, N'ftghfcgh', 1, CAST(0x0000A2E80163A7DE AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (43, 3, 4, N'jkgkgujbk', 1, CAST(0x0000A2E80163C0D6 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (44, 4, 3, N'reply...', 1, CAST(0x0000A2E80163DEE1 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (45, 3, 4, N'help', 1, CAST(0x0000A2E80163F536 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (46, 4, 3, N'b nv n', 1, CAST(0x0000A2E801645A50 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (47, 6, 3, N'hi..', 0, CAST(0x0000A2E900031AA2 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (48, 3, 6, N'gff..', 0, CAST(0x0000A2E900032DAF AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (49, 3, 6, N'hi..unread..', 0, CAST(0x0000A2E900135575 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (50, 3, 6, N'hi..', 0, CAST(0x0000A2E90016BAB5 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (51, 3, 6, N'gfhh..', 0, CAST(0x0000A2E90016C932 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (52, 5, 3, N'fgnfgn', 0, CAST(0x0000A2E900175D9A AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (53, 3, 5, N'fhdh..', 0, CAST(0x0000A2E900177834 AS DateTime))
INSERT [dbo].[communication] ([comid], [fromUser], [toUser], [content], [unread], [ctime]) VALUES (54, 3, 5, N'fvxfg', 1, CAST(0x0000A2E900178FED AS DateTime))
SET IDENTITY_INSERT [dbo].[communication] OFF
/****** Object:  ForeignKey [FK__communica__fromU__182C9B23]    Script Date: 03/09/2014 01:34:05 ******/
ALTER TABLE [dbo].[communication]  WITH CHECK ADD FOREIGN KEY([fromUser])
REFERENCES [dbo].[Users] ([uid])
GO
/****** Object:  ForeignKey [FK__communica__toUse__1920BF5C]    Script Date: 03/09/2014 01:34:05 ******/
ALTER TABLE [dbo].[communication]  WITH CHECK ADD FOREIGN KEY([toUser])
REFERENCES [dbo].[Users] ([uid])
GO
