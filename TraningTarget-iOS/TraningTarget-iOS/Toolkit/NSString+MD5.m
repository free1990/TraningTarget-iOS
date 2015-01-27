//
//  NSString+MD5.m
//  Teacher
//
//  Created by zhangkai on 10/9/14.
//  Copyright (c) 2014 FClassroom. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)MD5 {
    NSData *data = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    unsigned int outputLength = CC_MD5_DIGEST_LENGTH;
    unsigned char output[outputLength];
    CC_MD5(data.bytes, (unsigned int) data.length, output);
    
    NSMutableString* hash = [NSMutableString stringWithCapacity:outputLength * 2];
    for (unsigned int i = 0; i < outputLength; i++) {
        [hash appendFormat:@"%02x", output[i]];
        output[i] = 0;
    }
    return hash;
}

@end
