//
//  BSInitializeUtility.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/21/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "BSInitializeUtility.h"

@implementation BSInitializeUtility

-(id)init{
    self = [super init];
    
    if(self){
        
    }
    
    return self;
}

-(void) initService : (Class) className{
    [className initialize];
}

@end
