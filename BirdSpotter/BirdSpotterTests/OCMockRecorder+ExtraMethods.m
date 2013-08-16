//
//  OCMockRecorder+ExtraMethods.m
//  BirdSpotter
//
//  Created by Brent Stewart on 8/15/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "OCMockRecorder+ExtraMethods.h"



@implementation OCMockRecorder (ExtraMethods)

- (id) andReturnBoolean:(BOOL)aValue {
    NSValue *wrappedValue = nil;
    wrappedValue = [NSValue valueWithBytes:&aValue
                                  objCType:@encode(BOOL)];
    
    return [self andReturnValue:wrappedValue];
}

- (id) andReturnStruct:(void*)aValue objCType:(const char *)type{
    NSValue *wrappedValue = nil;
    wrappedValue = [NSValue valueWithBytes:aValue
                                  objCType:type];
    
    return [self andReturnValue:wrappedValue];
}

@end