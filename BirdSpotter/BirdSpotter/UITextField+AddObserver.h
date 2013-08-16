//
//  UITextField+AddObserver.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/18/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSActivityUtility.h"

@interface UITextField (AddObserver)

-(void) addObserverToTextField;
-(BOOL) textFieldDidChange : (id) sender;
@property (nonatomic) BOOL changed;

@end
