CREATE FUNCTION [dbo].[SPLIT](@RowData nvarchar(4000),@SPLITOn nvarchar(5))
RETURNS @RtnValue table
(
	ID int identity(1,1),
	DATA nvarchar(100)
)
AS
BEGIN
	Declare @Cnt int
	Set @Cnt = 1

	While (Charindex(@SPLITOn,@RowData)>0)
	Begin
		Insert Into @RtnValue (DATA)
		Select
			DATA = ltrim(rtrim(Substring(@RowData,1,Charindex(@SPLITOn,@RowData)-1)))

		Set @RowData = Substring(@RowData,Charindex(@SPLITOn,@RowData)+1,len(@RowData))
		Set @Cnt = @Cnt + 1
	End

	Insert Into @RtnValue (DATA)
	Select Data = ltrim(rtrim(@RowData))

	Return
END