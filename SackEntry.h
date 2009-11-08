//
//  SackEntry.h
//  TrackSack
//
//  Created by Jaroslaw Szpilewski on 10.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SackEntry : NSObject <NSCoding>
{
	NSString *location;
	BOOL visited;
}

@property (readwrite, assign) BOOL visited;
@property (readwrite, retain) NSString *location;

@end
