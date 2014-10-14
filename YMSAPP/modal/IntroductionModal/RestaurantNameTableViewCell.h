//
//  RestaurantNameTableViewCell.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantNameTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *restaurantPhoto;

@property (weak, nonatomic) IBOutlet UILabel *restaurantName;

@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
