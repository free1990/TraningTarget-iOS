//
//  FTPManager.h
//  TraningTarget-iOS
//
//  Created by John on 15/4/17.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CFNetwork/CFNetwork.h>

enum {
    kSendBufferSize = 32768
};

@protocol FTPManagerDelegate <NSObject>
-(void)ftpUploadFinishedWithSuccess:(BOOL)success;
-(void)ftpDownloadFinishedWithSuccess:(BOOL)success;
-(void)directoryListingFinishedWithSuccess:(NSArray *)arr;
-(void)ftpError:(NSString *)err;
@end



@interface FTPManager : NSObject<NSStreamDelegate>

@property (nonatomic, strong) NSString *ftpServer;
@property (nonatomic, strong) NSString *ftpUsername;
@property (nonatomic, strong) NSString *ftpPassword;

@property (nonatomic, assign) NSInputStream *writeStream;

- (id)initWithServer:(NSString *)server
                user:(NSString *)username
            password:(NSString *)pass;
- (void)downloadRemoteFile:(NSString *)filename localFileName:(NSString *)localname;
- (void)uploadFileWithFilePath:(NSString *)filePath;
- (void)createRemoteDirectory:(NSString *)dirname;
- (void)listRemoteDirectory;

@property (nonatomic, assign)id<FTPManagerDelegate> delegate;

@end
