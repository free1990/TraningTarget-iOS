//
//  MethodInvoke.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface RuntimeMsgForWarding: BaseViewController {
    id realObject1;
    id realObject2;
}

- (id)initWithTarget1:(id)t1 target2:(id)t2;

@end
