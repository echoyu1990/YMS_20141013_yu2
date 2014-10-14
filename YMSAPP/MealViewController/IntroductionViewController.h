//
//  IntroductionViewController.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSWebHttpRequest.h"
#import "YMSWebHttprRequestReceiveDelegate.h"
#import "RestaurantNameTableViewCell.h"
#import "RestaurantBannerTableViewCell.h"
#import "RestaurantProfileTableViewCell.h"
#import "BusinessHoursTableViewCell.h"
#import "RestaurantAddressTableViewCell.h"
#import "PhoneNumberTableViewCell.h"
#import "CommentsTableViewCell.h"

@interface IntroductionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YMSWebHttprRequestReceiveDelegate>

@property (strong,nonatomic) id introductiondetailItem;

@property (weak, nonatomic) IBOutlet UITableView *introductionTableView;

@property (strong,nonatomic) NSString *comentsNo;
@property (strong,nonatomic) NSArray *Comentlist;

@property (strong,nonatomic) NSString * mark;
@property (strong,nonatomic) NSString * mark2;
@property (assign,nonatomic) int indexpath;
@end
