//
//  CollectionTableViewController.m
//  MyData
//
//  Created by Rex Ma on 14-8-31.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "CollectTableViewCell.h"
#import "YMSAppDelegate.h"
#define queryStoreByLoginNo 1001  //查询用户的收藏商家列表信息
@interface CollectionTableViewController ()
@property (strong,nonatomic) NSArray * arrayData;
@property (strong,nonatomic) NSString * strBookMark;//预定标示
@property (strong,nonatomic) NSString * strTakeOutMark;//外卖标识
@end

@implementation CollectionTableViewController

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
    
    [self requestCollectRestaurant];
}

-(void)requestCollectRestaurant
{
    YMSWebHttpRequest * request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array = @[@"method",@"appName",@"appPwd",@"memberNo",@"password"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByLoginNo",@"method",@"order",@"appName",@"order",@"appPwd",[[NSUserDefaults standardUserDefaults] objectForKey:@"userMemberNo"],@"memberNo",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"],@"password", nil];
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/collectionAppService" Tag:1001 rankKeyArray:array postData:dic delegate:self];
}

-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == queryStoreByLoginNo) {
        self.arrayData = [jsonDic objectForKey:@"data"];
        
        
        
        [self.tableView reloadData];
        NSLog(@"ylzself.arrayData:%@",self.arrayData);
        
        NSLog(@"ylzself:%@",jsonDic);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source 和 delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.arrayData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    NSString * strImage = self.arrayData[indexPath.row][2];
    cell.imageRestaurant.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strImage]]];
    cell.labelRestaurantName.text = self.arrayData[indexPath.row][3];
    cell.labelAddress.text = self.arrayData[indexPath.row][4];
    cell.labelPercapita.text = [NSString stringWithFormat:@"￥%@",self.arrayData[indexPath.row][11]];
    
    NSString * score = [NSString stringWithFormat:@"%@",self.arrayData[indexPath.row][12]];
    
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
    myAppDelegate.strStoreCode = [NSString stringWithFormat:@"%@",self.arrayData[indexPath.row][1]];
    
    self.strBookMark = self.arrayData[indexPath.row][9];
    self.strTakeOutMark = self.arrayData[indexPath.row][8];
    
    
    NSString * strRestaurantName = self.arrayData[indexPath.row][3];
    
    if ([self.strBookMark isEqualToString:@"1"] && [self.strTakeOutMark isEqualToString:@"1"]) {
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:strRestaurantName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预定",@"外卖", nil];
        [actionSheet showInView:self.view];
    }else if ([self.strBookMark isEqualToString:@"1"]){
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:strRestaurantName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预定", nil];
        [actionSheet showInView:self.view];
    }else if ([self.strTakeOutMark isEqualToString:@"1"]){
        UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:strRestaurantName delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"外卖", nil];
        [actionSheet showInView:self.view];
    }
}
#pragma mark--UIActionSheet协议方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"预定");
        [self performSegueWithIdentifier:@"COLLECTION_TO_ORDER" sender:self];
        
    }else if (buttonIndex == 1){
        NSLog(@"外卖");
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

@end
