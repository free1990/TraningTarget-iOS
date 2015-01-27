//
//  AFDemoViewController.m
//  TraningTarget-iOS
//
//  Created by John on 15/1/27.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "AFDemoViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Macros.h"
#import "AppUtil.h"
#import "VersionResponse.h"
#import "PropertiesManager.h"

static NSString * const kServerDomain = @"http://182.92.194.136:10002/";

@interface AFDemoViewController (){
    
    AFHTTPRequestOperationManager *httpManager;
}

@property (nonatomic, assign) BOOL isReachable;

@end

@implementation AFDemoViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"AF demo";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *baseURL = [NSURL URLWithString:kServerDomain];
    
    httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    [httpManager.requestSerializer setTimeoutInterval:30];
    
    [httpManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"jike-client-from"];
    [httpManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"from"];
    
    [httpManager.requestSerializer setValue:@"name" forHTTPHeaderField:@"zhao-yang"];
    
    NSLog(@"头部字典的字段: %@", httpManager.requestSerializer.HTTPRequestHeaders);
    
    __weak __typeof(self)weakSelf = self;
    //        NSOperationQueue *operationQueue = _requestManager.operationQueue;
    [httpManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                //                    [operationQueue setSuspended:NO];
                weakSelf.isReachable = YES;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default: {
                //                    [operationQueue setSuspended:YES];
                weakSelf.isReachable = NO;
            }
                break;
        }
    }];
    
    [httpManager.reachabilityManager startMonitoring];
    
    
    [self versionInfoWithCompletion:^(VersionResponse *response){
        
        NSLog(@"----- %@", response.versionName);
        
    }];
}


- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void (^)(NSDictionary *responseInfo))completion {
    [httpManager GET:URLString
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     DLOG(@"%@, %@", operation, responseObject);
                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                         completion(responseObject);
                     } else {
                         DLOGERROR(@"%@, %@", operation, responseObject);
                         completion(nil);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     DLOGERROR(@"%@, %@", operation, error);
                     /*
                      -1001, The request timed out.
                      -1003, A server with the specified hostname could not be found.
                      -1004, Could not connect to the server.
                      -1009, The Internet connection appears to be offline.
                      */
                     switch (error.code) {
                         case -1001:
                         case -1009:
                         {
                             NSDictionary *dict = @{@"error_code":@(error.code), @"error_msg":error.localizedDescription};
                             completion(dict);
                         }
                             break;
                             
                         default: {
                             completion(nil);
                         }
                             break;
                     }
                 }];
}


- (void)versionInfoWithCompletion:(void (^)(VersionResponse *response))completion{
    
    NSString *appVersion  = [AppUtil appVersion];
    NSString *urlString = @"ckeckAppVersionState.json";
    NSDictionary *parameters = @{@"appType": @(2),
                                 @"versionName": appVersion};
    
    [self GET:urlString parameters:parameters completion:^(NSDictionary *responseInfo){
        
        VersionResponse *response = nil;
               if (responseInfo) {
                   response = [[VersionResponse alloc] init];
                   [response parseResponse:responseInfo];
               }
               
               completion(response);
        
           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
