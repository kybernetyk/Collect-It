//
//  AppDelegate.h
//  CollectIt
//
//  Created by Jaroslaw Szpilewski on 11.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CollectWindowController;
@class CollectItSession;

@interface AppDelegate : NSObject {
//	NSMutableArray *locationsArray;
	CollectWindowController *collectWindowController;
//	NSInteger currentSelectedIndex;
	BOOL isWindowOpen;
	BOOL shouldShowWindow;
	
	CollectItSession *session;
}


//@property (readwrite,assign) NSInteger currentSelectedIndex;
//@property (readwrite,retain) NSMutableArray *locationsArray;
@property (readwrite, assign) BOOL isWindowOpen;
@property (readwrite, assign) BOOL shouldShowWindow;
@property (readwrite, retain) CollectItSession *session;

- (IBAction) openNewWindow : (id) sender;
- (IBAction)openPreferencesWindow:(id)sender;

- (void) addNewEntryToList: (NSString *) location;

- (IBAction) saveList: (id) sender;
- (IBAction) loadList: (id) sender;

@end
