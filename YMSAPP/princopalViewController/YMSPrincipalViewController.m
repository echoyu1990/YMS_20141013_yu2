//
//  YMSPrincipalViewController.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14-8-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSPrincipalViewController.h"
#import "BaseMapViewController.h"
#import "GeoViewController.h"
#import "YMSMapViewController.h"
#import "MMLocationManager.h"

#import  "YMSAppDelegate.h"  

#import "YMSWebHttprRequestReceiveDelegate.h"
#import  "HomeTableViewCell.h"
#import "DetailMealViewController.h"

#import "YMSPrincipalDetailViewController.h"
#import "IntroductionViewController.h"

#define MainViewControllerTitle @"高德地图API-2D"

#define TAGE_HOMEPAGE_ADVERTISEMENT  235


@interface YMSPrincipalViewController ()
@property (strong,nonatomic) NSString * mark1;
@property (assign,nonatomic)int index;
@property(weak,nonatomic)IBOutlet UIView *imagePlayerView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *array3;
@property (nonatomic, strong) NSMutableDictionary *storeInformation;

@property(nonatomic,strong) NSArray *imageViewArray; // 存放广告轮播图片

@end



@implementation YMSPrincipalViewController
//@synthesize imageViewArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark----实现 首页定位

-(void)getLat
{
    __block __weak YMSPrincipalViewController *wself = self;
    [[MMLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        [wself saveLocation:locationCorrrdinate];
    }];
    [[MMLocationManager shareLocation] getAddress:^(NSString *addressString) {
        [wself setbuttonText:addressString];
    }];
}

-(void)setbuttonText:(NSString *)text
{
    NSLog(@"text %@",text);
    NSString *string = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    UIButton *button = (UIButton *)[self.view viewWithTag:10000];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:string forState:UIControlStateNormal];
    
    //[self.buttonShow.titleLabel sizeToFit];
    
    
    [button.titleLabel sizeToFit];
    CGRect frame = button.titleLabel.frame;
    frame.origin.x = 200;
    button.titleLabel.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = button.titleLabel.frame;
    frame.origin.x = 100;
    button.titleLabel.frame = frame;
    [UIView commitAnimations];
}

-(void)saveLocation:(CLLocationCoordinate2D)locationCorrrdinate
{
    NSUserDefaults * myUserDefaults  = [NSUserDefaults standardUserDefaults];
    
    
    NSNumber * floatNumberLatitude = [NSNumber numberWithFloat:locationCorrrdinate.latitude ];
    
    
    NSNumber * floatNumberLongitude = [NSNumber numberWithFloat:locationCorrrdinate.longitude ];
    
    [myUserDefaults setObject:floatNumberLatitude forKey:@"locallatitude"];
    
    [myUserDefaults setObject:floatNumberLongitude forKey:@"locallongitude"];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    [myAppDelegate.maFirstZoneADData removeAllObjects];
    [myAppDelegate.maFirstZoneADataDetail removeAllObjects];
    [myAppDelegate.maSecondZoneADData removeAllObjects];
    [myAppDelegate.maSecondZoneADDataDetail removeAllObjects];

    myAppDelegate.strStatus=@"0";
    
    [self getLat];
    
    [self.alertView setHidden:YES];
    [self.greyBackground setHidden:YES];
    
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
  
    // 首页获取server 数据
    [self performSelector:@selector(getHomePageADData) withObject:nil afterDelay:0.1];

    //----------- 广告轮播 -------------------
    if  ([myAppDelegate.strStatus isEqualToString:@"1" ]) {
    
        //imageViewArray=[NSArray arrayWithObjects:@"a1.jpg",@"a2.jpg",@"a3.jpg",@"a4.jpg",@"a5.jpg", nil];
        
        
        ImagePlayerView * imageplayer=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, 320, 146)];
       
        imageplayer.tag=123401;
        
        
        //[imageplayer initWithCount:[self.advertisementManager.advertisementData1 count] delegate:self];
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
   
        int tempCount= [myAppDelegate.maFirstZoneADData count];
        
        [imageplayer initWithCount: tempCount delegate:self];
        
        imageplayer.autoScroll=NO;
        imageplayer.scrollInterval=3;
        
        [imageplayer setPageControlPosition:ICPageControlPosition_BottomRight];
        imageplayer.hidePageControl=NO;
        
        [self.imagePlayerView addSubview:imageplayer];

    }
    
    
    //map
    //[self initMapView];
   
    // 加载首页数据
    
    //self.advertisementManager=[YMSAdvertisementManager shareAdvertisementManager];
    //[self.advertisementManager  startUpdata];
   
    
