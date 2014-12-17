//
//  DynamicMethodResolutionAndDynamicLoading.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/12.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RuntimeDynamicMethodResolutionAndDynamicLoading.h"
#import <objc/runtime.h>
#import "EmptyClass.h"



@interface RuntimeDynamicMethodResolutionAndDynamicLoading ()

@end

@implementation RuntimeDynamicMethodResolutionAndDynamicLoading

@dynamic name;

@dynamic author;

@synthesize version = _version;

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Runtime Dynamic Method Resolution And Dynamic Loading";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    class_addMethod([EmptyClass class], @selector(say:), (IMP)say, "i@:@");
    
    EmptyClass *instance = [[EmptyClass alloc] init];
    
    if ([instance respondsToSelector:@selector(say:)]) {
        [instance performSelector:@selector(say:) withObject:@"hahahahha"];
    }
    
}

int say(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%@", str);
    return 100;//随便返回个值
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - @dynamic demo
//一、@dynamic与@synthesize的区别
//@property有两个对应的词，一个是@synthesize，一个是@dynamic。如果@synthesize和@dynamic都没写，那么默认的就是@syntheszie var = _var;
//@synthesize的语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动为你加上这两个方法。
//@dynamic告诉编译器,属性的setter与getter方法由用户自己实现，不自动生成。（当然对于readonly的属性只需提供getter即可）。假如一个属性被声明为@dynamic var，然后你没有提供@setter方法和@getter方法，编译的时候没问题，但是当程序运行到instance.var =someVar，由于缺setter方法会导致程序崩溃；或者当运行到 someVar = var时，由于缺getter方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。

- (NSString *)name{
    
    if(nil == _name){
        _name = @"you forgot inputbook name";
    }
    
    return _name;
}

- (void)setName:(NSString *)name{
    _name = name;
    NSLog(@"_name address:%p", _name);
}

- (NSString *)author{
    
    if(nil == _author){
        _author = @"you forgot inputbook author";
    }
    return _author;
}

- (void)setAuthor:(NSString *)author{
    _author = author;
}

#pragma mark - Dynamic Method

//void sayHello(id self, SEL _cmd){
//    NSLog(@"Hello");
//}
//
//- (void)addMethod
//{
//    class_addMethod([DynamicMethodResolutionAndDynamicLoading class], @selector(sayHello2), (IMP)sayHello, "v@:");
//    // Test Method
//    DynamicMethodResolutionAndDynamicLoading *instance = [[DynamicMethodResolutionAndDynamicLoading alloc] init];
//    [instance sayHello2];
//}



@end
