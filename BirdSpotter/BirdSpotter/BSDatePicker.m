//
//  BSDatePicker.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/17/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSDatePicker.h"

@implementation BSDatePicker



-(id)init{
    self = [super init];
    if(self){
        self.date = [[NSDate alloc] init];
    }
    return self;
}

-(id)initWithDate : (NSDate*) date{
    self = [super init];
    if(self){
        self.date = date;
    }
    return self;
}


@end
