//
//  BSMapViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/24/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BSStoreBirdInformation.h"
#import "BSGeoLocationService.h"

@interface BSMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *map;
- (IBAction)locatedPosition:(UILongPressGestureRecognizer *)sender;

@end
