--建立查询群信息的存储过程
CREATE  PROCEDURE QUNXX_CX @QunNum int=null
as
BEGIN
declare @sql varchar(8000)
set @sql = 'select QunNum,Title,QunText from QunInfo' + CONVERT(varchar(5), @QunNum / 10000000 + 1) + '.dbo.'
set @sql += 'QunList' + CONVERT(varchar(10), @QunNum / 1000000 + 1) + ' where QunNum=' + Convert(varchar(20),@QunNum)
exec(@sql)
print(@sql)
END
GO