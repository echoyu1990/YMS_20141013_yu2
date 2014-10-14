//
//  FirmOrderViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirmOrderTableViewCell.h"
#import "FirmBottomTableViewCell.h"
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
@interface FirmOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>
//@property (strong,nonatomic) NSArray * orderArray;//总订单数

//by yu
- (IBAction)cashPayMoneyButtonClick:(id)sender;
- (IBAction)onlinePayMoneyButtonClick:(id)sender;
- (IBAction)yearAndDAteButtonClick:(id)sender;


- (IBAction)timeButtonClick:(id)sender;
@end
