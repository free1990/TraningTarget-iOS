//
//  RuntimeDemoTwoViewController.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>

@interface ClassCustomClass :NSObject{
    NSString *varTest1;
    NSString *varTest2;
    NSString *varTest3;
}
@property (nonatomic,strong) NSString *varTest1;
@property (nonatomic,strong) NSString *varTest2;
@property (nonatomic,strong) NSString *varTest3;
@property (nonatomic, strong) NSString *varTest4;
- (void) fun1;
@end

@interface ClassCustomClassOther :NSObject {
    int varTest2;
}
- (void) fun2;
@end


@interface RuntimeDemoTwoViewController : BaseViewController
{
    float myFloat;
    NSString *_temp;
    ClassCustomClass *allobj;
}

@end
