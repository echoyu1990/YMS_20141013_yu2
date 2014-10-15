//
//  YMSMessageViewController.m
//  YMSAPP
//
//  Created by vanceinfo on 14-9-30.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSMessageViewController.h"
#define updateCaptcha 172
#define checkCaptcha 182
@interface YMSMessageViewController ()

@end

@implementation YMSMessageViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark-- YMSWebHttprRequestReceiveDelegate的协议方法
-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == updateCaptcha) {
        NSLog(@"ylz:%@",jsonDic);
    }
    if (tag == checkCaptcha) {
        NSLog(@"fanhuiylz:%@",jsonDic);
        if ([[jsonDic objectForKey:@"result"] isEqualToString:@"0"]) {
            [self performSegueWithIdentifier:@"MESSAGE_SUCCEED" sender:self];
        }
    }
}
- (IBAction)getMessageButtonClick:(id)sender {
    YMSWebHttpRequest * requestMessage = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array = @[@"method",@"appName",@"appPwd",@"orderNum",@"phoneNumber",@"loginName",@"password"];
    NSString * strPhoneNumer = self.textPhone.text;
    NSString * strLonginName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString * strPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"updateCaptcha",@"method",@"order",@"appName",@"order",@"appPwd",@"YD1411953378684",@"orderNum",strPhoneNumer,@"phoneNumber",strLonginName,@"loginName",strPassword,@"password", nil];
    [requestMessage requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/takeOutOrderWMService" Tag:updateCaptcha rankKeyArray:array postData:dic delegate:self];
}

- (IBAction)confirmButtonClick:(id)sender {
    YMSWebHttpRequest * requestMessage = [YMSWebHttpRequest shareInterfaceYMSRequest];
    NSArray * array = @[@"method",@"appName",@"appPwd",@"orderNum",@"captcha",@"loginName",@"password",@"phoneNumber"];
    NSString * strCaptcha = self.textMessage.text;
    NSString * strPhoneNumer = self.textPhone.text;
    NSString * strLonginName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString * strPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"checkCaptcha",@"method",@"order",@"appName",@"order",@"appPwd",@"YD1411953378684",@"orderNum",strCaptcha,@"captcha",strLonginName,@"loginName",strPassword,@"password",strPhoneNumer,@"phoneNumber", nil];
    [requestMessage requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/takeOutOrderWMService" Tag:checkCaptcha rankKeyArray:array postData:dic delegate:self];
}

@end
