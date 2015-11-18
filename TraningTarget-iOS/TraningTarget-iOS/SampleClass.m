//
//  SampleClass.m
//  TraningTarget-iOS
//
//  Created by John on 15/5/11.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import "SampleClass.h"

dispatch_source_t CreateDispatchTimer(double interval, dispatch_queue_t queue, dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer)
    {
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}


@implementation SampleClass{
    dispatch_source_t _timer;
}

- (void)startTimer
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    double secondsToFire = 1.000f;
    
    _timer = CreateDispatchTimer(secondsToFire, queue, ^{
        // Do something
        NSLog(@"product is bitch");
    });
}

- (void)cancelTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        // Remove this if you are on a Deployment Target of iOS6 or OSX 10.8 and above
        _timer = nil;
    }
}

@end
