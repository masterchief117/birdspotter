//
//  BSOtherFoundBirdsViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/7/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSOtherFoundBirdsViewController.h"

@interface BSOtherFoundBirdsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSString* request;
    NSData* data;
    UITableView* _table;
    Birds* _birds;
}
@end

@implementation BSOtherFoundBirdsViewController

BSGeoLocationService* locationService;

@synthesize latitudeValueLabel;
@synthesize longitudeValueLabel;    


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [Birds birds].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Bird* bird = [[Birds birds] objectAtIndex:indexPath.row];
    cell.textLabel.text = bird.commonName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    Bird* bird = [[Birds birds] objectAtIndex:indexPath.row];
    annotation.coordinate = CLLocationCoordinate2DMake([bird.latitude doubleValue], [bird.longitude doubleValue]);
    [self.map addAnnotation:annotation];
    
}

- (void)viewDidLoad
{
    self.table.dataSource = self;
    self.table.delegate = self;
    [super viewDidLoad];
    locationService = [[BSGeoLocationService alloc] init];

    _table = self.table;
    self.latitudeValueLabel = [[UILabel alloc] init];
    longitudeValueLabel = [[UILabel alloc] init];
    
    [locationService setLatAndLon:self];

    request = [NSString stringWithFormat:@"http://ebird.org/ws1.1/data/obs/geo/recent?lng=%f&lat=%f&dist=10&back=7&maxResults=200&locale=en_US&fmt=json", [self.longitudeValueLabel.text floatValue], [self.latitudeValueLabel.text floatValue]];
    NSURL* requestURL = [NSURL URLWithString:request];
    
    
    NSMutableURLRequest* requestValue = [NSMutableURLRequest requestWithURL:requestURL];
    [requestValue setHTTPMethod:@"GET"];
    [requestValue setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestValue setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestValue setValue:@"json" forHTTPHeaderField:@"Data-Type"];
    
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    data = [NSURLConnection sendSynchronousRequest:requestValue
                                         returningResponse:&theResponse
                                                     error:&errorReturned];
    
    NSArray* birds = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for(NSDictionary* dic in birds){
        
        Bird* bird = [[Bird alloc] init];
        [bird setLatitude:[NSNumber numberWithDouble:[[dic objectForKey:@"lat"] doubleValue]]];
        [bird setLongitude:[NSNumber numberWithDouble:[[dic objectForKey:@"lng"] doubleValue]]];
        [bird setCommonName:[dic objectForKey:@"comName"]];
        [bird setLocationName:[dic objectForKey:@"locName"]];
        [Birds addBird:bird];
    }
//    for(Bird* bird in [Birds birds]){
//        UITableViewCell* cell = [[UITableViewCell alloc] init];
//        cell.textLabel.text = [NSString stringWithFormat:@"Name: %@  Location: %@", bird.commonName, bird.locationName];
    [self.table reloadData];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
