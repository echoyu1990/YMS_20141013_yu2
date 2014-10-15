//
//  IntroductionViewController.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-13.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "IntroductionViewController.h"
#import "YMSAppDelegate.h"
@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults * adressUserDefaults  = [NSUserDefaults standardUserDefaults];
    
    NSString *adressToMap = [[NSString alloc]init];
    if ([self.mark isEqualToString:@"fromPrincipal"])
    {
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
        if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
            adressToMap = [NSString stringWithFormat:@"%@",[myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number]objectForKey:@"adress"]];
            
        }else{
            adressToMap = [NSString stringWithFormat:@"%@",[myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number]objectForKey:@"adress"]];
            
            NSLog(@"gyj------------maFirstZoneADataDetail----------%@",adressToMap);
        }
    }else
    {
        adressToMap =[NSString stringWithFormat:@"%@",[_introductiondetailItem objectForKey:@"address"] ];
    }
    
    
    
    NSLog(@"gyj----------------------%@",adressToMap);
    [adressUserDefaults setObject:adressToMap forKey:@"locallatitude"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.comentsNo = [[NSString alloc]init];
    [self createSendMessage];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if ([tableView isEqual:_introductionTableView]) {
            if (indexPath.row ==0)
                return 109 ;
            else
                return 81;
    }
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([tableView isEqual:_introductionTableView]) {
        if (indexPath.row == 0) {
            RestaurantBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.IntorductionBannerImage.image = [UIImage imageNamed:@"sample_banner.png"];
            
            return cell;
        }
        
        else if (indexPath.row == 1) {
            RestaurantNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
                if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
                    cell.restaurantName.text = [myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number] objectForKey:@"name"];
                    cell.restaurantPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number] objectForKey:@"picture"]]]];
                    //距离
                    cell.distance.hidden = YES;
                    return cell;
                }else if([myAppDelegate.mark isEqualToString:@"bottomCell"]){
                
                
                cell.restaurantName.text = [myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number] objectForKey:@"name"];
                cell.restaurantPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number] objectForKey:@"picture"]]]];
                //距离隐藏
                    cell.distance.hidden = YES;
                return cell;
                }
                
            else{
            cell.restaurantName.text = [_introductiondetailItem objectForKey:@"name"];
            cell.restaurantPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_introductiondetailItem objectForKey:@"picture"]]]];
            NSString *distance = [_introductiondetailItem objectForKey:@"distance"];
            float intDistance = [distance floatValue];
            NSString *strDistance= [NSString stringWithFormat:@"%@m",distance];
        
            if (intDistance >= 1000)
            {
                double floatDistance = intDistance /1000;
                strDistance= [NSString stringWithFormat:@"%0.1fkm",floatDistance];
            }
        
            cell.distance.text = strDistance;
            return cell;
            }
        }
        else if (indexPath.row == 2){
            RestaurantProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
                if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
                    NSLog(@"zhixing");
                    cell.RestaurantProfile.text = [myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number] objectForKey:@"introduction"];
                    return cell;
                }else if([myAppDelegate.mark isEqualToString:@"bottomCell"]){
                cell.RestaurantProfile.text = [myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number] objectForKey:@"introduction"];
                return cell;
                }
            else{
            cell.RestaurantProfile.text = [_introductiondetailItem objectForKey:@"profile"];
            
            return cell;
            }
        }
        else if (indexPath.row == 3){
            BusinessHoursTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessHoursCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
                if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
                    cell.BusinessHours.text = [myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number] objectForKey:@"worktime"];
                    return cell;
                }else if([myAppDelegate.mark isEqualToString:@"bottomCell"]){
                cell.BusinessHours.text = [myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number] objectForKey:@"worktime"];
                return cell;
                }
            
            else{
            cell.BusinessHours.text = [_introductiondetailItem objectForKey:@"businessTime"];
            
            return cell;
            }
        }
        else if (indexPath.row == 4){
            RestaurantAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
                if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
                    cell.RestaurantAddress.text = [myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number] objectForKey:@"address"];
                    return cell;
                }else if([myAppDelegate.mark isEqualToString:@"bottomCell"]){
                cell.RestaurantAddress.text = [myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number] objectForKey:@"address"];
                return cell;
                }
            else{
            cell.RestaurantAddress.text = [_introductiondetailItem objectForKey:@"address"];
            
            return cell;
            }
        }
        else if (indexPath.row == 5){
            PhoneNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
                if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
                    cell.PhoneNumber.text = [myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number] objectForKey:@"phone"];
                    return cell;
                }else if([myAppDelegate.mark isEqualToString:@"bottomCell"]){
                cell.PhoneNumber.text = [myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number] objectForKey:@"phone"];
                return cell;
                }
            else{
                
            cell.PhoneNumber.text = [_introductiondetailItem objectForKey:@"phoneNumber"];
            
            return cell;
            }
        }
        else if (indexPath.row == 6){
            CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
                NSString *number = [NSString stringWithFormat:@"%@",self.comentsNo];
                cell.NumberOfComments.text = number;
                
                if([number isEqualToString:@""] ==NO&&[number isEqualToString:@"0"] == NO)
                {
                    NSLog(@"gyj----评论为空不应该跳进来");
                    NSString *name = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:0]];
                    cell.name.text = name;
                    
                    
                    NSString *time = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:1]];
                    cell.time.text = time;
                    
                    NSString *starNumber = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:4]];
                    if ([starNumber isEqualToString:@"5"]) {
                        [cell.star1 setHighlighted:YES];
                        [cell.star2 setHighlighted:YES];
                        [cell.star3 setHighlighted:YES];
                        [cell.star4 setHighlighted:YES];
                        [cell.star5 setHighlighted:YES];
                    }else if ([starNumber isEqualToString:@"4"])
                    {
                        [cell.star1 setHighlighted:YES];
                        [cell.star2 setHighlighted:YES];
                        [cell.star3 setHighlighted:YES];
                        [cell.star4 setHighlighted:YES];
                    }else if ([starNumber isEqualToString:@"3"])
                    {
                        [cell.star1 setHighlighted:YES];
                        [cell.star2 setHighlighted:YES];
                        [cell.star3 setHighlighted:YES];
                    }else if ([starNumber isEqualToString:@"2"])
                    {
                        [cell.star1 setHighlighted:YES];
                        [cell.star2 setHighlighted:YES];
                    }else if ([starNumber isEqualToString:@"1"])
                    {
                        [cell.star1 setHighlighted:YES];
                    }
                    
                    
                    NSString *body = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:2]];
                    cell.body.text = body;
                    
                    return cell;
                }else if([number isEqualToString:@""] ||[number isEqualToString:@"0"] )
                {
//                    NSString *name = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:0]];
//                    cell.name.text = name;
//                    
//                    
//                    NSString *time = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:1]];
//                    cell.time.text = time;
                    return cell;
                }
            
            else
            {
                NSString *name = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:0]];
                cell.name.text = name;
                
                
                NSString *time = [NSString stringWithFormat:@"%@",[self.Comentlist objectAtIndex:1]];
                cell.time.text = time;
                
