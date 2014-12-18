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

//    NSComparator cmptr;
//    cmptr = ^(ClassItem *cssInfo_1, ClassItem *cssInfo_2){
//        return [cssInfo_1.className caseInsensitiveCompare:cssInfo_2.className];
//    };
//    cmptr = ^(ClassItem *cssInfo_1, ClassItem *cssInfo_2){
//        if (cssInfo_1.className > cssInfo_2.className)
//            return (NSComparisonResult)NSOrderedAscending;
//        
//        if (cssInfo_1.className < cssInfo_2.className)
//            return (NSComparisonResult)NSOrderedDescending;
//        
//        return (NSComparisonResult)NSOrderedDescending;
//    };
//    NSArray *temp = [classItems sortedArrayUsingComparator:cmptr];
//    
//    for (ClassItem *one in temp) {
//        NSLog(@"--->%@", one.className);
//    }
    //    [classItems sortUsingComparator:cmptr];
    
    [classItems sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
        ClassItem *item1=(ClassItem *)obj1;
        ClassItem *item2=(ClassItem *)obj2;
        return [item1.className compare:item2.className];
    }];
    
}

@end
