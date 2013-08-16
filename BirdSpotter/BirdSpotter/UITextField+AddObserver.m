//
//  UITextField+AddObserver.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/18/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "UITextField+AddObserver.h"

@implementation UITextField (AddObserver)


@dynamic changed;

-(void)addObserverToTextField{
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(BOOL)textFieldDidChange:(id)sender{

    return ![self.text isEqualToString:@""] ? TRUE : FALSE;
}

@end
