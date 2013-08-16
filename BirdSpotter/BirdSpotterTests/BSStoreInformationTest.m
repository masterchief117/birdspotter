//
//  BSStoreInformationTest.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/15/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSStoreBirdInformation.h"

@interface BSStoreInformationTest : XCTestCase

@end

@implementation BSStoreInformationTest

NSDictionary* dic;

NSString* str;
NSArray* array;
UIScrollView* scrollView;

- (void)setUp
{

    [super setUp];
    str = @"New String!";
    array = [[NSArray alloc] initWithObjects:@"a long hiatus on Killer Instinct", nil];
    scrollView = [[UIScrollView alloc] init];
    [scrollView setBackgroundColor:[UIColor blackColor]];
    
    [BSStoreBirdInformation initialize];

    dic = [[NSDictionary alloc] initWithObjectsAndKeys:str, @"string", array, @"array", nil];
        [BSStoreBirdInformation addObjectsToUserDefault:dic];
}

- (void)tearDown
{
    [super tearDown];
}

- (void) testAddObjectToUserDefaults
{

    
    id string = [BSStoreBirdInformation getObjectFromUserDefaults:@"string"];
    
    XCTAssertTrue([string isKindOfClass:[NSString class]], @"Is kind of NSString class");

    
    XCTAssertTrue(str = string, @"Is equal to object sent in!");
    
    // change original string. Note that the
    
    str = @"Herro";
    XCTAssertFalse([string isEqualToString:@"Herro"], @"Changes are not persisted from original string!");
}

-(void) testCannotAddNonProperties{
    dic =[[NSDictionary alloc] initWithObjectsAndKeys:scrollView, @"Scroll", nil ];
    XCTAssertThrows(    [BSStoreBirdInformation addObjectsToUserDefault:dic], @"will throw. Cannot add UI to NSUserDefaults");
}
// tests removing all objects added to NSUserDefaults
-(void) testRemoveAllObjects{
    [BSStoreBirdInformation removeAllObjectsFromUserDefaults];
   id string = [[BSStoreBirdInformation getUserDefaults] objectForKey:@"string"];
   id array = [[BSStoreBirdInformation getUserDefaults] objectForKey:@"array"];
    XCTAssertTrue(string == nil && array == nil, @"removed all objects from NSUserDefaults");
}

// tests removing a single object, not all!
-(void) testRemoveObject{

    [BSStoreBirdInformation removeObjectFromUserDefaults:@"array"];
    id string = [[BSStoreBirdInformation getUserDefaults] objectForKey:@"string"];
    id array = [[BSStoreBirdInformation getUserDefaults] objectForKey:@"array"];
    XCTAssertTrue(string != nil && array == nil, @"removed all objects from NSUserDefaults");
}


@end
