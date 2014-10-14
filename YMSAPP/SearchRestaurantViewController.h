//
//  SearchRestaurantViewController.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
@interface SearchRestaurantViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textKeyWord;

@end
