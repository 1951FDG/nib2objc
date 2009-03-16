//
//  NSNumber+Nib2ObjcExtensions.h
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSNumber (Nib2ObjcExtensions)

- (NSString *)booleanString;
- (NSString *)intString;
- (NSString *)floatString;
- (NSString *)autoresizingMaskString;
- (NSString *)contentModeString;
- (NSString *)textAlignmentString;
- (NSString *)borderStyleString;
- (NSString *)contentHorizontalAlignmentString;
- (NSString *)contentVerticalAlignmentString;
- (NSString *)keyboardAppearanceString;
- (NSString *)returnKeyTypeString;
- (NSString *)autocapitalizationTypeString;
- (NSString *)autocorrectionTypeString;
- (NSString *)keyboardTypeString;
- (NSString *)progressViewStyleString;
- (NSString *)baselineAdjustmentString;
- (NSString *)lineBreakModeString;
- (NSString *)activityIndicatorViewStyleString;
- (NSString *)buttonTypeString;
- (NSString *)segmentedControlStyleString;
- (NSString *)scrollViewIndicatorStyleString;
- (NSString *)tableViewStyleString;
- (NSString *)tableViewCellSeparatorStyleString;
- (NSString *)tableViewCellAccessoryString;
- (NSString *)tableViewCellEditingStyleString;
- (NSString *)tableViewCellSelectionStyleString;

@end
