//
//  EmptyClass.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/15.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "EmptyClass.h"
#import <objc/runtime.h>

@implementation EmptyClass


void sayHello(id self, SEL _cmd){
    NSLog(@"Hello");
}

//- (void)addMethod
//{
//    class_addMethod([EmptyClass class], @selector(zhaoyang), (IMP)sayHello, "v@:");
//    // Test Method
//    EmptyClass *instance = [[EmptyClass alloc] init];
//    [instance zhaoyang];
//    
//}
//
//int say(id self, SEL _cmd, NSString *str)
//{
//    NSLog(@"%@", str);
//    return 100;//随便返回个值
//}



@end
