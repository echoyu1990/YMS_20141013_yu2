//
//  SendMealDetailViewController.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "MBProgressHUD.h"

@interface SendMealDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,YMSWebHttprRequestReceiveDelegate>

@property (nonatomic,strong) id detailItem;

@property (nonatomic,strong) MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UIButton *searchButtonClicked;

@end
