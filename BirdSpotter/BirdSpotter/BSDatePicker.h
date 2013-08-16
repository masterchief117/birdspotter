//
//  BSDatePicker.h
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSDatePicker : NSObject

@property (strong, nonatomic) NSDate* date;


-(id) init;
-(id) initWithDate : (NSDate*) date;

@end
