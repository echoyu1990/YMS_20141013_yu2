//
//  YMSAdvertisementManager.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14/8/28.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSAdvertisementManager.h"
@interface YMSAdvertisementManager ()

@property(strong,nonatomic)YMSWebHttpRequest*request;
//@property(assign,nonatomic)NSInteger state;

@end

@implementation YMSAdvertisementManager
//
//#define TAGE_HOMEPAGE_ADVERTISEMENT  235
//
//-(id)init
//{
//    if(self=[super init])
//    {
//        self.request=[YMSWebHttpRequest shareInterfaceYMSRequest];
//        self.advertisementData1=[[NSMutableArray alloc] init];
//        self.advertisementData2=[[NSMutableArray alloc] init];
//        self.advertisementImageArray1=[[NSMutableArray alloc] init];
//        self.advertisementImageArray2=[[NSMutableArray alloc] init];
//        self.state=1;
//        
//    }
//    return self;
//    
//}
//
//
//#pragma mark [----单例模式的实现
//+(id)shareAdvertisementManager
//{
//    static YMSAdvertisementManager*manager=nil;
//    static dispatch_once_t oncePredicate;
//    
//    dispatch_once(&oncePredicate, ^{
//    
//        manager=[[YMSAdvertisementManager alloc] init];
//        
//  
//    });
//    return manager;
//    
//}
//#pragma mark----单例模式的实现]
//
//-(NSInteger)dataState
//{
//    
//    
//    return self.state;
//}

//-(void)startUpdata
//{
//    [self.advertisementData1 removeAllObjects];
//    [self.advertisementData2  removeAllObjects];
//    [self.advertisementImageArray1 removeAllObjects];
//    [self.advertisementImageArray2 removeAllObjects];
//  
//    // 首页广告列表
//    NSDictionary *loginDic=[[NSDictionary alloc] initWithObjectsAndKeys:@"queryAppAdvertisements",@"method",@"order",@"appName",@"order",@"appPwd",@"1",@"type",nil];
//   
//    NSArray* rankparameter=@[@"method",@"appName",@"appPwd",@"type"];
//  
//    [self.request  requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/advertisementAppService" Tag: TAGE_HOMEPAGE_ADVERTISEMENT rankKeyArray:rankparameter postData:loginDic delegate:self];
//    
//    
//}
//

//
//#pragma mark--- YMSWebHttprRequestReceiveDelegate 实现
//
//- (void)ymsRequestFinishedOfDictionary:(NSDictionary*)jsonDic  Requestoftag:(NSInteger)tag{
//    
//    NSLog(@"%@",jsonDic);
//    
//       if(tag==TAGE_HOMEPAGE_ADVERTISEMENT)  // 首页广告列表
//       {
//         self.adData2 = [jsonDic objectForKey:@"data2"];
//          NSInteger state=[[jsonDic  objectForKey:@"result"] integerValue];
//          if(state==0)  //if  0：查询成功；1：查询无数据；2：校验账户密码错误
//          {
//              NSArray *data1=[jsonDic  objectForKey:@"data"];
//            
//              NSLog(@"helz: advertisement_data1= %@", data1) ;
//
//              for (int i=0; i<[data1 count]; i++){
//                  
//                  YMSPAdvertisement*temp=[[YMSPAdvertisement alloc] initWithArray:[data1 objectAtIndex:i]];
//                  [self.advertisementData1 addObject:temp];
//                 
//                  UIImage*image=[self  getImageFromURL:temp.advertisementImageUrl];
//                  [self.advertisementImageArray1 addObject:image];
//                  
//              }
//              
//              NSArray *data2=[jsonDic  objectForKey:@"data2"];
//             
//              NSLog(@"helz: advertisement_data2= %@", data2) ;
//              
//              self.ad2FirstUrl=[data2[0]  objectAtIndex:2];
//              [self.advertisementImageArray2 addObject:[self getImageFromURL:self.ad2FirstUrl]];
//              
//              NSLog(@"###############%@#############",data2[1]);
//              for (int i=1; i<[data2 count]; i++){
//                  
//                  YMSPAdvertisement*temp=[[YMSPAdvertisement alloc] initWithArray:[data2 objectAtIndex:i]];
//                  [self.advertisementData2 addObject:temp];
//                  
//                  UIImage*image=[self  getImageFromURL:temp.advertisementImageUrl];
//                  [self.advertisementImageArray2 addObject:image];
//                
//              }
//              
//              self.state=state;
//          }
//          
//           
//           
//           
//       }
//    
//    
//}

- (void)ymsRequestFailed:(ASIHTTPRequest *)request{
    
    
}

- (void)ymsRequestRedirected:(ASIHTTPRequest *)request{
    
    
    
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
   NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];

    
    return result;
}
@end
