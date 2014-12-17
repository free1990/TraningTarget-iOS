//
//  PropertyAndFunctionViewController.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/12.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "PropertyAndFunction.h"
#import <objc/runtime.h>

@interface PropertyAndFunction ()

@end

@implementation PropertyAndFunction

+(void)load
{
    [super registerClassItem:self];
}

- (id)init{
    if (self = [super init]) {
        self.className   = @"Property And Function";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    //类里面的属性的结构体类型
    typedef struct objc_property *Property;
 
    //获取所有的类的属性结构体返回的时数组
    objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)  
 
    //获取协议所有的属性，返回数组类型
    objc_property_t *protocol_copyPropertyList(Protocol *proto, unsigned int *outCount)
 
    发现property的名字
    const char *property_getName(objc_property_t property)
    
    //通过名字获取类里面这个属性
    objc_property_t class_getProperty(Class cls, const char *name)
 
    //通过名字获取类里面这个属性
    objc_property_t protocol_getProperty(Protocol *proto, const char *name, BOOL isRequiredProperty, BOOL isInstanceProperty)
 
    //获取已经被转为@encode之后的字符
    const char *property_getAttributes(objc_property_t property)
 
    property的Attributes类型

    T@"NSString",&,N,VsectionName
    
    T后面是encode符号，然后是类型，逗号后面是（）
     Code
     Meaning
     R
     The property is read-only (readonly).
     C
     The property is a copy of the value last assigned (copy).
     &
     The property is a reference to the value last assigned (retain).
     N
     The property is non-atomic (nonatomic).
     G<name>
     The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,).
     S<name>
     The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,).
     D
     The property is dynamic (@dynamic).
     W
     The property is a weak reference (__weak).
     P
     The property is eligible for garbage collection.
     t<encoding>
     Specifies the type using old-style encoding.
 
 */
    
    id baseViewController = objc_getClass("BaseViewController");
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(baseViewController, &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        fprintf(stdout, "---%s---- ****%s****\n", property_getName(property), property_getAttributes(property));
        
        NSLog(@"%s  ---  %s", property_getName(property), property_getAttributes(property));
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
