//
//  UIView+UITextFieldFinder.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/18/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "UIView+UITextFieldFinder.h"
#import "BSBirdSubmissionViewController.h"
#import "UITextField+AddObserver.h"

@implementation UIView (UITextFieldFinder)

static NSMutableArray* array;


- (void)addObserverForTextField
{
    if([self isKindOfClass:[UITextField class]]){
        [(UITextField*)self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [[UIView arrayOfFields] addObject:(UITextField*)self];
    }
    for (UIView *subview in self.subviews)
    {
        [subview addObserverForTextField];
    }
}

+(NSMutableArray *)arrayOfFields{
    if(array == nil){
        array = [[NSMutableArray alloc] init];
    }
    return array;
}

@end
