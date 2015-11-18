//
//  UploadHelper.m
//  TraningTarget-iOS
//
//  Created by John on 15/4/24.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#define Alert(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil] show]

#import "UploadHelper.h"

@implementation UploadHelper

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static UploadHelper *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[UploadHelper alloc] init];
    });
    return sharedManager;
}


- (id)init {
    if (self = [super init]) {
        _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [_reachabilityManager startMonitoring];
    }
    return self;
}

- (void)uploadOneFileWithDetailProgress:(void (^)(float percent, BOOL isUploaded))completion
{
    [self cheakNetworkstate];
}

- (void)cheakNetworkstate
{
    if (_reachabilityManager.reachable) {
        
        
        NSString *tipString = nil;
        if (_reachabilityManager.reachableViaWiFi) {
            tipString = NSLocalizedString(@"当前处于WiFi网络环境", nil);
        } else if (_reachabilityManager.reachableViaWWAN) {
            tipString = NSLocalizedString(@"当前处于移动网络环境", nil);
        }
        
        int long fileSize = 0;
//        NSString *slqPath = [DataPersistentceHelper pathCreatImageZipFileLocated:self.recInfo];
//        NSString *zipPath = [DataPersistentceHelper pathCreatSQLFileLocated:self.recInfo];
//        
//        NSLog(@"sql file path = %@", slqPath);
//        NSLog(@"zip file path = %@", zipPath);
        
//        fileSize = ([AppUtil fileSizeAtPath:slqPath] + [AppUtil fileSizeAtPath:zipPath])/1024;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:tipString
                                                            message:[NSString stringWithFormat:@"上传需要消耗流量 %ld Kb", fileSize]
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"取消", nil)
                                                  otherButtonTitles:NSLocalizedString(@"确定上传", nil), nil];
        [alertView show];
        
    } else {
        Alert(@"当前无网络连接", nil);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    DLOG(@"index = %ld", buttonIndex);
//    if (buttonIndex == 1) {
//        [self benginUpload:@"正在上传 1/1 学生阅卷信息..."];
//        _isSqlUploadSuccess = NO;
//        _isZipUploadSuccess = NO;
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            DLOG(@"开始长传");
//            _isSqlUploadSuccess = [self uploadFileWithPath:[DataPersistentceHelper localSqlFilePath:self.recInfo]];
//            _isZipUploadSuccess = [self uploadFileWithPath:[DataPersistentceHelper localZipFilePath:self.recInfo]];
//            DLOG(@"开始完成");
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self endUpload];
//                
//                [DataPersistentceHelper deleteAllStudentRecPaperInfoWith:self.recInfo];
//                NSString *resultString = nil;
//                if (_isSqlUploadSuccess && _isZipUploadSuccess) {
//                    DLOG(@"成功");
//                    resultString = NSLocalizedString(@"上传成功", nil);
//                    if ([self.delegate respondsToSelector:@selector(uploadManagerCompleteUploadWith:)]) {
//                        [self.delegate uploadManagerCompleteUploadWith:self.recInfo];
//                    }
//                }else {
//                    DLOG(@"失败");
//                    resultString = NSLocalizedString(@"上传失败", nil);
//                    if ([self.delegate respondsToSelector:@selector(uploadManagerCompleteUploadFailedWith:)]) {
//                        [self.delegate uploadManagerCompleteUploadFailedWith:self.recInfo];
//                    }
//                }
//                
//                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//                [delegate.window.rootViewController showHint:resultString];
//            });
//        });
//    }
}


@end
