//
//  YMSPrincipalViewController.h
//  YMSAPP
//
//  Created by gaoxuzhao on 14-8-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "YMSAdvertisementManager.h"
#import "LLARingSpinnerView.h"
#import "YMSPointPassDelegate.h"
#import "DetailMealViewController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"

@interface YMSPrincipalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate,ImagePlayerViewDelegate,YMSHomePassDelegate,UIActionSheetDelegate>

@property(strong,nonatomic)YMSAdvertisementManager* advertisementManager;

@property (strong,nonatomic) DetailMealViewController *detailVC;
@property (strong, nonatomic) IBOutlet UIControl *greyBackground;
@property (strong, nonatomic) AMapGeoPoint *point;
@property (strong, nonatomic) NSString *adress;

@property (strong, nonatomic) MBProgressHUD * hud;
// by helz

@property (nonatomic,strong) NSString * strHomePagePayPic;

@property (nonatomic,strong) NSString * strHomePagePayLink;

@property (weak, nonatomic) IBOutlet UITableView *myHomeTableView;



@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (strong, nonatomic) IBOutlet UILabel *alertviewTitle;
@property (strong, nonatomic) IBOutlet UIImageView *alertviewImage;

- (IBAction)backMainPage:(id)sender;
- (IBAction)ordering:(id)sender;
- (IBAction)delievery:(id)sender;




@end
