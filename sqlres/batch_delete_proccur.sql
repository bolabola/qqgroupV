declare proccur cursor
    for
        select [name] from sysobjects where type='P'
declare @procname varchar(100)
open proccur
fetch next from proccur into @procname
while(@@FETCH_STATUS = 0)
begin   
    exec('drop proc ' + @procname) 
    print(@procname + '已被删除')
    fetch next from proccur into @procname
end
close proccur
deallocate proccur