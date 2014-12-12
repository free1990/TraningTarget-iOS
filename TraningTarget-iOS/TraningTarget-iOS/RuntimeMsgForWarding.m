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
}

@end
