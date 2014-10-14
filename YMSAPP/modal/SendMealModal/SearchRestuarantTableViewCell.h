//
//  SearchRestuarantTableViewCell.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRestuarantTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageRestuarant;
@property (strong, nonatomic) IBOutlet UILabel *labelRestaurantName;
@property (strong, nonatomic) IBOutlet UILabel *labelRestautantAddress;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar1;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar2;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar3;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar4;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar5;
@property (strong, nonatomic) IBOutlet UILabel *labelMoney;

@end
