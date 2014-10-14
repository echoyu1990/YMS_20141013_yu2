//
//  NavigationPageViewController.m
//  MyData
//
//  Created by Rex Ma on 14-8-31.
//  Copyright (c) 2014年 Rex Ma. All rights reserved.
//

#import "NavigationPageViewController.h"

@interface NavigationPageViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *wel1ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *wel2ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *wel3ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *wel4ImageView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)pageView:(id)sender;
@end

@implementation NavigationPageViewController

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
    self.scrollView.contentSize = CGSizeMake(1280, 568);
    self.scrollView.pagingEnabled = YES;
    //[self.scrollView setContentOffset:CGPointMake(0, 0)];
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.wel1ImageView];
    [self.scrollView addSubview:self.wel2ImageView];
    [self.scrollView addSubview:self.wel3ImageView];
    [self.scrollView addSubview:self.wel4ImageView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    int x = point.x;
    int index = 0;
    if (x < 320) {
        index = 0;
    }else if (x < 640){
        index = 1;
    }else if (x < 960){
        index = 2;
    }else{
        index = 3;
    }
    self.pageControl.currentPage = index;
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

- (IBAction)pageView:(id)sender {
    UIPageControl * pageControl = (UIPageControl *)sender;
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage * 320, 0)  animated:YES];

}
@end
