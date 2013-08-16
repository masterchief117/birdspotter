//
//  BSProfileView.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/15/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BSBirdProfileView.h"

@interface BSProfileViewTests : XCTestCase

@end

@implementation BSProfileViewTests

BSBirdProfileView* view;

- (void)setUp
{
    [super setUp];
    view = [[BSBirdProfileView alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInstantationDoesNotInitProperties
{
    XCTAssertTrue(view.birdName == nil, @"There is no birdName init");
    XCTAssertTrue(view.birdImage == nil, @"There is no birdImage init");
}

@end
