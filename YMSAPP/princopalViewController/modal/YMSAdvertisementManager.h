//
//  YMSAdvertisementManager.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14/8/28.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "YMSWebHttprRequestReceiveDelegate.h"
#import "YMSWebHttpRequest.h"
#import  "YMSPAdvertisement.h"
#import "YMSAdRestaurant.h"

@interface YMSAdvertisementManager : NSObject<YMSWebHttprRequestReceiveDelegate>

@property(assign,nonatomic)NSInteger state;
@property(strong,nonatomic)NSMutableArray* advertisementData1;

@property(strong,nonatomic)NSMutableArray * advertisementImageArray1;

@property(strong,nonatomic)NSMutableArray* advertisementData2;
@property(strong,nonatomic)NSMutableArray * advertisementImageArray2;
@property(strong,nonatomic)NSMutableArray *adData2;//存贮信息

@property(copy,nonatomic)NSString *ad2FirstUrl;
+(id)shareAdvertisementManager;
-(void)startUpdata;
-(NSInteger)dataState;

@end
