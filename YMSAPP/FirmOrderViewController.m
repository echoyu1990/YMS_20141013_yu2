//
//  FirmOrderViewController.m
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "FirmOrderViewController.h"
#import "YMSAppDelegate.h"
#define generateOrders 122
@interface FirmOrderViewController ()

- (IBAction)addButtonClicked:(UIButton *)sender;

- (IBAction)minusButtonClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic) NSInteger iRealRowCount;

@property (nonatomic, strong) NSMutableArray * maOrderedDishes;

@property (nonatomic, strong) NSMutableArray * maOrderedOffset;

@property (weak, nonatomic) IBOutlet UILabel *labelTotalDescription;


//by yu
@property (strong,nonatomic)NSString * payType;//付款方式，0为到店支付，1为线上支付
@property (strong,nonatomic) NSString * strTime;//送货时间
- (IBAction)dateButtonClick:(id)sender;

- (IBAction)confirmButtonClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (assign,nonatomic)BOOL isSelectedPayment;//选择付款方式
@property (assign,nonatomic)BOOL isSelectedDate;//选择日期
@property (strong, nonatomic) IBOutlet UIButton *dateButton;
@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UITableView *dateTableView;
@property (strong, nonatomic) IBOutlet UITableView *timeTableView;

//计价行所需信息
@property (strong,nonatomic)NSString * textNumber;
@property (strong,nonatomic)NSString * textPerson;
@property (strong,nonatomic)NSString * textPhone;
@property (strong,nonatomic)NSString * textRemark;
- (IBAction)confirmDateButtonClick:(id)sender;


- (IBAction)cancelButtonClick:(id)sender;

@end

@implementation FirmOrderViewController

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
    //by yu
    self.isSelectedPayment = NO;
    self.isSelectedDate = NO;
    self.dateTableView.delegate = self;
    self.timeTableView.delegate = self;
    self.payType = @"0";
    //end
   
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
       
    self.maOrderedDishes = [[NSMutableArray alloc] init];
    
    self.maOrderedOffset = [[NSMutableArray alloc] init];
    int temp ;
    
    for (int i=0; i<[myAppDelegate.maImageViewOrderStatus count]; i++)
    {
       
        temp = [myAppDelegate.maImageViewOrderStatus[i] intValue];
        
        if (temp >0) {
        
       [self.maOrderedDishes addObject: myAppDelegate.detailInformationOfDish[i]];
        
       [self.maOrderedOffset addObject: [NSString stringWithFormat:@"%d",i]];
        
        }
    }
    
  
    self.labelTotalDescription.text = [NSString stringWithFormat:@"点了%@菜，合计%@元", myAppDelegate.strOrderQuantity,myAppDelegate.strTotalPrice];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    int iRows=0;
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    NSLog(@"helz: [myAppDelegate.maImageViewOrderStatus count]= %lu",(unsigned long)[myAppDelegate.maImageViewOrderStatus count]);
    
     NSLog(@"helz: maImageViewOrderStatus = %@", myAppDelegate.maImageViewOrderStatus);

    int temp ;
   for (int i= 0; i<[myAppDelegate.maImageViewOrderStatus count];i++ ) {
        
    temp = [myAppDelegate.maImageViewOrderStatus[i] intValue];
    if (temp >0)  iRows ++;
   
    }
    
    self.iRealRowCount = iRows;
    
    return iRows +1; //最后一行留给 计价显示
    
      //return self.orderArray.count +1;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row < self.orderArray.count) {
//        FirmOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FirmOrderCell" forIndexPath:indexPath];
//        cell.ylzDishImage.image = [UIImage imageNamed:@"b.png"];
//        cell.ylzDishName.text = @"菜名";
//        cell.ylzDishPrice.text = @"￥8/份";
//        cell.ylzTotalPrice.text = @"8";
//        cell.ylzNumber.text = @"1";
//        return cell;
//    }
    
    //获取当前的年月日
