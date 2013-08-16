//
//  BSOtherFoundBirdsViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/7/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIViewController+LatLonPropertiesDelegate.h"
#import "BSGeoLocationService.h"
#import "Bird.h"
#import "Birds.h"

@interface BSOtherFoundBirdsViewController : UIViewController <LatLonPropertiesDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) UILabel* latitudeValueLabel;
@property (strong, nonatomic) UILabel* longitudeValueLabel;

@end
