//
//  CommonParameters.h
//  jht
//
//  Created by 泽鹏邵 on 16/8/18.
//  Copyright © 2016年 dhgh. All rights reserved.
//

//设置请求网络的域名
#define LOADURLS @"http://xxx/"
//获取版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleShortVersionString"]
//加密串
#define LOADKEYS @"xxxxxxxxx"
//保存请求头version多用的key
#define APPREQUESTVERSION @"version"
//保存请求到的内容所用的key
#define LOADCONTENT @"loadcontent"

#import <Foundation/Foundation.h>

@interface CommonParameters : NSObject

@end
