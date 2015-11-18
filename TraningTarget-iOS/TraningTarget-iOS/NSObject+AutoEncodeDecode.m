//
//  NSObject+AutoEncodeDecode.m
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "NSObject+AutoEncodeDecode.h"
#import <objc/runtime.h>

@implementation NSObject (AutoEncodeDecode)

- (void)encodeWithCoder:(NSCoder *)encoder {
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int numberOfIvars =0;
        Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
        for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++){
            Ivar const ivar = *p;
            const char *type =ivar_getTypeEncoding(ivar);
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [self valueForKey:key];
            if (value) {
                switch (type[0]) {
                    case _C_STRUCT_B: {
                        NSUInteger ivarSize =0;
                        NSUInteger ivarAlignment =0;
                        NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                        NSData *data = [NSData dataWithBytes:(const char*)self + ivar_getOffset(ivar)
                                                     length:ivarSize];
                        [encoder encodeObject:data forKey:key];
                    }
                        break;
                    default:
                        [encoder encodeObject:value
                                       forKey:key];
                        break;
                }
            }
        }
        free(ivars);
        cls = class_getSuperclass(cls);
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    
    if (self) {
        Class cls = [self class];
        while (cls != [NSObject class]) {
            unsigned int numberOfIvars =0;
            Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
            
            for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++){
                Ivar const ivar = *p;
                const char *type =ivar_getTypeEncoding(ivar);
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
                id value = [decoder decodeObjectForKey:key];
                if (value) {
                    switch (type[0]) {
                        case _C_STRUCT_B: {
                            NSUInteger ivarSize =0;
                            NSUInteger ivarAlignment =0;
                            NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                            NSData *data = [decoder decodeObjectForKey:key];
                            char *sourceIvarLocation = (char*)self+ivar_getOffset(ivar);
                            [data getBytes:sourceIvarLocation length:ivarSize];
                        }
                            break;
                        default:
                            [self setValue:[decoder decodeObjectForKey:key]
                                    forKey:key];
                            break;
                    }
                }
            }
            free(ivars);
            cls = class_getSuperclass(cls);
        }
    }
    
    return self;
}

@end
