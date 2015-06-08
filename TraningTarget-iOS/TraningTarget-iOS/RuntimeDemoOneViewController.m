//
//  RuntimeDemoOneViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RuntimeDemoOneViewController.h"

@implementation CustomClass
- (void) fun1
{
    NSLog(@"fun1");
}
@end

@implementation TestClass
- (void) fun2
{
    NSLog(@"fun2");
}
@end

@interface RuntimeDemoOneViewController ()

@end

@implementation RuntimeDemoOneViewController


- (id)init{
    if (self = [super init]) {
        self.className   = @"Runtime Demo One";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //对象拷贝
    [self objectCopy];
    
    //对象释放
    [self objectDispose];
    
    //更改对象的类／获取对象的类
    [self changeClass];
    
    //获取对象的类
    [self getClass];
    
    //获取类的名字
    [self getClassName];
    
    //类添加方法
    [self addMethod];
    
    
//    Obj-C的方法（method）就是一个至少需要两个参数（self，_cmd）的C函数
//    IMP有点类似函数指针，指向具体的Method实现。
//    向一个类动态添加方法
//    BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
//    参数说明：
//    cls：被添加方法的类
//    name：可以理解为方法名
//    imp：实现这个方法的函数
//    types：一个定义该函数返回值类型和参数类型的字符串
}

- (void) objectCopy{

    CustomClass *obj = [CustomClass new];
    NSLog(@"%p", &obj);
    
    id objTest = object_copy(obj,sizeof(obj));
    NSLog(@"%p", &objTest);
    
    [objTest fun1];
}

- (void) objectDispose{
    
    CustomClass *obj = [CustomClass new];
    
    [obj fun1];
    
    //释放
    object_dispose(obj);
    
    NSLog(@"%ld", [obj retainCount]);
}

- (void)changeClass{
    
    CustomClass *obj = [CustomClass new];
    [obj fun1];
    
    Class aClass = object_setClass(obj, [TestClass class]);
    
    //obj 对象的类被更改了    swap the isa to an isa
    NSLog(@"aClass:%@",NSStringFromClass(aClass));
    NSLog(@"obj class:%@",NSStringFromClass([obj class]));
    
    if ([obj respondsToSelector:@selector(fun2)]) {
        [obj fun2];
    }
}

- (void) getClass
{
    CustomClass *obj = [CustomClass new];
    Class aLogClass = object_getClass(obj);
    NSLog(@"%@",NSStringFromClass(aLogClass));
}

- (void) getClassName
{
    CustomClass *obj = [CustomClass new];
    NSString *className = [NSString stringWithCString:object_getClassName(obj) encoding:NSUTF8StringEncoding];
    NSLog(@"className:%@", className);
}


int cfunction(id self, SEL _cmd, NSString *str) {
    NSLog(@"%@", str);
    return 10;//随便返回个值
}


- (void) addMethod {
    
    /*
     相关文档及说明：
     Obj-C的方法（method）就是一个至少需要两个参数（self，_cmd）的C函数
     
     IMP有点类似函数指针，指向具体的Method实现。
     
     向一个类动态添加方法
     
     BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
     参数说明：
     cls：被添加方法的类
     name：可以理解为方法名
     imp：实现这个方法的函数
     types：一个定义该函数返回值类型和参数类型的字符
     
     class_addMethod([TestClass class], @selector(ocMethod:), (IMP)testFunc, "i@:@");
     
     其中types参数为"i@:@“，按顺序分别表示：
     i：返回值类型int，若是v则表示void
     @：参数id(self)
     :：SEL(_cmd)
     @：id(str)
     
     */
    
    TestClass *instance = [[TestClass alloc] init];
    
    //方法添加
    class_addMethod([TestClass class],@selector(ocMethod:), (IMP)cfunction,"i@:@");
    
    if ([instance respondsToSelector:@selector(ocMethod:)]) {
        
        NSLog(@"Yes, instance respondsToSelector:@selector(ocMethod:)");
    }
    else
    {
        NSLog(@"Sorry");
    }
    
    int a = (int)[instance ocMethod:@"我是一个OC的method，C函数实现"];
    NSLog(@"a:%d", a);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
