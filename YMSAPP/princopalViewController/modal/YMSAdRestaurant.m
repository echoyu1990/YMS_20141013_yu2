//
//  YMSAdRestaurant.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14/8/27.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSAdRestaurant.h"

@implementation YMSAdRestaurant



-(id)initWithDic:(NSDictionary *)dic
{
    if(self=[super init])
    {
        
        NSLog(@"%@",dic);
        if([dic count]>=2)
        {
            
            self.restaurantID=[dic objectForKey:@"门店编号"];//门店编号
            self. restaurantName=[dic objectForKey:@"门店名称"];//门店名称
            self.restaurantPicture=[dic objectForKey:@"门店图片"];//门店图片
            self.restaurantAdress=[dic objectForKey:@"地址"];//  地址
            self. restaurantPhone=[dic objectForKey:@"电话"];//电话
            self.  restaurantShophour=[dic objectForKey:@"营业时间"];//营业时间
            self.  restaurantSynopsis=[dic objectForKey:@"简介"];//简介
            
            
            self. restaurantTakeoutTag=[[dic objectForKey:@"外卖标识"] intValue];//外卖标识
            self. restaurantReserveTag=[[dic objectForKey:@"预定标识"] intValue];//预定标识
            self. restaurantForbidTag=[[dic objectForKey:@"禁用标识"] intValue];//禁用标识
            
            self. restaurantAvgprice=[NSNumber numberWithInt:[[dic objectForKey:@"人均"]intValue]];//人均
            self. restaurantGrade=[NSNumber numberWithInt:[[dic objectForKey:@"评分"] intValue]];//评分
            
            
            
            self.restaurantBusinessTag=[[dic objectForKey:@"营业标识"] intValue];//营业标识
            
            
            self.restaurantOriginPrice=[NSNumber numberWithInt:[[dic objectForKey:@"起送费"]intValue]];//起送费
            self.restaurantSendmeals=[NSNumber numberWithInt:[[dic objectForKey:@"送餐费"]intValue] ];//送餐费
            self.restaurantLimitedOriginPrice=[NSNumber numberWithInt:[[dic objectForKey:@"满多少免送餐费"]intValue]];//满多少免送餐费
            
            
            
            self.  restaurantConcessionalTag=[[dic objectForKey:@"优惠券标识"] intValue];//优惠券标识
            
            
            self.restaurantTakeAwaySemidiameter=[NSNumber numberWithInt:[[dic objectForKey:@"送餐半径"]intValue] ];//送餐半径
            
            
            self. restaurantPaymentTag=[[dic objectForKey:@"到店付款标识"] intValue];//到店付款标识
            self.  restaurantLiveToPaymentTag=[[dic objectForKey:@"货到付款"] intValue];//货到付款标识
            self.restaurantReservationTag=[[dic objectForKey:@"订座标识"] intValue];//订座标识

              
            
            
            
            
        }
        
        
        
        
        
    }
    return self;
    
    
    
}



-(BOOL)upADrestaurantData:(NSDictionary *)dic
{
    if([dic count]>=2)
    {
        
        self.restaurantID=[dic objectForKey:@"门店编号"];//门店编号
        self. restaurantName=[dic objectForKey:@"门店名称"];//门店名称
        self.restaurantPicture=[dic objectForKey:@"门店图片"];//门店图片
        self.restaurantAdress=[dic objectForKey:@"地址"];//  地址
        self. restaurantPhone=[dic objectForKey:@"电话"];//电话
        self.  restaurantShophour=[dic objectForKey:@"营业时间"];//营业时间
        self.  restaurantSynopsis=[dic objectForKey:@"简介"];//简介
        
        
        self. restaurantTakeoutTag=[[dic objectForKey:@"外卖标识"] intValue];//外卖标识
        self. restaurantReserveTag=[[dic objectForKey:@"预定标识"] intValue];//预定标识
        self. restaurantForbidTag=[[dic objectForKey:@"禁用标识"] intValue];//禁用标识
        
        self. restaurantAvgprice=[NSNumber numberWithInt:[[dic objectForKey:@"人均"]intValue]];//人均
        self. restaurantGrade=[NSNumber numberWithInt:[[dic objectForKey:@"评分"] intValue]];//评分
        
        
        
        self.restaurantBusinessTag=[[dic objectForKey:@"营业标识"] intValue];//营业标识
        
        
        self.restaurantOriginPrice=[NSNumber numberWithInt:[[dic objectForKey:@"起送费"]intValue]];//起送费
        self.restaurantSendmeals=[NSNumber numberWithInt:[[dic objectForKey:@"送餐费"]intValue] ];//送餐费
        self.restaurantLimitedOriginPrice=[NSNumber numberWithInt:[[dic objectForKey:@"满多少免送餐费"]intValue]];//满多少免送餐费
        
        
        
        self.  restaurantConcessionalTag=[[dic objectForKey:@"优惠券标识"] intValue];//优惠券标识
        
        
        self.restaurantTakeAwaySemidiameter=[NSNumber numberWithInt:[[dic objectForKey:@"送餐半径"]intValue] ];//送餐半径
        
        
        self. restaurantPaymentTag=[[dic objectForKey:@"到店付款标识"] intValue];//到店付款标识
        self.  restaurantLiveToPaymentTag=[[dic objectForKey:@"货到付款"] intValue];//货到付款标识
        self.restaurantReservationTag=[[dic objectForKey:@"订座标识"] intValue];//订座标识
        return YES;
    
    }
    else
    {
        return NO;
    }
    
    
}
@end
