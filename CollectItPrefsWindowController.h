//
//  CollectItPrefsWindowController.h
//  Collect It
//
//  Created by Jaroslaw Szpilewski on 18.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DBPrefsWindowController.h"

@interface CollectItPrefsWindowController : DBPrefsWindowController 
{
	IBOutlet NSView *generalPrefsView;
	IBOutlet NSView *advancedPrefsView;
	IBOutlet NSView *updatesPrefsView;	
}

@end
