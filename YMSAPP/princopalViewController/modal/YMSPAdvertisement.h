//
//  YMSPAdvertisement.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14/8/27.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMSAdRestaurant.h"

@interface YMSPAdvertisement : NSObject
@property(copy,nonatomic)NSString* advertisementPart;//广告模块
@property(copy,nonatomic) NSString * advertisementTopic;//广告主题
@property(copy,nonatomic)NSString*advertisementImageUrl;//图片链接
@property(copy,nonatomic)NSString*advertisementUrl;//链接
@property(strong,nonatomic) YMSAdRestaurant *adRestaurant;//门店信息

-(id)initWithArray:(NSArray*)arraydata;
-(BOOL)updateAdrestaurant:(NSArray*)arraydata;

@end
