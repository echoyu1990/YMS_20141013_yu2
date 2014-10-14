//
//  MessageValidationViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
@interface MessageValidationViewController : UIViewController<YMSWebHttprRequestReceiveDelegate>
@property (strong, nonatomic) IBOutlet UILabel *userMobile;
@property (strong, nonatomic) NSString * memberNo;

@property (strong, nonatomic) NSString * strMobileNumber;
@end
