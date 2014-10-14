//
//  YMSMenuMapViewController.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14/9/19.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface YMSMenuMapViewController : UIViewController<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (strong, nonatomic) NSString *adress;

@end
