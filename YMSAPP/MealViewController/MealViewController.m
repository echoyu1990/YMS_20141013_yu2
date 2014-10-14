//
//  MealViewController.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-2.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "MealViewController.h"
#import "MainRestaurantListTableViewCell.h"
#import "YMSMapViewController.h"
#import "GeoViewController.h"
#import "YMSAPP-Prefix.pch"
#import "UIImageView+WebCache.h"
#import "DetailMealViewController.h"
#import "YMSAppDelegate.h"
#define queryStoreByCityAndOther 1002
#define queryStoreTasteTypeByCity 1006
#define uploaded 1007


@interface MealViewController ()

@property (nonatomic,strong) NSMutableArray *restaurant;
@property (nonatomic,strong) NSString *linkOfString;
@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,strong) NSArray * myTasteArray;
@property (strong, nonatomic) IBOutlet UIView *ylzAllTasteView;
@property (strong, nonatomic) IBOutlet UIView *ylzAllStoresView;

@property (strong, nonatomic) IBOutlet UIButton *allTaste;
@property (strong, nonatomic) IBOutlet UIButton *allStore;
@property (strong, nonatomic) IBOutlet UIButton *allperson;

@property (nonatomic) NSInteger numberOfData;//加载的数据行
@property (nonatomic) NSInteger numberOfPageSize;//
@property (nonatomic) NSInteger startIndex;//开始加载的未知

@property (strong, nonatomic) IBOutlet UIView *ylzAllPerson;
@property (assign,nonatomic) BOOL isShowTasteView;//全部口味子视图是否出现
@property (assign,nonatomic) BOOL isShowStoreView;
@property (assign,nonatomic) BOOL isShowPersonView;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton1;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton2;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton3;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton4;
@property (strong, nonatomic) IBOutlet UIButton *tastebutton5;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton6;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton7;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton8;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton9;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton10;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton11;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton12;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton13;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton14;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton15;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton16;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton17;
@property (strong, nonatomic) IBOutlet UIButton *tasteButton18;
- (IBAction)tasteButton:(id)sender;
- (IBAction)allstore:(id)sender;
- (IBAction)personButton:(id)sender;

@end

@implementation MealViewController

#pragma mark----实现 YMSPointPassDelegate

-(void)homePassValue:(AMapGeoPoint *)value
{
    self.point = value;
    NSLog(@"----------%f,%f",value.latitude,value.longitude);
}
-(void)homePassAdress:(NSString *)adress
{
    
}


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
    
     //初始化
    self.restaurant = [[NSMutableArray alloc]init];
    [self.restaurant removeAllObjects];
    
    //self.startIndex = 10;  // load more skip start from 下标 10
    
    self.strFirstLoad =@"0" ;  // 第一次加载数据

    //----refresh 初始化
    self.myPullTableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.myPullTableView.pullBackgroundColor = [UIColor lightGrayColor];
    self.myPullTableView.pullTextColor = [UIColor blackColor];

    //-----
    [self performSelector:@selector(createBookMeal) withObject:nil afterDelay:0.1];
   
    self.isShowTasteView = NO;
    self.isShowStoreView = NO;
    self.isShowPersonView = NO;
    
    //[self setupRefresh];
    
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if(!self.myPullTableView.pullTableIsRefreshing) {
        self.myPullTableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    }
}

