//
//  CollectTableViewCell.m
//  YMSAPP
//
//  Created by vanceinfo on 14-10-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "CollectTableViewCell.h"

@implementation CollectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end