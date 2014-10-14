//
//  YMSMessageViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-9-30.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
@interface YMSMessageViewController : UIViewController<YMSWebHttprRequestReceiveDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textPhone;
@property (strong, nonatomic) IBOutlet UITextField *textMessage;
- (IBAction)getMessageButtonClick:(id)sender;
- (IBAction)confirmButtonClick:(id)sender;

@end
