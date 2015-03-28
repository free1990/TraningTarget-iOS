//
//  Base64ViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/3/26.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "Base64ViewController.h"
#import "Base64ViewController.h"
#import "NSData+Encryption.h"

@interface Base64ViewController ()

@end

@implementation Base64ViewController


- (id)init{
    if (self = [super init]) {
        self.className   = @"Base64";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个NSData
    NSData *nsdata = [@"孔焕军 encoded in Base64"
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // 打印这个被编码的data的string类型
    NSLog(@"Encoded: %@", base64Encoded);
    
    
    // 把64位编码的字符串转成data
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    //解码
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded: %@", base64Decoded);
    
    
    //http://blog.csdn.net/pjk1129/article/details/8489550
    //PKCS7Padding iOS解决方案
    
    NSString *plainText = @"AES";
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte keyByte[] = {0x08,0x08,0x04,0x0b,0x02,0x0f,0x0b,0x0c,0x01,0x03,0x09,0x07,0x0c,0x03,
        0x07,0x0a,0x04,0x0f,0x06,0x0f,0x0e,0x09,0x05,0x01,0x0a,0x0a,0x01,0x09,0x06,0x07,0x09,0x0d};
    
    NSData *keyData = [[NSData alloc] initWithBytes:keyByte length:32];
    
    NSData *cipherTextData = [plainTextData AES256EncryptWithKey:keyData];
    Byte *plainTextByte = (Byte *)[cipherTextData bytes];
    
    for(int i=0;i<[cipherTextData length];i++){
        
        printf("%x",plainTextByte[i]);
    }
    
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
