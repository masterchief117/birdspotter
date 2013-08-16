//
//  BSMapViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/24/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSMapViewController.h"

@interface BSMapViewController ()


@end

@implementation BSMapViewController

NSTimer* timer;
MKPointAnnotation* point;
BSGeoLocationService* geoLocationService;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.map setUserTrackingMode:MKUserTrackingModeFollow];
    geoLocationService = [[BSGeoLocationService alloc] init];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(findMe:) userInfo:nil repeats:FALSE];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)findMe : (NSTimer*) sender
{
    [geoLocationService findMe:_map];
}


- (IBAction)locatedPosition:(UILongPressGestureRecognizer *)sender {
    [geoLocationService locatedPosition:sender map:self.map removeAnnotations:true];
}
@end