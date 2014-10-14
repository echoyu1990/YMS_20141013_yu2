//
//  myAddressCell.h
//  iWish
//
//  Created by 介扬 on 14-10-10.
//  Copyright (c) 2014年 介扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myAddressCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@end
