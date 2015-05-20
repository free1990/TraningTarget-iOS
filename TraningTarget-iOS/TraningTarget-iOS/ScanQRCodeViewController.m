//
//  ScanQRCodeViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/18.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanView.h"

#import "ZXCGImageLuminanceSource.H"
#import "ZXLuminanceSource.h"
#import "ZXBinaryBitmap.h"
#import "ZXHybridBinarizer.h"
#import "ZXDecodeHints.h"
#import "ZXMultiFormatReader.h"
#import "ZXResult.h"

@interface ScanQRCodeViewController() <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) ScanView *scanAnimationView;

@end

@implementation ScanQRCodeViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Scan QRCode";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initCapture];
    
    NSLog(@"------>开始了");
    
    //添加动画
    if (self.scanAnimationView == nil) {
        
        self.scanAnimationView = [[ScanView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.scanAnimationView];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scanAnimationView startScanAnimation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
    [self.scanAnimationView stopScanAnimation];
}

//初始化扫描
- (void)initCapture {
    
    if (self.captureSession == nil) {
        self.captureSession = [[AVCaptureSession alloc] init];
    } else {
        [self.captureSession startRunning];
        return;
    }
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *captureInpute = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    [self.captureSession addInput:captureInpute];
    
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    NSString *key = (NSString *)kCVPixelBufferPixelFormatTypeKey;
    NSNumber *value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    
    [captureOutput setVideoSettings:videoSettings];
    
    [self.captureSession addOutput:captureOutput];
    
    NSLog(@"captureSession----->%@", self.captureSession);
    
    NSString *preset = 0;
    if (NSClassFromString(@"NSOrderedSet") &&
        [UIScreen mainScreen].scale > 1 &&
        [inputDevice supportsAVCaptureSessionPreset:AVCaptureSessionPresetiFrame960x540]) {
        
        preset = AVCaptureSessionPresetiFrame960x540;
    }
    if (!preset) {
        preset = AVCaptureSessionPresetMedium;
    }
    self.captureSession.sessionPreset = preset;
    
    self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    
    CGRect videoFrame = self.view.bounds;
    self.captureVideoPreviewLayer.frame = videoFrame;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer addSublayer:self.captureVideoPreviewLayer];
    
     NSLog(@"captureSession----->%@", self.captureSession);
    
    [self.captureSession startRunning];
}

//生成图片
- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    size_t bytesPreRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace) {
        NSLog(@"CGColorSpaceCreateDeviceRGB failure");
        return nil;
    }
    
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
    
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPreRow, colorSpace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little, provider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    
    return image;
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

//扫描产生的数据
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
    
    NSLog(@"%f----%f", image.size.width, image.size.height);
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self decodeImage:image];
//    });
}

//图片解码
- (void)decodeImage:(UIImage *)image {
    
    CGImageRef imageToDecode = image.CGImage;  // Given a CGImage in which we are looking for barcodes
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    // There are a number of hints we can give to the reader, including
    // possible formats, allowed lengths, and the string encoding.
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        // The coded result as a string. The raw data can be accessed with
        // result.rawBytes and result.length.
        NSString *contents = result.text;
        
        NSLog(@"-------->  %@", contents);
        
        ZXBarcodeFormat format = result.barcodeFormat;
        
        UIAlertView *temp = [[UIAlertView alloc] initWithTitle:@"结果"
                                                       message:result.text
                                                      delegate:nil
                                             cancelButtonTitle:@"Yes"
                                             otherButtonTitles:nil];
        [temp show];
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSLog(@"ZXBarcodeFormat = %d", format);
        
    } else {
        
        UIImageWriteToSavedPhotosAlbum(image, self, nil, NULL);
        NSLog(@"error:%@", error);
    }
    
    NSLog(@"----处理结束");
    
}

- (void)dealloc {
    _captureVideoPreviewLayer = nil;
    _captureSession = nil;
    _scanAnimationView = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
