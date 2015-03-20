//
//  QRTestViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/20.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "QRTestViewController.h"
#import <ZXingObjC.h>
#import "ScanView.h"
#import "UINavigationBar+Awesome.h"
#import "ScanTitleView.h"

@interface QRTestViewController ()<ZXCaptureDelegate>
@property (nonatomic, strong) ScanView *scanAnimationView;
@property (nonatomic, strong) ZXCapture * capture;
@property (nonatomic, strong) UIButton *torchSwitch;
@end

@implementation QRTestViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *torchSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.torchSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *backImage = [UIImage imageNamed:@"torch_off"];
    [self.torchSwitch setFrame:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [self.torchSwitch setBackgroundImage:[UIImage imageNamed:@"torch_off"]
                                forState:UIControlStateNormal];
    [self.torchSwitch addTarget:self
                         action:@selector(torchSwitchChange)
               forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.torchSwitch];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.layer.frame = self.view.bounds;
    self.capture.rotation = 90.0f;
    [self.view.layer addSublayer:self.capture.layer];
    
    
    ScanTitleView *titleView = [[ScanTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    self.navigationItem.titleView = titleView;
    
//    self.navigationItem.titleView = ;
    
    //添加动画
    if (self.scanAnimationView == nil) {
        self.scanAnimationView = [[ScanView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.scanAnimationView];
    }
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    [self.scanAnimationView startScanAnimation];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lt_reset];
    self.capture.delegate = nil;
    [self.scanAnimationView stopScanAnimation];
}

#pragma mark -ZXCaptureDelegate

-(void)captureResult:(ZXCapture *)capture result:(ZXResult *)result{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描内容"
                                                    message:result.text
                                                   delegate:nil
                                          cancelButtonTitle:@"Yes"
                                          otherButtonTitles: nil];
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)torchSwitchChange
{
    BOOL isTorch = self.capture.torch;
    
    if (isTorch) {
        [self.torchSwitch setBackgroundImage:[UIImage imageNamed:@"torch_off"]
                                    forState:UIControlStateNormal];
    }else {
        [self.torchSwitch setBackgroundImage:[UIImage imageNamed:@"torch_on"]
                                    forState:UIControlStateNormal];
    }
    [self.capture setTorch:!isTorch];
}

- (void)dealloc
{
    self.capture = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
