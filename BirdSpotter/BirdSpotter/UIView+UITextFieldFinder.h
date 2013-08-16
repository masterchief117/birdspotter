//
//  UIView+UITextFieldFinder.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/18/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UITextFieldFinder)
- (void)addObserverForTextField;

+(NSMutableArray*) arrayOfFields;

@end
