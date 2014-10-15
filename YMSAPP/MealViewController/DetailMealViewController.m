//
//  DetailMealViewController.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-5.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "DetailMealViewController.h"

#import  "YMSAppDelegate.h"

#define queryDishByStoreCode 1003
#define addCollectionStoreByLoginNo 1004

@interface DetailMealViewController ()

@property (strong, nonatomic) IBOutlet UITableView *rootMenuTableView;

@property (strong, nonatomic) IBOutlet UITableView *subMenuTableView;

@property (weak, nonatomic) IBOutlet UIView *greyalphabackground;


@property (strong, nonatomic) IBOutlet UITextField *textKeyWord;
@property (strong,nonatomic)NSString * strKeyWord;
@property (nonatomic,strong) NSString *storeCode;

@property (nonatomic,strong) NSArray *styleOfString;

//@property (nonatomic,strong) NSMutableArray *styleofdish;//菜系的名字

@property (nonatomic,strong) NSArray *styleofdish;//菜系的名字

// numberOfDishSection 存放 data3 的数据；
@property (nonatomic,strong) NSArray *numberOfDishSection;//rootview中section中的row的数量

@property (nonatomic) NSInteger numberOfdishes;//subview中row的数量

//@property (nonatomic,strong) NSMutableArray *detailInformationOfDish;

//---helz--
@property (nonatomic,strong)  NSArray * subArray;
@property (nonatomic,strong)  NSString * orderStrNumber;

@property (nonatomic) int orderIntNumber;

@property (nonatomic,strong) NSMutableArray *maOrderMark;

//----machao
@property (nonatomic) NSInteger totalPrice;
@property (nonatomic) NSInteger totalNum;


- (IBAction)buyButtonClick:(id)sender;
- (IBAction)collectButtonClick:(id)sender;
@end

