//
//  SendMealViewController.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-3.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "SendMealViewController.h"
#import "YMSAppDelegate.h"
#define queryStoreByCityAndOther 1004
#define queryStoreTasteTypeByCity 1006
#import "DetailMealViewController.h"
@interface SendMealViewController ()
@property (strong, nonatomic) IBOutlet UIButton *allTaste;
@property (nonatomic,strong) NSArray * myTasteArray;
@property (nonatomic,strong) NSMutableArray *sendMeal;
@property (strong, nonatomic) IBOutlet UIView *allTasteView;
@property (assign,nonatomic) BOOL isShowTasteView;//全部口味子视图是否出现
- (IBAction)allTasteButtonClick:(id)sender;
- (IBAction)tasteButtonClick:(id)sender;

@end

@implementation SendMealViewController

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
    self.allTasteView.hidden = YES;
    self.isShowTasteView = NO;
    // Do any additional setup after loading the view.
    self.hud = [[MBProgressHUD alloc]init];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    [self performSelector:@selector(createSendMeal) withObject:nil afterDelay:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([[segue identifier]isEqualToString:@"sendmealdetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        [[segue destinationViewController]setDetailItem:self.sendMeal[indexPath.row]];
//    }
    if ([segue.identifier isEqualToString:@"PUSH_TO_DETAIL"]) {
        DetailMealViewController * detail = (DetailMealViewController *)segue.destinationViewController;
        detail.strFlag = @"0";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self performSegueWithIdentifier:@"sendmealdetail" sender:self];
//    self.sendmealdetailviewcontroller.detailItem = self.sendMeal[indexPath.row];
    
    
    [self performSegueWithIdentifier:@"PUSH_TO_DETAIL" sender:self];
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate];
    myAppDelegate.strStoreCode = [self.sendMeal[indexPath.row] objectForKey:@"storeCode"];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sendMeal count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResourceOfSendMealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendMealCell" forIndexPath:indexPath];
    
    cell.companyName.text = self.sendMeal[indexPath.row][@"name"];
    cell.companyAddress.text = self.sendMeal[indexPath.row][@"address"];
    NSString *distance = self.sendMeal[indexPath.row][@"distance"];
    float intDistance = [distance floatValue];
    NSString *strDistance= [NSString stringWithFormat:@"%@m",distance];
    
    if (intDistance >= 1000)
    {
        double floatDistance = intDistance /1000;
        strDistance= [NSString stringWithFormat:@"%0.1fkm",floatDistance];
    }
    
    cell.distance.text = strDistance;
    
    cell.companyPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.sendMeal[indexPath.row][@"picture"]]]];//餐厅图片
    
    return cell;
}

-(void)createSendMeal{
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSData *city = [@"北京市" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc]initWithData:city encoding:NSUTF8StringEncoding];
    
    
    NSArray *array2 = @[@"method",@"appName",@"appPwd",@"city",@"area",@"type",@"tasteType",@"recommended",@"perCapitaMin",@"perCapitaMax",@"longitude",@"latitude",@"skip",@"pageSize"];
//    NSString * strTaste = [self.allTaste currentTitle];
//    NSLog(@"yulongzhen:%@",strTaste);
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByCityAndOther",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",@"",@"area",@"0",@"type",@"",@"tasteType",@"",@"recommended",@"0",@"perCapitaMin",@"0",@"perCapitaMax",@"116.30",@"longitude",@"40.05",@"latitude",@"1",@"skip",@"10",@"pageSize", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryStoreByCityAndOther rankKeyArray:array2 postData:dic2 delegate:self];
}

