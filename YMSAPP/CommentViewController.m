//
//  CommentViewController.m
//  YMSAPP
//
//  Created by vanceinfo on 14-10-10.
//  Copyright (c) 2014年 gaoxuzhao. All rights reserved.
//

#import "CommentViewController.h"
#import "YMSAppDelegate.h"
#define queryAppraiseByStoreCode 222
@interface CommentViewController ()
@property (strong,nonatomic) NSArray * arrayComments;
@property (strong, nonatomic) IBOutlet UITableView *commentsTableView;

@end

@implementation CommentViewController

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
    //请求评论数据
    [self requestComments];
    
}

-(void)requestComments
{
    YMSWebHttpRequest *request = [YMSWebHttpRequest shareInterfaceYMSRequest];
    YMSAppDelegate * myAppDelegate = (YMSAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSString *companyNo = myAppDelegate.strStoreCode;
    NSArray *array = @[@"method",@"appName",@"appPwd",@"storeCode"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"queryAppraiseByStoreCode",@"method",@"order",@"appName",@"order",@"appPwd",companyNo,@"storeCode", nil];
    
    [request requestWithURL:@"http://www.youmeishi.cn/UnisPlatform/services/appraiseAppService" Tag:222 rankKeyArray:array postData:dic delegate:self];
}

-(void)ymsRequestFinishedOfDictionary:(NSDictionary *)jsonDic Requestoftag:(NSInteger)tag
{
    if (tag == queryAppraiseByStoreCode) {
        self.arrayComments = [jsonDic objectForKey:@"data"];
        NSLog(@"yuarraycomment:%@",self.arrayComments);
        [self.commentsTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-- UITableViewDateSource数据源方法和代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayComments count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"REVIEWCELL" forIndexPath:indexPath];
    cell.labelUserName.text = self.arrayComments[indexPath.row][0];
    cell.labelUserTime.text = self.arrayComments[indexPath.row][1];
    cell.labelContent.text = self.arrayComments[indexPath.row][2];
    NSString * score = [NSString stringWithFormat:@"%@",self.arrayComments[indexPath.row][4]];
    
    NSLog(@"scoreyu:%@",score);
    
    if ([score isEqualToString:@"1"]) {
        [cell.commentStar1 setHighlighted:YES];
    }else if ([score isEqualToString:@"2"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
    }else if ([score isEqualToString:@"3"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
        [cell.commentStar3 setHighlighted:YES];
    }else if ([score isEqualToString:@"4"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
        [cell.commentStar3 setHighlighted:YES];
        [cell.commentStar4 setHighlighted:YES];
    }else if ([score isEqualToString:@"5"]){
        [cell.commentStar1 setHighlighted:YES];
        [cell.commentStar2 setHighlighted:YES];
        [cell.commentStar3 setHighlighted:YES];
        [cell.commentStar4 setHighlighted:YES];
        [cell.commentStar5 setHighlighted:YES];
    }
    return  cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
