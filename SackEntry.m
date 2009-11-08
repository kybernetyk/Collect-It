//
//  SackEntry.m
//  TrackSack
//
//  Created by Jaroslaw Szpilewski on 10.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SackEntry.h"


@implementation SackEntry

@synthesize visited, location;

- (id) init
{
//	NSLog(@"sackentry init %i",[self retainCount]);
	self = [super init];
	
	if (self)
	{
		[self setVisited: NO];
		[self setLocation:@"http://www.apple.com"];
	}
	
	return self;
}

- (id) initWithCoder: (NSCoder *) coder
{
	[super init];
	
	location = [[coder decodeObjectForKey:@"location"] retain];
	visited = [coder decodeBoolForKey:@"visited"];
	
	return self;
	
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeObject: location forKey: @"location"];
	[coder encodeBool: visited forKey: @"visited"];
	
}


@end
