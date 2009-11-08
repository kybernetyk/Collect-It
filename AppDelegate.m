//
//  AppDelegate.m
//  CollectIt
//
//  Created by Jaroslaw Szpilewski on 11.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "CollectWindowController.h"
#import "SackEntry.h"
#import "CollectItSession.h"
#import "CollectItPrefsWindowController.h"
#import <Carbon/Carbon.h>


@implementation AppDelegate
//@synthesize locationsArray,isWindowOpen, currentSelectedIndex;
@synthesize isWindowOpen, session, shouldShowWindow;

- (id) init
{
	NSLog(@"init");
	[self setShouldShowWindow: YES];
	self = [super init];
	session = nil;

	//will set session if it loads
	[self loadList: self];

	if (session == nil) //no session loaded? 
	{
		NSLog(@"no session loaded - let's create one!");
		session = [[[CollectItSession alloc] init] autorelease];
		[session retain];		
	}
	
	collectWindowController = nil;
	[self setIsWindowOpen: NO];
	
	return self;
}

// Hot Key Handler to activate app
OSStatus MyHotKeyHandler(EventHandlerCallRef nextHandler,EventRef theEvent,	 void *userData)
{
	//[NSApp unhide:(id)userData];
	//[NSApp activate: NO];
//	NSLog(@"hotkey pressed, bitch!");
	//NSLog(@"%@",(id)userData);
	//Do something once the key is pressed
//	AppDelegate *d = (AppDelegate *)userData;
//	[d openNewWindow: d];
	
	if ([NSApp isActive])
		[NSApp hide: nil];
	else
	{	
		[NSApp activateIgnoringOtherApps: YES];
			AppDelegate *d = (AppDelegate *)userData;
		[d setShouldShowWindow: YES];
		
	}
	return noErr;
}


-(void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	NSLog(@"applicationDidFinishLaunching");
	[NSApp setServicesProvider:self];
	
	//Register the Hotkeys
	EventHotKeyRef gMyHotKeyRef;
	EventHotKeyID gMyHotKeyID;
	EventTypeSpec eventType;
	eventType.eventClass=kEventClassKeyboard;
	eventType.eventKind=kEventHotKeyPressed;
	
	//register hotkey handler
	InstallApplicationEventHandler(&MyHotKeyHandler,1,&eventType,self,NULL);
	
	//register hotkey (option + tab)
	gMyHotKeyID.signature='htk1';
	gMyHotKeyID.id=1;
	//RegisterEventHotKey(49, cmdKey+optionKey, gMyHotKeyID, 	GetApplicationEventTarget(), 0, &gMyHotKeyRef);
	RegisterEventHotKey(48, optionKey, gMyHotKeyID, GetApplicationEventTarget(), 0, &gMyHotKeyRef);
	
//	UnregisterEventHotKey(gMyHotKeyRef);

	
	
	//wird in application did become active geladen ...
	//aber hier sollts vorher aufgerufen werden ...
	[self openNewWindow:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	[self saveList: self];
}


- (IBAction) saveList: (id) sender
{
	BOOL b = [NSKeyedArchiver archiveRootObject:session toFile:@"collectit_session.dat"];
	
	if (b == NO)
	{
		NSLog(@"error saving collectit.dat!");
	}
}

- (IBAction) loadList: (id) sender
{	
	CollectItSession *newSession = (CollectItSession *)[NSKeyedUnarchiver unarchiveObjectWithFile:@"collectit_session.dat"];
	
	if (newSession == nil)
	{
		NSLog(@"error loading saved session!");
		return;
	}
	
	[session release];
	[self setSession: newSession];
}



-(void)doString:(NSPasteboard *)pboard userData:(NSString *)userData error:(NSString **)error 
{
	[NSApp hide: self];
	
    NSString *pboardString = [pboard stringForType:NSStringPboardType];
NSLog(@"Adding new Entry! %@",pboardString);
    
	
	NSURL *url = [NSURL URLWithString:pboardString];
	if (url != nil)
	{
		[self addNewEntryToList:pboardString];
	}

}

- (void) addNewEntryToList: (NSString *) location
{
	//BOOL selectFirstRow = NO;
	
	NSMutableArray *locationsArray = [session entries];
	
	//if ([session currentlySelectedEntry] < 0)
	//	selectFirstRow = YES;
	
	BOOL addEntry = YES;
	for (SackEntry *s in locationsArray)
	{
		if ([[s location] isEqualToString: location])
			addEntry = NO;
	}
	
	if (addEntry == YES)
	{
		SackEntry *se = [[[SackEntry alloc] init] autorelease];
		[se setLocation: location];		
		//[[self locationsArray] addObject: se];
		[locationsArray addObject: se];
		
		//if (selectFirstRow)
		//	[session setCurrentlySelectedEntry: 0];
	}	
}


- (IBAction) openNewWindow : (id) sender
{	
	if ([self isWindowOpen])
		return;
	if ([self shouldShowWindow] == NO)
		return;
	

	[self setIsWindowOpen: YES];
	
	
	
	NSLog(@"open New Window");
	
	if (collectWindowController != nil)
	{	
//		NSLog(@"releaseing controller");
		[collectWindowController release];		
	}
	
	collectWindowController = [[CollectWindowController alloc] initWithWindowNibName:@"CollectWindow"];

	[collectWindowController setParentObject: self];
	

	//select first unvisited, if no selected row
	if ([session currentlySelectedEntry] < 0)
	{
		int count = 0;
		for (SackEntry *se in [session entries])
		{
//			NSLog(@"%i",[se retainCount]);
			if ([se visited] == NO)
			{
				[session setCurrentlySelectedEntry: count];
				break;
			}
			count ++;
		}
	}
	

	[[collectWindowController window] center];
	NSRect frame = [[collectWindowController window] frame];
	frame.origin.y -= (frame.size.height/4);
	
	[[collectWindowController window] setFrame:frame display:YES animate:NO];
	[collectWindowController showWindow:self];	

}


- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
	NSLog(@"reopen");

	[self setShouldShowWindow: YES];
	[self openNewWindow:self];
	return YES;
}

- (void)applicationWillBecomeActive:(NSNotification *)aNotification
{
	NSLog(@"WILL BECOME ACTIVE!");

}

- (void)applicationDidBecomeActive:(NSNotification *)aNotification
{
	NSLog(@"applicationDidBecomeActive");
	[self openNewWindow:self];
}



- (void)applicationWillResignActive:(NSNotification *)aNotification
{
//	NSLog(@"WILL BECOME INACTIVE!");
	[self setShouldShowWindow: NO];
	[[CollectItPrefsWindowController sharedPrefsWindowController] close];
	[collectWindowController close];
}


- (IBAction)openPreferencesWindow:(id)sender
{
	
	[[CollectItPrefsWindowController sharedPrefsWindowController] showWindow:nil];

}


@end
