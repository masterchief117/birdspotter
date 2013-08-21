//
//  BSGeoLocationServiceTests.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/15/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//



#import <XCTest/XCTest.h>
#import "BSGeoLocationService.h"
#import <MapKit/MapKit.h>

#import "OCMock.h"
#import "OCMockObject.h"
#import "OCMArg.h"
#import "OCMConstraint.h"
#import "OCMockRecorder.h"
#import "OCMockRecorder+ExtraMethods.h"
#import "UIViewController+LatLonPropertiesDelegate.h"


@interface BSGeoLocationServiceTests : XCTestCase <LatLonPropertiesDelegate>
@property (strong, nonatomic) UILabel* latitudeValueLabel;
@property (strong, nonatomic) UILabel *longitudeValueLabel;
@end

@implementation BSGeoLocationServiceTests

BSGeoLocationService* geoLocationService;

id mapMock;
id userLocationMock;
id cllLocationMock;
id longPressGestureRecognizerMock;

CLLocationCoordinate2D locationCoordinates;
MKCoordinateRegion coordinateRegion;
NSArray* array;
NSError* error;
MKMapType hybridMap = MKMapTypeHybrid;
CGPoint point;



id<LatLonPropertiesDelegate> viewOfLatAndLonProperties;

- (void)setUp
{
    [super setUp];
    //inits
    geoLocationService = [[BSGeoLocationService alloc] init];
    viewOfLatAndLonProperties = self;
    
    
    // class level mocks
    geoLocationService.locationManager = [OCMockObject mockForClass:[CLLocationManager class]];
    mapMock = [OCMockObject mockForClass:[MKMapView class]];
    userLocationMock = [OCMockObject mockForClass:[MKUserLocation class]];
    cllLocationMock = [OCMockObject mockForClass:[CLLocation class]];
    longPressGestureRecognizerMock = [OCMockObject mockForClass:[UILongPressGestureRecognizer class]];
    
    // protocol mocks
    geoLocationService.delegate = [OCMockObject mockForProtocol:@protocol(BSGeolLocationDelegate)];
    
    
    // other
    locationCoordinates = CLLocationCoordinate2DMake(69, 70);
    point = CGPointMake(55, 55);
    coordinateRegion = MKCoordinateRegionMake(locationCoordinates, MKCoordinateSpanMake(0.008f, 0.008f));
    array = @[@"one"];
    _latitudeValueLabel = [[UILabel alloc] init];
    _longitudeValueLabel = [[UILabel alloc] init];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
}


- (void)testFindMe
{
    [((CLLocation*)[[cllLocationMock expect] andReturnStruct:&locationCoordinates objCType:@encode(CLLocationCoordinate2D)]) coordinate];
    [((MKUserLocation*)[[userLocationMock expect] andReturn:cllLocationMock]) location];
    
    [[[mapMock expect] andReturn:userLocationMock] userLocation];
    [[mapMock expect] setRegion:coordinateRegion animated:YES];
    // make sure we are setting the map to MKMapTypeHybrid!
    [[mapMock expect ]setMapType:MKMapTypeHybrid];
    
    [geoLocationService findMe:(MKMapView*) mapMock];
    
    [userLocationMock verify];
    [mapMock verify];
    [cllLocationMock verify];
    
    // for the test, check this!
}

-(void) testStopLocating{
    [((CLLocationManager*)[(id)geoLocationService.locationManager expect]) stopUpdatingHeading];
    [((CLLocationManager*)[(id)geoLocationService.locationManager expect]) stopUpdatingLocation];
    [geoLocationService stopLocating];
    [(id)geoLocationService.locationManager verify];
}

-(void) testStartLocating{
    [((CLLocationManager*)[(id)geoLocationService.locationManager expect]) startUpdatingHeading];
    [((CLLocationManager*)[(id)geoLocationService.locationManager expect]) startUpdatingLocation];
    [geoLocationService startLocating];
    [(id)geoLocationService.locationManager verify];
}

-(void) testLocationManager{
    [((id<BSGeolLocationDelegate>)[geoLocationService.delegate expect]) locationUpdate:[array lastObject]];
    [geoLocationService locationManager:geoLocationService.locationManager didUpdateLocations:array];
    [geoLocationService.delegate verify];
}


-(void) testLocationManagerFailWithError{
    error = [[NSError alloc]init];
    [((id<BSGeolLocationDelegate>)[geoLocationService.delegate expect]) locationError:error];
    [geoLocationService locationManager:geoLocationService.locationManager didFailWithError:error];
    [geoLocationService.delegate verify];
}

-(void) testSetLatAndLonUserDefaultsEmpty{
    
    [BSStoreBirdInformation removeAllObjectsFromUserDefaults];
    [[(id)geoLocationService.locationManager expect] startUpdatingLocation];
    [((CLLocationManager*)[[(id)geoLocationService.locationManager expect] andReturn:cllLocationMock]) location];
    [((CLLocation*)[[(id)cllLocationMock expect] andReturnStruct:&locationCoordinates objCType:@encode(CLLocationCoordinate2D)]) coordinate];
    [[(id)geoLocationService.locationManager expect] startUpdatingLocation];
    [[(id)geoLocationService.locationManager expect] startUpdatingLocation];
    [geoLocationService setLatAndLon:(UIViewController<LatLonPropertiesDelegate>*)viewOfLatAndLonProperties];
    NSLog(@"%@",viewOfLatAndLonProperties.latitudeValueLabel.text);
    XCTAssertTrue([viewOfLatAndLonProperties.latitudeValueLabel.text floatValue] == 69);
    XCTAssertTrue([viewOfLatAndLonProperties.longitudeValueLabel.text floatValue] == 70);
}

-(void) testSetLatAndLong{
    [BSStoreBirdInformation addObjectsToUserDefault:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:25], @"latitude", [NSNumber numberWithFloat:52], @"longitude", nil]];
    [geoLocationService setLatAndLon:(UIViewController<LatLonPropertiesDelegate>*)viewOfLatAndLonProperties];
    XCTAssertTrue([viewOfLatAndLonProperties.latitudeValueLabel.text floatValue] == 25);
    XCTAssertTrue([viewOfLatAndLonProperties.longitudeValueLabel.text floatValue] == 52);
}

-(void) testLocatedPositionNoRemove{

    [[[longPressGestureRecognizerMock expect] andReturnStruct:&point objCType:@encode(CGPoint)] locationInView:mapMock];
    [[[mapMock expect] andReturnStruct:&locationCoordinates objCType:@encode(CLLocationCoordinate2D)] convertPoint:point toCoordinateFromView:mapMock];
    [[mapMock expect] addAnnotation:[OCMArg any]];
    MKPointAnnotation* annotation = [geoLocationService locatedPosition:longPressGestureRecognizerMock map:mapMock removeAnnotations:FALSE];
    [longPressGestureRecognizerMock verify];
    [mapMock verify];
    XCTAssertTrue(annotation.coordinate.latitude == locationCoordinates.latitude, @"Latitude is the same");
    XCTAssertTrue(annotation.coordinate.longitude == locationCoordinates.longitude  , @"Latitude is the same");
    
}
@end