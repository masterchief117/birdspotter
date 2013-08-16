//
//  BSActivityPickerViewController.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/19/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSActivityPickerViewController.h"

@interface BSActivityPickerViewController ()

@end

@implementation BSActivityPickerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// How many Options will be displayed in a picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[BSActivityUtility getActivities] objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [BSActivityUtility getActivities].count;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [BSActivityUtility setActivity:[[BSActivityUtility getActivities] objectAtIndex:row]];
}

@end