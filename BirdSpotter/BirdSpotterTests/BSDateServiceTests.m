//
//  BSDateServiceTests.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/21/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSDateService.h"

@interface BSDateServiceTests : XCTestCase

@end

@implementation BSDateServiceTests
NSCalendar* calendar;
NSDateComponents* components;
NSDate* now;

+(void)initialize{
    components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:1];
    [components setYear:2000];
    now = [NSDate date];
    
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitBSDateService
{
    [BSDateService initialize];
    XCTAssertTrue([BSDateService getDate:START_DATE ] != nil, @"Start Date is not nil");
    XCTAssertTrue([BSDateService getDate:END_DATE ] != nil, @"Start Date is not nil");
    XCTAssertTrue([BSDateService getDate:FOUND_DATE ] != nil, @"Start Date is not nil");
}

-(void) testSetAndGetDate{
    XCTAssertFalse(now.timeIntervalSince1970 == [BSDateService getDate:END_DATE].timeIntervalSince1970, @"Verify the dates do not equal");
    [BSDateService setDate:now dateType:END_DATE];
    
    XCTAssertTrue(now.timeIntervalSince1970 == [BSDateService getDate:END_DATE].timeIntervalSince1970, @"Verify the dates are now equal");
    

    XCTAssertFalse(now.timeIntervalSince1970 == [BSDateService getDate:START_DATE].timeIntervalSince1970, @"Verify the dates do not equal");
    [BSDateService setDate:now dateType:START_DATE];
    
    XCTAssertTrue(now.timeIntervalSince1970 == [BSDateService getDate:START_DATE].timeIntervalSince1970, @"Verify the dates are now equal");
    

    XCTAssertFalse(now.timeIntervalSince1970 == [BSDateService getDate:FOUND_DATE].timeIntervalSince1970, @"Verify the dates do not equal");
    [BSDateService setDate:now dateType:FOUND_DATE];
    
    XCTAssertTrue(now.timeIntervalSince1970 == [BSDateService getDate:FOUND_DATE].timeIntervalSince1970, @"Verify the dates are now equal");
}


-(void) testDateDescription{
    [BSDateService setDate:[[NSCalendar currentCalendar] dateFromComponents:components] dateType:START_DATE];
    XCTAssertTrue([@"1 - 1 - 2000" isEqualToString:[BSDateService description:START_DATE]]);
}
@end