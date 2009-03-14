//
//  UISliderProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UISliderProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISliderProcessor

- (id)init
{
    if (self = [super init])
    {
        klass = @"UISlider";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"continuous"])
    {
        NSString *stringOutput = [value booleanString];
        [output setObject:stringOutput forKey:item];
    }
    else if ([item isEqualToString:@"maxValue"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.3f", [value floatValue]];
        [output setObject:stringOutput forKey:@"maximumValue"];
    }
    else if ([item isEqualToString:@"minValue"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.3f", [value floatValue]];
        [output setObject:stringOutput forKey:@"minimumValue"];
    }
    else if ([item isEqualToString:@"value"])
    {
        NSString *stringOutput = [NSString stringWithFormat:@"%1.3f", [value floatValue]];
        [output setObject:stringOutput forKey:@"value"];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
