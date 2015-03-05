//
//  Paper_Content.h
//  TraningTarget-iOS
//
//  Created by John on 15/3/5.
//  Copyright (c) 2015年 WorkMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paper_Content : NSObject

@property (nonatomic, assign) NSInteger paperContent_id;
@property (nonatomic, strong) NSString *paperContent_contentBinSheet;
@property (nonatomic, strong) NSString *paperContent_contentBinText;
@property (nonatomic, strong) NSString *paperContent_docPath;

@end
