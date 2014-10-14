//
//  YMSWebHttprRequestReceiveDelegate.h
//  YMS_GXZ_HTTP
//
//  Created by gaoxuzhao on 14-8-11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

/*
 名称：YMSwebhttpRequestRceivedelegate 
 描述： 实现delegate 完成 对接受数据的处理
 
 
 */

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@protocol YMSWebHttprRequestReceiveDelegate <NSObject>

@required
/*!
 请求结束  返回   原始 的处理后的json  字典
 
 */
- (void)ymsRequestFinishedOfDictionary:(NSDictionary*)jsonDic  Requestoftag:(NSInteger)tag;

@optional
/*!
 请求结束  返回   原始 的处理后的json  数据 字符串
 
 */
- (void)ymsRequestFinishedOfString:(NSString*)respondString Requestoftag:(NSInteger)tag;

/*!
 请求结束  返回   原始 的request
 
*/
- (void)ymsRequestFinished:(ASIHTTPRequest *)request;

- (void)ymsRequestFailed:(ASIHTTPRequest *)request;

- (void)ymsRequestRedirected:(ASIHTTPRequest *)request;

@end
