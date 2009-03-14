//
//  NSString+Nib2ObjcExtensions.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSString+Nib2ObjcExtensions.h"

@implementation NSString (Nib2ObjcExtensions)

+ (NSString *)rectStringFromPoint:(NSString *)pointString size:(NSString *)sizeString
{
    NSPoint point = NSPointFromString(pointString);
    NSSize size = NSSizeFromString(sizeString);
    return [NSString stringWithFormat:@"CGRectMake(%1.1f, %1.1f, %1.1f, %1.1f)", point.x, point.y, size.width, size.height];
}

- (NSString *)colorString
{
    NSMutableString *color = [[[NSMutableString alloc] init] autorelease];
    if ([self hasPrefix:@"NSCalibratedRGBColorSpace"])
    {
        float red, green, blue, alpha;
        sscanf([self UTF8String], "NSCalibratedRGBColorSpace %f %f %f %f", &red, &green, &blue, &alpha);
        [color appendFormat:@"[UIColor colorWithRed:%1.3f green:%1.3f blue:%1.3f alpha:%1.3f]", red, green, blue, alpha];
    }
    else if ([self hasPrefix:@"NSCustomColorSpace Generic Gray colorspace "])
    {
        float gray, alpha;
        sscanf([self UTF8String], "NSCustomColorSpace Generic Gray colorspace %f %f", &gray, &alpha);
        [color appendFormat:@"[UIColor colorWithWhite:%1.3f alpha:%1.3f]", gray, alpha];
    }
    else if ([self hasPrefix:@"NSCalibratedWhiteColorSpace"])
    {
        float gray, alpha;
        sscanf([self UTF8String], "NSCalibratedWhiteColorSpace %f %f", &gray, &alpha);
        [color appendFormat:@"[UIColor colorWithWhite:%1.3f alpha:%1.3f]", gray, alpha];
    }
    else if ([self hasPrefix:@"NSCustomColorSpace Generic CMYK colorspace "])
    {
        float cyan, magenta, yellow, black, alpha;
        sscanf([self UTF8String], "NSCustomColorSpace Generic CMYK colorspace %f %f %f %f %f", &cyan, &magenta, &yellow, &black, &alpha);
        // There is no method in UIColor for CMYK colors...
        [color appendFormat:@"[UIColor colorWithCGColor:CGColorCreate(kCGColorSpaceGenericCMYK, {%1.3f, %1.3f, %1.3f, %1.3f, %1.3f})]", cyan, magenta, yellow, black, alpha];
    }
    else
    {
        [color appendString:self];
    }
    return color;
}

- (NSString *)quotedAsCodeString
{
    return [NSString stringWithFormat:@"@\"%@\"", self];
}

@end
