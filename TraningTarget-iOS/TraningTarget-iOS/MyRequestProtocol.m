//
//  MyRequestProtocol.m
//  TraningTarget-iOS
//
//  Created by John on 15/2/4.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "MyRequestProtocol.h"

@implementation MyRequestProtocol

//遍历到我们自定义的NSURLProtocol时，系统先会调用canInitWithRequest:这个方法。顾名思义，这是整个流程的入口，只有这个方法返回YES我们才能够继续后续的处理。我们可以在这个方法的实现里面进行请求的过滤，筛选出需要进行处理的请求。
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    
    NSLog(@"判断request是否符合情况=%@", request.URL);
    
    NSLog(@"%@", [NSURLProtocol propertyForKey:@"MyRequestProtocol" inRequest:request]);
    
    if ([NSURLProtocol propertyForKey:@"MyRequestProtocol" inRequest:request])
    {
        return YES;
    }
    
    return NO;
    
    NSString *scheme = [[request URL] scheme];
    NSDictionary *dict = [request allHTTPHeaderFields];
    return [dict objectForKey:@"custom_header"] == nil &&
    ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
     [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame);
}

//当筛选出需要处理的请求后，就可以进行后续的处理，需要至少实现如下4个方法
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

//判断两个NSURLRequest是否相同（主要用来判断缓存）
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a
                       toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    
    //此处可以对request进行处理
    //[MyRequestProtocol applyCustomHeaders:mutableReqeust];
    [mutableReqeust setValue:@"APP-client" forHTTPHeaderField:@"zhaoyang"];
    
    [NSURLProtocol setProperty:@(YES)
                        forKey:@"MyRequestProtocol"
                     inRequest:mutableReqeust];
    
    self.connection = [NSURLConnection connectionWithRequest:mutableReqeust
                                                    delegate:self];
}
- (void)stopLoading
{
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark - connection delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    if (response != nil)
    {
        [[self client] URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
    return request;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [self.client URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [self.client URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.client URLProtocol:self
          didReceiveResponse:response
          cacheStoragePolicy:[[self request] cachePolicy]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self
                 didLoadData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
}


@end
