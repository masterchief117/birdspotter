//
//  BSBirdMapViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/31/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSBirdMapViewController.h"

@interface BSBirdMapViewController ()

@end

@implementation BSBirdMapViewController

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
    [self loadAllBirds];
	// Do any additional setup after loading the view.
}

-(void)loadAllBirds{
    BSAppDelegate* appDelegate = (BSAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];

    NSFetchRequest* fetch = [[NSFetchRequest alloc] initWithEntityName:@"BSBird"];
    NSError* error;
    NSArray* birds = [context executeFetchRequest:fetch error:&error];
    NSMutableArray* annotations = [[NSMutableArray alloc] init];
    for(BSBird* bird in birds){
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([bird.latitude floatValue], [bird.longitude floatValue]);
        MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = location;
        [annotation setTitle:bird.name];
        [annotation setSubtitle:bird.activity];
        [annotations addObject:annotation];
    }
    [self.map addAnnotations:annotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
