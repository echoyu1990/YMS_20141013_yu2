//
//  YMSWebHttpRequest.m
//  YMS_GXZ_HTTP
//
//  Created by gaoxuzhao on 14-8-11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSWebHttpRequest.h"
@interface  YMSWebHttpRequest ()


@end

@implementation YMSWebHttpRequest




//单例模式的实现--------------

+(YMSWebHttpRequest*)shareInterfaceYMSRequest
{
    static  YMSWebHttpRequest *YMSrequest;

    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        
        YMSrequest=[[YMSWebHttpRequest alloc] init];
        
    });
    
    return  YMSrequest;
}

//单例模式的实现--------------



/*!

 ///函数名:网络访问方法
 函数功能描述:向服务器发送请求
 *函数参数 ：  网络地址URL    请求标示tag   post 数据postDictionary（根据接口文件  定义的 接口名称和 参数值生成 字典   接口 key:value- method:接口名称    参数  key:value-参数名称:传入参数值 ,参数的顺序根据 webservice wsdl定义的 接口参数顺序 ） delegate
 *函数返回值 ： null
 *作者 ： gao
 */
-(BOOL)requestWithURL:(NSString*)url Tag:(NSInteger)tag rankKeyArray:(NSArray*)rankedparameter postData:(NSDictionary*)postDictionary delegate:(id <YMSWebHttprRequestReceiveDelegate>)delegate;
{
    
    
    //判断是否参数 存在 
   if(postDictionary&&delegate&&url&&tag)
   {
    // 判断队列是否存在
    if(!queue)
    {
        queue=[[NSOperationQueue alloc] init];
        //[queue setMaxConcurrentOperationCount:100];
        
    }

    
  
    
   NSString*soapMessage=@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"
    "<soapenv:Body>"
    "<queryAppAdvertisements xmlns=\"http://www.youmeishi.cn/UnisPlatform/services/advertisementAppService\">"
        "<appName>order</appName>"
         "<appPwd>order</appPwd>"
         "<type>1</type>"
        "</queryAppAdvertisements>"
    "</soapenv:Body>"
    "</soapenv:Envelope>";

   
    
    
    
   
    
   //-------------动态生成soap 信息
    NSMutableString*portMessage=[NSMutableString stringWithFormat:@"<%@ xmlns=\"%@\">",[postDictionary objectForKey:@"method"],url];
    
    
    
    for (int i=1; i<[rankedparameter count]; i++) {
        
        NSString*key=[rankedparameter  objectAtIndex:i];
        NSString*value=[postDictionary  objectForKey:key];
      
        [portMessage appendFormat:@"<%@>%@</%@>",key,value,key];
     
        
    }
    
    [portMessage  appendFormat:@"</%@>",[postDictionary  objectForKey:@"method"]];
    
    NSMutableString *  dynamicSoapMessage=[NSMutableString  stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                           "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"
                                           "<soapenv:Body>"
                                             "%@"
                                           "</soapenv:Body>"
                                           "</soapenv:Envelope>", portMessage];
    NSLog(@"动态生成  soapmessage：【%@】",dynamicSoapMessage);
  //-------------动态生成soap 信息
   
//-----------与webservice 交互   发送soap协议  请求 头信息必须设置五部分信息
    NSURL*URL=[NSURL  URLWithString:url];
 
    ASIHTTPRequest * postRequest=[[ASIHTTPRequest alloc] initWithURL:URL];
    [postRequest setRequestMethod:@"POST"];

    [postRequest addRequestHeader:@"Content-Type" value:@"application/soap+xml;charset=utf-8"];
    
    NSString *contentLength=[NSString stringWithFormat:@"%d",[dynamicSoapMessage length]];
    
    [postRequest  addRequestHeader:@"Content-Length" value:contentLength];
    
    [postRequest addRequestHeader:@"SOAPAction" value:url];
    
//       NSString*tempDynamicSoapMessage=[NSString stringWithString:dynamicSoapMessage];
    [postRequest  setPostBody:(NSMutableData*)[dynamicSoapMessage  dataUsingEncoding:NSUTF8StringEncoding]];
    //-----------与webservice 交互   发送soap协议  请求 头信息必须设置五部分信息
    postRequest.tag=tag;
    
    NSDictionary* requestInfo=[[NSDictionary  alloc] initWithObjectsAndKeys:delegate,@"delegate",[NSNumber numberWithInt:tag],@"tag",[NSString  stringWithFormat:@"%@",[postDictionary  objectForKey:@"method"]],@"method",nil];
    postRequest.userInfo=requestInfo;
    
    postRequest.delegate=self;
    
    [queue addOperation:postRequest];
       return YES;
   }
    else
    {
        return NO;
    }
    
    
    
}



#pragma mark----实现 asiHttpRequest 的 数据处理delegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary *requestInfo=request.userInfo;
    id  delegate=[requestInfo  objectForKey:@"delegate"];
    
     //[[requestInfo  objectForKey:@"delegate"] ymsRequestFinishedOfString:[request responseString]];
    if([delegate  respondsToSelector:@selector(ymsRequestFinished:)])
    {
        [delegate ymsRequestFinished:request];
    }
    if([delegate  respondsToSelector:@selector(ymsRequestFinishedOfString:Requestoftag:)])
    {
        NSString *element=[[request.userInfo   objectForKey:@"method"] stringByAppendingString:@"Return"];
        NSString * result=[YMSXMLParser  stringParserXmldatefor:[request responseString] xmlelement:element];
        [delegate ymsRequestFinishedOfString:result Requestoftag:request.tag];
        
        
    }
    if(1)
    {
        NSString*element=[[request.userInfo  objectForKey:@"method"]stringByAppendingString:@"Return"];
        NSString * result=[YMSXMLParser  stringParserXmldatefor:[request responseString] xmlelement:element];
        NSDictionary * jsonDic=[NSJSONSerialization  JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        [delegate  ymsRequestFinishedOfDictionary:jsonDic Requestoftag:request.tag];
    }
    
   // NSLog(@"%@",[request responseString]);
    //[request  removeTemporaryUncompressedDownloadFile];
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSDictionary *requestInfo=request.userInfo;
    
    [[requestInfo  objectForKey:@"delegate"] ymsRequestFailed:request];
    
}
- (void)requestRedirected:(ASIHTTPRequest *)request
{
    NSDictionary *requestInfo=request.userInfo;
    
    [[requestInfo  objectForKey:@"delegate"]ymsRequestRedirected:request];
    
}
#pragma mark----实现 asiHttpRequest 的 数据处理delegate




@end
