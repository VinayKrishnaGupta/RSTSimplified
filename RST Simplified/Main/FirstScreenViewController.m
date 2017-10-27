//
//  FirstScreenViewController.m
//  RST Simplified
//
//  Created by RSTI E-Services on 26/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

#import "FirstScreenViewController.h"

@interface FirstScreenViewController () {
    UIImageView *bgImageView;
    float width;
}

@end

@implementation FirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAnimatingBackground];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addAnimatingBackground {
    
    
    UIImageView *testView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background_main"]];
    
    testView.contentMode = UIViewContentModeScaleAspectFit;
    
    width  = testView.frame.size.width;
    float height  = testView.frame.size.height;
    
    float mult = height/[[UIScreen mainScreen]bounds].size.height;
    
    width = width/mult;
    
    bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, [[UIScreen mainScreen] bounds].size.height)];
    [bgImageView setImage:[UIImage imageNamed:@"background_main"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    [self AnimatingView];
    
}
-(void)AnimatingView {
    
    // Add UIViewAnimationOptionCurveLinear in options to get constant velocity while moving
    
    
    [UIView animateWithDuration:8.0f
                          delay:0.0f
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         [bgImageView setFrame:CGRectMake(-(bgImageView.bounds.size.width - [UIScreen mainScreen].bounds.size.width), 0,bgImageView.bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
                     }
                     completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