*/



 -(void) loadMoreData {

    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSUserDefaults * myUserDefaults  = [NSUserDefaults standardUserDefaults];
    
    NSNumber * floatNumberLatitude = [ myUserDefaults                            objectForKey:@"locallatitude"];
    
    float floatLatitude=[floatNumberLatitude floatValue];
    
    NSNumber * floatNumberlongitude = [ myUserDefaults                            objectForKey:@"locallongitude"];
    
    float floatLongitude=[floatNumberlongitude floatValue];
    
    NSString *cityName = [myUserDefaults objectForKey:@"city"];
    NSLog(@"the city name is %@",cityName);
    
#ifdef  IN_SIMULATOR
    cityName =@"北京市" ;
#else
    
#endif
    
    NSString *districtName = [myUserDefaults objectForKey:@"district"];
    NSLog(@"the district name is %@",districtName);
    
    NSData *city = [cityName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc]initWithData:city encoding:NSUTF8StringEncoding];
    
   NSData *district = [districtName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *districtInformation = [[NSString alloc]initWithData:district encoding:NSUTF8StringEncoding];
    
    NSString *strLatitude = [NSString stringWithFormat:@"%f",floatLatitude];
    
    NSString *strLongitude = [NSString stringWithFormat:@"%f",floatLongitude];
    
    NSString *taste;
    NSString *store;
    
    NSLog(@"machao:the taste is %@",self.allTaste.titleLabel.text);
    NSLog(@"machao:the store is %@",self.allStore.titleLabel.text);
    NSLog(@"machao:the Average Price is %@",self.allperson.titleLabel.text);
    if ([self.allTaste.titleLabel.text isEqualToString:@"全部口味"]) {
        taste = @"";
    }
    else{

        taste = self.allTaste.titleLabel.text;
    }
    
    if ([self.allStore.titleLabel.text isEqualToString:@"全部门店"]) {
        store = @"";
    }
    else{
        store = @"1";
    }
    
  //  NSString *skipString = [NSString stringWithFormat:@"%d",self.startIndex];//开始页面
    
    NSArray *array2 = @[@"method",@"appName",@"appPwd",@"city",@"area",@"type",@"tasteType",@"recommended",@"perCapitaMin",@"perCapitaMax",@"longitude",@"latitude",@"skip",@"pageSize"];
    
//    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByCityAndOther",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",districtInformation,@"area",@"1",@"type",taste,@"tasteType",@"",@"recommended",@"0",@"perCapitaMin",@"0",@"perCapitaMax",strLongitude,@"longitude",strLatitude,@"latitude",skipString,@"skip",@"10",@"pageSize", nil];
    
     NSString *temp2 = [NSString stringWithFormat:@"%d", ([self.strSize intValue ]-10) ];
     
       NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByCityAndOther",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",districtInformation,@"area",@"1",@"type",taste,@"tasteType",@"",@"recommended",@"0",@"perCapitaMin",@"0",@"perCapitaMax",strLongitude,@"longitude",strLatitude,@"latitude",@"10",@"skip",temp2,@"pageSize", nil];
     
     [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:uploaded rankKeyArray:array2 postData:dic2 delegate:self];
    
}
 



#pragma mark -- UITableViewDataSource方法and UITableViewDelegate方法

/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.restaurant count];
}

/*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *expression = @"";
    return expression;
}
*/

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainRestaurantListTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"restaurantCell" forIndexPath:indexPath];
    
    cell.companyName.text = self.restaurant[indexPath.row][@"name"] ;//餐厅的名称
    
    cell.companyAddress.text = self.restaurant[indexPath.row][@"address"];//餐厅地址
    
    NSString *distance = self.restaurant[indexPath.row][@"distance"];
    float intDistance = [distance floatValue];
    NSString *strDistance= [NSString stringWithFormat:@"%@m",distance];
    
    if (intDistance >= 1000)
    {
        double floatDistance = intDistance /1000;
        strDistance= [NSString stringWithFormat:@"%0.1fkm",floatDistance];
    }
    
    cell.distance.text = strDistance;
    
   
    //cell.companyPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.restaurant[indexPath.row][@"picture"]]]];//餐厅图片
    
   
    [cell.companyPhoto setImageWithURL:[NSURL URLWithString:self.restaurant[indexPath.row][@"picture"]] placeholderImage:[UIImage imageNamed:@"b.png"] ];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailViewController.detailItem = self.restaurant[indexPath.row];
    //[self.navigationItem.backBarButtonItem
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
    myAppDelegate.strStoreCode = [self.restaurant[indexPath.row] objectForKey:@"storeCode"];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"showDetail"]) {
        
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        
        NSIndexPath *indexPath = [self.myPullTableView indexPathForSelectedRow];

        
        [[segue destinationViewController] setDetailItem:self.restaurant[indexPath.row]];
        
        DetailMealViewController * detail = (DetailMealViewController *)segue.destinationViewController;
        detail.strFlag = @"1";
    }
    else if([segue.identifier isEqualToString:@"PRINCIPAL_TO_RESERVE"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        
        YMSMapViewController *mapViewController =(YMSMapViewController *)[nav viewControllers][0];
        
        mapViewController.delegate = self;
        
    }
    
}

