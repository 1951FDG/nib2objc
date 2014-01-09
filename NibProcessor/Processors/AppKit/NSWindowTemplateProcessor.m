//
//  NSWindowTemplateProcessor.m
//  nib2objc
//
//  Created by administrator on 3/8/12.
//  Copyright 2012 1951FDG. All rights reserved.
//

#import "NSWindowTemplateProcessor.h"

@implementation NSWindowTemplateProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"NSWindow";
}

- (NSString *)frameString
{
	NSPoint point = NSPointFromString([self.input objectForKey:@"contentRectOrigin"]);
	NSSize size = NSSizeFromString([self.input objectForKey:@"contentRectSize"]);
	return [NSString stringWithFormat:@"NSMakeRect((CGFloat)%1.1f, (CGFloat)%1.1f, (CGFloat)%1.1f, (CGFloat)%1.1f)", point.x, point.y, size.width, size.height];
}

- (NSString *)constructorString
{
	NSString *className = [self.input objectForKey:@"className"];
	NSString *contentRect = [self frameString];
	NSString *aStyle = [self styleMaskString:[self.input objectForKey:@"styleMask"]];
	NSString *bufferingType = [self backingTypeString:[self.input objectForKey:@"backingType"]];
	NSString *flag = ([[self.input objectForKey:@"deferred"] boolValue]) ? @"YES" : @"NO";
	return [NSString stringWithFormat:@"[[%@ alloc] initWithContentRect:%@ styleMask:%@ backing:%@ defer:%@]", className, contentRect, aStyle, bufferingType, flag];
}

- (void)processKey:(id)item value:(id)value
{
	NSString *aString = nil;
	if ([item isEqualToString:@"class"])
    {
        aString = [self getProcessedClassName];
    }
	else if ([item isEqualToString:@"allowsToolTipsWhenApplicationIsInactive"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"autorecalculatesKeyViewLoop"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"designableHasMaxSize"])
	{
		if ([value boolValue])
		{
			aString = [self sizeString:[self.input objectForKey:@"gMaxSize"]];
			item = @"contentMaxSize";
		}
	}
	else if ([item isEqualToString:@"designableHasMinSize"])
	{
		if ([value boolValue])
		{
			aString = [self sizeString:[self.input objectForKey:@"gMinSize"]];
			item = @"contentMinSize";
		}
	}
	else if ([item isEqualToString:@"hasShadow"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"hidesOnDeactivate"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"oneShot"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"releasedWhenClosed"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"showsToolbarButton"])
	{
		aString = ([value boolValue]) ? @"YES" : @"NO";
	}
	else if ([item isEqualToString:@"title"])
	{
		aString = [NSString stringWithFormat:@"@\"%@\"", value];
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

- (NSString *)checkString:(NSString *)aString key:(id)item value:(id)value
{
	id object = nil;
	
	NSString *aClassName = [self getProcessedClassName];
	
	if ([aClassName hasSuffix:@"Cell"])
	{
		if ([aClassName isEqualToString:@"NSImageCell"])
		{
			Class aClass = NSClassFromString(@"NSImageView");
			
			if (aClass)
			{
				object = [[[[aClass alloc] initWithFrame:NSZeroRect] autorelease] cell];
			}
		}
		else
		{
			Class aClass = NSClassFromString([aClassName substringToIndex:[aClassName length] - [@"Cell" length]]);
			
			if (aClass)
			{
				object = [[[[aClass alloc] initWithFrame:NSZeroRect] autorelease] cell];
			}
		}
	}
	else if ([aClassName isEqualToString:@"NSArrayController"])
	{
		Class aClass = NSClassFromString(@"NSArrayController");
		
		if (aClass)
		{
			object = [[[aClass alloc] init] autorelease];
		}
	}
	else if ([aClassName isEqualToString:@"NSWindow"])
	{
		Class aClass = NSClassFromString(@"NSWindow");
		
		if (aClass)
		{
			object = [[[aClass alloc] initWithContentRect:NSZeroRect styleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask backing:NSBackingStoreBuffered defer:YES] autorelease];
		}
	}
	else
	{
		Class aClass = NSClassFromString(aClassName);
		
		if (aClass)
		{
			object = [[[aClass alloc] initWithFrame:NSZeroRect] autorelease];
		}
	}
	
	if (object)
	{
		SEL selector = NSSelectorFromString(item);
		
		BOOL flag = [object respondsToSelector:selector];
		
		if (!flag)
		{
			selector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"is", [item stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[item substringToIndex:1] uppercaseString]]]);
			flag = [object respondsToSelector:selector];
		}
		
		if (flag)
		{
			id anObject = [object valueForKey:item];
			
			if (anObject)
			{
				if (CFGetTypeID(value) == CFGetTypeID(anObject))
				{
					if (CFGetTypeID(value) == CFStringGetTypeID())
					{
						if ([value isEqualToString:anObject])
						{
#ifdef DEBUG
							aString = [NSString stringWithFormat:@"// default: %@", aString];
#else
							aString = nil;
#endif
						}
					}
					else if (value == anObject)
					{
#ifdef DEBUG
						aString = [NSString stringWithFormat:@"// default: %@", aString];
#else
						aString = nil;
#endif
					}
				}
			}
		}
	}
	
	return aString;
}

- (NSString *)backingTypeString:(id)value
{
	NSArray *values = [NSArray arrayWithObjects:@"NSBackingStoreRetained",
                       @"NSBackingStoreNonretained",
                       @"NSBackingStoreBuffered", nil];
	return [values objectAtIndex:[value unsignedIntegerValue]];
}

- (NSString *)sizeString:(id)value
{
	NSSize size = NSSizeFromString(value);
	return [NSString stringWithFormat:@"NSMakeSize((CGFloat)%1.1f, (CGFloat)%1.1f)", size.width, size.height];
}

- (NSString *)styleMaskString:(id)value
{
    /* From the documentation
    enum 
    {
		NSTitledWindowMask = 1 << 0,
		NSClosableWindowMask = 1 << 1,
		NSMiniaturizableWindowMask = 1 << 2,
		NSResizableWindowMask = 1 << 3,
		NSTexturedBackgroundWindowMask = 1 << 8,
		NSUnifiedTitleAndToolbarWindowMask = 1 << 12
    };
	 */
    
    NSUInteger mask = [value unsignedIntegerValue];
    NSMutableString *maskValue = [[[NSMutableString alloc] init] autorelease];
    
    if ((mask & NSTitledWindowMask) == NSTitledWindowMask)
    {
        [maskValue appendString:@"NSTitledWindowMask"];
    }
    if ((mask & NSClosableWindowMask) == NSClosableWindowMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSClosableWindowMask"];
    }
    if ((mask & NSMiniaturizableWindowMask) == NSMiniaturizableWindowMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSMiniaturizableWindowMask"];
    }
    if ((mask & NSResizableWindowMask) == NSResizableWindowMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSResizableWindowMask"];
    }
	if ((mask & NSTexturedBackgroundWindowMask) == NSTexturedBackgroundWindowMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSTexturedBackgroundWindowMask"];
    }
	if ((mask & NSUnifiedTitleAndToolbarWindowMask) == NSUnifiedTitleAndToolbarWindowMask)
    {
        if ([maskValue length] > 0) [maskValue appendString:@" | "];
        [maskValue appendString:@"NSUnifiedTitleAndToolbarWindowMask"];
    }
    
    return maskValue;
}

@end
