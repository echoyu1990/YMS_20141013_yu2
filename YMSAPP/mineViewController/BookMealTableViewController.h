//
//  BookMealTableViewController.h
//  MyData
//
//  Created by Rex Ma on 14-8-29.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"

@interface BookMealTableViewController : UITableViewController<YMSWebHttprRequestReceiveDelegate,UITableViewDataSource,UITableViewDelegate>

@end
