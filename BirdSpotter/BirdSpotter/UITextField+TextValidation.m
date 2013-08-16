//
//  UITextField+TextValidation.m
//  BirdSpotter
//
//  Created by Brent Stewart on 7/26/13.
//  Copyright (c) 2013 masterchief117. All rights reserved.
//

#import "UITextField+TextValidation.h"



@implementation UITextField (TextValidation)




- (BOOL)checkForValidInput:(UITextField *)field{
    BOOL isValid = false;
        field.backgroundColor = [UIColor redColor];
    if(field.text.length > 0){
            field.backgroundColor = [UIColor whiteColor];
        isValid = true;
        for(int index = 0; index < field.text.length; index++){
            if(containsNumber([field.text characterAtIndex:index])){
                field.backgroundColor = [UIColor redColor];
                return false;}
        }
    }
    return isValid;
}

bool containsNumber(char a){
    if(a == '0' || a == '1' || a == '2' || a == '3' || a == '4' || a == '5' || a == '6' || a == '7' || a == '8' || a == '9')
        return TRUE;
    return FALSE;
}

@end
