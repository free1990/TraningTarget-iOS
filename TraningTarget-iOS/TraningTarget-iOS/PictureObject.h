//
//  PictureObject.h
//  TraningTarget-iOS
//
//  Created by John on 15/2/27.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PictureObject : NSObject

@property (nonatomic, strong) ALAsset *alAsset;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *recInfo;
@property (atomic, assign) BOOL isSelect;

@end
