CREATE FUNCTION TBL_FUN (@ID INT)
RETURNS TABLE
AS
RETURN (
	SELECT * FROM EMPLOYEE 	
	WHERE id = @ID
)

SELECT * FROM dbo.TBL_FUN(5)