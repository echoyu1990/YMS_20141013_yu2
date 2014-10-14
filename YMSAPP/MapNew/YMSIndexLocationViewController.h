//
//  YMSIndexLocationViewController.h
//  YMSAPP
//
//  Created by 介扬 on 14-10-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@interface YMSIndexLocationViewController : UIViewController <MAMapViewDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MAMapView *mapView;
@end
