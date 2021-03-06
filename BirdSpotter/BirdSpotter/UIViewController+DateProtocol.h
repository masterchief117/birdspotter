//
//  UIViewController+DateProtocol.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/25/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSDateService.h"

@protocol DateSelectedDelegate
@required
- (IBAction)dateSelected:(UIDatePicker *)sender;

@end

@interface UIViewController (DateProtocol) 

@end
