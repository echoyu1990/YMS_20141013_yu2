//
//  YMSPAdvertisement.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14/8/27.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSPAdvertisement.h"

@implementation YMSPAdvertisement


-(id)initWithArray:(NSArray *)arraydata
{
    if(self=[super init])
    {
        self.advertisementPart=[arraydata objectAtIndex:0];
        self.advertisementTopic=[arraydata  objectAtIndex:1];
        self.advertisementImageUrl=[arraydata objectAtIndex:2];
        self.advertisementUrl=[arraydata objectAtIndex:3];
        
        NSArray*restaurantMark=@[@"门店编号",@"门店名称",@"门店图片",@"地址",@"电话",@"营业时间",@"简介",@"外卖标识",@"预定标识",@"禁用标识",@"人均",@"评分",@"营业标识",@"起送费",@"送餐费",@"满多少免送餐费",@"优惠标识",@"送餐半径",@"到店付款标识",@"货到付款标识",@"订座标识"];
        
        NSDictionary*temp=[NSDictionary  dictionaryWithObjects:[arraydata objectAtIndex:4] forKeys:restaurantMark];
                           
        
        
        self.adRestaurant=[[YMSAdRestaurant alloc] initWithDic:temp];
        
        
        
    }
    return self;
    
    
    
}


-(BOOL)updateAdrestaurant:(NSArray *)arraydata
{
    if([arraydata  count]>2)
    {
        
        
        self.advertisementPart=[arraydata objectAtIndex:0];
        self.advertisementTopic=[arraydata  objectAtIndex:1];
        self.advertisementImageUrl=[arraydata objectAtIndex:2];
        self.advertisementUrl=[arraydata objectAtIndex:3];
        
        
        NSArray*restaurantMark=@[@"门店编号",@"门店名称",@"门店图片",@"地址",@"电话",@"营业时间",@"简介",@"外卖标识",@"预定标识",@"禁用标识",@"人均",@"评分",@"营业标识",@"起送费",@"满多少免送餐费",@"优惠标识",@"送餐半径",@"到店付款标识",@"货到付款标识",@"订座标识"];
        
        NSDictionary*temp=[NSDictionary  dictionaryWithObjects:[arraydata objectAtIndex:4] forKeys:restaurantMark];
        [self.adRestaurant upADrestaurantData:temp];
        return YES;
    }
    else
    {
        return NO;
    }
    
    
    
}
@end
