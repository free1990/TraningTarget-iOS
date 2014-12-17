//
//  RuntimeDemoThreeViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RuntimeDemoThreeViewController.h"

@interface RuntimeDemoThreeViewController ()

@end

@implementation RuntimeDemoThreeViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Runtime Demo Three";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //交换系统方法
    [self methodExchange];
    
    //自定义方法实现
    [self methodSetImplementation];
    [self justLog2];
    [self justLog1];
    
}

- (void) methodExchange {
    Method m1 = class_getInstanceMethod([NSString class],@selector(lowercaseString));
    Method m2 = class_getInstanceMethod([NSString class],@selector(uppercaseString));
    method_exchangeImplementations(m1, m2);
    
    NSLog(@"%@", [@"sssAAAAss" lowercaseString]);
    NSLog(@"%@", [@"sssAAAAss" uppercaseString]);
}


- (void) justLog1 {
    NSLog(@"justLog1");
}
- (void) justLog2 {
    NSLog(@"justLog2");
}
- (void) methodSetImplementation {
    
    //justlog1 会作为justlog2的执行
    Method method = class_getInstanceMethod([RuntimeDemoThreeViewController class],@selector(justLog1));
    IMP originalImp = method_getImplementation(method);
    Method m1 = class_getInstanceMethod([RuntimeDemoThreeViewController class],@selector(justLog2));
    method_setImplementation(m1, originalImp);
}

//IMP cFuncPointer;
//IMP cFuncPointer1;
//IMP cFuncPointer2;
//
//NSString* CustomUppercaseString(id self,SEL _cmd){
//    printf("真正起作用的是本函数CustomUppercaseString\r\n");
//    NSString *string = cFuncPointer(self,_cmd);
//    return string;
//}
//NSArray* CustomComponentsSeparatedByString(id self,SEL _cmd,NSString *str){
//    printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//    return cFuncPointer1(self,_cmd, str);
//}
////不起作用，求解释
//bool CustomIsEqualToString(id self,SEL _cmd,NSString *str) {
//printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//return cFuncPointer2(self,_cmd, str);
//}
//- (void) replaceMethod{
//    cFuncPointer = [NSString instanceMethodForSelector:@selector(uppercaseString)];
//    class_replaceMethod([NSString class],@selector(uppercaseString), (IMP)CustomUppercaseString,"@@:");
//    cFuncPointer1 = [NSString instanceMethodForSelector:@selector(componentsSeparatedByString:)];
//    class_replaceMethod([NSString class],@selector(componentsSeparatedByString:), (IMP)CustomComponentsSeparatedByString,"@@:@");
//    cFuncPointer2 = [NSString instanceMethodForSelector:@selector(isEqualToString:)];
//    class_replaceMethod([NSString class],@selector(isEqualToString:), (IMP)CustomIsEqualToString,"B@:@");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
