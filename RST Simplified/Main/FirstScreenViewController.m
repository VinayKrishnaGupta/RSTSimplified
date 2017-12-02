//
//  FirstScreenViewController.m
//  RST Simplified
//
//  Created by RSTI E-Services on 26/10/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

#import "FirstScreenViewController.h"
#import "RST Simplified-Bridging-Header.h"
#import "RST_Simplified-Swift.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface FirstScreenViewController () {
    UIImageView *bgImageView;
    float width;
    __weak IBOutlet UIImageView *VisaImageView;
    __weak IBOutlet UIImageView *ImmigrationImageView;
    __weak IBOutlet UIImageView *StudentServicesImageView;
    __weak IBOutlet UIImageView *AttestationImageView;
    __weak IBOutlet UIImageView *AirportServicesImageView;
    __weak IBOutlet UIImageView *PassportServicesImageView;
    
    
    
}

@end

@implementation FirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"warning"]];
    [SVProgressHUD setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
//    [SVProgressHUD show];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    [SVProgressHUD setRingNoTextRadius:24];
    [SVProgressHUD setRingThickness:2];
    
     [self SetupTapGuestures];
     self.view.userInteractionEnabled = true ;
     [self addAnimatingBackground];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
}

-(void)SetupTapGuestures {
    
    UITapGestureRecognizer *VisaTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(VisaButton)];
    VisaTap.numberOfTapsRequired = 1;
    [VisaImageView setUserInteractionEnabled:YES];
    [VisaImageView addGestureRecognizer:VisaTap];
    
    
    UITapGestureRecognizer *ImmigrationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImmigrationButton)];
    ImmigrationTap.numberOfTapsRequired = 1;
    [ImmigrationImageView setUserInteractionEnabled:YES];
    [ImmigrationImageView addGestureRecognizer:ImmigrationTap];
    
    UITapGestureRecognizer *StudentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StudentServices)];
    StudentTap.numberOfTapsRequired = 1;
    [StudentServicesImageView setUserInteractionEnabled:YES];
    [StudentServicesImageView addGestureRecognizer:StudentTap];
    
    UITapGestureRecognizer *AttestationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AttestationServices)];
    AttestationTap.numberOfTapsRequired = 1;
    [AttestationImageView setUserInteractionEnabled:YES];
    [AttestationImageView addGestureRecognizer:AttestationTap];
    
    UITapGestureRecognizer *AirportTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AirportServices)];
    AirportTap.numberOfTapsRequired = 1;
    [AirportServicesImageView setUserInteractionEnabled:YES];
    [AirportServicesImageView addGestureRecognizer:AirportTap];
    
    UITapGestureRecognizer *PassportTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PassportServices)];
    PassportTap.numberOfTapsRequired = 1;
    [PassportServicesImageView setUserInteractionEnabled:YES];
    [PassportServicesImageView addGestureRecognizer:PassportTap];
   
    
}

-(void)tapDetected{
    NSLog(@"single Tap on imageview");
}


-(void)VisaButton {
    [SVProgressHUD show];
    self.view.userInteractionEnabled = false ;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Visa" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"chooseVisatype"];
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = nil;////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:232/256 green:105/256 blue:40/256 alpha:1];
    self.navigationController.view.tintColor = [UIColor whiteColor];
   
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)ImmigrationButton {
    //chooseImmigrationtype
    [SVProgressHUD show];
     self.view.userInteractionEnabled = false ;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Immigration" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"chooseImmigrationtype"];
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = nil;////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:232/256 green:105/256 blue:40/256 alpha:1];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)AttestationServices {
    [SVProgressHUD show];
    self.view.userInteractionEnabled = false ;
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = nil;////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:232/256 green:105/256 blue:40/256 alpha:1];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    
    WebviewViewController *vc = [[WebviewViewController alloc] initWithNibName:@"WebviewViewController" bundle:nil];
    vc.URLString = @"https://rst-attestation.com/";
    vc.NavigationTitle = @"Attestation Services";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)PassportServices {
  //  [SVProgressHUD show];
     self.view.userInteractionEnabled = false ;
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = nil;////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:232/256 green:105/256 blue:40/256 alpha:1];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    
    WebviewViewController *vc = [[WebviewViewController alloc] initWithNibName:@"WebviewViewController" bundle:nil];
    vc.URLString = @"https://uk-passporthub.com";
    vc.NavigationTitle = @"Passport Services";
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)StudentServices {
    //StudentServiceType
    [SVProgressHUD show];
     self.view.userInteractionEnabled = false ;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StudentServiceType"];
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = nil;////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:232/256 green:105/256 blue:40/256 alpha:1];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)AirportServices {
    //https://airportservices.ae/
    [SVProgressHUD show];
     self.view.userInteractionEnabled = false ;
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = nil;////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:232/256 green:105/256 blue:40/256 alpha:1];
    self.navigationController.view.tintColor = [UIColor whiteColor];
    
    
    AirportWebViewController *vc = [[AirportWebViewController alloc] initWithNibName:@"AirportWebViewController" bundle:nil];
    vc.URLString = @"http://airportservices.ae";
    vc.NavigationTitle = @"Airport Services";
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
    
    
    [UIView animateWithDuration:6.0f
                          delay:0.0f
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         [bgImageView setFrame:CGRectMake(-(bgImageView.bounds.size.width - [UIScreen mainScreen].bounds.size.width), 0,bgImageView.bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
                     }
                     completion:nil];
}


-(void)viewWillDisappear:(BOOL)animated {
   // [self.view bringSubviewToFront:bgImageView];
 //   [self.view willRemoveSubview:bgImageView];
    self.view.userInteractionEnabled = true;
    [SVProgressHUD dismiss];
  
    
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
