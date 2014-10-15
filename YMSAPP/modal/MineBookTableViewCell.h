//
//  MineBookTableViewCell.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineBookTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageRestaurant;
@property (strong, nonatomic) IBOutlet UILabel *labelOrderTime;
@property (strong, nonatomic) IBOutlet UILabel *labelRestaurantName;
@property (strong, nonatomic) IBOutlet UILabel *labelNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelPhoneNumber;
@property (strong, nonatomic) IBOutlet UILabel *labelPayWay;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelOrderStatus;

@end
