//
//  BSBirdMapViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/31/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BSBird.h"
#import "BSAppDelegate.h"
@interface BSBirdMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *map;

@end
