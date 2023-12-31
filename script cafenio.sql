USE [master]
GO
/****** Object:  Database [VentasDB]    Script Date: 17/10/2023 09:53:54 p. m. ******/
CREATE DATABASE [VentasDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VentasDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\VentasDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VentasDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\VentasDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [VentasDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VentasDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VentasDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VentasDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VentasDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VentasDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VentasDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [VentasDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VentasDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VentasDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VentasDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VentasDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VentasDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VentasDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VentasDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VentasDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VentasDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VentasDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VentasDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VentasDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VentasDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VentasDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VentasDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VentasDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VentasDB] SET RECOVERY FULL 
GO
ALTER DATABASE [VentasDB] SET  MULTI_USER 
GO
ALTER DATABASE [VentasDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VentasDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VentasDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VentasDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VentasDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VentasDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'VentasDB', N'ON'
GO
ALTER DATABASE [VentasDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [VentasDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [VentasDB]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[VentaId] [int] IDENTITY(1,1) NOT NULL,
	[Folio] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[ClienteId] [int] NOT NULL,
	[NumeroPuntosId] [int] NOT NULL,
	[FormaPagoId] [int] NOT NULL,
	[IVA] [decimal](8, 2) NOT NULL,
	[Total] [decimal](8, 2) NOT NULL,
	[Lugar] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[VentaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](256) NOT NULL,
	[TarjetapuntosId] [varchar](20) NOT NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_VentasClientes]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_VentasClientes]
AS
SELECT dbo.Ventas.Folio, dbo.Ventas.Fecha, dbo.Clientes.Codigo, dbo.Clientes.Nombre, dbo.Ventas.Id AS VentaId
FROM     dbo.Clientes INNER JOIN
                  dbo.Ventas ON dbo.Clientes.Id = dbo.Ventas.ClienteId
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[CategoriaId] [int] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](50) NOT NULL,
	[Detalles] [varchar](255) NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[CategoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[ClaveEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[ClaveEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormaPago]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormaPago](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FormaDePago] [varchar](50) NOT NULL,
	[Importe] [decimal](8, 2) NULL,
 CONSTRAINT [PK_FormaPago_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ProductoId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[CategoriaId] [int] NOT NULL,
	[PrecioBase] [decimal](8, 2) NOT NULL,
	[Detalles] [varchar](255) NULL,
 CONSTRAINT [PK_Productos_1] PRIMARY KEY CLUSTERED 
(
	[ProductoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tamanio]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tamanio](
	[TamanioId] [int] IDENTITY(1,1) NOT NULL,
	[ProductoId] [int] NULL,
	[Tamanio] [varchar](50) NOT NULL,
	[PrecioAgregado] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Tamanio] PRIMARY KEY CLUSTERED 
(
	[TamanioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TarjetaPuntos]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TarjetaPuntos](
	[TarjetaPuntosId] [int] IDENTITY(1,1) NOT NULL,
	[ClienteId] [int] NOT NULL,
	[Puntos] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_TarjetaPuntos] PRIMARY KEY CLUSTERED 
(
	[TarjetaPuntosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo](
	[TipoId] [int] NOT NULL,
	[TipoBebida] [varchar](50) NOT NULL,
	[PrecioAgregado] [decimal](4, 2) NOT NULL,
	[ProductoId] [int] NULL,
 CONSTRAINT [PK_Tipo] PRIMARY KEY CLUSTERED 
(
	[TipoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCafe]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCafe](
	[TipoCafeId] [int] IDENTITY(1,1) NOT NULL,
	[ProductoId] [int] NULL,
	[TipoCafe] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoCafe] PRIMARY KEY CLUSTERED 
(
	[TipoCafeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoLeche]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoLeche](
	[TipoLecheId] [int] IDENTITY(1,1) NOT NULL,
	[ProductoId] [int] NULL,
	[TipoLeche] [varchar](50) NOT NULL,
	[PrecioAgregado] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_TipoLeche] PRIMARY KEY CLUSTERED 
(
	[TipoLecheId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topping]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topping](
	[ToppingId] [int] IDENTITY(1,1) NOT NULL,
	[Topping] [varchar](55) NOT NULL,
	[PrecioAgregado] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Topping] PRIMARY KEY CLUSTERED 
(
	[ToppingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ToppingxProducto]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToppingxProducto](
	[ToppingId] [int] NOT NULL,
	[ProductoId] [int] NOT NULL,
	[Cantidad] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VentaDetalle]    Script Date: 17/10/2023 09:53:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VentaDetalle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VentaId] [int] NOT NULL,
	[ProductoId] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Subtotal] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_VentaDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categoria] FOREIGN KEY([CategoriaId])
REFERENCES [dbo].[Categoria] ([CategoriaId])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categoria]
GO
ALTER TABLE [dbo].[Tamanio]  WITH CHECK ADD  CONSTRAINT [FK_Tamanio_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[Tamanio] CHECK CONSTRAINT [FK_Tamanio_Productos]
GO
ALTER TABLE [dbo].[TarjetaPuntos]  WITH CHECK ADD  CONSTRAINT [FK_TarjetaPuntos_Clientes] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Clientes] ([Id])
GO
ALTER TABLE [dbo].[TarjetaPuntos] CHECK CONSTRAINT [FK_TarjetaPuntos_Clientes]
GO
ALTER TABLE [dbo].[Tipo]  WITH CHECK ADD  CONSTRAINT [FK_Tipo_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[Tipo] CHECK CONSTRAINT [FK_Tipo_Productos]
GO
ALTER TABLE [dbo].[TipoCafe]  WITH CHECK ADD  CONSTRAINT [FK_TipoCafe_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[TipoCafe] CHECK CONSTRAINT [FK_TipoCafe_Productos]
GO
ALTER TABLE [dbo].[TipoLeche]  WITH CHECK ADD  CONSTRAINT [FK_TipoLeche_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[TipoLeche] CHECK CONSTRAINT [FK_TipoLeche_Productos]
GO
ALTER TABLE [dbo].[ToppingxProducto]  WITH CHECK ADD  CONSTRAINT [FK_ToppingxProducto_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[ToppingxProducto] CHECK CONSTRAINT [FK_ToppingxProducto_Productos]
GO
ALTER TABLE [dbo].[ToppingxProducto]  WITH CHECK ADD  CONSTRAINT [FK_ToppingxProducto_Topping] FOREIGN KEY([ToppingId])
REFERENCES [dbo].[Topping] ([ToppingId])
GO
ALTER TABLE [dbo].[ToppingxProducto] CHECK CONSTRAINT [FK_ToppingxProducto_Topping]
GO
ALTER TABLE [dbo].[VentaDetalle]  WITH CHECK ADD  CONSTRAINT [FK_VentaDetalle_Ventas] FOREIGN KEY([VentaId])
REFERENCES [dbo].[Ventas] ([VentaId])
GO
ALTER TABLE [dbo].[VentaDetalle] CHECK CONSTRAINT [FK_VentaDetalle_Ventas]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Clientes1] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Clientes] ([Id])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Clientes1]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleado] ([ClaveEmpleado])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Empleado]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_FormaPago] FOREIGN KEY([FormaPagoId])
REFERENCES [dbo].[FormaPago] ([Id])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_FormaPago]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_TarjetaPuntos] FOREIGN KEY([NumeroPuntosId])
REFERENCES [dbo].[TarjetaPuntos] ([TarjetaPuntosId])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_TarjetaPuntos]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Clientes"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ventas"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_VentasClientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_VentasClientes'
GO
USE [master]
GO
ALTER DATABASE [VentasDB] SET  READ_WRITE 
GO
