//
//  MealViewController.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-2.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "DetailMealViewController.h"
#import "YMSPointPassDelegate.h"
#import  "PullTableView.h"


@class AMapGeoPoint;

@class DetailMealViewController;

@interface MealViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate,YMSHomePassDelegate,PullTableViewDelegate>

@property (nonatomic,strong) DetailMealViewController *detailViewController;

@property (nonatomic,strong) NSString * strSize; 

@property (nonatomic,strong) NSString * strFirstLoad;


//@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet PullTableView *myPullTableView;

@property (strong, nonatomic) AMapGeoPoint *point;
- (IBAction)buttonAllTasteList:(id)sender;

- (IBAction)buttonAllStoresList:(id)sender;

- (IBAction)buttonAveragePriceList:(id)sender;

- (IBAction)backToMainPage:(id)sender;
@end
