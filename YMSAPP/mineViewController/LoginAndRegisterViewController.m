//
//  LoginAndRegisterViewController.m
//  MyData
//
//  Created by Rex Ma on 14-8-28.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#define appLogin 112
@interface LoginAndRegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) NSString * strUserName;
- (IBAction)loginButton:(id)sender;


@end


@implementation LoginAndRegisterViewController

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
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed =YES;
}
- (void)ymsRequestFinishedOfDictionary:(NSDictionary*)jsonDic  Requestoftag:(NSInteger)tag
{
    
    if (tag == appLogin) {
        
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            //NSArray * array2 = [jsonDic objectForKey:@"data"];
            
            NSArray * array2 = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"登陆成功返回:%@",array2);
            //登陆成功后把登录名，手机号，会员编号，头像记录到NSUserDefaults
            
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:array2[0] forKey:@"userName"];
            [userDefault setObject:array2[1] forKey:@"realName"];
            [userDefault setObject:array2[2] forKey:@"userMemberNo"];
            [userDefault setObject:array2[3] forKey:@"userImage"];
            [userDefault setObject:array2[4] forKey:@"userPassword"];
            [userDefault setObject:array2[5] forKey:@"userPhoneNumber"];
            [userDefault synchronize];
            
            // by helz
            [self dismissViewControllerAnimated: YES completion:nil ] ;
            

            
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"1"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"2"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"3"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"4"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    self.hidesBottomBarWhenPushed = NO;
//}



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
    
    if ([segue.identifier isEqualToString:@"segue_id_login"]) {
        MainTableViewController * mainConroller = (MainTableViewController *)[segue destinationViewController];
        mainConroller.strUserName = self.userName.text;
        
    }

}



- (IBAction)loginButton:(id)sender {
    YMSWebHttpRequest * loginRequest = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array1 = @[@"method",@"appName",@"appPwd",@"loginName",@"password"];
    NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"appLogin",@"method",@"order",@"appName",@"order",@"appPwd",self.userName.text,@"loginName",self.userPassword.text,@"password", nil];
    [loginRequest requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/personMemberWebService" Tag:appLogin rankKeyArray:array1 postData:dic1 delegate:self];

}
@end
