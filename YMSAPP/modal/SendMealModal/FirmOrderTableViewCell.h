//
//  FirmOrderTableViewCell.h
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirmOrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ylzDishImage;
@property (strong, nonatomic) IBOutlet UILabel *ylzDishName;
@property (strong, nonatomic) IBOutlet UILabel *ylzDishPrice;
@property (strong, nonatomic) IBOutlet UILabel *ylzTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderNumber;


@property (strong, nonatomic) IBOutlet UIButton *ylzAddButtonClick;

@property (strong, nonatomic) IBOutlet UIButton *ylzMinusButtonClick;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;



@end
