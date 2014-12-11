//
//  ClassSet.h
//  ZYZone
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassItem.h"

@interface ClassSet : NSObject
{
    @private
    NSMutableArray *classItems;
}

@property (nonatomic, readonly) NSUInteger count;

+ (ClassSet *)sharedClassGallery;

- (void)addClassItem:(ClassItem *)classItem;
- (void)sortByTitle;
- (ClassItem *)objectAtIndex:(NSUInteger)index;
- (NSInteger)numOfClassItem;

@end