//                NSString *number =[NSString stringWithFormat:@"%@",[_introductiondetailItem objectForKey:@"comments"]];
//                
//                cell.NumberOfComments.text = number;
                return cell;
            }

        }
        
    }
    return nil;
}
//选中行时不是高亮状态
//-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}

//订餐拨打电话
-(IBAction)callNumber:(id)sender
{
    NSString *cellNo = [[NSString alloc]init];
    if ([self.mark isEqualToString:@"fromPrincipal"])
    {
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
        if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
            cellNo =[NSString stringWithFormat:@"%@",[myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number]objectForKey:@"phone"]];
            
        }else{
            cellNo = [NSString stringWithFormat:@"%@",[myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number]objectForKey:@"phone"]];
            
        }
    }else
    {
        cellNo = [NSString stringWithFormat:@"%@",[_introductiondetailItem objectForKey:@"phoneNumber"]];
    }
    
    [[UIApplication  sharedApplication] openURL:[NSURL  URLWithString:[NSString stringWithFormat:@"telprompt://%@",cellNo]]];
    NSLog(@"可以拨打电话");
}


//评论songshu获取
- (void)createSendMessage
{
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSString *companyNo = [[NSString alloc]init];
    
        
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
        if ([myAppDelegate.mark isEqualToString:@"lunbo"]) {
            companyNo = [myAppDelegate.maFirstZoneADataDetail[myAppDelegate.number]objectForKey:@"number"];
            NSLog(@"GYJ----------这是轮播广告门店----companyNo:%@",companyNo);
            
        }else if([myAppDelegate.mark isEqualToString:@"bottomCell"]){
            companyNo = [myAppDelegate.maSecondZoneADDataDetail[myAppDelegate.number]objectForKey:@"number"];
            NSLog(@"GYJ----------这是cell广告门店----companyNo:%@",companyNo);
        }else if([myAppDelegate.mark isEqualToString:@"book"]){
            
        
            companyNo = [_introductiondetailItem objectForKey:@"storeCode"];
        
            NSLog(@"GYJ----------这是预定点餐门店----companyNo:%@",companyNo);
    
        }
    
    NSArray *array = @[@"method",@"appName",@"appPwd",@"storeCode"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryLatestAppraiseByStoreCode",@"method",@"order",@"appName",@"order",@"appPwd",companyNo,@"storeCode", nil];
    
    //        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryLatestAppraiseByStoreCode",@"method",@"order",@"appName",@"order",@"appPwd",myAppDelegate.strStoreCode,@"storeCode", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/appraiseAppService" Tag:111 rankKeyArray:array postData:dic delegate:self];
}



-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag{
    if (tag == 111) {
        NSArray *data = [[NSArray alloc] initWithArray:[jsonDic objectForKey:@"data"]];
        NSLog(@"GYJ----------jsonDIC----DATA:%@",data);
        
        self.comentsNo = [data objectAtIndex:0];
        self.Comentlist = [data objectAtIndex:1];
        
        [self.introductionTableView reloadData];
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 6) {
//        //进入评论界面
//        [self performSegueWithIdentifier:@"INFO_TO_REVIEW" sender:nil];
//    }
//}

-(void)setIntroductiondetailItem:(id)newintroductiondetailItem{
    if (_introductiondetailItem != newintroductiondetailItem) {
        _introductiondetailItem = newintroductiondetailItem;
        NSLog(@"introductiondetailItem is %@",_introductiondetailItem);
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
