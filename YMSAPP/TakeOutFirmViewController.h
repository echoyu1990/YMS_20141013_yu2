//
//  TakeOutFirmViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-9.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirmOrderTableViewCell.h"
#import "FirmBottomTableViewCell.h"
#import "FirmAddressTableViewCell.h"
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
@interface TakeOutFirmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>

//by yu
- (IBAction)cashPayMoneyButtonClick:(id)sender;
- (IBAction)onlinePayMoneyButtonClick:(id)sender;
- (IBAction)yearAndDAteButtonClick:(id)sender;


- (IBAction)timeButtonClick:(id)sender;
@end
