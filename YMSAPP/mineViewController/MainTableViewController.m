//
//  MainTableViewController.m
//  MyData
//
//  Created by Rex Ma on 14-8-27.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import "MainTableViewController.h"
#import "NavigationPageViewController.h"
#import "LoginAndRegisterViewController.h"
@interface MainTableViewController ()
{
    NSMutableArray *dataGroup;
    NSMutableArray *dataString;
}

@end

@implementation MainTableViewController


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
    
    [self createData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //self.hidesBottomBarWhenPushed = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [dataGroup count];
    //NSLog(@ "numberofsections= %lu",(unsigned long)[self.dataGroup count]);
    //NSLog(@"reach number of section");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataGroup[section] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return dataString[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell" forIndexPath:indexPath];
    
    cell.textLabel.text = dataGroup[indexPath.section][indexPath.row][@"name"];
    cell.imageView.image = [UIImage imageNamed:dataGroup[indexPath.section][indexPath.row][@"picture"]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] != nil && indexPath.section == 0) {
        UIButton * cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 250, 60, 30)];
        [cancelButton setTitle:@"注销" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cancelButton];
    }

    // Configure the cell...
    
    return cell;
}
-(void)cancel
{
    self.strUserName = nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"MAIN_TO_LOGIN_AND_REGISTER" sender:self];
                break;
                
            default:
                break;
        }
    }else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] != nil) {
        if(indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"MAIN_TO_TAKE_OUT" sender:self];
                    break;
                    
                case 1:
                    [self performSegueWithIdentifier:@"MAIN_TO_BOOK_MEAL" sender:self];
                    break;
                    
                case 2:
                    [self performSegueWithIdentifier:@"MAIN_TO_COLLECTION" sender:self];
                    break;
                    
                case 3:
                    [self performSegueWithIdentifier:@"MAIN_TO_TICKET_BAG" sender:self];
                    break;
                    
                default:
                    break;
            }
        }
        
        if (indexPath.section == 2) {
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"MAIN_TO_ADDRESS" sender:self];
                    break;
                    
                case 1:
                    //                    [self performSegueWithIdentifier:@"MAIN_TO_NAVIGATION" sender:self];
                {
                    //点击进入导航页面
                    
                    
//                    UIStoryboard * navigationStotyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    NavigationPageViewController * navigationPageView  = [navigationStotyBoard instantiateViewControllerWithIdentifier:@"NavigationPageView"];
//                    [self presentViewController:navigationPageView animated:NO completion:nil];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
    }else{
        if (indexPath.section == 2 && indexPath.row == 1) {
            //[self performSegueWithIdentifier:@"MAIN_TO_NAVIGATION" sender:self];
//            UIStoryboard * navigationStotyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            NavigationPageViewController * navigationPageView  = [navigationStotyBoard instantiateViewControllerWithIdentifier:@"NavigationPageView"];
            //[self presentViewController:navigationPageView animated:NO completion:nil];
        }else if([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] == nil){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"您还没有登录，请先登录！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerMethod:) userInfo:alert repeats:YES];
            [alert show];
        }
    }
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)timerMethod:(NSTimer *)theTimer
{
    UIAlertView * alert = (UIAlertView *)[theTimer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    alert = NULL;
}

-(void)createData{
    NSMutableArray *login,*mydata,*configure;
    [dataString addObject:@""];
    [dataString addObject:@""];
    [dataString addObject:@""];
    
    login = [[NSMutableArray alloc]init];
    mydata = [[NSMutableArray alloc]init];
    configure = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"] == nil) {
        [login addObject:@{@"name": @"点击登录",
                           @"picture":@"brand_default_head.png"}];
    }else{
        [login addObject:@{@"name": [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"],
                           @"picture":@"brand_default_head.png"}];
    }
    [mydata addObject:@{@"name": @"我的外卖",
                        @"picture":@"wdwm.png"}];
    [mydata addObject:@{@"name": @"我的订餐",
                        @"picture":@"wdyd.png"}];
    [mydata addObject:@{@"name": @"我的收藏",
                        @"picture":@"wdsc.png"}];
    [mydata addObject:@{@"name": @"我的券包",
                        @"picture":@"myjb.png"}];
    
    [configure addObject:@{@"name": @"地址管理",
                           @"picture":@"share.png"}];
    [configure addObject:@{@"name": @"导航页面",
                           @"picture":@"us.png"}];
    
    dataGroup = [@[login,mydata,configure] mutableCopy];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([[segue identifier]isEqualToString:@""]) {
//        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    }
    
    if ([segue.identifier isEqualToString:@"MAIN_TO_LOGIN_AND_REGISTER"]) {
        LoginAndRegisterViewController * loginAndRegister = (LoginAndRegisterViewController *)[segue destinationViewController];
        loginAndRegister.delegate = self;
    }

}
-(void)passValue:(NSString *)value
{
    self.strUserName = value;
}

@end
