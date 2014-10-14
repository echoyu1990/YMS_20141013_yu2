//
//  YMSMapViewController.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14/9/11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSPointPassDelegate.h"

@interface YMSMapViewController : UIViewController<YMSPointPassDelegate>

@property (strong, nonatomic) AMapGeoPoint *point;
@property (strong, nonatomic) NSString *adress;

@property(nonatomic,assign) NSObject<YMSHomePassDelegate> *delegate;

@end
