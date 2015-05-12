//
//  GCDDeepUse.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "GCDDeepUse.h"
#import "JNWThrottledBlock.h"
#import "SampleClass.h"//timer source
#import <objc/runtime.h>

//dispatch_benchmark函数是libdispatch (Grand Central Dispatch) 的一部分，这个方法并没有被公开声明，所以必须要自己声明。
//在app里面会被拒
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

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
    
    //all dispatch objects are Objective-C objects
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_USER_INTERACTIVE, DISPATCH_QUEUE_PRIORITY_LOW);
    
    const char *label = "zhaotyang";
    dispatch_queue_t myQueue = dispatch_queue_create(label, attr);
    
    NSLog(@"lable = %s", dispatch_queue_get_label(myQueue));
    
    dispatch_block_t block = ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"-------%d", i);
        }
    };
    
//    [self target_set];
    
    //block提交给main（不会返回）
//    dispatch_main();
    
    //提交和终止任务
    dispatch_async_f(myQueue, 0 ,myDispatchFunc);
    dispatch_async_f(myQueue, NULL ,myDispatchFunc);
    
    NSLog(@"dispatch_apply");
    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t index){
        NSLog(@"copy-%ld", index);
    });
    
    NSLog(@"group----------------/*");
    NSLog(@"dispatch_group_enter(group)/dispatch_group_leave(group);");
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t index){
        dispatch_group_async(group, myQueue, ^{
            NSLog(@"加入组，开始活动");
        });
    });
    
    
    // again... (and again...)
    dispatch_group_enter(group);     // pair 2 enter
    [self computeInBackground:3 completion:^{
        NSLog(@"3 done");
        dispatch_group_leave(group); // pair 2 leave
    }];
    
    // again... (and again...)
    dispatch_group_enter(group);     // pair 2 enter
    [self computeInBackground:1 completion:^{
        NSLog(@"1 done");
        dispatch_group_leave(group); // pair 2 leave
    }];
    
    dispatch_group_notify(group, myQueue, ^{
        NSLog(@"group 执行完成");
    });
    
    //阻塞当前线程，直到group完成
    dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    
    NSLog(@"group----------------*/");
    
    NSLog(@"Managing Dispatch Objects----------------/*");
    
    dispatch_queue_t q = m_dispatch_queue_create( "com.apple.test", NULL );
    
    //queue终止的时候调用方法myreleaseFunc
    dispatch_set_finalizer_f(q, myreleaseFunc);
    
    for( unsigned i = 0; i < 5; i++ )
    {
        m_dispatch_async( q,^{
         printf("executing block %u\n", i );
         sleep(1);
        });
    }
    sleep(2);
    m_dispatch_release( q );
    sleep(5);
    
    //用来终止队列
    NSLog(@"++++++++++++++++++++终止队列");
    dispatch_suspend(test_processing_queue());
    dispatch_async(test_processing_queue(), block);
    NSLog(@"恢复队列");
    dispatch_resume(test_processing_queue());

    NSLog(@"Managing Dispatch Objects----------------*/");
    
    NSLog(@"semaphore----------------/*");
    
    //创建10个信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);

    for (int i = 0; i < 20; i++)
    {
        //每次减一个信号量
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, myQueue, ^{
            NSLog(@"task - %i",i);
            sleep(1);
            //执行完成之后增加信号量
            dispatch_semaphore_signal(semaphore);
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"semaphore----------------*/");
    
    NSLog(@"barrier----------------/*");
    
    dispatch_apply(5, myQueue, ^(size_t index){
        NSLog(@"barrier - %ld", index);
    });
    
    dispatch_barrier_async(myQueue, ^{
        NSLog(@"barrier");
    });
    
    NSLog(@"barrier----------------*/");
    
    NSLog(@"Managing Dispatch Sources----------------/*");
    
    /*
     GCD provides a suite of dispatch sources—interfaces for monitoring
     (low-level system objects such as Unix descriptors, Mach ports, Unix signals,
     VFS nodes, and so forth) for activity. and submitting event handlers 
     to dispatch queues when such activity occurs. When an event occurs, 
     the dispatch source submits your task code asynchronously to the specified
     dispatch queue for processing.
     */
    
    NSLog(@"Managing Dispatch Sources----------------*/");
    
    NSLog(@"Managing Dispatch Data Objects----------------/*");
    
//    dispatch_data_create
//    dispatch_data_get_size
//    dispatch_data_create_map
//    dispatch_data_create_concat
//    dispatch_data_create_subrange
//    dispatch_data_apply
//    dispatch_data_copy_region
    
    //监视进程
//    NSRunningApplication *mail = [NSRunningApplication
//                                  runningApplicationsWithBundleIdentifier:@"com.apple.mail"];
//    if (mail == nil) {
//        return;
//    }
//    pid_t const pid = mail.processIdentifier;
//    
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_PROC,
//                                                      pid,
//                                                      DISPATCH_PROC_EXIT,
//                                                      DISPATCH_TARGET_QUEUE_DEFAULT);
//    dispatch_source_set_event_handler(source, ^(){
//        NSLog(@"Mail quit.");
//    });
    
    
    //监视文件
//    NSURL *directoryURL; // assume this is set to a directory
//    int const fd = open([[directoryURL path] fileSystemRepresentation], O_EVTONLY);
//    if (fd < 0) {
//        char buffer[80];
//        strerror_r(errno, buffer, sizeof(buffer));
//        NSLog(@"Unable to open \"%@\": %s (%d)", [directoryURL path], buffer, errno);
//        return;
//    }
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd,
//                                                      DISPATCH_VNODE_WRITE | DISPATCH_VNODE_DELETE, DISPATCH_TARGET_QUEUE_DEFAULT);
//    dispatch_source_set_event_handler(source, ^(){
//        unsigned long const data = dispatch_source_get_data(source);
//        if (data & DISPATCH_VNODE_WRITE) {
//            NSLog(@"The directory changed.");
//        }
//        if (data & DISPATCH_VNODE_DELETE) {
//            NSLog(@"The directory has been deleted.");
//        }
//    });
//    dispatch_source_set_cancel_handler(source, ^(){
//        close(fd);
//    });
//    dispatch_resume(source);
    
    //定时器
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
//                                                      0, 0, dispatch_get_main_queue());
//    dispatch_source_set_event_handler(source, ^(){
//        NSLog(@"Timer");
//    });
//    dispatch_time_t start = DISPATCH_TIME_NOW;
//    dispatch_source_set_timer(source, start, 5ull * NSEC_PER_SEC,
//                              100ull * NSEC_PER_MSEC);
//    dispatch_resume(source);
    
//    [JNWThrottledBlock runBlock:^{
//        NSLog(@"timer");
//    }
//                 withIdentifier:@"timer"
//                       throttle:3.0f];

//    SampleClass *timerTest = [[SampleClass alloc] init];
//    [timerTest startTimer];
    
    NSLog(@"Managing Dispatch Data Objects----------------*/");
    
    size_t const objectCount = 1000;
    uint64_t n = dispatch_benchmark(10, ^{
        @autoreleasepool {
            id obj = @42;
            NSMutableArray *array = [NSMutableArray array];
            for (size_t i = 0; i < objectCount; ++i) {
                [array addObject:obj];
            }
        }
    });
    NSLog(@"-[NSMutableArray addObject:] : %llu ns", n);
}

