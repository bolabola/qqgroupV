
const Koa = require("koa");
const KoaRouter = require("koa-router");
const KoaStatic = require("koa-static");
const Koa2Cors = require("koa2-cors");
const MSSQL = require("mssql");

const config = {
    user: 'sa',
    password: '123qwe',
    server: 'localhost',
    database: 'master'
};

const serverPort = 80;

(async () => {
    try {
        let pool = await MSSQL.connect(config);
        let app = new Koa();
        let router = new KoaRouter();

        //跨域配置
        let cors = Koa2Cors({
            origin: function (ctx) {
                return "*";
            },
            exposeHeaders: ['WWW-Authenticate', 'Server-Authorization'],
            maxAge: 5,
            credentials: true,
            allowMethods: ['GET'],
            allowHeaders: ['Content-Type', 'Authorization', 'Accept'],
        });

        router.get('/qq/:id', async (ctx, next) => {
            let qqNum = Number(ctx.params.id);
            let result = await pool.request()
                            .input('QQNum', MSSQL.Int, qqNum)
                            .execute('REN_CX');
            ctx.body = result.recordsets;
        });

        router.get('/group/:id', async (ctx, next) => {
            let qunNum = Number(ctx.params.id);
            let result = await pool.request()
                            .input('QunNum', MSSQL.Int, qunNum)
                            .execute('QUNCY_CX');
            ctx.body = result.recordsets;
        });

        app.use(cors).use(KoaStatic(__dirname + "/www")).use(router.routes()).use(router.allowedMethods());

        app.listen(serverPort);
        console.log("服务已经启动，工作在 " + serverPort + " 端口...");
    }
    catch (e) {
        console.error(e);
    }
})();





