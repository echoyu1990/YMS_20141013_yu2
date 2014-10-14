//
//  YMSPointPassDelegate.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14/9/12.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AMapGeoPoint;
@protocol YMSPointPassDelegate <NSObject>

-(void)passValue:(AMapGeoPoint *)value;
-(void)passAdress:(NSString *)adress;

@end

@protocol YMSHomePassDelegate <NSObject>

-(void)homePassValue:(AMapGeoPoint *)value;
-(void)homePassAdress:(NSString *)adress;

@end
