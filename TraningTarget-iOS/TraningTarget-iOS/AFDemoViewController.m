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

#import "MyRequestProtocol.h"

#import "PaperInfoResponse.h"

//手机app
//static NSString * const kServerDomain = @"http://182.92.194.136:10002/";

static NSString * const kServerDomain = @"http://120.131.64.134:20002/";

@interface AFDemoViewController (){
    
    AFHTTPRequestOperationManager *httpRequestManager;
    AFHTTPSessionManager *httpSessionManager;
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
    
    [NSURLProtocol registerClass:[MyRequestProtocol class]];
    
    NSURL *baseURL = [NSURL URLWithString:kServerDomain];
    
    httpRequestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    [httpRequestManager.requestSerializer setTimeoutInterval:30];
    
    [httpRequestManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"jike-client-from"];
    [httpRequestManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"from"];
    
//    [httpRequestManager.requestSerializer setValue:@"name" forHTTPHeaderField:@"zhao-yang"];
    
    NSLog(@"头部字典的字段: %@", httpRequestManager.requestSerializer.HTTPRequestHeaders);
    
    __weak __typeof(self)weakSelf = self;
    //        NSOperationQueue *operationQueue = _requestManager.operationQueue;
    [httpRequestManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
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
    
    [httpRequestManager.reachabilityManager startMonitoring];
//    [self versionInfoWithCompletion:^(VersionResponse *response){
//        
//        NSLog(@"----- %@", response.versionName);
//        
//    }];
    
    [self paperInfoWithCompletion:^(PaperInfoResponse *response){
        
        NSLog(@"-----> %@", response);
        
        NSLog(@"paper_examPapers count--------> %ld", [response.paper_examPapers count]);
        NSLog(@"paper_parents count--------> %ld", [response.paper_parents count]);
        
        [self parseParentsData:response.paper_parents];
        
    }];
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL
//                                                  sessionConfiguration:configuration];
//    
//    [httpSessionManager.requestSerializer setTimeoutInterval:30];
//
//    [httpSessionManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"jike-client-from"];
//    [httpSessionManager.requestSerializer setValue:@"APP" forHTTPHeaderField:@"from"];
//    
//    [self sessionVersionInfoWithCompletion:^(VersionResponse *response){
//    
//        NSLog(@"----- %@", response.versionName);
//        
//        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//            NSLog(@"cockie = %@", cookie);
//        }
//        
//    }];
    
}

-(void)parseParentsData:(NSArray *)data{
    
    if (data && [data count] > 0) {
        
        for (Paper_parent *temp in data) {
            NSLog(@"---------> %ld", temp.paper_parent_id);
            
            [self parseParentsData:temp.paper_parent_children];
        }
        
    }else{
        NSLog(@"最内层");
    }
    
}

- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void (^)(NSDictionary *responseInfo))completion {
   
    [httpRequestManager GET:URLString
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
                     
                 }];
    
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
    
//    //POST一个表单（测试）
//    [httpRequestManager POST:URLString
//           parameters:parameters
//              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//                  DLOG(@"%@, %@", operation, responseObject);
//                  if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                      completion(responseObject);
//                  } else {
//                      DLOGERROR(@"%@, %@", operation, responseObject);
//                      completion(nil);
//                  }
//                  
//              }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  DLOGERROR(@"%@, %@", operation, error);
//                  //                     switch (error.code)
//              }];
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


- (void)paperInfoWithCompletion:(void (^)(PaperInfoResponse *response))completion{
    
    NSString *urlString = @"exam/queryById.json";
    NSDictionary *parameters = @{@"accessToken": @(33211),
                                 @"id": @(2787)
                                 };
    
    [self GET:urlString parameters:parameters completion:^(NSDictionary *responseInfo){
        
        PaperInfoResponse *response = nil;
        if (responseInfo) {
            response = [[PaperInfoResponse alloc] init];
            
            [response parseResponse:responseInfo];
        }
        
        completion(response);
        
    }];
}



- (void)sessionGET:(NSString *)URLString parameters:(id)parameters completion:(void (^)(NSDictionary *responseInfo))completion {
    
    //POST一个表单（测试）
    [httpSessionManager GET:URLString
                 parameters:parameters
                    success:^(NSURLSessionDataTask *task, id responseObject){
                        
                        if ([responseObject isKindOfClass:[NSDictionary class]]) {
                            completion(responseObject);
                        } else {
                            DLOGERROR(@"%@, %@", task, responseObject);
                            completion(nil);
                        }
                        
                    }
                    failure:^(NSURLSessionDataTask *operation, NSError *error) {
                        DLOGERROR(@"%@, %@", operation, error);
                        
                    }];
}


- (void)sessionVersionInfoWithCompletion:(void (^)(VersionResponse *response))completion{
    
    NSString *appVersion  = [AppUtil appVersion];
    NSString *urlString = @"ckeckAppVersionState.json";
    NSDictionary *parameters = @{@"appType": @(2),
                                 @"versionName": appVersion};
    
    [self sessionGET:urlString parameters:parameters completion:^(NSDictionary *responseInfo){
        
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