@implementation DetailMealViewController

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
   // self.keywordsearchbar.delegate = self;
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    //[self createDetailMeal];
    self.greyalphabackground.hidden = YES;
    
   // self.keywordsearchbar.hidden =YES;
    
    [self performSelector:@selector(createDetailMeal) withObject:nil afterDelay:0.1];
    
    // by helz for 初始化 左侧order label 要显示的 order 数量
    self.maOrderMark = [[NSMutableArray alloc] init ];
    // by helz for 初始化 cell 被 “点”后的图标
    
    if (! self.maSearchData)  self.maSearchData =[[NSMutableArray alloc]init ];
    
   
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];

    [myAppDelegate.detailInformationOfDish removeAllObjects];
    
    [myAppDelegate.maImageViewOrderStatus  removeAllObjects] ; 
    
    
     myAppDelegate.strOrderQuantity =@"0";
    
     myAppDelegate.strTotalPrice = @"0" ;
    
    self.strSearchStatus =@"0" ;
    [self eraseTableData] ;  //helz: 清除数据库中表的内容
    
    
    //by machao for 总价格
    self.totalPrice = 0;
    self.totalNum = 0;
    [self.buttonAccount setHidden:YES];
    [self.accountsInformation setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.subMenuTableView reloadData] ;
    
    [self.rootMenuTableView reloadData] ;

    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    self.accountsInformation.text = [NSString stringWithFormat:@"共计：%@个菜,%@元",myAppDelegate.strOrderQuantity ,myAppDelegate.strTotalPrice];

    
}
#pragma mark -- tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual: self.rootMenuTableView]) {
        
        if ([self.strSearchStatus isEqualToString:@"0"])
          return self.numberOfdishes;
        else
            return 1;
    }
    else if ([tableView isEqual:self.subMenuTableView]) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual: self.subMenuTableView]) {
        return self.numberOfdishes;
    }
    
    else if([tableView isEqual: self.rootMenuTableView]){

        if ( [self.strSearchStatus isEqualToString:@"0"] ) {
        // 来自data3的数据结构
        NSInteger number,firstindex,secondindex;//row的数量
        firstindex = [[self.numberOfDishSection objectAtIndex:section] intValue];
        secondindex = [[self.numberOfDishSection objectAtIndex:section+1] intValue];
        number = secondindex - firstindex;
        return number;
        }
        else
        {
        
            return [ self.maSearchData count] ;  //search到的记录数
            
        }
    }
    
    return 0;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual: self.subMenuTableView]) {
        return @"";
    }
    else if([tableView isEqual: self. rootMenuTableView]){
        return self.styleOfString[section];
    }
    
    return @"";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
      // 显示右侧列表food menu
    
    if ([tableView isEqual: self.rootMenuTableView]) {
       
        RootMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailDishCell" forIndexPath:indexPath];
        
        //section 中的row + data3 的偏移量，每个row.tag都是唯一的。
    
        int intRealRow;
        
        if ( [self.strSearchStatus isEqualToString:@"0"])
        {
        intRealRow = [self.numberOfDishSection[indexPath.section] intValue ]+ indexPath.row;
        }
        
        else
        
        {
            DishRecordData * data = self.maSearchData[indexPath.row];
        
            intRealRow =[data.strDishID intValue];
        
            NSLog(@"helz: self.arrSearchData = %@", data) ; 
        }
        
        cell.orderButton.tag = intRealRow;
        
    
        NSLog(@"helz: orderButton.tag = %d", cell.orderButton.tag) ;
        
        
        //----------联动-----------------------
       
        // 右侧tableView 的section，对应着 左侧tableView的 row。
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.section  inSection:0 ];
        
        NSLog(@"helz: rootTableView IndexPath.section = %d", indexPath.section );
       
        // 两个tableView联动，当右侧tableView section 变动时，
        [self.subMenuTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //--------------------------------------------
        
       
        
       YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
        
        cell.dishName.text = [myAppDelegate.detailInformationOfDish[intRealRow] objectForKey:@"name"];//菜品名称
        
        NSString *price = [NSString stringWithFormat:@"¥%d/",[[myAppDelegate.detailInformationOfDish[intRealRow] objectForKey:@"price"] intValue]];
        
        cell.dishPrice.text = price;//菜品价格
        
        cell.dishUnit.text = [myAppDelegate.detailInformationOfDish[intRealRow] objectForKey:@"unit"];

        
       NSLog(@"helz: myAppDelegate.detailInformationOfDish =%@",myAppDelegate.detailInformationOfDish) ;
        
        
        //当前 picture的返回值都是 null
        
//        NSString * temp = [myAppDelegate.detailInformationOfDish[intRealRow] objectForKey:@"picture"];
//        
//        [cell.dishView setImageWithURL:[NSURL URLWithString: temp] placeholderImage: [UIImage imageNamed:@"b.png"] ];
        
        
        cell.dishView.image = [UIImage imageNamed:@"b.png"];
        
        cell.orderlabel.image = nil;
       
        int temp1 =[myAppDelegate.maImageViewOrderStatus[intRealRow] intValue];
        
        if (temp1 >0)
        {
         cell.orderlabel.image = [UIImage imageNamed:@"yd.png"] ;
         
        }
      
        return cell;
        
    }
        // 左侧TableView显示
    else if ([tableView isEqual: self.subMenuTableView]){
        subMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StyleOfDishCell" forIndexPath:indexPath];
        
        cell.dishStyle.text = self.styleofdish[indexPath.row];
        
        cell.numberOfDishes.text = self.maOrderMark[indexPath.row];
        
        
        return cell;
    }
    
    return NULL;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual: self.rootMenuTableView])
       return 71 ;
    
    else if ([tableView isEqual: self.subMenuTableView])
        return 50 ;

    return 60 ;
}

 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    [self.rootMenuTableView deselectRowAtIndexPath:indexPath animated:NO];
   
    if ([tableView isEqual: self.subMenuTableView]) {
        
        self.strSearchStatus =@"0";  //点击左侧，全面展示右侧菜单
        [self.rootMenuTableView reloadData] ;
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
       [self.rootMenuTableView scrollToRowAtIndexPath: path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


-(void)createDetailMeal{
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
    //预定点餐
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    //NSLog(@"The profile is %@",[_detailItem objectForKey:@"profile"]);
    
    NSArray *array2 = @[@"method",@"appName",@"appPwd",@"storeCode",@"flag"];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryDishByStoreCode",@"method",@"order",@"appName",@"order",@"appPwd",myAppDelegate.strStoreCode,@"storeCode",@"1",@"flag", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryDishByStoreCode rankKeyArray:array2 postData:dic2 delegate:self];
    
    //外卖送餐
    YMSWebHttpRequest *request22 = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSArray *array22 = @[@"method",@"appName",@"appPwd",@"storeCode",@"flag"];
   
    NSString * strStoreCode = myAppDelegate.strStoreCode;
    NSDictionary *dic22 = [NSDictionary dictionaryWithObjectsAndKeys:@"queryDishByStoreCode",@"method",@"order",@"appName",@"order",@"appPwd",strStoreCode,@"storeCode",@"0",@"flag", nil];
    
    [request22 requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/baseInfoService" Tag:queryDishByStoreCode rankKeyArray:array22 postData:dic22 delegate:self];

}


// added by helz ------------
- (IBAction)orderButtonClicked:(UIButton *)sender {
   
    
    //------ 显示 “勾选” 被点的cell
    
        YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    int temp;
    
    // 某道菜被点了几次
    temp = [myAppDelegate.maImageViewOrderStatus[sender.tag] intValue];
    temp ++;
        myAppDelegate.maImageViewOrderStatus[sender.tag]=[NSString stringWithFormat:@"%d",temp];
    
    // 更改 总共点了几个菜
    int tempQuantity ;
    tempQuantity = [myAppDelegate.strOrderQuantity intValue];
    tempQuantity ++;
    myAppDelegate.strOrderQuantity =[NSString stringWithFormat:@"%d",tempQuantity] ;
    
    
    // 更改总价
    //float tempPrice = [myAppDelegate.strTotalPrice floatValue];
    int tempPrice = [myAppDelegate.strTotalPrice floatValue];
    tempPrice = tempPrice + [[myAppDelegate.detailInformationOfDish [sender.tag] objectForKey:@"price"] floatValue];
    myAppDelegate.strTotalPrice = [NSString stringWithFormat:@"%d",tempPrice];
    

    
    
    //----------------------------
    int section ;   // 判断所“点”的cell 属于哪个 section
    //通过for循环获取section的数值
    for ( section=0; section<[self.styleofdish count]; section++) {
        
        if  (sender.tag  <  [self.numberOfDishSection[section] intValue])
            break;
    }
    section = section -1;
    NSLog(@"machao:the new sender.tag is %d",sender.tag);
    NSLog(@"helz: orderClickedSection = %d",section);
     // 获取到 section
    
    int orderNumber =  [self.maOrderMark[section] intValue];
         orderNumber ++;
                        
    self.maOrderMark[section]=[NSString stringWithFormat:@"%d",orderNumber];
    
    //---machao-----获取总价格和菜的数量
    //-----machao-----获取点菜总数
    self.totalNum = self.totalNum + 1;
    //    NSInteger index = [self.numberOfDishSection[section] intValue]+sender.tag;
    NSLog(@"the index is %d",sender.tag);
   
    
//    NSInteger price = [[[myAppDelegate.detailInformationOfDish objectAtIndex:sender.tag] objectForKey:@"price"] intValue];
// 
//    NSLog(@"machao:the order price is %d",price);
//    self.totalPrice = self.totalPrice + price;
//    NSLog(@"machao:the total price is %d",self.totalPrice);
    
    
   
    
    //self.accountsInformation.text = [NSString stringWithFormat:@"共计：%d个菜,%d元",self.totalNum,self.totalPrice];
    
    self.accountsInformation.text = [NSString stringWithFormat:@"共计：%@个菜,%@元",myAppDelegate.strOrderQuantity ,myAppDelegate.strTotalPrice];

    
    //self.accountsInformation.text = [self.accountsInformation.text stringByAppendingFormat:@",%d元",self.totalPrice];
    [self.accountsInformation setHidden:NO];
    [self.buttonAccount setHidden:NO];
       // 设置 subArray 中的对应的值。
    
       // 更改 submenu cell 的 值
    
      [self.subMenuTableView reloadData] ;
    
      [self.rootMenuTableView reloadData] ;

    //[self.rootMenuTableView reloadRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
    
    

}



-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag{
    if (tag == queryDishByStoreCode) {
        NSLog(@"The information of dishes is %@",jsonDic);
        
        
        NSArray *data = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
        NSArray *data2 = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data2"]];
        NSArray *data3 = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data3"]];
        
        self.numberOfdishes = [data2 count];//菜的种类数量
        self.styleOfString = [[NSArray alloc]initWithArray:data2];//菜的种类
        self.numberOfDishSection = [[NSArray alloc]initWithArray:data3];
        
        NSLog(@"data2 is %@",data2);
        NSLog(@"data3 is %@",data3);
        
        
       YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
        
        int indexID =0;
        
        for (NSArray *dishInformation in data) {
           
     [myAppDelegate.detailInformationOfDish addObject:
       @{@"name":[dishInformation objectAtIndex:1],
         @"price":[dishInformation objectAtIndex:5],
         @"unit":[dishInformation objectAtIndex:4],
         @"picture":[dishInformation objectAtIndex:6],
        }];

            // helz： 将菜品的indexID、name 存入数据库表中
            
            DishRecordData * recordData = [[DishRecordData alloc] init ];
            
            recordData.strDishName = [dishInformation objectAtIndex:1];
            
            recordData.strDishID = [NSString stringWithFormat:@"%d",indexID];
          
            [self insertDish:recordData];
            indexID ++;
   }
        
     NSLog(@"helz: myDelegat.detailinfo =%@",myAppDelegate.detailInformationOfDish );
        
        
        self.styleofdish = [[NSArray alloc] initWithArray:data2 ];
        
        for (int i=0; i<[self.styleofdish count]; i++)
        {
         [self.maOrderMark insertObject:@"0" atIndex:i];
        }
        
//        for (int i=0; i<[data count]; i++)  // data: 表示总共有多少个菜
//       {
//            [myAppDelegate.maImageViewOrderStatus insertObject:@"0" atIndex:i];
//        }
        
        
       for (int i=0; i<[[self.numberOfDishSection lastObject] intValue]; i++)  // data: 表示总共有多少个菜
        {
          [myAppDelegate.maImageViewOrderStatus insertObject:@"0" atIndex:i];
        }

        //----------------------------------------------------------
        [self.hud hide:YES];
        [self.rootMenuTableView reloadData];
        [self.subMenuTableView reloadData];
        
        
        
    }
    
    
    if (tag == addCollectionStoreByLoginNo) {
        NSLog(@"collection:%@",jsonDic);
    }
}

-(void)setDetailItem:(id)newdetailItem{
    if(_detailItem != newdetailItem){
        _detailItem = newdetailItem;
        //NSLog(@"the information is %@",_detailItem);
    }
    
}



#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"DETAIL_TO_INTRODUCTION"]){
        [[segue destinationViewController] setIntroductiondetailItem:self.detailItem];
    }
}




- (IBAction)introductionButtonClicked:(UIButton *)sender {
    [self performSegueWithIdentifier:@"DETAIL_TO_INTRODUCTION" sender:self];
    self.introductionviewcontroller.introductiondetailItem = self.detailItem;
}




#pragma mark -- database ---

//------------------------------------------
- (void) insertDish: ( DishRecordData  *) dishData {
    
    //    // 注意表的名称
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO MyTable"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    
    NSMutableArray * arguments = [[NSMutableArray alloc] init ] ;
    
    
    if (dishData.strDishID) {
        [keys appendString:@"id,"];
        [values appendString:@"?,"];
        [arguments addObject:dishData.strDishID];
    }
    if (dishData.strDishName) {
        [keys appendString:@"name,"];
        [values appendString:@"?,"];
        [arguments addObject:dishData.strDishName];
    }
    
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    
    NSLog(@"helz: query =: %@",query);
    
    NSLog(@"helz: arguments =: %@", arguments);
    
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    [myAppDelegate.myDataBase open] ;
    
    [myAppDelegate.myDataBase executeUpdate:query withArgumentsInArray:arguments];
    
    [myAppDelegate.myDataBase close] ;
}


//--------------------------
/*
- (NSArray *) searchRecord:(NSString *) name  {
    
    NSString *query = [NSString stringWithFormat:
                    @"SELECT * FROM MyTable WHERE name LIKE '%%%@%%'",
                              name
                              ];

    
 YMSAppDelegate * myAppDelegate = [[UIApplication sharedApplication] delegate ];
    
    [myAppDelegate.myDataBase open] ;
    
    
    FMResultSet * rs = [myAppDelegate.myDataBase executeQuery:query];
    
    NSMutableArray * array = [[NSMutableArray alloc ] init];
    
	
    while ([rs next]) {
        
        DishRecordData * data = [[DishRecordData alloc] init ];
        
        data.strDishID = [rs stringForColumn:@"id"];
        data.strDishName = [rs stringForColumn:@"name"];
        
        [array addObject:data];
  	}
	
    NSLog(@"helz: database data = %@", array) ;
    
    [rs close];
    
    [myAppDelegate.myDataBase close] ;
    
    return array;
    
    
    NSLog(@"helz: search result =%@", array) ;
    
}
*/


- (void) searchRecord:(NSString *) name  {
    
    [self.maSearchData removeAllObjects];
    
    NSString *query = [NSString stringWithFormat:
                       @"SELECT * FROM MyTable WHERE name LIKE '%%%@%%'",
                       name
                    ];

   
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    [myAppDelegate.myDataBase open] ;
    
    
    FMResultSet * rs = [myAppDelegate.myDataBase executeQuery:query];
    
   
    while ([rs next]) {
        
        DishRecordData * data = [[DishRecordData alloc] init ];
        
        data.strDishID = [rs stringForColumn:@"id"];
        data.strDishName = [rs stringForColumn:@"name"];
        
        [self.maSearchData addObject:data];
  	}
	
    NSLog(@"helz: database data = %@", self.maSearchData) ;
    
    [rs close];
    
    [myAppDelegate.myDataBase close] ;
    
    
    NSLog(@"helz: search result =%@", self.maSearchData) ;
    
}


- (BOOL) eraseTableData
{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM MyTable"];
   
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[[UIApplication sharedApplication] delegate ];
    
    [myAppDelegate.myDataBase open] ;
    
    if (![myAppDelegate.myDataBase executeUpdate: query])
    {
        NSLog(@"helz: Erase table error!");
   
        [myAppDelegate.myDataBase close] ;
 
        return NO;
    }
    
    [myAppDelegate.myDataBase close] ;

    return YES;
}





#pragma  mark -- search --
- (IBAction)searchButtton:(id)sender {
  
    self.strKeyWord = self.textKeyWord.text;
    [self.textKeyWord resignFirstResponder];
    [self searchRecord: self.strKeyWord] ;
    
    
    self.strSearchStatus =@"1";
    
    [self.rootMenuTableView reloadData];
    
    [self.subMenuTableView reloadData] ;
}

- (IBAction)buyButtonClick:(id)sender {
    if ([self.strFlag isEqualToString:@"0"]) {
        //外卖订餐
        [self performSegueWithIdentifier:@"TAKEOUT_ORDER" sender:self];
    }else{
        //预定订餐,登陆可以跳转，未登录先登录
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName" ] != nil) {
            [self performSegueWithIdentifier:@"ORDER_FIRM" sender:self];
        }else{
            //先登录
            
            [self performSegueWithIdentifier:@"DETAIL_TO_LOGIN" sender:self];
            YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
            myAppDelegate.mark2 = @"fromBookDetail";
        }
        
    }
    
}

- (IBAction)collectButtonClick:(id)sender {
    
    YMSWebHttpRequest * request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    
    NSArray * array = @[@"method",@"appName",@"appPwd",@"memberNo",@"companyNo",@"password"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"addCollectionStoreByLoginNo",@"method",@"order",@"appName",@"order",@"appPwd",[[NSUserDefaults standardUserDefaults] objectForKey:@"userMemberNo"],@"memberNo",[_detailItem objectForKey:@"storeCode"],@"companyNo",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"],@"password", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/collectionAppService" Tag:addCollectionStoreByLoginNo rankKeyArray:array postData:dic delegate:self];

}


- (IBAction)unwindFromRegisterToDetailMealViewController:(UIStoryboardSegue *)segue {
    
    
}

@end
