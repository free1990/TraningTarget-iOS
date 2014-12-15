//
//  DynamicMethodResolutionAndDynamicLoading.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/12.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "BaseViewController.h"

@interface DynamicMethodResolutionAndDynamicLoading : BaseViewController{

    @private
    
    __strong NSString *_name;
    
    __strong NSString *_author;
}

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *author;

@property(nonatomic, copy) NSString*version;

@end
