//
//  BSGeoLocationService.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/19/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@protocol BSGeolLocationDelegate
@required
- (void) locationUpdate : (CLLocation*) location;
- (void) locationError : (NSError*) error;
@end

#import <Foundation/Foundation.h>

#import "BSBirdSubmissionViewController.h"
#import "UIViewController+LatLonPropertiesDelegate.h"


@interface BSGeoLocationService : NSObject <CLLocationManagerDelegate, BSGeolLocationDelegate> {
    CLLocationManager* locationManager;
    
}

@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, assign) id delegate;


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
- (MKPointAnnotation*)locatedPosition:(UILongPressGestureRecognizer *)sender map : (MKMapView*) map removeAnnotations : (bool) remove;
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
- (void)stopLocating;
- (void)startLocating;
- (void)findMe : (MKMapView*) map;
- (id)initWithDelegateId:(UIViewController<LatLonPropertiesDelegate>*) view;

-(void) setLatAndLon : (UIViewController<LatLonPropertiesDelegate>*) view;

@end
