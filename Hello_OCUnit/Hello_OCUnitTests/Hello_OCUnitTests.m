//
//  Hello_OCUnitTests.m
//  Hello_OCUnitTests
//
//  Created by artwalk on 7/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Hello_OCUnitTests : XCTestCase

@end

@implementation Hello_OCUnitTests

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
    XCTAssert(YES, @"pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
