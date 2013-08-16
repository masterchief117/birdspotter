//
//  BSActivityPickerViewController.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/19/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSActivityUtility.h"

@interface BSActivityPickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *activityPicker;


@end
