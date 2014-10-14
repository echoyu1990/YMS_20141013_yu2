//
//  SearchRestaurantViewController.m
//  YMSAPP
//
//  Created by vanceinfo on 14-10-11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "SearchRestaurantViewController.h"
#import "SearchRestuarantTableViewCell.h"
#import "YMSAppDelegate.h"
#define queryStoreByCityAndKeyword 1001//根据关键字查询门店
@interface SearchRestaurantViewController ()
@property (strong, nonatomic) IBOutlet UITableView *restaurantTableView;
@property (strong,nonatomic) NSString * strKeyWord;
@property (strong,nonatomic) NSArray * arrayRestaurant;
- (IBAction)searchButtonClick:(id)sender;

@end

@implementation SearchRestaurantViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UITableViewDataSoure数据源方法和表格协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayRestaurant count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchRestuarantTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//选中表格时不是高亮状态
    
    NSString * strImage = self.arrayRestaurant[indexPath.row][8];
    cell.imageRestuarant.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strImage]]];
    cell.labelRestaurantName.text = self.arrayRestaurant[indexPath.row][1];
    cell.labelRestautantAddress.text = self.arrayRestaurant[indexPath.row][2];
    cell.labelMoney.text = [NSString stringWithFormat:@"￥%@",self.arrayRestaurant[indexPath.row][6]];
    
    
    NSString * score = [NSString stringWithFormat:@"%@",self.arrayRestaurant[indexPath.row][7]];
    if ([score isEqualToString:@"1"]) {
        [cell.commentStar1 setHighlighted:YES];
    }else if ([score isEqualToString:@"2"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
    }else if ([score isEqualToString:@"3"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
        [cell.commentStar3 setHighlighted:YES];
    }else if ([score isEqualToString:@"4"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
        [cell.commentStar3 setHighlighted:YES];
        [cell.commentStar4 setHighlighted:YES];
    }else if ([score isEqualToString:@"5"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
        [cell.commentStar3 setHighlighted:YES];
        [cell.commentStar4 setHighlighted:YES];
        [cell.commentStar5 setHighlighted:YES];
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
    myAppDelegate.strStoreCode = self.arrayRestaurant[indexPath.row][0];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchButtonClick:(id)sender {
    self.strKeyWord = self.textKeyWord.text;
    [self.textKeyWord resignFirstResponder];
    YMSWebHttpRequest * request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSData *str1 = [@"北京市" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result1 = [[NSString alloc]initWithData:str1 encoding:NSUTF8StringEncoding];
    
    NSData * str2 = [self.strKeyWord dataUsingEncoding:NSUTF8StringEncoding];
    NSString * result2 = [[NSString alloc]initWithData:str2 encoding:NSUTF8StringEncoding];
    
    NSArray * array = @[@"method",@"appName",@"appPwd",@"city",@"keywords",@"type"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByCityAndKeyword",@"method",@"order",@"appName",@"order",@"appPwd",result1,@"city",result2,@"keywords",@"1",@"type", nil];
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryStoreByCityAndKeyword rankKeyArray:array postData:dic delegate:self];
    [self.restaurantTableView reloadData];
}
-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == queryStoreByCityAndKeyword) {
        self.arrayRestaurant = [jsonDic objectForKey:@"data"];
        NSLog(@"restaurant:%@",jsonDic);
        NSLog(@"self.restaurant:%@",self.arrayRestaurant);
        
        [self.restaurantTableView reloadData];
    }
}
@end
