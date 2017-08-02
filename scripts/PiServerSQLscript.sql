
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PowergridView](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PowerScout] [nvarchar](4000) NULL,
	[TimeStamp] [datetime] NULL,
	[Amps L1] [float] NULL,
	[Amps L2] [float] NULL,
	[Amps L3] [float] NULL,
	[Amps System Avg] [float] NULL,
	[Breaker Details] [nvarchar](4000) NULL,
	[Breaker Label] [nvarchar](4000) NULL,
	[Building] [nvarchar](4000) NULL,
	[Daily Electric Cost] [float] NULL,
	[Daily kWh System] [float] NULL,
	[Modbus Base Address] [int] NULL,
	[Monthly Electric Cost] [float] NULL,
	[Monthly kWh System] [float] NULL,
	[Rated Amperage] [float] NULL,
	[ReadingTime] [datetime] NULL,
	[Rolling Hourly kWh System] [float] NULL,
	[Serial Number] [nvarchar](4000) NULL,
	[Type] [nvarchar](4000) NULL,
	[Volts L1 to Neutral] [float] NULL,
	[Volts L2 to Neutral] [float] NULL,
	[Volts L3 to Neutral] [float] NULL,
	[kW L1] [float] NULL,
	[kW L2] [float] NULL,
	[kW L3] [float] NULL,
	[kW System] [float] NULL,
	[PIIntTSTicks] [bigint] NULL,
	[PIIntShapeID] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SensorData]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SensorData](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Wireless Tag Template] [nvarchar](4000) NULL,
	[TimeStamp] [datetime] NULL,
	[Brightness] [float] NULL,
	[Humidity] [float] NULL,
	[Name] [nvarchar](4000) NULL,
	[Temperature] [float] NULL,
	[PIIntTSTicks] [bigint] NULL,
	[PIIntShapeID] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Weather]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weather](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Weather] [nvarchar](4000) NULL,
	[TimeStamp] [datetime] NULL,
	[Pressure] [float] NULL,
	[Relative Humidity] [float] NULL,
	[Temperature] [float] NULL,
	[Visibility] [float] NULL,
	[Weather.Weather] [nvarchar](4000) NULL,
	[Wind Direction] [nvarchar](4000) NULL,
	[Wind Speed] [float] NULL,
	[PIIntTSTicks] [bigint] NULL,
	[PIIntShapeID] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
