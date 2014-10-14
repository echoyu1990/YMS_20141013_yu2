//
//  ResourceOfSendMealTableViewCell.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-4.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResourceOfSendMealTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *companyPhoto;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *companyAddress;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *price;

@end
