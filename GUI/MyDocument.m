//
//  MyDocument.m
//  nib2objc
//
//  Created by Adrian on 7/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyDocument.h"
#import "NibProcessor.h"

@interface MyDocument ()

@property (nonatomic, copy) NSString *nibCode;
@property (nonatomic, copy) NSString *fileName;

@end



@implementation MyDocument

@synthesize editor = _editor;
@synthesize nibCode = _nibCode;
@synthesize fileName = _fileName;

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (NSString *)windowNibName
{
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    [self.editor setString:self.nibCode];
}

- (BOOL)readFromFile:(NSString *)fileName ofType:(NSString *)type
{
    self.fileName = fileName;
    NibProcessor *processor = [[[NibProcessor alloc] init] autorelease];
    processor.input = self.fileName;
    self.nibCode = processor.output;
    return YES;
}

@end