//    
//    
//    // Do any additional setup after loading the view.
//    //-------------加载  图片轮播
//    //--------kvo健值监听
//    
//    
//    [self.advertisementManager  addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
//    
//    //--------kvo健值监听

    
    
    
  /*
    if([self.advertisementManager dataState]==0)
    {
    imageViewArray=[NSArray arrayWithObjects:@"a1.jpg",@"a2.jpg",@"a3.jpg",@"a4.jpg",@"a5.jpg", nil];
    
    ImagePlayerView *imageplayer=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, 320, 146)];
    imageplayer.tag=123401;
        
        
    [imageplayer initWithCount:[self.advertisementManager.advertisementData1 count] delegate:self];
   
    imageplayer.autoScroll=NO;
    imageplayer. scrollInterval=3;
    
    [imageplayer setPageControlPosition:ICPageControlPosition_BottomRight];
    imageplayer.hidePageControl=NO;
    
    [self.imagePlayerView addSubview:imageplayer];
        
        [self.tableView reloadData];
    }
     //-------------加载  图片轮播
     else
     {
         LLARingSpinnerView* progressView=[[LLARingSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
       progressView.tintColor = [UIColor colorWithRed:215.f/255 green:49.f/255 blue:69.f/255 alpha:1];
         progressView.center = CGPointMake(CGRectGetMidX(self.imagePlayerView.bounds), CGRectGetMidY(self.imagePlayerView.bounds));
         progressView.backgroundColor=[UIColor whiteColor];
         progressView.tag=1002;
         progressView.lineWidth=1.8f;
         
      
         [self.imagePlayerView  addSubview:progressView];
            [progressView startAnimating];
         
         
         
         
         
     }
    
 */
    
}

/*
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if(![self.imagePlayerView viewWithTag:123401])
    {
        // Do any additional setup after loading the view.
        //-------------加载  图片轮播
        if([self.advertisementManager dataState]==0)
        {
            //缓冲图
            [[self.imagePlayerView viewWithTag:1002] removeFromSuperview];
            
            
            imageViewArray=[NSArray arrayWithObjects:@"a1.jpg",@"a2.jpg",@"a3.jpg",@"a4.jpg",@"a5.jpg", nil];
            
            ImagePlayerView*imageplayer=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, 320, 146)];
           
      //imageplayer.tag=123401;
            NSInteger num=(NSInteger)[self.advertisementManager.advertisementImageArray1 count];
            
            [imageplayer initWithCount:num delegate:self];
            imageplayer.autoScroll=NO;
            imageplayer. scrollInterval=3;
            
            [imageplayer setPageControlPosition:ICPageControlPosition_BottomCenter];
            imageplayer.hidePageControl=NO;
            
            [self.imagePlayerView addSubview:imageplayer];
            [self.tableView reloadData];
        
        }
        //-------------加载  图片轮播
        
        
        
        
        
    }
    
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
//    self.navigationController.navigationBar.translucent = NO;
//    
//    [self.navigationController setToolbarHidden:YES animated:animated];
//    
    
}

*/

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    //----------- 广告轮播 -------------------
    if  ([myAppDelegate.strStatus isEqualToString:@"1" ]) {
        
        ImagePlayerView * imageplayer=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, 320, 146)];
        
        //imageplayer.tag=123401;
        
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
        
        int tempCount= [myAppDelegate.maFirstZoneADData count];
        
        [imageplayer initWithCount: tempCount delegate:self];
        
        imageplayer.autoScroll=NO;
        imageplayer.scrollInterval=3;
        
        [imageplayer setPageControlPosition:ICPageControlPosition_BottomRight];
        imageplayer.hidePageControl=NO;
        
        [self.imagePlayerView addSubview:imageplayer];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark----实现 YMSPointPassDelegate

