//
//  YMSWebHttpRequest.h
//  YMS_GXZ_HTTP
//
//  Created by gaoxuzhao on 14-8-11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//
/*!
 自定义的网络访问类，对ASiHttpRequest 做了进一步的封装
 
*/
#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIFormDataRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "YMSXMLParser.h"

@interface YMSWebHttpRequest : NSObject<ASIHTTPRequestDelegate>
{

  @private
    
    // 维护一个队列
    NSOperationQueue *queue;
   
    
}

//@property(nonatomic,strong)id <YMSWebHttprRequestReceiveDelegate> delegate;


// 单例模式实现------------------
+(YMSWebHttpRequest*)shareInterfaceYMSRequest;

//----------------------------
/*!
 ///函数名:网络访问方法
 函数功能描述:向服务器发送请
 *函数参数 ：  网络地址URL,请求标示tag, 参数名称顺序 数组 rankedParameter    post数据postDictionary（根据接口文件定义的接口名称和参数值生成字典.接口 key:value- method:接口名称|参数key:value-参数名称:|传入参数值  ,参数的顺序根据 webservice wsdl定义的 接口参数顺序 , delegate
 *函数返回值 ： null
 *作者 ： gao
*/
-(BOOL)requestWithURL:(NSString*)url Tag:(NSInteger)tag rankKeyArray:(NSArray*)rankedparameter postData:(NSDictionary*)postDictionary delegate:(id <YMSWebHttprRequestReceiveDelegate>)delegate;


@end
