//
//  SendMealViewController.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-3.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "ResourceOfSendMealTableViewCell.h"
#import "MBProgressHUD.h"
#import "SendMealDetailViewController.h"

@interface SendMealViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>

- (IBAction)backToMainPage:(id)sender;

@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,strong) SendMealDetailViewController *sendmealdetailviewcontroller;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton1;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton2;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton3;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton4;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton5;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton6;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton7;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton8;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton9;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton10;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton11;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton12;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton13;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton14;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton15;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton16;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton17;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton18;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton19;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton20;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton21;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton22;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton23;

@end
