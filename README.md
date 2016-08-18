# JSPatch-IOS
 一款 基于JSPatch的iOS开源库，用于修改当前线上版本的Object-C代码
 
##  集成
* 下载完整工具包，并全部导入
* 引入框架JavaScriptCore.framework

##  代码文档
* 我们首先要创建一些常量
  * LOADURLS[请求网络的域名] 
  * AppVersion[app版本号]
  * LOADKEYS[解密串]
  * APPREQUESTVERSION[用于储存请求头中version所用到的key]
  * LOADCONTENT[用于储存请求内容多用到的key]
* 接下来，我们取本地存储的信息，如果取出的值不为空，我们就直接加载内容；
  * NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
  * NSString *version = [user objectForKey:APPREQUESTVERSION];
  *   NSString *oldScript = [user objectForKey:LOADCONTENT];
  *   if(oldScript && [oldScript isEqualToString:@""]==NO){
  *       [JPEngine evaluateScript:oldScript];
  *   }
* 如果为空，首页构造请求地址 域名＋版本号＋参数(该参数为请求头中获取的version，第一次为空传0) ，如果获取到的内容和上次一样，服务器则返回空，不一样，返回新内容，本地存储。每次请求完，都需要存储一下 version。
  * 构造地址：
     * NSString *urlk = [NSString stringWithFormat:@"%@/%@.js?v=%@",LOADURLS,AppVersion,version];
  * 获取请求头中的version并储存：
     * NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
     *    NSDictionary *allHeaderFields = httpResponse.allHeaderFields;
     *    NSString *newversion = [allHeaderFields objectForKey:@"version"];
     *    [user setObject:newversion forKey:APPREQUESTVERSION];
  * 获取请求到的内容并解密，然后储存 ，最后加载js新内容
    * NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    *     NSString *newscript = [DES3EncryptUtil decrypt:script key:LOADKEYS];
    *     [user setObject:newversion forKey:APPREQUESTVERSION];
    *     if(newscript && [newscript isEqualToString:@""]==NO){
    *         [user setObject:newscript forKey:LOADCONTENT];
    *         [JPEngine evaluateScript:newscript];
    *     }