-(void)createBookMeal{
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSUserDefaults * myUserDefaults  = [NSUserDefaults standardUserDefaults];
    
    
    NSNumber * floatNumberLatitude = [ myUserDefaults                            objectForKey:@"locallatitude"];
    
    float floatLatitude=[floatNumberLatitude floatValue];
    
    
    NSNumber * floatNumberlongitude = [ myUserDefaults                            objectForKey:@"locallongitude"];
    
    float floatLongitude=[floatNumberlongitude floatValue];
    
    NSString *cityName = [myUserDefaults objectForKey:@"city"];
    NSLog(@"the city name is %@",cityName);
    
#ifdef IN_SIMULATOR
    cityName=@"北京市" ;
#else
    
#endif
    
    NSString *districtName = [myUserDefaults objectForKey:@"district"];
    NSLog(@"the district name is %@",districtName);
    
    NSData *city = [cityName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc]initWithData:city encoding:NSUTF8StringEncoding];
    
    NSData *district = [districtName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *districtInformation = [[NSString alloc]initWithData:district encoding:NSUTF8StringEncoding];
    
    NSString *strLatitude = [NSString stringWithFormat:@"%f",floatLatitude];
    
    NSString *strLongitude = [NSString stringWithFormat:@"%f",floatLongitude];

    NSString *taste;
    NSString *store;
    NSString * averagePriceMin;
    NSString * averagePriceMax;
    
    NSLog(@"machao:the dish is %@",self.allTaste.titleLabel.text);
    NSLog(@"machao:the taste is %@",self.allTaste.titleLabel.text);
    NSLog(@"machao:the store is %@",self.allStore.titleLabel.text);
    NSLog(@"machao:the Average Price is %@",self.allperson.titleLabel.text);
    if ([self.allTaste.currentTitle isEqualToString:@"全部口味"]) {
        taste = @"";
    }
    else{
        //        NSData *tasteName = [self.allTaste.titleLabel.text dataUsingEncoding:NSUTF8StringEncoding];
        //        taste = [[NSString alloc]initWithData:tasteName encoding:NSUTF8StringEncoding];
        taste = self.allTaste.currentTitle;
        NSLog(@"self.allTaste.currentTitle:%@",self.allTaste.currentTitle);
    }
    
    if ([self.allStore.currentTitle isEqualToString:@"推荐门店"]) {
        store = @"1";
    }
    else{
        store = @"";
    }
    
    if ([self.allperson.currentTitle isEqualToString:@"人均不限"]) {
        averagePriceMin = @"0";
        averagePriceMax = @"0";
    }else if ([self.allperson.currentTitle isEqualToString:@"0-20"]){
        averagePriceMin = @"0";
        averagePriceMax = @"20";
    }else if ([self.allperson.currentTitle isEqualToString:@"20-30"]){
        averagePriceMin = @"20";
        averagePriceMax = @"30";
    }else if ([self.allperson.currentTitle isEqualToString:@"30-50"]){
        averagePriceMin = @"30";
        averagePriceMax = @"50";
    }else if ([self.allperson.currentTitle isEqualToString:@"50-100"]){
        averagePriceMin = @"50";
        averagePriceMax = @"100";
    }else if ([self.allperson.currentTitle isEqualToString:@"100以上"]){
        averagePriceMin = @"100";
        averagePriceMax = @"0";
    }
    
    
    NSArray *array2 = @[@"method",@"appName",@"appPwd",@"city",@"area",@"type",@"tasteType",@"recommended",@"perCapitaMin",@"perCapitaMax",@"longitude",@"latitude",@"skip",@"pageSize"];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByCityAndOther",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",districtInformation,@"area",@"1",@"type",taste,@"tasteType",store,@"recommended",averagePriceMin,@"perCapitaMin",averagePriceMax,@"perCapitaMax",strLongitude,@"longitude",strLatitude,@"latitude",@"0",@"skip",@"10",@"pageSize", nil];
    
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryStoreByCityAndOther rankKeyArray:array2 postData:dic2 delegate:self];
    
    [self.myPullTableView reloadData];
}

#pragma mark -- request data from server

