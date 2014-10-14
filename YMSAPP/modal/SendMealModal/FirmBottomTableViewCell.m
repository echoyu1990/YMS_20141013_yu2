//
//  FirmBottomTableViewCell.m
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "FirmBottomTableViewCell.h"

@implementation FirmBottomTableViewCell

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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textNumber resignFirstResponder];
    [self.textPerson resignFirstResponder];
    [self.textPhone resignFirstResponder];
    [self.textMore resignFirstResponder];
}
@end
