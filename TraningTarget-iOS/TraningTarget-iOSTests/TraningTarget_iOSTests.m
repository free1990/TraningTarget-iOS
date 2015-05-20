//
//  TraningTarget_iOSTests.m
//  TraningTarget-iOSTests
//
//  Created by John on 14/12/11.
//  Copyright (c) 2014年 WorkMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "VVStack.h"
//XCTestCase的子类
@interface TraningTarget_iOSTests : XCTestCase

@end

@implementation TraningTarget_iOSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
//    XCTAssert(YES, @"Pass");
}

- (void)testStackExist {
    XCTAssertNotNil([VVStack class], @"VVStack class should exist.");
}

- (void)testStackObjectCanBeCreated {
    VVStack *stack = [VVStack new];
    XCTAssertNotNil(stack, @"VVStack object can be created.");
}

- (void)testPushANumberAndGetIt {
    VVStack *stack = [VVStack new];
    [stack push:2.3];
    double topNumber = [stack top];
    XCTAssertEqual(topNumber, 2.3, @"VVStack should can be pushed and has that top value.");
    
    [stack push:4.6];
    topNumber = [stack top];
    XCTAssertEqual(topNumber, 4.6, @"Top value of VVStack should be the last num pushed into it");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
