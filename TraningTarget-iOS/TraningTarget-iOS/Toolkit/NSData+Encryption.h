//
//  NSData+Encryption.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/26.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSData *)key;   //加密

- (NSData *)AES256DecryptWithKey:(NSData *)key;   //解密

- (NSString *)newStringInBase64FromData;            //追加64编码

+ (NSString*)base64encode:(NSString*)str;           //同上64编码



@end
