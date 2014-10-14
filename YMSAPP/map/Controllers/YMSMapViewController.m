//
//  YMSMapViewController.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14/9/11.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSMapViewController.h"
#import "BaseMapViewController.h"
#import "GeoViewController.h"

#define MainViewControllerTitle @"高德地图API-2D"

@interface YMSMapViewController ()

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation YMSMapViewController


#pragma mark----实现 YMSPointPassDelegate

-(void)passValue:(AMapGeoPoint *)value
{
    self.point = value;
    [self.delegate homePassValue:value];
}
-(void)passAdress:(NSString *)adress
{
    self.adress = adress;
    [self.delegate homePassAdress:adress];
    NSLog(@"-------------%@",adress);
}


- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.title = MainViewControllerTitle;
        
        /* 初始化search. */
        [self initSearch];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMapView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BaseMapViewController *subViewController = [[GeoViewController alloc] init];
    
    subViewController.delegate = self;
    subViewController.title   = @"地理编码+输入提示";
    subViewController.mapView = self.mapView;
    subViewController.search  = self.search;
    [self.navigationController pushViewController:subViewController animated:YES];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}


@end
