//
//  MethodInvoke.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RuntimeMsgForWarding.h"
#import "MsgForWardingDemo.h"

@implementation RuntimeMsgForWarding

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if ([super init]) {
        self.className   = @"Runtime Msg ForWarding";
    }
    return self;
}

- (void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    UILabel *outLable = [[UILabel alloc] initWithFrame:self.view.frame];
    outLable.textAlignment = NSTextAlignmentCenter;
    outLable.text = @"Please see console output";
    [self.view addSubview:outLable];
    
    NSMutableString *string = [[NSMutableString alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];

    id proxy = [[MsgForWardingDemo alloc] initWithTarget1:string target2:array];
    
    [proxy appendString:@"This "];
    [proxy appendString:@"is "];
    [proxy appendString:@"a "];
    [proxy appendString:@"test!"];
    
    [proxy addObject:string];
    [proxy addObject:string];
    
    NSLog(@"count should be 2, it is: %lu", (unsigned long)[proxy count]);
    
    if ([[proxy objectAtIndex:0] isEqualToString:@"This is a test!"]) {
        NSLog(@"Appending successful.");
    } else {
        NSLog(@"Appending failed, got: '%@'", proxy);
    }
    
//    void (*setter)(id, SEL, BOOL);
//    int i;
//    
//    setter = (void (*)(id, SEL, BOOL))[target
//                                       methodForSelector:@selector(setFilled:)];
//    for ( i = 0 ; i < 1000 ; i++ )
//        setter(targetList[i], @selector(setFilled:), YES);
    
    
    //如果需要大量的调用方法可以通过直接获取方法的地址，然后进行调用Getting a Method Address
    void (*setter)(id, SEL, BOOL);
    int i;
    
    //10000次16:27:40.592-16:27:41.056
    setter = (void (*)(id, SEL, BOOL))[self methodForSelector:@selector(test)];
    for ( i = 0 ; i < 1000 ; i++ )
        setter(self, @selector(test), YES);
    
//    //10000次16:23:04.161   16:23:08.333
//    for ( i = 0 ; i < 10000 ; i++ )
//        [self test];
}

- (void)test{
    NSLog(@"test");
}


@end
