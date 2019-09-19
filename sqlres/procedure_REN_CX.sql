CREATE PROCEDURE REN_CX @QQNum int=null
AS
BEGIN
declare @sql varchar(8000)
declare @dbIdx int = 1
-------------------------------------------------------------
if OBJECT_ID('tempdb.dbo.#QunList') is not null
drop table #QunList
    
--新建了一个临时表
create table #QunList
(
QQNum int,
Nick varchar(20),
Age int,
Gender int,
Auth int,
QunNum int
)
    
--------------------------------------------------------------
-- Search QunList
--一个嵌套循环查找 一个表一个表找，找到一个插入临时表一条
while @dbIdx <= 11
begin
declare @tblIdx int = 1
declare @tblName varchar(50)
    
while @tblIdx <= 100
begin
set @tblName = 'GroupData' + CONVERT(varchar(2), @dbIdx) + '.dbo.Group'
set @tblName += CONVERT(varchar(5), (@dbIdx - 1) * 100 + @tblIdx)
    
set @sql = 'select QQNum, Nick, Age,Gender, Auth,QunNum from '
set @sql += @tblName + ' where QQNum=' + CONVERT(varchar(15), @QQNum)
    
insert into #QunList(QQNum, Nick,Age,Gender,Auth,QunNum)  exec(@sql)
    
print @tblname + ' OK'
    
set @tblIdx += 1    --循环递增
end
    
set @dbIdx += 1   --外层递增
end
    
-----------------------------------------------------------------------
--显示
    
select * from #QunList
END
GO