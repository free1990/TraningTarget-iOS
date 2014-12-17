//
//  RuntimeDemoTwoViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "RuntimeDemoTwoViewController.h"

@implementation ClassCustomClass
@synthesize varTest1, varTest2, varTest3;
- (void) fun1 {
    NSLog(@"fun1");
}
@end

@implementation ClassCustomClassOther
- (void) fun2 {
    NSLog(@"fun2");
}
@end

@interface RuntimeDemoTwoViewController ()

@end

@implementation RuntimeDemoTwoViewController

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Runtime Demo Two";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myFloat = 100.0f;
    _temp = @"zhao";
    
    allobj = [[ClassCustomClass alloc] init];
    
    //获取类的方法列表
    [self getClassAllMethod];
    
    //获取全局变量的列表
    [self getInstanceVar];
    
    
    //设置全局变量的值
    [self setInstanceVar];
    
    //获取某个类属性的类型
    [self getVarType];
    
    //根据属性的值来获取属性的类型
    allobj = [ClassCustomClass new];
    allobj.varTest1 =@"varTest1String";
    allobj.varTest2 =@"varTest2String";
    allobj.varTest3 =@"varTest3String";
    NSString *str = [self nameOfInstance:@"varTest1String"];
    NSLog(@"str:%@", str);
}

- (void) getClassAllMethod
{
    u_int count;
    Method *methods= class_copyMethodList([UIImageView class], &count);
    for (int i = 0; i < count ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name)encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }
}

- (void) getInstanceVar {
    float myFloatValue;
    object_getInstanceVariable(self,"myFloat", (void*)&myFloatValue);
    NSLog(@"%f", myFloatValue);
}

- (void) setInstanceVar {
    
    NSString *old;
    object_getInstanceVariable(self,"_temp", (void*)&old);
    NSLog(@"%@", old);
    
    NSString *temp = @"yang";
    
    object_setInstanceVariable(self, "_temp", (void*)temp);
    NSLog(@"%@", _temp);
}


- (void) getVarType {
    ClassCustomClass *obj = [ClassCustomClass new];
    Ivar var = class_getInstanceVariable(object_getClass(obj),"varTest1");
    const char* typeEncoding = ivar_getTypeEncoding(var);
    NSString *stringType =  [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding];
    
    if ([stringType hasPrefix:@"@"]) {
        // handle class case
        NSLog(@"handle class case");
    } else if ([stringType hasPrefix:@"i"]) {
        // handle int case
        NSLog(@"handle int case");
    } else if ([stringType hasPrefix:@"f"]) {
        // handle float case
        NSLog(@"handle float case");
    } else
    {
        
    }
}

- (NSString *)nameOfInstance:(id)instance
{
    unsigned int numIvars =0;
    NSString *key=nil;
    
    //Describes the instance variables declared by a class.
    Ivar * ivars = class_copyIvarList([ClassCustomClass class], &numIvars);
    
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        
        //不是class就跳过
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        
        //Reads the value of an instance variable in an object. object_getIvar这个方法中，当遇到非objective-c对象时，并直接crash
        if ((object_getIvar(allobj, thisIvar) == instance)) {
            // Returns the name of an instance variable.
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }
    free(ivars);
    return key;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
