//
//  YMSAdRestaurant.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14/8/27.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMSAdRestaurant : NSObject
@property(copy,nonatomic)NSString* restaurantID;//商店编号
@property(copy,nonatomic)NSString* restaurantName;//商店名称
@property(copy,nonatomic)NSString* restaurantPicture;//商店图片
@property(copy,nonatomic)NSString* restaurantAdress;//  商店地址
@property(copy,nonatomic)NSString* restaurantPhone;//商店电话
@property(copy,nonatomic)NSString*  restaurantShophour;//商店营业时间
@property(copy,nonatomic)NSString*  restaurantSynopsis;//简介
@property(assign,nonatomic)BOOL  restaurantTakeoutTag;//外卖标识
@property(assign,nonatomic)BOOL  restaurantReserveTag;//预定标识
@property(assign,nonatomic)BOOL  restaurantForbidTag;//禁用标识
@property(copy,nonatomic)NSNumber*  restaurantAvgprice;//人均消费
@property(copy,nonatomic)NSNumber* restaurantGrade;//评分
@property(assign,nonatomic)BOOL restaurantBusinessTag;//营业标识
@property(copy,nonatomic)NSNumber *restaurantOriginPrice;//起送费
@property(copy,nonatomic)NSNumber * restaurantSendmeals;//送餐费
@property(copy,nonatomic)NSNumber *restaurantLimitedOriginPrice;//满多少免送餐费
@property(assign,nonatomic)BOOL  restaurantConcessionalTag;//优惠券标识
@property(copy,nonatomic)NSNumber *restaurantTakeAwaySemidiameter;//送餐半径
@property(assign,nonatomic)BOOL restaurantPaymentTag;//到店付款标识
@property(assign,nonatomic)BOOL  restaurantLiveToPaymentTag;//货到付款标识
@property(assign,nonatomic)BOOL restaurantReservationTag;//订座标识

/*!
 dic： 字典中应包含  门店的所有的信息
 
 */
-(id)initWithDic:(NSDictionary*)dic;

-(BOOL)upADrestaurantData:(NSDictionary*)dic;
@end
