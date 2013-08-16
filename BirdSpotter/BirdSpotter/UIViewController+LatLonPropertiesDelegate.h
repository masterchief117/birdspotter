//
//  UIViewController+LatLonPropertiesDelegate.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/25/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LatLonPropertiesDelegate
@property (strong, nonatomic) UILabel* latitudeValueLabel;
@property (strong, nonatomic) UILabel *longitudeValueLabel;
@end

@interface UIViewController (LatLonPropertiesDelegate)

@end