- (void)ymsRequestFinishedOfDictionary:(NSDictionary*)jsonDic  Requestoftag:(NSInteger)tag
{
    if(tag == queryStoreByCityAndOther)
    {
        
         [self.restaurant removeAllObjects];
        
        NSArray *data = [[NSArray alloc] initWithArray:[jsonDic objectForKey:@"data"]];
       
        self.strSize = [jsonDic objectForKey:@"size"];
        
        NSLog(@"helz: size= %@", self.strSize) ;
        
        
        for (NSDictionary *information in data) {
      
            //NSLog(@"sss = %@",[information objectForKey:@"distance"]);
            [self.restaurant addObject:@{@"name": [information objectForKey:@"companyName"],
                                         @"address": [information objectForKey:@"companyAddress"],
                                         @"picture":[information objectForKey:@"companyPhoto"],
                                         @"distance":[information objectForKey:@"distance"],
                                         @"storeCode":[information objectForKey:@"companyNo"],
                                         @"comments":[information objectForKey:@"comments"],
                                         @"profile":[information objectForKey:@"introduction"],
                                         @"businessTime":[information objectForKey:@"businessHours"],
                                         @"phoneNumber":[information objectForKey:@"linkPhone"],
                                         
                                         @"perCapita":[information objectForKey:@"perCapita"]}];
            //NSLog(@"the storecode is %@",[information objectForKey:@"companyNo"]);
        }
       
        
        NSLog(@"helz: restaurant data_first_batch= %@",self.restaurant);
        
        
     
        /*
        //2.2秒之后刷新表格
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.hud hide:YES];
            // 刷新表格
            //[self.tableView reloadData];
            
            [self.myPullTableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            //[self.tableView headerEndRefreshing];
            
        });
        */
        
        [self.hud hide:YES];
       
        NSLog(@"helz: spinner stop" );
              
        
        //[self.myTableView reloadData];
        [self.myPullTableView reloadData];

        
    }
    
    if (tag == uploaded) {
        NSArray *data = [[NSArray alloc] initWithArray:[jsonDic objectForKey:@"data"]];
        
        for (NSDictionary *information in data) {
            //NSLog(@"sss = %@",[information objectForKey:@"distance"]);
            [self.restaurant addObject:@{@"name": [information objectForKey:@"companyName"],
                                         @"address": [information objectForKey:@"companyAddress"],
                                         @"picture":[information objectForKey:@"companyPhoto"],
                                         @"distance":[information objectForKey:@"distance"],
                                         @"storeCode":[information objectForKey:@"companyNo"],
                                         @"comments":[information objectForKey:@"comments"],
                                         @"profile":[information objectForKey:@"introduction"],
                                         @"businessTime":[information objectForKey:@"businessHours"],
                                         @"phoneNumber":[information objectForKey:@"linkPhone"],
                                         @"perCapita":[information objectForKey:@"perCapita"]}];
        }
        //self.numberOfData = [self.restaurant count];
       
        
        /*
        // 2.2秒后刷新表格UI
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            //[self.hud hide:YES];
            
            //[self.tableView reloadData];
            
            [self.myPullTableView reloadData];

            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            //[self.tableView footerEndRefreshing];
       });
       */
        
        NSLog(@"helz: restaurant count = %d", [self.restaurant count]) ;
        
        //[self.myTableView reloadData];
        [self.myPullTableView reloadData];

        
        
    }
    
    if (tag == queryStoreTasteTypeByCity) {
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            //NSLog(@"machao:result is %@",[jsonDic objectForKey:@"result"]);
            
            
            // NSArray *tasteData = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
            
            self.myTasteArray =[[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
            NSLog(@"helz: myTasteArray result is %@",self. myTasteArray );
            
            if (self.isShowTasteView == YES) {
                
                self.ylzAllTasteView.hidden = NO;
                
                [self.tasteButton1 setTitle:self.myTasteArray[0] forState:UIControlStateNormal];
                self.tasteButton1.tintColor = [UIColor whiteColor];
                
                [self.tasteButton2 setTitle:self.myTasteArray[1] forState:UIControlStateNormal];
                self.tasteButton2.tintColor = [UIColor whiteColor];
                
                [self.tasteButton3 setTitle:self.myTasteArray[2] forState:UIControlStateNormal];
                self.tasteButton3.tintColor = [UIColor whiteColor];
                
                [self.tasteButton4 setTitle:self.myTasteArray[3] forState:UIControlStateNormal];
                self.tasteButton4.tintColor = [UIColor whiteColor];
                
                [self.tastebutton5 setTitle:self.myTasteArray[4] forState:UIControlStateNormal];
                self.tastebutton5.tintColor = [UIColor whiteColor];
                
                [self.tasteButton6 setTitle:self.myTasteArray[5] forState:UIControlStateNormal];
                self.tasteButton6.tintColor = [UIColor whiteColor];
                
                [self.tasteButton7 setTitle:self.myTasteArray[6] forState:UIControlStateNormal];
                self.tasteButton7.tintColor = [UIColor whiteColor];
                
                [self.tasteButton8 setTitle:self.myTasteArray[7] forState:UIControlStateNormal];
                self.tasteButton8.tintColor = [UIColor whiteColor];
                
                [self.tasteButton9 setTitle:self.myTasteArray[8] forState:UIControlStateNormal];
                self.tasteButton9.tintColor = [UIColor whiteColor];
                
                [self.tasteButton10 setTitle:self.myTasteArray[9] forState:UIControlStateNormal];
                self.tasteButton10.tintColor = [UIColor whiteColor];
                
                [self.tasteButton11 setTitle:self.myTasteArray[10] forState:UIControlStateNormal];
                self.tasteButton11.tintColor = [UIColor whiteColor];
                
                [self.tasteButton12 setTitle:self.myTasteArray[11] forState:UIControlStateNormal];
                self.tasteButton12.tintColor = [UIColor whiteColor];
                
                [self.tasteButton13 setTitle:self.myTasteArray[12] forState:UIControlStateNormal];
                self.tasteButton13.tintColor = [UIColor whiteColor];
                
                [self.tasteButton14 setTitle:self.myTasteArray[13] forState:UIControlStateNormal];
                self.tasteButton14.tintColor = [UIColor whiteColor];
                
                [self.tasteButton15 setTitle:self.myTasteArray[14] forState:UIControlStateNormal];
                self.tasteButton15.tintColor = [UIColor whiteColor];
                
                [self.tasteButton16 setTitle:self.myTasteArray[15] forState:UIControlStateNormal];
                self.tasteButton16.tintColor = [UIColor whiteColor];
                
                [self.tasteButton17 setTitle:self.myTasteArray[16] forState:UIControlStateNormal];
                self.tasteButton17.tintColor = [UIColor whiteColor];
                
                [self.tasteButton18 setTitle:self.myTasteArray[17] forState:UIControlStateNormal];
                self.tasteButton18.tintColor = [UIColor whiteColor];
                
            }else{
                self.ylzAllTasteView.hidden = YES;
                
            }

        }
    }
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
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
- (IBAction)buttonAllTasteList:(id)sender {
    //发送所有口味请求
    YMSWebHttpRequest *tasteRequest = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSUserDefaults *myUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *cityName = [myUserDefaults objectForKey:@"city"];
    
    NSData *city = [cityName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc]initWithData:city encoding:NSUTF8StringEncoding];
    
    NSArray *tasteArray = @[@"method",@"appName",@"appPwd",@"city",@"type"];
    
    NSDictionary *tasteDic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreTasteTypeByCity",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",@"1",@"type",nil];
    
    [tasteRequest requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryStoreTasteTypeByCity rankKeyArray:tasteArray postData:tasteDic delegate:self];
    
    self.ylzAllStoresView.hidden = YES;
    self.ylzAllPerson.hidden = YES;
    self.isShowTasteView = !self.isShowTasteView;
    
    
}



