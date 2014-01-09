//
//  NSProgressIndicatorProcessor.m
//  Command Line
//
//  Created by administrator on 7/18/13.
//  Copyright 2013 1951FDG. All rights reserved.
//

#import "NSProgressIndicatorProcessor.h"


@implementation NSProgressIndicatorProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSProgressIndicator";
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"class"])
    {
        aString = [self getProcessedClassName];
    }
	else if ([item isEqualToString:@"bezeled"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"displayedWhenStopped"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"doubleValue"])
	{
		aString = [self floatString:value];
	}
	else if ([item isEqualToString:@"indeterminate"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"maxValue"])
	{
		aString = [self floatString:value];
	}
	else if ([item isEqualToString:@"minValue"])
	{
		aString = [self floatString:value];
	}
	else if ([item isEqualToString:@"style"])
	{
		aString = [self styleString:value];
	}
	else
    {
        [super processKey:item value:value];
    }
	if (aString != nil)
    {
        aString = [self checkString:aString key:item value:value];
    }
	if (aString != nil)
    {
        [output setObject:aString forKey:item];
    }
}

- (NSString *)styleString:(id)value
{
	/* From the documentation
	 enum {
	 NSProgressIndicatorBarStyle = 0,
	 NSProgressIndicatorSpinningStyle = 1
	 };
	 */
	
	NSString *aString = nil;
	NSUInteger unsignedIntegerValue = [value unsignedIntegerValue];
	if (unsignedIntegerValue == NSProgressIndicatorBarStyle)
	{
		aString = @"NSProgressIndicatorBarStyle";
	}
	else if (unsignedIntegerValue == NSProgressIndicatorSpinningStyle)
	{
		aString = @"NSProgressIndicatorSpinningStyle";
	}
	return aString;
}

@end
