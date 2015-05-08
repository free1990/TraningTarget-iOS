//
//  GCDDeepUse.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "GCDDeepUse.h"

static dispatch_queue_t test_processing_queue() {
    static dispatch_queue_t test_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test_processing_queue = dispatch_queue_create("com.test.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return test_processing_queue;
}

@implementation GCDDeepUse

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Practice";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    dispatch_suspend(test_processing_queue());
    //用来终止队列
    NSLog(@"++++++++++++++++++++");
    
    dispatch_block_t block = ^{
        for (int i = 0; i < 1000; i++) {
                NSLog(@"-------%d", i);
        }
    };
    
    dispatch_async(test_processing_queue(), block);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"**********************");
        dispatch_resume(test_processing_queue());
    });
    
}

//@interface Canceller
//{
//    BOOL _shouldCancel;
//}
//- (void)setShouldCancel:(BOOL)shouldCancel;
//- (BOOL)shouldCancel;
//@end
//
//@implementation Canceller
//- (void)setShouldCancel:(BOOL)shouldCancel {
//    _shouldCancel = shouldCancel;
//}
//- (BOOL)shouldCancel {
//    return _shouldCancel;
//}
//@end
//
//static void test(int a){
//    static Canceller * canceller = nil;
//    
//    if(q){
//        [canceller setShouldCancel:YES];
//        [canceller release];
//        dispatch_suspend(q);
//        dispatch_release(q);
//        q=nil;
//    }
//    canceller = [[Canceller alloc] init];
//    q=dispatch_get_global_queue(0,0);
//    dispatch_async(q,^ {
//        while(![canceller shouldCancel]){NSLog(@"query %d",a);sleep(2);}
//    });
//    
//}

@end
