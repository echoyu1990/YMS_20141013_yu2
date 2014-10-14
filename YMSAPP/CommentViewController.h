//
//  CommentViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-10.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewTableViewCell.h"
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>

@end
