//
//  DynamicChangeCode.m
//  jht
//
//  Created by 泽鹏邵 on 16/8/17.
//  Copyright © 2016年 dhgh. All rights reserved.
//

#import "DynamicChangeCode.h"
#import "JPEngine.h"
#import "DES3EncryptUtil.h"
#import "CommonParameters.h"

@implementation DynamicChangeCode
+(void) loadURLConnectionCompletion {
    [JPEngine startEngine];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //获取上次储存的version(请求头中获取)和js内容
    NSString *version = [user objectForKey:APPREQUESTVERSION];
    NSString *oldScript = [user objectForKey:LOADCONTENT];
    //上次储存的js内容不为空，直接加载
    if(oldScript && [oldScript isEqualToString:@""]==NO){
        [JPEngine evaluateScript:oldScript];
    }
    //version为空设为0
    if(!version || [version isEqualToString:@""]){
        version = @"0";
    }
    //构造请求地址，并传参数version
    NSString *urlk = [NSString stringWithFormat:@"%@/%@.js?v=%@",LOADURLS,AppVersion,version];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlk]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //获取请求头中的version并储存
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSDictionary *allHeaderFields = httpResponse.allHeaderFields;
//        NSString *newversion = StrValueFromDictionary(allHeaderFields, @"version");
        NSString *newversion = [allHeaderFields objectForKey:@"version"];
        //获取请求到的内容并解密，然后储存
        NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *newscript = [DES3EncryptUtil decrypt:script key:LOADKEYS];
        [user setObject:newversion forKey:APPREQUESTVERSION];
        if(newscript && [newscript isEqualToString:@""]==NO){
            [user setObject:newscript forKey:LOADCONTENT];
            //加载js内容
            [JPEngine evaluateScript:newscript];
        }
    }];
}
@end
