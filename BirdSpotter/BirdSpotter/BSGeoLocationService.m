//
//  BSGeoLocationService.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/19/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSGeoLocationService.h"

@interface BSGeoLocationService(){
    
}


@end

@implementation BSGeoLocationService
static BSGeoLocationService* _me;


@synthesize locationManager;
@synthesize delegate;

- (id) init {
    if(_me == nil){
        _me = [super init];
        if (_me != nil) {
            _me = [_me initWithDelegateId:nil];
        }}
    return _me;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* location = [locations lastObject];
    [_me.delegate locationUpdate:location];
    
}
-(void)locationUpdate:(CLLocation *)location{
    
}
-(void)locationError:(NSError *)error{
    
}

- (void)locationManager:(CLLocationManager *) manager
       didFailWithError:(NSError *)error
{
    [_me.delegate locationError:error];
}

-(void)stopLocating{
    [_me.locationManager stopUpdatingHeading];
    [_me.locationManager stopUpdatingLocation];
}

-(void) startLocating{
    [_me.locationManager startUpdatingHeading];
    [_me.locationManager startUpdatingLocation];
}


- (void)findMe : (MKMapView*) map
{
    CLLocationCoordinate2D center = map.userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.008f, 0.008f);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    
    [map setRegion:region animated:YES];
    map.mapType = MKMapTypeHybrid;
}

- (MKPointAnnotation*)locatedPosition:(UILongPressGestureRecognizer *)sender map : (MKMapView*) map removeAnnotations : (bool) remove{

    MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
    
;
    [point setCoordinate:[map convertPoint:[sender locationInView:map] toCoordinateFromView:map]];
    [map addAnnotation:point];
    [BSStoreBirdInformation addObjectsToUserDefault:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:point.coordinate.latitude], @"latitude", [NSNumber numberWithFloat:point.coordinate.longitude], @"longitude",nil]];
    if(remove){
        [_me removeAnnotations:point map:map];}
    return point;
}

-(void)removeAnnotations : (MKPointAnnotation*) point map : (MKMapView*) map{
    for(id obj in map.annotations){
        if(point != obj)
            [map removeAnnotation:obj];
    }
}



-(void) setLatAndLon : (UIViewController<LatLonPropertiesDelegate>*) view{
    NSNumber* lat = [BSStoreBirdInformation getObjectFromUserDefaults:@"latitude"];
    NSNumber* lon = [BSStoreBirdInformation getObjectFromUserDefaults:@"longitude"];
    // if for some reason has not been set, reset!! eek!
    if([lat intValue] == 0 || [lon intValue] == 0){
        [_me.locationManager startUpdatingLocation];
        CLLocationCoordinate2D location = _me.locationManager.location.coordinate;
        [view.latitudeValueLabel setText:[NSString stringWithFormat:@"%f", location.latitude]];
        [view.longitudeValueLabel setText:[NSString stringWithFormat:@"%f", location.longitude]];
    }
    else{
        view.latitudeValueLabel.text = [NSString stringWithFormat:@"%@", lat];
        view.longitudeValueLabel.text = [NSString stringWithFormat:@"%@",lon];
    }
}

// setter injection
- (id)initWithDelegateId:(UIViewController<LatLonPropertiesDelegate>*) view{
    _me = [super init];
    if(_me){
        _me.locationManager = [[CLLocationManager alloc] init];
        _me.locationManager.delegate = _me; // send loc updates to
        _me.delegate = _me;
       //         [_me locationManager:_me.locationManager didUpdateLocations:_me.locationManager.location];
        view.latitudeValueLabel.text = [NSString stringWithFormat:@"%f",_me.locationManager.location.coordinate.latitude];
        view.longitudeValueLabel.text = [NSString stringWithFormat:@"%f",_me.locationManager.location.coordinate.longitude];
    }
    
    //        [[NSNotificationCenter defaultCenter]  addObserver:(BSBirdSubmissionViewController*)observer selector:@selector(updateText:) name:@"labelChanged" object:label];
    
    return _me;
}

+(void)initialize{
    _me = [[BSGeoLocationService alloc] init];
    [_me startLocating];
}

@end
