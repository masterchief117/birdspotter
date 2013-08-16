//
//  BSDatePickerViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSDateService.h"

@interface BSDatePickerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)datePickerChanged:(id)sender;

@end