- (IBAction)buttonAllStoresList:(id)sender {
    self.ylzAllPerson.hidden = YES;
    self.ylzAllTasteView.hidden = YES;
    self.isShowStoreView = !self.isShowStoreView;
    if (self.isShowStoreView == YES) {
        self.ylzAllStoresView.hidden = NO;
    }else {
        self.ylzAllStoresView.hidden = YES;
    }

}

- (IBAction)buttonAveragePriceList:(id)sender {
    self.ylzAllTasteView.hidden = YES;
    self.ylzAllStoresView.hidden = YES;
    self.isShowPersonView = !self.isShowPersonView;
    if (self.isShowPersonView == YES) {
        self.ylzAllPerson.hidden = NO;
    }else {
        self.ylzAllPerson.hidden = YES;
    }

}

-(IBAction)backToMainPage:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击某一个口味，allTasteView消失，且button按钮的title为点击的按钮的title
- (IBAction)tasteButton:(id)sender {
    UIButton * tasteButton = (UIButton *)sender;
    if (tasteButton.tag == 1) {
        [self.allTaste setTitle:@"全部口味" forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 2){
        [self.allTaste setTitle:self.myTasteArray[0] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 3){
        [self.allTaste setTitle:self.myTasteArray[1] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 4){
        [self.allTaste setTitle:self.myTasteArray[2] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 5){
        [self.allTaste setTitle:self.myTasteArray[3] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 6){
        [self.allTaste setTitle:self.myTasteArray[4] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 7){
        [self.allTaste setTitle:self.myTasteArray[5] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 8){
        [self.allTaste setTitle:self.myTasteArray[6] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 9){
        [self.allTaste setTitle:self.myTasteArray[7] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 10){
        [self.allTaste setTitle:self.myTasteArray[8] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 11){
        [self.allTaste setTitle:self.myTasteArray[9] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 12){
        [self.allTaste setTitle:self.myTasteArray[10] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 13){
        [self.allTaste setTitle:self.myTasteArray[11] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 14){
        [self.allTaste setTitle:self.myTasteArray[12] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 15){
        [self.allTaste setTitle:self.myTasteArray[13] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 16){
        [self.allTaste setTitle:self.myTasteArray[14] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 17){
        [self.allTaste setTitle:self.myTasteArray[15] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 18){
        [self.allTaste setTitle:self.myTasteArray[16] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }else if (tasteButton.tag == 19){
        [self.allTaste setTitle:self.myTasteArray[17] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }
    
    self.ylzAllTasteView.hidden = YES;
    //NSLog(@"machao:the taste is %@",self.allTaste.titleLabel.text);
    
    //选择口味后重新发送请求
    
    [self createBookMeal];
}

- (IBAction)allstore:(id)sender {
    UIButton * storeButton = (UIButton *)sender;
    if (storeButton.tag == 21) {
        [self.allStore setTitle:@"所有门店" forState:UIControlStateNormal];
        [self.allStore setTintColor:[UIColor redColor]];
    }else if (storeButton.tag == 22){
        [self.allStore setTitle:@"推荐门店" forState:UIControlStateNormal];
        [self.allStore setTintColor:[UIColor redColor]];
    }
    self.ylzAllStoresView.hidden = YES;
    //NSLog(@"machao:the store is %@",self.allStore.titleLabel.text);
    
    [self createBookMeal];
}

- (IBAction)personButton:(id)sender {
    UIButton * personButton = (UIButton *)sender;
    if (personButton.tag == 31) {
        [self.allperson setTitle:@"人均不限" forState:UIControlStateNormal];
        [self.allperson setTintColor:[UIColor redColor]];
    }else if (personButton.tag == 32){
        [self.allperson setTitle:@"0-20" forState:UIControlStateNormal];
        [self.allperson setTintColor:[UIColor redColor]];
    }else if (personButton.tag == 33){
        [self.allperson setTitle:@"20-30" forState:UIControlStateNormal];
        [self.allperson setTintColor:[UIColor redColor]];
    }else if (personButton.tag == 34){
        [self.allperson setTitle:@"30-50" forState:UIControlStateNormal];
        [self.allperson setTintColor:[UIColor redColor]];
    }else if (personButton.tag == 35){
        [self.allperson setTitle:@"50-100" forState:UIControlStateNormal];
        [self.allperson setTintColor:[UIColor redColor]];
    }else if(personButton.tag == 36){
        [self.allperson setTitle:@"100以上" forState:UIControlStateNormal];
        [self.allperson setTintColor:[UIColor redColor]];
    }
    self.ylzAllPerson.hidden = YES;
    //NSLog(@"machao:the Average Price is %@",self.allperson.titleLabel.text);
    
    [self createBookMeal];
}



#pragma mark - Refresh and load more methods

- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.
     
     */
    
    NSLog(@"helz: refreshTable ") ;
    
    self.myPullTableView.pullLastRefreshDate = [NSDate date];
    self.myPullTableView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
     
     */
    NSLog(@"helz: load more data ") ;

    if ( [self.strFirstLoad isEqualToString:@"0"] )
     {
         [self loadMoreData];
         self.strFirstLoad =@"1";   // 只执行一次 loadmoredata
     }
    
    
    self.myPullTableView.pullTableIsLoadingMore = NO;
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView  {
    
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.1f];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView{
    
    //[self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    
     //NSLog(@"helz: load more data ");
    
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:0.1f];
    

    
}


@end
