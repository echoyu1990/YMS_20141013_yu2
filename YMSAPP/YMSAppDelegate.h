//
//  YMSAppDelegate.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14-8-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderInfo.h"

#import "FMDatabase.h"

#import "WXApi.h"

#define MyDBName  @"MyDataBase.sqlite"


@interface YMSAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
//by yulongzhen

@property (strong,nonatomic) NSString * mark;//区分餐厅简介的来源是轮播还是cell或者预定点餐
@property (strong,nonatomic) NSString * mark2;//区分登陆来自预定点餐还是“我的”登陆
// for map
@property (assign,nonatomic) float longitude;
@property (assign,nonatomic) float latitude;
//----- by helz for dish order

@property (assign,nonatomic) int number;
@property (nonatomic, strong) NSString * strTotalPrice ;
@property (nonatomic, strong) NSString * strOrderQuantity;

@property (nonatomic, strong) NSString * strStoreCode;


@property (nonatomic,strong) NSMutableArray * arrDishOrder;


@property (nonatomic,strong) NSMutableArray * detailInformationOfDish;

@property (nonatomic,strong) NSMutableArray * maImageViewOrderStatus;

//for homepage  --

@property (nonatomic,strong) NSMutableArray * maFirstZoneADData;
@property (nonatomic,strong) NSMutableArray * maFirstZoneADataDetail;


@property (nonatomic,strong) NSMutableArray * maSecondZoneADData;
@property (nonatomic,strong) NSMutableArray * maSecondZoneADDataDetail;
@property (nonatomic,strong) NSString *strStatus; 

@property (nonatomic,strong) FMDatabase * myDataBase;

-(void)addOrderNumber:(NSInteger)orderIndex;

-(void)subOrderNumber:(NSInteger)orderIndex;


@end
