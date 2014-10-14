//
//  myAddressCell.m
//  iWish
//
//  Created by 介扬 on 14-10-10.
//  Copyright (c) 2014年 介扬. All rights reserved.
//

#import "myAddressCell.h"

@implementation myAddressCell

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

-(void)setName:(NSString *)name{
    _nameLabel.text = name;
}
-(void)setAddress:(NSString *)address{
    _addressLabel.text = address;
}
@end
