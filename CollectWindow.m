//
//  CollectWindow.m
//  CollectIt
//
//  Created by Jaroslaw Szpilewski on 13.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CollectWindow.h"


@implementation CollectWindow
- (void)close
{
	[super close];
	[NSApp hide: self];
//	NSLog(@"close lols!");
}

- (BOOL)canBecomeMainWindow
{
//	NSLog(@"can become main?");
	
	return YES;
}

- (BOOL)canBecomeKeyWindow
{
//	NSLog(@"can become key?");
	
	
	return YES;
}

- (void) doParty
{
//	NSLog(@"do party!");
}

@end
