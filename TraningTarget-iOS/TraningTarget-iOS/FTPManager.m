//
//  FTPManager.m
//  TraningTarget-iOS
//
//  Created by John on 15/4/17.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "FTPManager.h"

@implementation FTPManager


-(id)initWithServer:(NSString *)server user:(NSString *)username password:(NSString *)pass
{
    if ((self = [super init]))
    {
        self.ftpServer = server;
        self.ftpUsername = username;
        self.ftpPassword = pass;
    }
    return self;  
}

- (void)scheduleInCurrentThread:(NSStream*)aStream
{
    [aStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(NSURL *)smartURLForString:(NSString *)str
{
    NSURL * result;
    NSString * trimmedStr;
    NSRange schemeMarkerRange;
    NSString * scheme;
    
    result = nil;
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ( (trimmedStr != nil) && ([trimmedStr length] != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat: @"ftp://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            if ( ([scheme compare:@"http" options:
                   NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];  
            } else {  
                //unsupported url schema  
            }   
        }  
    }  
    return result;   
}

- (BOOL)isSending {
    return (_writeStream != nil);
}

-(void)closeAll {
    
    if (_writeStream != nil) {
        [_writeStream removeFromRunLoop:
         [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _writeStream.delegate = nil;
        [_writeStream close];
        _writeStream = nil;
    }
}

- (void)uploadFileWithFilePath:(NSString *)filePath
{
    BOOL success;
    NSURL * url;
    
    url = [self smartURLForString:_ftpServer];
    success = (url != nil);
    
    if (success) {
        url = CFBridgingRelease( CFURLCreateCopyAppendingPathComponent(NULL,( CFURLRef) url,( CFStringRef) [filePath lastPathComponent], false));
        success = (url!= nil);
    }
    if ( ! success) {
        [self.delegate ftpError:@"invalid url for uploadFileWithFilePath method"];
    } else {
        if (self.isSending){
            [self.delegate ftpError:@"sending in progress"];
            return ;
        }
        self.writeStream = [NSInputStream inputStreamWithFileAtPath:filePath];
        
        [self.writeStream open];
        
        self.writeStream = CFBridgingRelease(CFWriteStreamCreateWithFTPURL(NULL,(__bridge CFURLRef) url));
        //set credentials
        [self.writeStream setProperty:_ftpUsername
                                 forKey:(id)kCFStreamPropertyFTPUserName];
        [self.writeStream setProperty:_ftpPassword
                                 forKey:(id)kCFStreamPropertyFTPPassword];
        self.writeStream.delegate = self;
        [self performSelector:@selector(scheduleInCurrentThread:)
                     onThread:[NSThread currentThread]
                   withObject:self.writeStream
                waitUntilDone:YES];  
        [self.writeStream open];
    }  
}


@end
