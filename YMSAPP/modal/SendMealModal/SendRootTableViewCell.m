//
//  SendRootTableViewCell.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "SendRootTableViewCell.h"

@implementation SendRootTableViewCell

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

- (IBAction)orderButton:(id)sender {
}
@end
