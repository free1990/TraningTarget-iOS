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
//    [httpManager GET:URLString
//              parameters:parameters
//                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                     
//                     DLOG(@"%@, %@", operation, responseObject);
//                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                         completion(responseObject);
//                     } else {
//                         DLOGERROR(@"%@, %@", operation, responseObject);
//                         completion(nil);
//                     }
//                     
//                 }
//                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                     DLOGERROR(@"%@, %@", operation, error);
////                     switch (error.code) 
//                    }];
    
//    [httpManager HEAD:URLString
//           parameters:parameters
//              success:^(AFHTTPRequestOperation *operation) {
//                  
//                  //HEAD 请求操作上于GET类似，但是区别在于，这个请求是用来判断是够存在某个资源，并不返回内容，而GET返回内容
//                  NSLog(@"成功了");
//              }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  DLOGERROR(@"%@, %@", operation, error);
//                  //                     switch (error.code)
//            }];
    
    //POST一个表单（测试）
    [httpManager POST:URLString
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
                  //                     switch (error.code)
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
