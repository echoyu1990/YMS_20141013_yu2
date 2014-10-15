//
//  LoginAndRegisterViewController.h
//  MyData
//
//  Created by Rex Ma on 14-8-28.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "MainTableViewController.h"
@interface LoginAndRegisterViewController : UIViewController<YMSWebHttprRequestReceiveDelegate>

@property (assign,nonatomic) MainTableViewController<ViewDelegate> * delegate;
- (IBAction)testbutton:(id)sender;


@end
