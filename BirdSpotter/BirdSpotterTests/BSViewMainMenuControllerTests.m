//
//  BSViewMainMenuControllerTests.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/21/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSViewMainMenuController.h"
#import <OCMock/OCMock.h>
#import "BSInitializeUtility.h"
#import <UIKit/UIKit.h>

@interface BSViewMainMenuControllerTests : XCTestCase

@end

@implementation BSViewMainMenuControllerTests

NSMutableArray* objects;
Class objectToMatch;


UIEventSubtype eventType;
BSViewMainMenuController* mainMenuController;
id foundNewBirdButtonMock;
id bsGeoLocationServiceMock;
id initializeUtilityMock;
id uiButton;
id eventMock;

- (void)setUp
{
    [super setUp];
    // init
    mainMenuController = [[BSViewMainMenuController alloc] init];
    // mockedClasses
    foundNewBirdButtonMock = [OCMockObject mockForClass:[UIButton class]];
    bsGeoLocationServiceMock = [OCMockObject mockForClass:[BSGeoLocationService class]];
    initializeUtilityMock = [OCMockObject mockForClass:[BSInitializeUtility class]];
    eventMock = [OCMockObject mockForClass:[UIEvent class]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewDidLoad
{
    [mainMenuController setFoundNewBird:foundNewBirdButtonMock];
    [mainMenuController setInitializeUtility:initializeUtilityMock];
    
    [[foundNewBirdButtonMock expect] setTitle:@"Found Bird" forState:UIControlStateNormal];
    [[initializeUtilityMock expect] initService:[BSGeoLocationService class]];
    
    [mainMenuController viewDidLoad];
    [foundNewBirdButtonMock verify];
    [initializeUtilityMock verify];
}

-(void) testMotionEndedWithNone{
    eventType = UIEventSubtypeNone;
    
    [((UIEvent*)[[eventMock expect] andReturnValue:[[NSValue alloc] initWithBytes:&eventType objCType:@encode(UIEventSubtype)]]) subtype];
    
    
    [mainMenuController motionEnded:UIEventSubtypeNone withEvent:eventMock];
    [BSViewMainMenuControllerTests findObjectsInView:mainMenuController.view requestedObjectType:[UIButton class]];
    bool setButton = [BSViewMainMenuControllerTests buttonContainsString];
    XCTAssertFalse(setButton, @"Button was not set!");
    
}


-(void) testMotionEndedWithShake{
    eventType = UIEventSubtypeMotionShake;
    [((UIEvent*)[[eventMock expect] andReturnValue:[[NSValue alloc] initWithBytes:&eventType objCType:@encode(UIEventSubtype)]]) subtype];
    
    
    [mainMenuController motionEnded:UIEventSubtypeNone withEvent:eventMock];
        [BSViewMainMenuControllerTests findObjectsInView:mainMenuController.view requestedObjectType:[UIButton class]];
    bool setButton = [BSViewMainMenuControllerTests buttonContainsString];
    XCTAssertTrue(setButton, @"Button was set!");
    
}

-(void) testSecretMovement{
    
    [mainMenuController setFoundNewBird:foundNewBirdButtonMock];
    [[foundNewBirdButtonMock expect] setAlpha:0];
    [mainMenuController secretMovement:nil];
    [foundNewBirdButtonMock verify];

}

+(bool) buttonContainsString{
    bool setButton = false;
    for(id obj in objects){
        if([obj isKindOfClass:[UIButton class]]){
            NSString* label = ((UIButton*)obj).titleLabel.text;
            if([label isEqualToString:@"Top Secrets!"]){
                [(UIButton*)obj removeFromSuperview];
                setButton = true;
            }
        }
    }
    objects = nil;
    return setButton;
}

+(NSArray*) findObjectsInView : (UIView*) findObjectsInView requestedObjectType :(Class) requestedObject{
    objects = [[NSMutableArray alloc] init];
    objectToMatch = requestedObject;
    [BSViewMainMenuControllerTests iterateThroughViewForObject:findObjectsInView];
    return objects;
}

+(void) iterateThroughViewForObject : (UIView*) view {
    if(objectToMatch == [view class]){
        [objects addObject:view];
    }
    for(UIView* nextView in [view subviews]){
        [BSViewMainMenuControllerTests iterateThroughViewForObject:nextView];
    }
}

@end
