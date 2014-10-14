//
//  MessageValidationViewController.m
//  YMSAPP
//
//  Created by vanceinfo on 14-9-24.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "MessageValidationViewController.h"
#define updateMemberRegCaptcha 1132
#define checkRegCaptcha 1142
#import "MainTableViewController.h"
@interface MessageValidationViewController ()
@property (strong, nonatomic) IBOutlet UITextField *messageText;
@property (strong, nonatomic) NSString * strCaptcha;//验证码
- (IBAction)getMessageButton:(id)sender;

- (IBAction)validationButton:(id)sender;
@end

@implementation MessageValidationViewController

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
    self.userMobile.text = self.strMobileNumber;
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
- (IBAction)getMessageButton:(id)sender {
    YMSWebHttpRequest * requestMessage = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array1 = @[@"method",@"appName",@"appPwd",@"memberNo",@"phoneNumber"];
    
    //NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"updateMemberRegCaptcha",@"method",@"order",@"appName",@"order",@"appPwd",self.memberNo,@"memberNo",self.userMobile.text,@"phoneNumber", nil];
    
    NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"updateMemberRegCaptcha",@"method",@"order",@"appName",@"order",@"appPwd",self.memberNo,@"memberNo",self.strMobileNumber,@"phoneNumber", nil];
    
    
    [requestMessage requestWithURL:@"http://youmeishi.cn/UnisPlatform/services/personMemberWebService" Tag:updateMemberRegCaptcha rankKeyArray:array1 postData:dic1 delegate:self];
}


-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == updateMemberRegCaptcha) {
        
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"1"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"2"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"3"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"4"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }
    }
    
    if (tag == checkRegCaptcha) {
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            //验证成功，跳转到”我的“界面
            //            UIStoryboard * mineStoryBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //            MainTableViewController * mainController = [mineStoryBorad instantiateViewControllerWithIdentifier:@"mineController"];
            //            [self presentViewController:mainController animated:NO completion:^{
            //                mainController.strUserName = [jsonDic objectForKey:@"data"][0];
            //
            //            }];
            
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"1"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"2"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"4"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }else if ([[jsonDic objectForKey:@"result"] isEqualToString:@"5"]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[jsonDic objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(theTimer:) userInfo:alert repeats:YES];
            [alert show];
        }
        
    }
}
-(void)theTimer:(NSTimer *)theTimer
{
    UIAlertView * alert = [theTimer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    alert = NULL;
}

//验证验证码

- (IBAction)validationButton:(id)sender {
    
    YMSWebHttpRequest * requestValidation = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array1 = @[@"method",@"appName",@"appPwd",@"memberNo",@"captcha",@"phoneNumber"];
    NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"checkRegCaptcha",@"method",@"order",@"appName",@"order",@"appPwd",self.memberNo,@"memberNo",@"147702",@"captcha",self.strMobileNumber,@"phoneNumber", nil];
    [requestValidation requestWithURL:@"http://youmeishi.cn/UnisPlatform/services/personMemberWebService" Tag:checkRegCaptcha rankKeyArray:array1 postData:dic1 delegate:self];
    
}

@end
