//
//  PriticseViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "PracticeViewController.h"
#import "ScanTitleView.h"
#import "UIView+MGBadgeView.h"
#import "GRRequestsManager.h"
#import "ZYButton.h"
#import "ZYSegmentView.h"

@interface PracticeViewController ()< GRRequestsManagerDelegate>

@property (nonatomic, strong) GRRequestsManager *requestsManager;

@end

@implementation PracticeViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Practice";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Roundbutton  *button = [Roundbutton buttonWithType:UIButtonTypeCustom];
    button.redValue = 0.2;
    button.greenValue = 0.3;
    button.blueValue = 0.5;
    button.frame = CGRectMake(100, 100, 80, 25);
    [button setTitle:@"醉了" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    
    
    
//    ScanTitleView *temp = [[ScanTitleView alloc] initWithFrame:CGRectMake(200, 200, 110, 44)];
//    
//    [temp setLableBadgeViewWithNum:1000];
//    
////    [temp setCenter:self.view.center];
//    
//    [self.view addSubview:temp];
    
    
//    ZYButton *button = [[ZYButton alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
//    button.center = self.view.center;
//    [self.view addSubview:button];
    
//    ZYSegmentView *mySeg = [[ZYSegmentView alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
//    
//    [mySeg displayContent];
//    
//    mySeg.center = self.view.center;
//    
//    [self.view addSubview:mySeg];
    
//    //the upload request needs the input data to be NSData
//    //so we first convert the image to NSData
//    UIImage * ourImage = [UIImage imageNamed:@"space.jpg"];
//    NSData * ourImageData = UIImageJPEGRepresentation(ourImage, 100);
//    
//    
//    //we create the upload request
//    //we don't autorelease the object so that it will be around when the callback gets called
//    //this is not a good practice, in real life development you should use a retain property to store a reference to the request
//    WRRequestUpload * uploadImage = [[WRRequestUpload alloc] init];
//    uploadImage.delegate = self;
//    
//    //for anonymous login just leave the username and password nil
//    uploadImage.hostname = @"xxx.xxx.xxx.xxx";
//    uploadImage.username = @"myuser";
//    uploadImage.password = @"mypass";
//    
//    //we set our data
//    uploadImage.sentData = ourImageData;
//    
//    //the path needs to be absolute to the FTP root folder.
//    //full URL would be ftp://xxx.xxx.xxx.xxx/space.jpg
//    uploadImage.path = @"/space.jpg";
//    
//    //we start the request
//    [uploadImage start];
    
//    self.requestsManager = [[GRRequestsManager alloc] initWithHostname:@"SIP"
//                                                                  user:@"yizhong"
//                                                              password:@"admin"];
//    self.requestsManager.delegate = self;
}

//-(void) requestCompleted:(WRRequest *) request{
//    
//    //called if 'request' is completed successfully
//    NSLog(@"%@ completed!", request);
//    
//}
//
//-(void) requestFailed:(WRRequest *) request{
//    
//    //called after 'request' ends in error
//    //we can print the error message
//    NSLog(@"%@", request.error.message);
//    
//}
//
//-(BOOL) shouldOverwriteFileWithRequest:(WRRequest *)request {
//    
//    //if the file (ftp://xxx.xxx.xxx.xxx/space.jpg) is already on the FTP server,the delegate is asked if the file should be overwritten
//    //'request' is the request that intended to create the file
//    return YES;
//    
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
