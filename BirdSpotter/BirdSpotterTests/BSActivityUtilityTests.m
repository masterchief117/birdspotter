//
//  BSActivityUtilityTests.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/15/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSActivityUtility.h"

@interface BSActivityUtilityTests : XCTestCase

@end

@implementation BSActivityUtilityTests


- (void)setUp
{
    [super setUp];
    [BSActivityUtility initialize];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
// verify no additional activities have been set.
- (void)testActivities
{
    XCTAssertTrue([BSActivityUtility getActivities].count == 3, @"only three are in there!");
    XCTAssertTrue([[BSActivityUtility getActivities] containsObject:@"None"], @"Contains the word None");
    XCTAssertTrue([[BSActivityUtility getActivities] containsObject:@"Eating"], @"Contains the word Eating");
    XCTAssertTrue([[BSActivityUtility getActivities] containsObject:@"Squawking"], @"Contains the word Squakwing");
}
// test the getter and setters
- (void) testGetterAndSetter{
    [BSActivityUtility setActivity:@"BAWLS"];
    XCTAssertTrue([[BSActivityUtility getActivity] isEqualToString:@"BAWLS"] , @"make sure the object returned is the one set");
    
    XCTAssertFalse([[BSActivityUtility getActivity] isEqualToString:@"MUCH?"] , @"make sure the object returned is the one set");
}

@end