-(void)homePassValue:(AMapGeoPoint *)value
{
    self.point = value;
    NSLog(@"------------%f,%f",value.latitude,value.longitude);

}
-(void)homePassAdress:(NSString *)adress
{
    [self setbuttonText:adress];
  
}

#pragma mark----实现 传数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;

    
    /*
    //将page2设定成Storyboard Segue的目标UIViewController
    if([segue.identifier isEqualToString:@"mapViewSegue"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        
        YMSMapViewController *mapViewController =(YMSMapViewController *)[nav viewControllers][0];
        
        mapViewController.delegate = self;
    }
     */
    
//    if ([segue.identifier isEqualToString:@"HOME_TO_DIANCAN"]){
//        if ([self.mark1 isEqualToString:@"lunbo"]) {
//            YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
//            myAppDelegate.mark = @"lunbo";
//        }
//    }
    
    
//    if ([segue.identifier isEqualToString:@"PRINCIPAL_TO_DETAIL"]) {
//        [[segue destinationViewController] setDetailItem:_storeInformation];
//    }
    
//     else if ([segue.identifier isEqualToString:@"HOME_TO_WAIMAI"])
//     {
//    
//     }
//         //从首页跳转到点餐
//    else if ([segue.identifier isEqualToString:@"HOME_TO_DIANCAN"]) {
//        
//        YMSPrincipalDetailViewController * detailMeal = segue.destinationViewController;
//
//        //detailMeal.detailItem = myAppDelegate.maSecondZoneADDataDetail;
        NSLog(@"ylz*******:%@",[myAppDelegate.maSecondZoneADDataDetail[self.index] objectForKey:@"number"]);
//        
//       // detailMeal.strStoreCode = [myAppDelegate.maSecondZoneADDataDetail[self.index] objectForKey:@"number"];
    
//        //detailMeal.strStoreCode = [myAppDelegate.maSecondZoneADDataDetail[1] objectForKey:@"number"];
//    
//        // detailMeal.strStoreCode = @"1401261579031";
//        
//    }
}

#pragma mark----实现 tableView datareource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

     YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    //    if ([self.advertisementManager dataState]==0) {
//        return [self.advertisementManager.advertisementImageArray2 count];
//        
//    }
//    else
//    {
//        return 1;
//    }
//
    
     if  ([myAppDelegate.strStatus isEqualToString:@"1" ] )
         return [myAppDelegate.maSecondZoneADData count]+1; //多出的一行是支付宝
      else
     return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    if ([tableView isEqual: self.myHomeTableView]) {
     
       HomeTableViewCell   *cell=[tableView  dequeueReusableCellWithIdentifier:@"cellone" forIndexPath:indexPath];
    
        if (indexPath.row ==0)
        {
            
            
//         cell.myHomeImageView.image = [UIImage imageWithData:
//                                       [NSData dataWithContentsOfURL:
//                                         [NSURL URLWithString:                                          self.strHomePagePayPic
//                                         ]
//                                       ]
//                                     ] ; // 图片
            
            
        NSString * str = self.strHomePagePayPic;
            
        [cell.myHomeImageView setImageWithURL: [NSURL URLWithString:str] placeholderImage: [UIImage imageNamed:@"b.png"] ] ;
            
     }
        else
        {
        
//            //cell.myHomeImageView.image = [UIImage imageWithData:
//                                          [NSData dataWithContentsOfURL:
//                                           [NSURL URLWithString:
//                                            [myAppDelegate.maSecondZoneADData [indexPath.row] objectForKey:@"picture" ]
//                                            ]
//                                           ]
//                                          ] ; // 图片
      
    NSString * str = [myAppDelegate.maSecondZoneADData [indexPath.row-1] objectForKey:@"picture" ];//indexPath.row-1是表格的第二行，maSecondZoneADData的第一个数据
            
    [cell.myHomeImageView setImageWithURL: [NSURL URLWithString:str] placeholderImage: [UIImage imageNamed:@"b.png"] ] ;
            
            
    }
        
   
 
    return cell;
    
    }
    else
        
     return NULL;
    
    
}

