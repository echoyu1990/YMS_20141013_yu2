//
//  YMSPrincipalDetailViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-9-29.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootMenuTableViewCell.h"
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "subMenuTableViewCell.h"
#import "MBProgressHUD.h"
#import "IntroductionViewController.h"
@interface YMSPrincipalDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>
@property (nonatomic,strong) id detailItem;

@property (nonatomic,strong ) NSString *strStoreCode; 


@property (strong, nonatomic) MBProgressHUD * hud;
@property (strong, nonatomic) IBOutlet UILabel *accountsInformation;

@property (strong,nonatomic) IntroductionViewController *introductionviewcontroller;
@property (strong, nonatomic) IBOutlet UIButton *buttonAccount;
- (IBAction)buttonAccountButtonClick:(id)sender;

- (IBAction)introductionButtonClicked:(UIButton *)sender;

- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)orderButtonClicked:(UIButton *)sender;
@end
