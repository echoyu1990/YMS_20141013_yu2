//
//  BookMealTableViewController.m
//  MyData
//
//  Created by Rex Ma on 14-8-29.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import "BookMealTableViewController.h"

@interface BookMealTableViewController (){
    NSMutableArray *bookMeal;
    NSString *bookMealString;
}


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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [bookMeal[section] count];
}



-(void)createbook{
    YMSWebHttpRequest *requestbook = [YMSWebHttpRequest shareInterfaceYMSRequest];
    [requestbook requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/takeOutOrderWMService" Tag:200 rankKeyArray:@[@"method",@"appName",@"appPwd",@"orderNum",@"loginName",@"password"] postData:@{@"method": @"queryOrderInfoByOrderNum",@"appName":@"order",@"appPwd":@"order",@"orderNum":@"YD1407220916489",@"loginName":@"rex",@"password":@"qwerty"} delegate:self];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    bookMealString = @"";
    return bookMealString;
}

-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag{
    NSString *message;
    NSInteger numberOfdata2;
    message = [jsonDic objectForKey:@"message"];
    NSMutableArray *data1,*data2;
    
    if ([message isEqualToString:@"查询成功!"] == NO) {
        [data1 initWithArray:[jsonDic objectForKey:@"data1"]];
        [data2 initWithArray:[jsonDic objectForKey:@"data2"]];
    }
    
    
    for (numberOfdata2 = 0; numberOfdata2 < [data2 count]; numberOfdata2++) {
        
    }
}

-(void)ymsRequestFailed:(ASIHTTPRequest *)request{
    [request responseString];
}

//-(void)ymsRequestFinished:(ASIHTTPRequest *)request{
//   NSString*temp= [request responseString];
//    NSLog(@"%@",temp);
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookMealCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = bookMeal[indexPath.section][indexPath.row][@"restaurant"];
    cell.detailTextLabel.text = bookMeal[indexPath.section][indexPath.row][@"price"];
    cell.imageView.image = [UIImage imageNamed:bookMeal[indexPath.section][indexPath.row][@"picture"]];
    
    return cell;
}



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

@end
