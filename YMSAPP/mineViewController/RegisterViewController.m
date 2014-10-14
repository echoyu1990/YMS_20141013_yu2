//
//  RegisterViewController.m
//  YMSAPP
//
//  Created by Rex Ma on 14-9-2.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "RegisterViewController.h"
#define appRegistered 122
#import "MessageValidationViewController.h"
@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userMobile;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) NSString * memberNo;//会员编号
- (IBAction)registerButton:(id)sender;
@end

@implementation RegisterViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)registerButton:(id)sender {
    YMSWebHttpRequest * registerRequest = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array1 = @[@"method",@"appName",@"appPwd",@"loginName",@"mobile",@"password"];
    NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"appRegistered",@"method",@"order",@"appName",@"order",@"appPwd",self.userName.text,@"loginName",self.userMobile.text,@"mobile",self.userPassword.text,@"password", nil];
    [registerRequest requestWithURL:@"http://youmeishi.cn/UnisPlatform/services/personMemberWebService" Tag:appRegistered rankKeyArray:array1 postData:dic1 delegate:self];

}
-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == appRegistered) {
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            NSArray * array2 = [[NSArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];//注册成功
            self.memberNo = array2[1];
            
            //by helz
            [self performSegueWithIdentifier: @"segue_id_register" sender:nil ];
            
            NSLog(@"注册成功返回：%@",array2);
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

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString: @"segue_id_register"]) {
         
         MessageValidationViewController * messageController = (MessageValidationViewController *)[segue destinationViewController];
         // messageController.userMobile.text = self.userMobile.text;
         messageController.memberNo = self.memberNo;
         messageController.strMobileNumber=self.userMobile.text;
         
     }

 }

@end