-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag{
    if (tag == queryStoreByCityAndOther) {
        
        NSArray *data = [[NSArray alloc] initWithArray:[jsonDic objectForKey:@"data"]];
        self.sendMeal = [[NSMutableArray alloc]init];
        NSLog(@"the data is %@",data);
        
        for (NSDictionary *information in data) {
            [self.sendMeal addObject:@{@"name": [information objectForKey:@"companyName"],
                                       @"address": [information objectForKey:@"companyAddress"],
                                       @"picture":[information objectForKey:@"companyPhoto"],
                                       @"distance":[information objectForKey:@"distance"],
                                       @"storeCode":[information objectForKey:@"companyNo"],
                                       @"comments":[information objectForKey:@"comments"],
                                       @"profile":[information objectForKey:@"introduction"],
                                       @"businessTime":[information objectForKey:@"businessHours"],
                                       @"phoneNumber":[information objectForKey:@"linkPhone"]}];
            //NSLog(@"the storecode is %@",[information objectForKey:@"companyNo"]);
        }
        [self.hud hide:YES];
        [self.tableView reloadData];
    }
    
    if (tag == queryStoreTasteTypeByCity) {
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            //NSLog(@"machao:result is %@",[jsonDic objectForKey:@"result"]);
            
            
            // NSArray *tasteData = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
            
            self.myTasteArray =[[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
            NSLog(@"helz: myTasteArray result is %@",self. myTasteArray );
            
            if (self.isShowTasteView == YES) {
                
                self.allTasteView.hidden = NO;
                
                [self.tasteButton2 setTitle:self.myTasteArray[0] forState:UIControlStateNormal];
                self.tasteButton2.tintColor = [UIColor whiteColor];
 
                
                [self.tasteButton3 setTitle:self.myTasteArray[1] forState:UIControlStateNormal];
                self.tasteButton3.tintColor = [UIColor whiteColor];
                
                [self.tasteButton4 setTitle:self.myTasteArray[2] forState:UIControlStateNormal];
                self.tasteButton4.tintColor = [UIColor whiteColor];
                
                [self.tasteButton5 setTitle:self.myTasteArray[3] forState:UIControlStateNormal];
                self.tasteButton5.tintColor = [UIColor whiteColor];
                
                [self.tasteButton6 setTitle:self.myTasteArray[4] forState:UIControlStateNormal];
                self.tasteButton6.tintColor = [UIColor whiteColor];
                
                [self.tasteButton7 setTitle:self.myTasteArray[5] forState:UIControlStateNormal];
                self.tasteButton7.tintColor = [UIColor whiteColor];
                
                [self.tasteButton8 setTitle:self.myTasteArray[6] forState:UIControlStateNormal];
                self.tasteButton8.tintColor = [UIColor whiteColor];
                
                [self.tasteButton9 setTitle:self.myTasteArray[7] forState:UIControlStateNormal];
                self.tasteButton9.tintColor = [UIColor whiteColor];
                
                [self.tasteButton10 setTitle:self.myTasteArray[8] forState:UIControlStateNormal];
                self.tasteButton10.tintColor = [UIColor whiteColor];
                
                [self.tasteButton11 setTitle:self.myTasteArray[9] forState:UIControlStateNormal];
                self.tasteButton11.tintColor = [UIColor whiteColor];
                
                [self.tasteButton12 setTitle:self.myTasteArray[10] forState:UIControlStateNormal];
                self.tasteButton12.tintColor = [UIColor whiteColor];
                
                [self.tasteButton13 setTitle:self.myTasteArray[11] forState:UIControlStateNormal];
                self.tasteButton13.tintColor = [UIColor whiteColor];
                
                [self.tasteButton14 setTitle:self.myTasteArray[12] forState:UIControlStateNormal];
                self.tasteButton14.tintColor = [UIColor whiteColor];
                
                [self.tasteButton15 setTitle:self.myTasteArray[13] forState:UIControlStateNormal];
                self.tasteButton15.tintColor = [UIColor whiteColor];
                
                [self.tasteButton16 setTitle:self.myTasteArray[14] forState:UIControlStateNormal];
                self.tasteButton16.tintColor = [UIColor whiteColor];
                
                [self.tasteButton17 setTitle:self.myTasteArray[15] forState:UIControlStateNormal];
                self.tasteButton17.tintColor = [UIColor whiteColor];
                
                [self.tasteButton18 setTitle:self.myTasteArray[16] forState:UIControlStateNormal];
                self.tasteButton18.tintColor = [UIColor whiteColor];
                
                [self.tasteButton19 setTitle:self.myTasteArray[17] forState:UIControlStateNormal];
                self.tasteButton19.tintColor = [UIColor whiteColor];
                
                [self.tasteButton20 setTitle:self.myTasteArray[18] forState:UIControlStateNormal];
                self.tasteButton20.tintColor = [UIColor whiteColor];
                
//                [self.tasteButton21 setTitle:self.myTasteArray[19] forState:UIControlStateNormal];
//                self.tasteButton21.tintColor = [UIColor whiteColor];
//                
//                [self.tasteButton22 setTitle:self.myTasteArray[20] forState:UIControlStateNormal];
//                self.tasteButton22.tintColor = [UIColor whiteColor];
//                
//                [self.tasteButton23 setTitle:self.myTasteArray[21] forState:UIControlStateNormal];
//                self.tasteButton23.tintColor = [UIColor whiteColor];
                
            }else{
                self.allTasteView.hidden = YES;
                
            }
        }
    }

}


- (IBAction)backToMainPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)allTasteButtonClick:(id)sender {
    self.isShowTasteView = !self.isShowTasteView;
    
    //发送所有口味请求
    YMSWebHttpRequest *tasteRequest = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSUserDefaults *myUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *cityName = [myUserDefaults objectForKey:@"city"];
    
    NSData *city = [cityName dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc]initWithData:city encoding:NSUTF8StringEncoding];
    
    NSArray *tasteArray = @[@"method",@"appName",@"appPwd",@"city",@"type"];
    
    NSDictionary *tasteDic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreTasteTypeByCity",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",@"0",@"type",nil];
    
    [tasteRequest requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryStoreTasteTypeByCity rankKeyArray:tasteArray postData:tasteDic delegate:self];

    
}

- (IBAction)tasteButtonClick:(id)sender {
    [self.sendMeal removeAllObjects];
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
    }else if (tasteButton.tag == 20){
        [self.allTaste setTitle:self.myTasteArray[18] forState:UIControlStateNormal];
        [self.allTaste setTintColor:[UIColor redColor]];
    }    
    self.allTasteView.hidden = YES;

    
    //选择口味后重新发送请求
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSData *city = [@"北京市" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc]initWithData:city encoding:NSUTF8StringEncoding];
    
    
    NSArray *array2 = @[@"method",@"appName",@"appPwd",@"city",@"area",@"type",@"tasteType",@"recommended",@"perCapitaMin",@"perCapitaMax",@"longitude",@"latitude",@"skip",@"pageSize"];
    NSString * strTaste = [self.allTaste currentTitle];
    NSLog(@"yulongzhen:%@",strTaste);
    
//    NSData *str = [@"川菜" dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *result1 = [[NSString alloc]initWithData:str encoding:NSUTF8StringEncoding];
    //外卖口味暂没有数据
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryStoreByCityAndOther",@"method",@"order",@"appName",@"order",@"appPwd",result,@"city",@"",@"area",@"1",@"type",strTaste,@"tasteType",@"",@"recommended",@"0",@"perCapitaMin",@"0",@"perCapitaMax",@"116.30",@"longitude",@"40.05",@"latitude",@"1",@"skip",@"10",@"pageSize", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryStoreByCityAndOther rankKeyArray:array2 postData:dic2 delegate:self];

    
}
@end
