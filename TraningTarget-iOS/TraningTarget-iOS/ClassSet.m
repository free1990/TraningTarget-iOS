//
//  ClassSet.m
//  ZYZone
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import "ClassSet.h"

@implementation ClassSet

static ClassSet *sharedClassGallery = nil;

+(ClassSet *)sharedClassGallery
{
    @synchronized(self)
    {
        if ( sharedClassGallery == nil ) {
            sharedClassGallery = [[self alloc] init];
        }
    }
    return sharedClassGallery;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if ( sharedClassGallery == nil ) {
            return [super allocWithZone:zone];
        }
    }
    return sharedClassGallery;
}

-(id)init
{
    Class thisClass = [self class];

    @synchronized(thisClass)
    {
        
        if ( sharedClassGallery == nil ) {
            if ( (self = [super init]) ) {
                sharedClassGallery = self;
                classItems         = [[NSMutableArray alloc] init];
            }
        }
    }

    return sharedClassGallery;
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(void)addClassItem:(ClassItem *)classItem
{
    [classItems addObject:classItem];
}

-(NSUInteger)count
{
    return classItems.count;
}

-(ClassItem *)objectAtIndex:(NSUInteger)index
{
    return classItems[index];
}

-(void)sortByTitle
{
    [classItems sortedArrayUsingComparator: ^NSComparisonResult(ClassItem *a, ClassItem *b) {
        return [a.className compare:b.className];
    }];
   

}


@end
