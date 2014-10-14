//
//  YMSMenuMapViewController.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14/9/19.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSMenuMapViewController.h"
#import "GeocodeAnnotation.h"
#import "YMSLocationViewController.h"

@interface YMSMenuMapViewController ()

@end

@implementation YMSMenuMapViewController

#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}


- (void)returnAction
{
    //[self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self clearMapView];

}


#pragma mark - Initialization

- (void)geocodeQuery
{
    
    if (self.adress == nil || [self.adress length] == 0) {
        return ;
    }
    
    CLGeocoder *geocode = [[CLGeocoder alloc] init];
    
    [geocode geocodeAddressString:self.adress completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数: %i",[placemarks count]);
        
        if ([placemarks count ] > 0) {
            //移除目前地图上得所有标注点
            [self.mapView removeAnnotations:_mapView.annotations];
            
        }
        
        for (int i = 0; i< [placemarks count]; i++) {
            CLPlacemark * placemark = placemarks[i];
            
            //调整地图位置和缩放比例,第一个参数是目标区域的中心点，第二个参数：目标区域南北的跨度，第三个参数：目标区域的东西跨度，单位都是米
            MACoordinateRegion viewRegion = MACoordinateRegionMakeWithDistance(placemark.location.coordinate, 1000, 1000);
            
            //重新设置地图视图的显示区域
            [self.mapView setRegion:viewRegion animated:YES];
            
            YMSLocationViewController * annotation = [[YMSLocationViewController alloc] init];
            annotation.streetAddress = placemark.thoroughfare ;
            annotation.city = placemark.locality;
            annotation.state = placemark.administrativeArea ;
            annotation.zip = placemark.postalCode;
            annotation.coordinate = placemark.location.coordinate;
//            GeocodeAnnotation * annotation = [[GeocodeAnnotation alloc] init];
//            annotation.geocode.formattedAddress = placemark.thoroughfare ;
//            annotation.geocode.city = placemark.locality;
//            annotation.geocode.province= placemark.administrativeArea ;
//            annotation.geocode.adcode = placemark.postalCode;
//            annotation.geocode.location.latitude = placemark.location.coordinate.latitude;
//            annotation.geocode.location.longitude = placemark.location.coordinate.longitude;
            
            
            //把标注点MapLocation 对象添加到地图视图上，一旦该方法被调用，地图视图委托方法mapView：ViewForAnnotation:就会被回调
            [self.mapView addAnnotation:annotation];
        }
        
        
    }];
    
}

#pragma mark mapView Delegate 地图 添加标注时 回调

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    // 获得地图标注对象
    MAPinAnnotationView * annotationView = (MAPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if (annotationView == nil) {
        annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    // 设置大头针标注视图为紫色
    annotationView.pinColor = MAPinAnnotationColorPurple ;
    // 标注地图时 是否以动画的效果形式显示在地图上
    annotationView.animatesDrop = YES ;
    // 用于标注点上的一些附加信息
    annotationView.canShowCallout = YES ;
    
    return annotationView;
    
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void)mapViewDidFailLoadingMap:(MAMapView *)theMapView withError:(NSError *)error {
    NSLog(@"error : %@",[error description]);
}


- (void)initMapView
{
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.visibleMapRect = MAMapRectMake(220880104, 101476980, 272496, 466656);
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
    
    NSUserDefaults * adressUserDefaults  = [NSUserDefaults standardUserDefaults];
    
    
    self.adress  = [ adressUserDefaults  objectForKey:@"locallatitude"];
    
    
    NSLog(@"%@",self.adress);
    //self.adress = @"北京市海淀区上地东路环洋大厦";
    [self initMapView];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(returnAction)];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self geocodeQuery];

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

@end
