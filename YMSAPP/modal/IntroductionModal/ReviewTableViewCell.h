//
//  ReviewTableViewCell.h
//  YMSAPP
//
//  Created by vanceinfo on 14-10-10.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelUserName;
@property (strong, nonatomic) IBOutlet UILabel *labelUserTime;
@property (strong, nonatomic) IBOutlet UILabel *labelContent;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar1;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar2;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar3;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar4;
@property (strong, nonatomic) IBOutlet UIImageView *commentStar5;

@end
