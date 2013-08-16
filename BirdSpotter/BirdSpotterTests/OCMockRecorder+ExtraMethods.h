//
//  OCMockRecorder+ExtraMethods.h
//  BirdSpotter
//
//  Created by Brent Stewart on 8/15/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "OCMockRecorder.h"

@interface OCMockRecorder (ExtraMethods)
- (id) andReturnBoolean:(BOOL)aValue;
- (id) andReturnStruct:(void*)aValue objCType:(const char *)type;
@end