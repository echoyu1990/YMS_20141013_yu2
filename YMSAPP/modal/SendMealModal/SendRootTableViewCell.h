//
//  SendRootTableViewCell.h
//  YMSAPP
//
//  Created by Rex Ma on 14-9-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendRootTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dishPhoto;
@property (weak, nonatomic) IBOutlet UILabel *dishName;

@property (weak, nonatomic) IBOutlet UILabel *dishPrice;

@property (weak, nonatomic) IBOutlet UILabel *dishUnit;
@property (weak, nonatomic) IBOutlet UIImageView *orderlabel;
- (IBAction)orderButton:(id)sender;


@end
