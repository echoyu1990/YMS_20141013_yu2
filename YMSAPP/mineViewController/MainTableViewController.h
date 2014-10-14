//
//  MainTableViewController.h
//  MyData
//
//  Created by Rex Ma on 14-8-27.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewDelegate<NSObject>
-(void)passValue:(NSString *)value;
@end
@interface MainTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,ViewDelegate>
@property (strong,nonatomic)NSString * strUserName;
@end
