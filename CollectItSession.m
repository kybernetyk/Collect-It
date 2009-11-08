//
//  CollectItSession.m
//  Collect It
//
//  Created by Jaroslaw Szpilewski on 17.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CollectItSession.h"


@implementation CollectItSession

@synthesize entries, currentlySelectedEntry;

- (id) init
{
	//	NSLog(@"sackentry init %i",[self retainCount]);
	self = [super init];
	
	if (self)
	{
		entries = [[[NSMutableArray alloc] init] autorelease];
		[entries retain];
		[self setCurrentlySelectedEntry: -1];

		//[self setVisited: NO];
		//[self setLocation:@"http://www.apple.com"];
	}
	
	return self;
}

- (id) initWithCoder: (NSCoder *) coder
{
	[super init];
	
	entries = [[coder decodeObjectForKey:@"entries"] retain];
	currentlySelectedEntry = [coder decodeIntForKey:@"currentlySelectedEntry"];
	
	return self;
	
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeObject: entries forKey: @"entries"];
	[coder encodeInt:currentlySelectedEntry forKey: @"currentlySelectedEntry"];
	
}


@end
