//
//  DetailMealViewController.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-5.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootMenuTableViewCell.h"
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "subMenuTableViewCell.h"
#import "MBProgressHUD.h"
#import "IntroductionViewController.h"
#import "DishRecordData.h"
#import "UIImageView+WebCache.h"

@interface DetailMealViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate,UISearchBarDelegate>

@property (nonatomic,strong) id detailItem;

@property (strong, nonatomic) MBProgressHUD * hud;
@property (strong, nonatomic) IBOutlet UILabel *accountsInformation;

@property (strong,nonatomic) IntroductionViewController *introductionviewcontroller;
@property (strong, nonatomic) IBOutlet UIButton *buttonAccount;

- (IBAction)introductionButtonClicked:(UIButton *)sender;


- (IBAction)orderButtonClicked:(UIButton *)sender;

@property (nonatomic,strong) NSString * strSearchStatus; 

@property (nonatomic,strong) NSMutableArray * maSearchData;


@property (strong,nonatomic) NSString * strFlag;
@end
