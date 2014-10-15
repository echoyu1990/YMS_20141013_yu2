//
//  BookMealTableViewController.m
//  MyData
//
//  Created by Rex Ma on 14-8-29.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import "BookMealTableViewController.h"
#import "MineBookTableViewCell.h"
#define queryOrderListByLoginName 200
@interface BookMealTableViewController (){
    NSMutableArray *bookMeal;
    NSString *bookMealString;
}

@property (strong,nonatomic) NSArray * arrayData;
- (IBAction)detailsButtonClick:(id)sender;

@end

@implementation BookMealTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self createbook];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source 和delegate方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.arrayData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    //return [bookMeal[section] count];
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookMealCell" forIndexPath:indexPath];
//    
//    // Configure the cell...
//    cell.textLabel.text = bookMeal[indexPath.section][indexPath.row][@"restaurant"];
//    cell.detailTextLabel.text = bookMeal[indexPath.section][indexPath.row][@"price"];
//    cell.imageView.image = [UIImage imageNamed:bookMeal[indexPath.section][indexPath.row][@"picture"]];
    
    MineBookTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineBookCell" forIndexPath:indexPath];
    cell.labelOrderTime.text = self.arrayData[indexPath.section][8];
    
    NSString * strImage = self.arrayData[indexPath.section][10];
    cell.imageRestaurant.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strImage]]];
    cell.labelRestaurantName.text = self.arrayData[indexPath.section][11];
    cell.labelNumber.text = [NSString stringWithFormat:@"%@",self.arrayData[indexPath.section][0]];
    cell.labelPhoneNumber.text = [NSString stringWithFormat:@"%@",self.arrayData[indexPath.section][2]];
    NSString * payType = [NSString stringWithFormat:@"%@",self.arrayData[indexPath.section][15]];
    if ([payType isEqualToString:@"0"]) {
        cell.labelPayWay.text = @"货到付款";
    }else if ([payType isEqualToString:@"1"]){
        cell.labelPayWay.text = @"线上支付";
    }
    
    cell.labelPrice.text = [NSString stringWithFormat:@"￥%@",self.arrayData[indexPath.section][3]];
    
    NSString * strOrderStatus = [NSString stringWithFormat:@"%@",self.arrayData[indexPath.section][7]];
    
    if ([strOrderStatus isEqualToString:@"0"]) {
        cell.labelOrderStatus.text = @"未申请";
    }else if ([strOrderStatus isEqualToString:@"1"]){
        cell.labelOrderStatus.text = @"申请";
    }else if ([strOrderStatus isEqualToString:@"2"]){
        cell.labelOrderStatus.text = @"商家受理";
    }else if ([strOrderStatus isEqualToString:@"3"]){
        cell.labelOrderStatus.text = @"商家不受理";
    }else if ([strOrderStatus isEqualToString:@"4"]){
        cell.labelOrderStatus.text = @"完成退款";
    }else if ([strOrderStatus isEqualToString:@"5"]){
        cell.labelOrderStatus.text = @"取消申请";
    }
    
    
    return cell;
}



//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
////    bookMealString = @"";
////    return bookMealString;
//    
//}

-(void)createbook{
    YMSWebHttpRequest *requestbook = [YMSWebHttpRequest shareInterfaceYMSRequest];
    //    [requestbook requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/takeOutOrderWMService" Tag:queryOrderListByLoginName rankKeyArray:@[@"method",@"appName",@"appPwd",@"orderNum",@"loginName",@"password"] postData:@{@"method": @"queryOrderInfoByOrderNum",@"appName":@"order",@"appPwd":@"order",@"orderNum":@"YD1407220916489",@"loginName":@"rex",@"password":@"qwerty"} delegate:self];
    NSArray * array = @[@"method",@"appName",@"appPwd",@"loginName",@"orderType",@"password"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryOrderListByLoginName",@"method",@"order",@"appName",@"order",@"appPwd",[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"],@"loginName",@"1",@"orderType",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"],@"password", nil];
    [requestbook requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/takeOutOrderWMService" Tag:queryOrderListByLoginName rankKeyArray:array postData:dic delegate:self];
    
    
}


-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
//    NSString *message;
//    NSInteger numberOfdata2;
//    message = [jsonDic objectForKey:@"message"];
//    NSMutableArray *data1,*data2;
//    
//    if ([message isEqualToString:@"查询成功!"] == NO) {
//        [data1 initWithArray:[jsonDic objectForKey:@"data1"]];
//        [data2 initWithArray:[jsonDic objectForKey:@"data2"]];
//    }
//    
//    
//    for (numberOfdata2 = 0; numberOfdata2 < [data2 count]; numberOfdata2++) {
//        
//    }
    if (tag == queryOrderListByLoginName) {
        self.arrayData = [jsonDic objectForKey:@"data"];
        NSLog(@"ylzself.arrayData:%@",self.arrayData);
        NSLog(@"ylzself.arrayData:%@",jsonDic);
        [self.tableView reloadData];
    }
}

-(void)ymsRequestFailed:(ASIHTTPRequest *)request{
    [request responseString];
}

//-(void)ymsRequestFinished:(ASIHTTPRequest *)request{
//   NSString*temp= [request responseString];
//    NSLog(@"%@",temp);
//}






// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)detailsButtonClick:(id)sender {
    
    
}
@end
