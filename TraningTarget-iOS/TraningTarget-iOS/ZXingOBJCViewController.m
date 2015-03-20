//
//  ZXingOBJCViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/3.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "ZXingOBJCViewController.h"
#import "ZXingOBJCViewController.h"
#import "ZXCGImageLuminanceSource.H"
#import "ZXLuminanceSource.h"
#import "ZXBinaryBitmap.h"
#import "ZXHybridBinarizer.h"
#import "ZXDecodeHints.h"
#import "ZXMultiFormatReader.h"
#import "ZXResult.h"

@interface ZXingOBJCViewController (){
    
    UILabel *textLable;
}

@end

@implementation ZXingOBJCViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"ZXing";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    textLable  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    
    [textLable setTextColor:[UIColor blackColor]];
    [textLable setCenter:self.view.center];
    
    [self.view addSubview:textLable];
    
    //容错30%
    //大小280x280
    
    [self test];
}


- (void)test{
    
    NSLog(@"----开始处理");
    
    UIImage *barcode = [UIImage imageNamed:@"A4.jpg"];
    
    CGImageRef imageToDecode = barcode.CGImage;  // Given a CGImage in which we are looking for barcodes
    
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
        
        UIImageWriteToSavedPhotosAlbum(barcode, self, nil, NULL);
        
        [textLable setText:[NSString stringWithFormat:@"识别结果: %@",result.text]];
        // The barcode format, such as a QR code or UPC-A
        ZXBarcodeFormat format = result.barcodeFormat;
        
        NSLog(@"ZXBarcodeFormat = %d", format);
    } else {
        
        NSLog(@"error:%@", error);
        
        // Use error to determine why we didn't get a result, such as a barcode
        // not being found, an invalid checksum, or a format inconsistency.
    }
    
    NSLog(@"----处理结束");
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
