//
//  BaseViewController.h
//  TraningTarget-iOS
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) NSString *sectionName;

+(void)registerClassItem:(id)item;

@end
