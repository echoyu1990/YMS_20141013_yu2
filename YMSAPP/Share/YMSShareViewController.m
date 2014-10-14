//
//  YMSShareViewController.m
//  YMSAPP
//
//  Created by gaoxuzhao on 14/10/8.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "YMSShareViewController.h"
#import "WXApi.h"

@interface YMSShareViewController ()

@end

@implementation YMSShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)OnWXClick:(id)sender
{
    UIActionSheet *acSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享给微信好友",@"分享到朋友圈", nil];
    acSheet.tag = 1;
    acSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [acSheet showInView:[[UIApplication sharedApplication]keyWindow]];
    //[self sendTextContent];
}

- (void) sendTextContentToWXSceneSession
{
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene = WXSceneSession;
    req.text = @"我正在使用一款订餐软件——“有美食”用它订餐方便、快捷、时尚、下载来试试...";
    req.bText = YES;
    
    [WXApi sendReq:req];
}

- (void) sendTextContentWXSceneTimeline
{
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene = WXSceneTimeline;
    req.text = @"我正在使用一款订餐软件——“有美食”用它订餐方便、快捷、时尚、下载来试试...";
    req.bText = YES;
    
    [WXApi sendReq:req];
}

#pragma mark - uiactionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1) {
        if (buttonIndex == 0) {
            
            [self sendTextContentToWXSceneSession];
        }
        else if (buttonIndex == 1) {
            
            [self sendTextContentWXSceneTimeline];
        }
        
    }
    
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

@end
