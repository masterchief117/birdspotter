//
//  Birds.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/7/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "Birds.h"

@implementation Birds

NSMutableArray* birds;
// static constructor
+(void)initialize{

        birds = [[NSMutableArray alloc] init];

}

+(void)addBird:(Bird *)bird{

        [birds addObject: bird];

}
+(NSMutableArray *)birds{

        return birds;

}

@end
