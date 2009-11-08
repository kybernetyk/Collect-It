//
//  CollectItPrefsWindowController.m
//  Collect It
//
//  Created by Jaroslaw Szpilewski on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CollectItPrefsWindowController.h"


@implementation CollectItPrefsWindowController

- (void)setupToolbar
{
	[self addView:generalPrefsView label:@"General"];
	[self addView:advancedPrefsView label:@"Advanced"];
	[self addView:updatesPrefsView label:@"Updates"];
}

@end
