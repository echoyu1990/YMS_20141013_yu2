//
//  CollectTableViewCell.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageRestaurant;
@property (strong, nonatomic) IBOutlet UILabel *labelRestaurantName;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelDistance;
@property (strong, nonatomic) IBOutlet UILabel *labelPercapita;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar1;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar2;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar3;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar4;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar5;

@end