- (void)computeInBackground:(int)no completion:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"%d starting", no);
        sleep(no);
        block();
    });
}

void myDispatchFunc(void *temp)
{
    // do some stuff
    NSLog(@"do some stuff");
    // do some more stuff
}

void myreleaseFunc(void *temp)
{
    // do some stuff
    NSLog(@"myreleaseFunc");
    // do some more stuff
}

- (void)target_set{
    
    @autoreleasepool {
        
        //电话都是局域网，只要有一个打进来，其他人都能听到，或者发声，我们目的是让这些电话的过程变得有秩序，只能有一个打一个接（确保不混乱）
        //第一个房间的人喜欢给第二个房间的人，打电话，每次打了，然后一秒钟后还会再打
        NSArray *house1Folks = @[@"Joe", @"Jack", @"Jill"];
        NSArray *house2Folks = @[@"Irma", @"Irene", @"Ian"];
        
        dispatch_queue_t house1Queue = dispatch_queue_create("house 1", DISPATCH_QUEUE_CONCURRENT);
        
        //尝试一（直接打）结果很混乱
//        for (NSString *caller in house1Folks) {
//            dispatch_async(house1Queue, ^{
//                makeCall(house1Queue, caller, house2Folks);
//            });
//        }
        
        //尝试二（使用target)
        // Set the target queue
//        dispatch_queue_t partyLine = dispatch_queue_create("party line", DISPATCH_QUEUE_SERIAL);
//        dispatch_set_target_queue(house1Queue, partyLine);
//        
//        for (NSString *caller in house1Folks) {
//            
//            NSLog(@"caller name = %@", caller);
//            dispatch_async(house1Queue, ^{
//                makeCall(house1Queue, caller, house2Folks);
//            });
//        }
        
        //尝试三（多个队列指定在一个上）
        dispatch_queue_t house2Queue = dispatch_queue_create("house 2", DISPATCH_QUEUE_CONCURRENT);
        
        // Set the target queue for BOTH house queues
        dispatch_queue_t partyLine = dispatch_queue_create("party line", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(house1Queue, partyLine);
        dispatch_set_target_queue(house2Queue, partyLine);
        
        for (NSString *caller in house1Folks) {
            dispatch_async(house1Queue, ^{
                makeCall(house1Queue, caller, house2Folks);
            });
        }
        for (NSString *caller in house2Folks) {
            dispatch_async(house2Queue, ^{
                makeCall(house2Queue, caller, house1Folks);
            });
        }
    }
}

void makeCall(dispatch_queue_t queue, NSString *caller, NSArray *callees) {
    
    // Randomly call someone
    NSInteger targetIndex = arc4random() % callees.count;
    NSString *callee = callees[targetIndex];
    
    NSLog(@"%@ is calling %@...", caller, callee);
    sleep(1);//通话时间
    NSLog(@"...%@ is done calling %@.", caller, callee);
    
    //等一个时间这俩货继续再打
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (arc4random() % 1000) * NSEC_PER_MSEC), queue, ^{
        makeCall(queue, caller, callees);
    });
}

dispatch_queue_t m_dispatch_queue_create( char * label, dispatch_queue_attr_t attr )
{
    dispatch_queue_t q = dispatch_queue_create( label, attr );
    dispatch_set_context( q, (void *) true ); // mark the queue as available
    return q;
}

void m_dispatch_release( dispatch_queue_t q )
{
    // unless the queue is protected, more blocks (upto 1 for serial)
    // can be queued and executed prior to the next operation.
    dispatch_set_context( q, (void*) false );  // mark the queue as unavailable
}

void m_dispatch_async( dispatch_queue_t q, dispatch_block_t block )
{
    dispatch_async( q,
                   ^{
                       bool run = dispatch_get_context( q );
                       //  only execute the block if the queue is available
                       if ( run )
                       {
                           block();
                       }
                       else
                       {
                           printf( "cancelled\n" );
                       }
                   } );
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
