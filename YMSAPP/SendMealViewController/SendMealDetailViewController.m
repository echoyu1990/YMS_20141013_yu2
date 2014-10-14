//
//  SendMealDetailViewController.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "SendMealDetailViewController.h"
#import "SendRootTableViewCell.h"
#import "SendSubTableViewCell.h"
#define queryDishByStoreCode 1005

@interface SendMealDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *SendSubTableView;

@property (weak, nonatomic) IBOutlet UITableView *SendRootTableView;

@property (nonatomic,strong) NSString *storeCode;

@property (nonatomic,strong) NSMutableArray *styleofdish;//菜系的名字

@property (nonatomic,strong) NSArray *numberOfDishSection;//rootview中的section数量

@property (nonatomic) NSInteger numberOfDishes;//菜系的数量

@property (nonatomic,strong) NSMutableArray *detailInformationOfDish;

@end

@implementation SendMealDetailViewController

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
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    //[self createDetailMeal];
    [self performSelector:@selector(createSendDetailMenu) withObject:nil afterDelay:0.1];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:_SendRootTableView]) {
        return 2;
    }
    else if ([tableView isEqual:_SendSubTableView]) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_SendSubTableView]) {
        return 2;
    }
    
    else if([tableView isEqual:_SendRootTableView]){
        if (section == 0) {
            return 23;
        }
        else {
            return 21;
        }
    }
    
    return 0;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_SendSubTableView]) {
        return @"";
    }
    else if([tableView isEqual:_SendRootTableView]){
        if(section == 0)
        {
            return @"荤菜";
        }
        else if(section == 1){
            return @"素菜";
        }
    }
    
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual: _SendRootTableView])
        return 90 ;
    
    else if ([tableView isEqual: _SendSubTableView])
        return 50 ;
    
    return 60 ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 显示右侧列表food menu
    
    if ([tableView isEqual:_SendRootTableView]) {
        
        SendRootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendDetailDishCell" forIndexPath:indexPath];
        
        //NSLog(@"helz: detailInformation = %@", self.detailInformationOfDish[indexPath.section]);
        
        
        cell.dishName.text = self.detailInformationOfDish[indexPath.row][@"name"];//菜品名称
        
        NSString *price = [NSString stringWithFormat:@"%d",[self.detailInformationOfDish[indexPath.row][@"price"] intValue]];
        
        cell.dishPrice.text = price;//菜品价格
        
        cell.dishUnit.text = self.detailInformationOfDish[indexPath.row][@"unit"];
        
        //cell.dishView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailInformationOfDish[indexPath.row][@"picture"]]]];//菜品图片
        
        
        //cell.orderlabel.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.detailInformationOfDish[indexPath.row][@"orderpicture"]]]];
        
        return cell;
        
    }
    else if ([tableView isEqual:_SendSubTableView]){
        SendSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendStyleOfDishCell" forIndexPath:indexPath];
        
        cell.dishStyle.text = self.styleofdish[indexPath.row][@"name"];
        return cell;
    }
    
    return NULL;
}

-(void)setDetailItem:(id)newsenddetailItem{
    if (_detailItem != newsenddetailItem) {
        _detailItem = newsenddetailItem;
        NSLog(@"the newsenddetailItem is %@",_detailItem);
    }
}

-(void)createSendDetailMenu{
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    //NSLog(@"The profile is %@",[_detailItem objectForKey:@"profile"]);
    
    NSArray *array2 = @[@"method",@"appName",@"appPwd",@"storeCode",@"flag"];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryDishByStoreCode",@"method",@"order",@"appName",@"order",@"appPwd",[_detailItem objectForKey:@"storeCode"],@"storeCode",@"1",@"flag", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryDishByStoreCode rankKeyArray:array2 postData:dic2 delegate:self];
}

-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag{
    if (tag == queryDishByStoreCode) {
        //NSLog(@"The information of dishes is %@",jsonDic);
        
        self.detailInformationOfDish = [[NSMutableArray alloc]init];
        self.styleofdish =[[NSMutableArray alloc]init];
        
        NSArray *data = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
        NSArray *data2 = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data2"]];
        
        NSLog(@"data2 is %@",data2);
        
        for (NSArray *dishInformation in data) {
            [self.detailInformationOfDish addObject:@{@"name":[dishInformation objectAtIndex:1],
                                                      @"price":[dishInformation objectAtIndex:5],
                                                      @"unit":[dishInformation objectAtIndex:4],
                                                      @"picture":[dishInformation objectAtIndex:6]
                                                      }];
            //        NSLog (@"helz:[dishInformation objectAtIndex:1]= %@ ",[dishInformation objectAtIndex:1] );
        }
        
        for (NSArray *styleString in data2) {
            //NSLog(@"the style is %@",styleString);
            [self.styleofdish addObject:@{@"name": styleString}];
        }
        
        
        [self.hud hide:YES];
        
        [_SendRootTableView reloadData];
        [_SendSubTableView reloadData];
    }
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

@end
