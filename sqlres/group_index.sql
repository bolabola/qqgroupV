set xact_abort on
begin tran

    declare @dbIdx int = 1
    while @dbIdx <= 11
        begin
            declare @tblIdx int = 1
            declare @tblName varchar(50)
            while @tblIdx <= 100
            begin
                set @tblName = 'GroupData' + CONVERT(varchar(2), @dbIdx) + '.dbo.Group'
                set @tblName += CONVERT(varchar(5), (@dbIdx - 1) * 100 + @tblIdx)

                exec ('create index ix_Group_QQNum on ' + @tblName + '(QQNum)');
                print @tblname + ' OK'
                set @tblIdx += 1
            end
            set @dbIdx += 1
        end

commit tran