//    NSDate * now = [NSDate date];
//    NSCalendar * cal = [NSCalendar currentCalendar];
//    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents * dd = [cal components:unitFlags fromDate:now];
//    int year = [dd year];
//    int month = [dd month];
//    int day = [dd day];
//   // int hour = []
//    if ([tableView isEqual:self.dateTableView]) {
//        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DATETIME" forIndexPath:indexPath];
//        //NSDateFormatter * formatter = [NSDateFormatter ]
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];
//        return cell;
//    }
    
    
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
     if (indexPath.row < self.iRealRowCount) {
        FirmOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FirmOrderCell" forIndexPath:indexPath];
        
        cell.ylzDishName.text = [self.maOrderedDishes[indexPath.row] objectForKey:@"name"];

          cell.ylzDishPrice.text  = [NSString stringWithFormat:@"¥%d/",[[self.maOrderedDishes[indexPath.row ]  objectForKey:@"price"] intValue]];
     
         cell.addButton.tag =[self.maOrderedOffset[indexPath.row] intValue ];
         
         cell.minusButton.tag =cell.addButton.tag;

         cell.labelOrderNumber.text = myAppDelegate.maImageViewOrderStatus[cell.addButton.tag];
         
         
         return cell;
      }
    
   
 
   if  (indexPath.row == self.iRealRowCount) {
    
       FirmBottomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FirmBottomCell"];
       
       //支付方式
       if (self.isSelectedPayment == YES) {
           //设置付款按钮背景
           [cell.cashPayMent setBackgroundImage:[UIImage imageNamed:@"ddt_radio_payment_type.png"] forState:UIControlStateNormal];
       }else{
           [cell.cashPayMent setBackgroundImage:[UIImage imageNamed:@"ddt_radio_payment_type_act.png"] forState:UIControlStateNormal];
       }
       if (self.isSelectedPayment == YES) {
           [cell.onlinePayMent setBackgroundImage:[UIImage imageNamed:@"ddt_radio_payment_type_act.png"] forState:UIControlStateNormal];
       }else{
           [cell.onlinePayMent setBackgroundImage:[UIImage imageNamed:@"ddt_radio_payment_type.png"] forState:UIControlStateNormal];
       }
       
       //应付金额
       cell.labelAllMoney.text = myAppDelegate.strTotalPrice;
       cell.labelPaymoney.text = myAppDelegate.strTotalPrice;
       
       cell.textPhone.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNumber"];//登陆后返回的手机号
       self.textNumber = cell.textNumber.text;//就餐人数
       self.textPerson = cell.textPerson.text;//联系人
       self.textPhone = cell.textPhone.text;//
       self.strTime = cell.labelYearAndDate.text;//预约时间
       self.textRemark = cell.textMore.text;//备注
       
       return cell;
       
    }
    
    return nil;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (indexPath.row == self.orderArray.count) {
    if (indexPath.row ==  self.iRealRowCount) {
    return 360;
    }else return 70;
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

#pragma mark--点击事件的处理
- (IBAction)addButtonClicked:(UIButton *)sender {
    //加一份
  
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    int temp;
     // 更改某道菜点了几次
    temp = [myAppDelegate.maImageViewOrderStatus[sender.tag]intValue];
    temp ++;
    myAppDelegate.maImageViewOrderStatus[sender.tag] = [NSString stringWithFormat:@"%d",temp];
   
    // 更改 总共点了几个菜
    
    temp = [myAppDelegate.strOrderQuantity intValue];
    temp ++;
    myAppDelegate.strOrderQuantity =[NSString stringWithFormat:@"%d",temp] ;
    
    
    // 更改总价
    //float tempPrice = [myAppDelegate.strTotalPrice floatValue];
    int tempPrice = [myAppDelegate.strTotalPrice floatValue];

    tempPrice = tempPrice + [[myAppDelegate.detailInformationOfDish [sender.tag] objectForKey:@"price"] floatValue];
    
    myAppDelegate.strTotalPrice = [NSString stringWithFormat:@"%d",tempPrice];
    
    
    
    [self.myTableView reloadData];
    
     self.labelTotalDescription.text = [NSString stringWithFormat:@"点了%@菜，合计%@元", myAppDelegate.strOrderQuantity,myAppDelegate.strTotalPrice];
}

- (IBAction)minusButtonClicked:(UIButton *)sender {

    //减一份
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    int temp = [myAppDelegate.maImageViewOrderStatus[sender.tag]intValue];
    
    if (temp >0)
    {
    temp --;
        
    myAppDelegate.maImageViewOrderStatus[sender.tag] = [NSString stringWithFormat:@"%d",temp];
    
    // 更改 总共点了几个菜
    
    temp = [myAppDelegate.strOrderQuantity intValue];
    temp --;
    myAppDelegate.strOrderQuantity =[NSString stringWithFormat:@"%d",temp] ;
    
    
    // 更改总价
    //float tempPrice = [myAppDelegate.strTotalPrice floatValue];
    
    int tempPrice = [myAppDelegate.strTotalPrice floatValue];
        
      tempPrice = tempPrice - [[myAppDelegate.detailInformationOfDish [sender.tag] objectForKey:@"price"] floatValue];
    
    myAppDelegate.strTotalPrice = [NSString stringWithFormat:@"%d",tempPrice];
        
    
    [self.myTableView reloadData];
    
    self.labelTotalDescription.text = [NSString stringWithFormat:@"点了%@菜，合计%@元", myAppDelegate.strOrderQuantity,myAppDelegate.strTotalPrice];
    }
}




- (IBAction)yearAndDAteButtonClick:(id)sender {
    //选择具体日期
    self.dateTableView.hidden = NO;
}

- (IBAction)timeButtonClick:(id)sender {
    //选择具体时间
    self.timeTableView.hidden = NO;
}

- (IBAction)confirmDateButtonClick:(id)sender {
    //确定日期
    self.dateView.hidden = YES;
    
}



- (IBAction)cancelButtonClick:(id)sender {
    //取消选择
    self.dateView.hidden = YES;
}


- (IBAction)dateButtonClick:(id)sender {//表格上的日期选择
    //日期选择的view出现
    self.dateView.hidden = NO;
    [self.view bringSubviewToFront:self.dateView];//将选择时间的view显示在最前方
    self.isSelectedDate = YES;
    [self.myTableView reloadData];
}
- (IBAction)confirmButtonClick:(id)sender {//确认订单
    [self.myTableView reloadData];
    //到店支付无条件跳转
    //[self performSegueWithIdentifier:@"PUSH_TO_VERIFY" sender:self];
    
   //有条件跳转
    if (self.textNumber != nil && self.textPerson != nil && self.textPhone != nil) {
        if ([self.payType isEqualToString:@"0"]) {
            //到店支付
             [self performSegueWithIdentifier:@"PUSH_TO_VERIFY" sender:nil];//进入短信验证页面
        }else{
            //在线支付
            [self performSegueWithIdentifier:@"PUSH_TO_ZHIFUBAO" sender:self];//进入支付宝
        }
       
     //点击时发送订单生成请求
        YMSWebHttpRequest * requestOrder = [YMSWebHttpRequest shareInterfaceYMSRequest];
        NSArray * array = @[@"method",@"appName",@"appPwd",@"loginName",@"storeCode",@"customerName",@"customerPhone",@"deliveryAddress",@"deliveryTime",@"requirements",@"invoice",@"payment",@"totalPrice",@"freight",@"subtotalPrice",@"remark",@"orderType",@"peopleNum",@"orderSource",@"payOff",@"password",@"coupons",@"remainder",@"actualPay",@"couponsId ",@"dishDetail"];
        //NSString * strLoginName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        //NSString * strPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
        YMSAppDelegate * myDelegate  = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
        NSString * strStoreCode = myDelegate.strStoreCode;
        //NSString * strName = [[NSUserDefaults standardUserDefaults] objectForKey:@"realName"];
       // NSString * strPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneNumber"];
       // NSString * remark = self
        NSLog(@"yulz:%@",strStoreCode);
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"generateOrders",@"method",@"order",@"appName",@"order",@"appPwd",@"echo1990",@"loginName",@"1411372920821",@"storeCode",@"yu",@"customerName",@"13792048925",@"customerPhone",@"beijing",@"deliveryAddress",@"2014-10-8 15:40",@"deliveryTime",@"test",@"requirements",@"test",@"invoice",@"1",@"payment",myDelegate.strTotalPrice,@"totalPrice",@"0",@"freight",myDelegate.strTotalPrice,@"subtotalPrice",@"test",@"remark",@"1",@"orderType",@"2",@"peopleNum",@"1",@"orderSource",@"0",@"payOff",@"25f9e794323b453885f5181f1b624d0b",@"password",@"0",@"coupons",@"0",@"remainder",@"0",@"actualPay",@"0",@"couponsId ",@"test",@"dishDetail", nil];
        [requestOrder requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/takeOutOrderWMService" Tag:generateOrders rankKeyArray:array postData:dic delegate:self];
     
    }
    if (self.textNumber == nil) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"就餐人数不能为空！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
        [alert show];
    }else if(self.textPerson == nil){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"联系人不能为空！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
        [alert show];
    }else if(self.textPhone == nil){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"联系电话不能为空！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
        [alert show];
    }

}
-(void)theTimer:(NSTimer *)theTimer
{
    UIAlertView * alert = [theTimer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    alert = NULL;
}

- (IBAction)cashPayMoneyButtonClick:(id)sender {//到店付款
    //到店付款
    self.payType = @"0";
    self.isSelectedPayment = !self.isSelectedPayment;
    [self.myTableView reloadData];
}

- (IBAction)onlinePayMoneyButtonClick:(id)sender {//网上支付
    self.payType = @"1";
    self.isSelectedPayment = !self.isSelectedPayment;
    [self.myTableView reloadData];

}
#pragma mark--YMSWebHttprRequestReceiveDelegate的协议方法
-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == generateOrders) {
        NSLog(@"dingdanhao:%@",jsonDic);//没有数据返回
    }
}

- (IBAction)payButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"PUSH_TO_ZHIFUBAO" sender:self];//进入支付宝
}

@end
