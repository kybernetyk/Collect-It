//
//  CollectItSession.h
//  Collect It
//
//  Created by Jaroslaw Szpilewski on 17.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CollectItSession : NSObject <NSCoding>
{
	NSMutableArray *entries;
	NSInteger currentlySelectedEntry;
}

@property (readwrite, retain) NSMutableArray *entries;
@property (readwrite, assign) NSInteger currentlySelectedEntry;

@end
