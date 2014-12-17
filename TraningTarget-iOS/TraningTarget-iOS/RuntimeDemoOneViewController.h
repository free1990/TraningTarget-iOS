//
//  RuntimeDemoOneViewController.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/17.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>

@interface CustomClass : NSObject
- (void) fun1;
@end

@interface TestClass : NSObject
@end




@interface RuntimeDemoOneViewController : BaseViewController

@end


