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

@interface QRTestViewController ()<ZXCaptureDelegate>
@property (nonatomic, strong) ScanView *scanAnimationView;
@property (nonatomic, strong) ZXCapture * capture;
@end

@implementation QRTestViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Scan QRCode Test";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.layer.frame = self.view.bounds;
    self.capture.rotation = 90.0f;
    [self.view.layer addSublayer:self.capture.layer];
    
    //添加动画
    if (self.scanAnimationView == nil) {
        self.scanAnimationView = [[ScanView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.scanAnimationView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    [self.scanAnimationView startScanAnimation];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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