#pragma mark----点击 tableview
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
    myAppDelegate.mark = @"bottomCell";
    
    if (indexPath.row > 0) {
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
        
        myAppDelegate.mark = @"bottomCell";//传到餐厅介绍时和轮播作区分
        
        myAppDelegate.number = indexPath.row-1;//餐厅介绍需要点击的行号
        
        myAppDelegate.strStoreCode = [myAppDelegate.maSecondZoneADDataDetail[indexPath.row-1] objectForKey:@"number"];//评论需要餐厅的编号
        
        NSLog(@"numberyu:%@",myAppDelegate.strStoreCode);
        
        NSString * name = [myAppDelegate.maSecondZoneADDataDetail[indexPath.row-1] objectForKey:@"name"];
        NSString * takeout = [myAppDelegate.maSecondZoneADDataDetail[indexPath.row-1] objectForKey:@"takeout" ];
        NSString * book = [myAppDelegate.maSecondZoneADDataDetail[indexPath.row-1] objectForKey:@"book" ];
        if ([takeout isEqualToString:@"1"] && [book isEqualToString:@"1"]) {
            UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:name delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预定",@"外卖", nil];
            [orderActionSheet showInView:self.view];
        }else if ([takeout isEqualToString:@"1"]){
            UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:name delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"外卖", nil];
            [orderActionSheet showInView:self.view];
        }else if ([book isEqualToString:@"1"]){
            UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:name delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预定", nil];
            [orderActionSheet showInView:self.view];
        }else{
            UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:@"不支持预定和外卖" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
            [orderActionSheet showInView:self.view];
        }
        self.index = indexPath.row-1;//减去第一行
        
    }

    
    
}
#pragma mark-- UIActionSheetDelegate方法

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    if (actionSheet.tag == 111) {//上面的轮播图触发的actionsheet
        
        if (buttonIndex == 0) {
            NSLog(@"预定");
            
           
            [self performSegueWithIdentifier:@"HOME_TO_DIANCAN" sender:self];
            
            
            
        }else if (buttonIndex == 1){
                NSLog(@"外卖");
        }

    }
   else if (buttonIndex == 0) {//下面的表格触发的actionsheet
        NSLog(@"预定");
        //点击预定进入点餐页面
       
        myAppDelegate.strStoreCode = [myAppDelegate.maSecondZoneADDataDetail[self.index] objectForKey:@"number"];
        
        [self performSegueWithIdentifier:@"HOME_TO_DIANCAN" sender:self];
        
        
    }else if (buttonIndex == 1){
        NSLog(@"外卖");
    }
    
}
#pragma mark----实现 tableView delegate



#pragma mark----实现 imagePlayerView delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    
    //imageView.image=[self.advertisementManager.advertisementImageArray1 objectAtIndex:index];
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    
    
    // by helz
