//
//  RootMenuTableViewCell.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-9.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subMenuTableViewCell.h"

@interface RootMenuTableViewCell : UITableViewCell

@property (strong,nonatomic) subMenuTableViewCell *submenutableview;

@property (strong, nonatomic) IBOutlet UIImageView *dishView;
@property (strong, nonatomic) IBOutlet UILabel *dishName;
@property (strong, nonatomic) IBOutlet UILabel *dishPrice;
@property (strong, nonatomic) IBOutlet UILabel *dishUnit;
@property (strong, nonatomic) IBOutlet UIImageView *orderlabel;

@property (weak, nonatomic) IBOutlet UIButton *orderButton;

@end
