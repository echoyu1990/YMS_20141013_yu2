//
//  YMSIndexLocationViewController.m
//  YMSAPP
//
//  Created by 介扬 on 14-10-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import <AMapSearchKit/AMapSearchAPI.h>
#import "YMSIndexLocationViewController.h"
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "myAddressCell.h"

@interface YMSIndexLocationViewController ()<AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSArray *pois;
@property (strong, nonatomic) IBOutlet UISearchBar *UISearchBarOutLet;
@property (strong, nonatomic) IBOutlet UITableView *tableViewOutLet;
@property (strong, nonatomic) NSArray *list;
@property CLLocationCoordinate2D myLocation;

@end

@implementation YMSIndexLocationViewController

#pragma mark -LifeCycleRela
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [MAMapServices sharedServices].apiKey =@"34f249b2282c0a8f336f806cd0862c7d";
    self.mapView=[[MAMapView alloc] initWithFrame:CGRectMake(0, 108, 320, 207)];
    //定位开启
    self.mapView.showsUserLocation = YES;
    //    self.mapView.rotateEnabled = NO;
    //    self.mapView.rotateCameraEnabled = NO;
    [self.view addSubview:self.mapView];
    //一打开就显示到定位
    [self modeAction];
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:@"34f249b2282c0a8f336f806cd0862c7d" Delegate:nil];
    self.mapView.delegate = self;
    self.search.delegate = self;
    self.tableViewOutLet.delegate = self;
}

//左上角的return按钮的触摸方法
- (IBAction)returnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -AMapSearchDelegate
/*!
 @brief POI 查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapPlaceSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapPlaceSearchResponse类中的定义)
 */
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response{
    self.pois = [NSMutableArray arrayWithCapacity:response.pois.count];
    self.pois =  response.pois;
    [self performSelectorOnMainThread:@selector(updateTableViewData) withObject:nil waitUntilDone:YES];
}

-(void)updateTableViewData{
    [self.tableViewOutLet reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

/*!
 @brief 通知查询成功或失败的回调函数
 @param searchRequest 发起的查询
 @param errInfo 错误信息
 */
- (void)search:(id)searchRequest error:(NSString*)errInfo{
    NSLog(@"查询失败的回调函数");
}

- (void)modeAction
{
    //地图跟着位置移动
    [self.mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
}

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"regionDidChange");
    CLLocationCoordinate2D newLocation = [self.mapView convertPoint:CGPointMake(160, 125)toCoordinateFromView:self.mapView];
    if(newLocation.latitude!=_myLocation.latitude || newLocation.longitude!=_myLocation.longitude){
        _myLocation = newLocation;
        [self searchPlaceByAroundWithKeywords:@""];
        //测试获得经纬度坐标
        NSString* testStr = [NSString stringWithFormat:@"%f,%f",_myLocation.latitude,_myLocation.longitude];
        NSLog(@"%@",testStr);
    }
}


//搜索周边关键IPO
- (void)searchPlaceByAroundWithKeywords:(NSString *)keywords
{
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceAround;
    poiRequest.location = [AMapGeoPoint locationWithLatitude:(_myLocation.latitude) longitude:(_myLocation.longitude)];
    poiRequest.keywords = keywords;
    poiRequest.sortrule = 0;
    poiRequest.requireExtension = YES;
    poiRequest.radius= 1000;
    [self.search AMapPlaceSearch: poiRequest];
}


#pragma mark -TableViewDelegate
//数组更新————>cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier"; //相当于一个行标识
    //myAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    //tableViewCell重绘
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"myAddressCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    myAddressCell *cell = [self.tableViewOutLet dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    NSUInteger row = indexPath.row; //获取行号
    if(row >= _pois.count){
        cell.textLabel.text = nil;//数据显示
        return cell;
    }
    AMapPOI  *poi = [self.pois objectAtIndex:row];//获取数据
    NSString *address;
    if([poi.province isEqualToString:poi.city]){
        address = [NSString stringWithFormat:@"%@,%@,%@",poi.city,poi.district,poi.address];
    }else{
        address = [NSString stringWithFormat:@"%@,%@,%@,%@",poi.province,poi.city,poi.district,poi.address];
    }
    [cell setAddress:address];
    [cell setName:poi.name];//数据显示
    NSLog(@"%@%@%@%@",poi.province,poi.city,poi.district,poi.address);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"更新Raws为：%d",self.pois.count);
    return self.pois.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return height
    return 60;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    myAddressCell *cell = [self.tableViewOutLet cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.nameLabel.text);
    NSLog(@"%@",cell.addressLabel.text);
}


#pragma mark -SearchBarRela
//search Button clicked....
// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //    NSLog( @"%s,%d" , __FUNCTION__ , __LINE__ );
    //根据用户提供的关键字在周围进行搜索
    [self searchPlaceByAroundWithKeywords:self.UISearchBarOutLet.text];
    [searchBar resignFirstResponder];
}
@end
