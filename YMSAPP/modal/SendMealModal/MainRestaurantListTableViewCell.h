//
//  MainRestaurantListTableViewCell.h
//  YMSAPP
//
//  Created by He lingzhi on 9/4/14.
//  Copyright (c) 2014 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainRestaurantListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *companyPhoto;

@property (weak, nonatomic) IBOutlet UILabel *companyName;

@property (weak, nonatomic) IBOutlet UILabel *companyAddress;

@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIImageView *commentsImageView;

@end