//    imageView.image = [UIImage imageWithData:
//     [NSData dataWithContentsOfURL:
//      [NSURL URLWithString:
//       [myAppDelegate.maFirstZoneADData[index] objectForKey:@"picture" ]
//       ]
//      ]
//     ] ;
    
    NSString * str = [myAppDelegate.maFirstZoneADData[index] objectForKey:@"picture" ];

     [imageView  setImageWithURL:[NSURL URLWithString: str]  placeholderImage:[UIImage imageNamed:@"b.png"] ];
    
    
}
-(void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    myAppDelegate.mark = @"lunbo";
    
    myAppDelegate.strStoreCode = [myAppDelegate.maFirstZoneADataDetail[index] objectForKey:@"number"];
    
    NSLog(@"echo:%@",myAppDelegate.strStoreCode);
    
    
    myAppDelegate.number = index;
    
    
    
    myAppDelegate.strStoreCode = [myAppDelegate.maFirstZoneADataDetail[index] objectForKey:@"number"];
    
    NSLog(@"yustrstoreCode:%@",myAppDelegate.strStoreCode);
    
    NSString * name = [myAppDelegate.maFirstZoneADataDetail[index] objectForKey:@"name"];
    NSString * takeout = [myAppDelegate.maFirstZoneADataDetail[index] objectForKey:@"takeout" ];
    NSString * book = [myAppDelegate.maFirstZoneADataDetail[index] objectForKey:@"book" ];
    if ([takeout isEqualToString:@"1"] && [book isEqualToString:@"1"]) {
        UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:name delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预定",@"外卖", nil];
        orderActionSheet.tag = 111;//给actionsheet一个tag属性用于分别
        [orderActionSheet showInView:self.view];
    }else if ([takeout isEqualToString:@"1"]){
        UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:name delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"外卖", nil];
        orderActionSheet.tag = 111;
        [orderActionSheet showInView:self.view];
    }else if ([book isEqualToString:@"1"]){
        UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:name delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"预定", nil];
        orderActionSheet.tag = 111;
        [orderActionSheet showInView:self.view];
    }else{
        UIActionSheet * orderActionSheet = [[UIActionSheet alloc]initWithTitle:@"不支持预定和外卖" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
        orderActionSheet.tag = 111;
        [orderActionSheet showInView:self.view];
    }

}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}



#pragma mark----实现 imagePlayerView delegate



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self viewWillAppear:YES];
    [self.myHomeTableView reloadData];
    
}


- (IBAction)backMainPage:(id)sender {
    [self.greyBackground setHidden:YES];
    [self.alertView setHidden:YES];
}

- (IBAction)ordering:(id)sender {
    self.detailVC.detailItem = _storeInformation;
}

- (IBAction)delievery:(id)sender {
}


#pragma  --mark  Reqeust data from server  --

-(void) getHomePageADData
{
    
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];

    // 首页广告列表
    
    NSArray* rankParameter=@[@"method",@"appName",@"appPwd",@"type"];
    
    NSDictionary *loginDic=[[NSDictionary alloc] initWithObjectsAndKeys:@"queryAppAdvertisements",@"method",@"order",@"appName",@"order",@"appPwd",@"1",@"type",nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/advertisementAppService" Tag:TAGE_HOMEPAGE_ADVERTISEMENT rankKeyArray:rankParameter postData:loginDic delegate:self];
}


#pragma mark--- YMSWebHttprRequestReceiveDelegate 实现

