//
//  FirmBottomTableViewCell.h
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirmBottomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *textNumber;
@property (strong, nonatomic) IBOutlet UITextField *textPerson;
@property (strong, nonatomic) IBOutlet UITextField *textPhone;
@property (strong, nonatomic) IBOutlet UITextField *textMore;
@property (strong, nonatomic) IBOutlet UILabel *labelAllMoney;
@property (strong, nonatomic) IBOutlet UILabel *labelPaymoney;
@property (strong, nonatomic) IBOutlet UILabel *labelYearAndDate;
@property (strong, nonatomic) IBOutlet UIButton *cashPayMent;
@property (strong, nonatomic) IBOutlet UIButton *onlinePayMent;






@end
