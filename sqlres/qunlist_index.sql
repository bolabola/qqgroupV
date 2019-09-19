set xact_abort on
begin tran

    declare @dbIdx int = 1
    while @dbIdx <= 11
        begin
            declare @tblIdx int = 1
            declare @tblName varchar(50)
            while @tblIdx <= 10
            begin
                set @tblName = 'QunInfo' + CONVERT(varchar(2), @dbIdx) + '.dbo.QunList'
                set @tblName += CONVERT(varchar(5), (@dbIdx - 1) * 10 + @tblIdx)

                exec ('create index ix_QunList_QunNum on ' + @tblName + '(QunNum)');
                print @tblname + ' OK'
                set @tblIdx += 1
            end
            set @dbIdx += 1
        end

commit tran