- (void)ymsRequestFinishedOfDictionary:(NSDictionary*)jsonDic  Requestoftag:(NSInteger)tag{
    
    
    NSLog(@"%@",jsonDic);
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    
    
    if(tag==TAGE_HOMEPAGE_ADVERTISEMENT)  // 首页广告列表
    {
      
     
        NSInteger state=[[jsonDic  objectForKey:@"result"] integerValue];
 
        
        if(state==0)  //if  0：查询成功；1：查询无数据；2：校验账户密码错误
        {
            NSArray *data1=[jsonDic  objectForKey:@"data"]; // 一区广告
            
            NSLog(@"helz: advertisement_data1= %@", data1) ;
            
        for (int i=0; i< [data1 count]; i++) {    // 只取每个餐馆的前4项
            
        [myAppDelegate.maFirstZoneADData addObject:
                  
                   @{@"module":[data1[i] objectAtIndex:0],
                    
                    @"topic":[data1[i] objectAtIndex:1],
                    
                    @"picture":[data1[i] objectAtIndex:2],
                    
                    @"link":[data1[i] objectAtIndex:3],
                    
                    }];
        
       
            //获取餐馆信息
        NSArray *tempArray = [ data1[i] objectAtIndex:4]; // 餐馆信息
        
        NSLog(@"helz: restaurant data = %@", tempArray) ;
        
         
          [myAppDelegate.maFirstZoneADataDetail addObject:
             
             @{@"number":[tempArray objectAtIndex:0],
               
               @"name":[tempArray objectAtIndex:1],
               
               @"picture":[tempArray objectAtIndex:2],
               
               @"address": [tempArray objectAtIndex:3],
               
               @"phone": [tempArray objectAtIndex:4],
               
               @"worktime":[tempArray objectAtIndex:5],
               
               @"introduction":[tempArray objectAtIndex:6],
               
               @"takeout":[tempArray objectAtIndex:7],
               
               @"book":[tempArray objectAtIndex:8],
               
               }
           ];
       // }
        //[门店编号，门店名称,门店图片，地址，电话，营业时间，简介
        // 添加 ...... 根据接口文档
        //}
        
     }
            
          NSLog(@"helz: maFirstZoneADData= %@", myAppDelegate.maFirstZoneADData) ;
          NSLog(@"helz: maFirstZoneADDataDetail= %@", myAppDelegate.maFirstZoneADataDetail);
            

       //------------------------------------
            
           NSArray *data2=[jsonDic  objectForKey:@"data2"]; // 二区广告
            
            NSLog(@"helz: advertisement_data2= %@", data2) ;
            
            //获取支付图片
            
            self.strHomePagePayPic = [data2 objectAtIndex:0][2];
            ///后续数据 for 支付优惠......
            
            
            for (int i=1; i< [data2 count]; i++) {    // 只取每个餐馆的前4项
                
                [myAppDelegate.maSecondZoneADData addObject:
                 
                 @{@"module":[data2[i] objectAtIndex:0],
                   
                   @"topic":[data2[i] objectAtIndex:1],
                   
                   @"picture":[data2[i] objectAtIndex:2],
                   
                   @"link":[data2[i] objectAtIndex:3],
                   
                   }];
                
                
                //获取餐馆信息
                NSArray *tempArray = [ data2[i] objectAtIndex:4]; // 餐馆信息
                
                NSLog(@"helz: restaurant data = %@", tempArray) ;
                
                
                [myAppDelegate.maSecondZoneADDataDetail addObject:
                 
                 @{@"number":[tempArray objectAtIndex:0],
                   
                   @"name":[tempArray objectAtIndex:1],
                   
                   @"picture":[tempArray objectAtIndex:2],
                   
                   @"address": [tempArray objectAtIndex:3],
                   
                   @"phone": [tempArray objectAtIndex:4],
                   
                   @"worktime":[tempArray objectAtIndex:5],
                   
                   @"introduction":[tempArray objectAtIndex:6],
                   
                   @"takeout":[tempArray objectAtIndex:7],
                   
                   @"book":[tempArray objectAtIndex:8],
                   
                   @"comments":[tempArray objectAtIndex:11],//评分
                   
                   
                   }
                 ];
                // }
                //[门店编号，门店名称,门店图片，地址，电话，营业时间，简介
                // 添加 ...... 根据接口文档
                //}
                
            }
            
            
            NSLog(@"helz: maSecondZoneADData= %@", myAppDelegate.maSecondZoneADData) ;
            
            NSLog(@"helz: maSecondZoneADDataDetail= %@", myAppDelegate.maSecondZoneADDataDetail);
            
            NSString *pic = [ myAppDelegate.maSecondZoneADData[1] objectForKey:@"picture" ];
            
            
            NSLog(@"helz: cell data = %@", pic) ;
            
            
          
//            self.ad2FirstUrl=[data2[0]  objectAtIndex:2];
//        
//            
//            [self.advertisementImageArray2 addObject:[self getImageFromURL:self.ad2FirstUrl]];
//            
//            NSLog(@"###############%@#############",data2[1]);
//            for (int i=1; i<[data2 count]; i++){
//                
//                YMSPAdvertisement*temp=[[YMSPAdvertisement alloc] initWithArray:[data2 objectAtIndex:i]];
//                [self.advertisementData2 addObject:temp];
//                
//                UIImage*image=[self  getImageFromURL:temp.advertisementImageUrl];
//                [self.advertisementImageArray2 addObject:image];
//                
//            }
//            
//            self.state=state;
//        }
             myAppDelegate.strStatus=@"1";
            [self.hud hide:YES];
            [self viewWillAppear:YES]; // 广告图片轮播
            [self.myHomeTableView reloadData] ; 
    }
  }
}



@end
