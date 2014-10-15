//
//  YMSAppDelegate.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14-8-15.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSAppDelegate.h"
#import <MAMapKit/MAMapKit.h>
#import "APIKey.h"

#import "OrderInfo.h"

@implementation YMSAppDelegate


-(void)orderDishDataInit:(OrderInfo*)  OrderInfo
{
    if (! self.arrDishOrder)  self.arrDishOrder = [ [NSMutableArray alloc] init];
    
    [self.arrDishOrder addObject:OrderInfo] ;
   
    self.strTotalPrice =@"0";

}


-(void)addOrderNumber:(NSInteger)orderIndex
{
   
   OrderInfo * myOrder=[self.arrDishOrder objectAtIndex: orderIndex ];
    
    self.strTotalPrice  = [NSString stringWithFormat:@"%d元",[self.strTotalPrice intValue] + [myOrder.strDishPrice intValue ]];
    
    
    
}


-(void)subOrderNumber:(NSInteger)orderIndex;
{
    OrderInfo * myOrder=[self.arrDishOrder objectAtIndex: orderIndex ];
    
    self.strTotalPrice  = [NSString stringWithFormat:@"%d元",[self.strTotalPrice intValue] - [myOrder.strDishPrice intValue ]];

}




//注册地图sdk
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *name   = [NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__];
        NSString *reason = [NSString stringWithFormat:@"请首先配置APIKey.h中的APIKey, 申请APIKey参考见 http://api.amap.com"];
        
        @throw [NSException exceptionWithName:name
                                       reason:reason
                                     userInfo:nil];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    //iOS8 定位修复
    CLLocationManager *locationManager;
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
    [locationManager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
    locationManager.delegate = self;
    
    
    //注册地图sdk
    [self  configureAPIKey];
    
    //注册微信sdk
    [WXApi registerApp:@"wxd930ea5d5a258f4f"];
    
    if (! self.detailInformationOfDish)   // by helz
        self.detailInformationOfDish =[[NSMutableArray alloc] init ];
        
    if (! self.maImageViewOrderStatus ) self.maImageViewOrderStatus =[[NSMutableArray alloc] init ];
    
    //--------------------------------------------
    if (! self.maFirstZoneADData)   //首页banner 广告摘要
        self.maFirstZoneADData =  [[NSMutableArray alloc] init];

    if (! self.maFirstZoneADataDetail)   //首页banner 广告详情
        self.maFirstZoneADataDetail =  [[NSMutableArray alloc] init];

    
    if (! self.maSecondZoneADData)    // 首页二区广告摘要
        self.maSecondZoneADData =  [[NSMutableArray alloc] init];

    if (! self.maSecondZoneADDataDetail)  // 首页二区广告详情
        self.maSecondZoneADDataDetail =  [[NSMutableArray alloc] init];
    
    [self initDatabase];    //创建数据库
    
    [self createTable] ;    //创建表
    
    
    return YES;
}


#pragma mark -- WXSDK Delegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送消息结果"];
        
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        //        WXSuccess           = 0,    /**< 成功    */
        //        WXErrCodeCommon     = -1,   /**< 普通错误类型    */
        //        WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
        //        WXErrCodeSentFail   = -3,   /**< 发送失败    */
        //        WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
        //        WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
        if(resp.errCode == 0)
        {
            strMsg = @"分享成功！";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else if (resp.errCode == -2){
            strMsg = @"取消分享！";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- FMDB database 

//-------- for database initialization ------

//初始化数据库
-(void) initDatabase{
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex: 0];
    
    //NSString *path = [NSString stringWithFormat:@"%@/%@",docDir,@"dishes.sqlite3"];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",docDir,MyDBName];
    
    NSLog(@"helz: database_path = %@", path);
    
    
    self.myDataBase = [[FMDatabase alloc] initWithPath:path];
    self.myDataBase.traceExecution = YES;
    
    
}


- (void) createTable

{
     YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    [myAppDelegate.myDataBase open] ;
    
    
    FMResultSet * set = [myAppDelegate.myDataBase  executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'",@"MyDataBase.sqlite"]];
    
    [set next];
    
    NSInteger count = [set intForColumnIndex:0];
    
    BOOL existTable = !!count;
    
    
    if (existTable) {
        NSLog(@"helz: 所要创建的表已经存在,重新命名新表");
        
    } else {
        
        // TODO: 创建新的表
   
         NSString * sql = @"CREATE TABLE MyTable (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name VARCHAR(100) )";
        
        
        //--  id  |-- dish name --
        
        [myAppDelegate.myDataBase open] ;
        
        BOOL res = [myAppDelegate.myDataBase executeUpdate:sql];
        
        if (!res) {
            NSLog(@"helz: 表创建失败");
        }
        else {
            NSLog(@"helz: 表创建成功");
        }
    }
    
    [myAppDelegate.myDataBase close] ;
    
}



@end
