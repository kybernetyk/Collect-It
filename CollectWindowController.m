//
//  CollectWindowController.m
//  CollectIt
//
//  Created by Jaroslaw Szpilewski on 11.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CollectWindowController.h"
#import "AppDelegate.h"
#import "SackEntry.h"
#import "CollectWindow.h"
#import "CollectItSession.h"

@implementation CollectWindowController

@synthesize parentObject;

- (void) awakeFromNib
{
//	NSLog(@"awake from nib!");
//	[locationsArrayController setSelectionIndex: [parentObject currentSelectedIndex]];
	
	if ([[parentObject session] currentlySelectedEntry] >= 0)
	{
		NSIndexSet *set = [[NSIndexSet alloc] initWithIndex: [[parentObject session] currentlySelectedEntry]];	
		[tableView selectRowIndexes:set byExtendingSelection:NO];	
		[set release];
	}
	
	//double click biatch!
	[tableView setDoubleAction: @selector(visitLocation:)];
}


- (void)windowWillClose:(NSNotification *)notification
{
	/*NSLog(@"Window will close! %i", [parentObject isWindowOpen]);
	for (SackEntry *se in [self locationsArray])
	{
		NSLog(@"\tretain count %i",[se retainCount]);
	}*/
	//NSLog(@"Window will close!");
//	[parentObject setCurrentSelectedIndex: [locationsArrayController selectionIndex]];
	[parentObject setIsWindowOpen: NO];
/*	NSLog(@"Window Closed!");
	for (SackEntry *se in [self locationsArray])
	{
		
		NSLog(@"\t %@ retain count %i",[se location],[se retainCount]);
		[se release];
		se = nil;

	}*/
}


- (IBAction) saveList: (id) sender
{
	[parentObject saveList: self];
	
	//NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:locationsArray];
	
}

- (IBAction) loadList: (id) sender
{
	[parentObject loadList: self];
	[tableView reloadData];
}



- (IBAction) visitLocation: (id) sender
{
	//NSLog(@"visit location");
	
	//omg selection invalid!
	if ([tableView selectedRow] < 0)
		return;
	

	if ([tableView selectedRow] >= [[[parentObject session] entries] count])
		return;
	
	SackEntry *se = [	[[parentObject session] entries] objectAtIndex: [tableView selectedRow]];
	NSString *str = [se location];
	[se setVisited: YES];
	NSURL *url = [NSURL URLWithString:str];
	[[NSWorkspace sharedWorkspace] openURL: url];

	
	//< [locationsArray count] -1 = nachdem das letzte item ausgewaehlt wurde, bleibt es angewaehlt
	//< [locationsArray count] = nachdem das letzte item ausgewaehlt wurde, wird nix angewaehlt
	if ([[parentObject session] currentlySelectedEntry] < [	[[parentObject session] entries] count] -1)
	{	
		[[parentObject session] setCurrentlySelectedEntry: [[parentObject session] currentlySelectedEntry] + 1];
		//[parentObject setCurrentSelectedIndex: [parentObject currentSelectedIndex] + 1];
		NSIndexSet *set = [[NSIndexSet alloc] initWithIndex: [[parentObject session] currentlySelectedEntry]];	
		[tableView selectRowIndexes:set byExtendingSelection:NO];	
		[set release];
		
	}
	

}

- (IBAction) clearLocationList: (id) sender
{
	[[[parentObject session] entries] removeAllObjects];
	[tableView reloadData];
}

- (IBAction) removeLocationFromList: (id) sender
{
	if ([tableView selectedRow] < 0)
		return;
	
	NSLog(@"remove the shit!");	
	SackEntry *se = [[[parentObject session] entries] objectAtIndex: [tableView selectedRow]];
	NSLog(@"\tremove: %@",[se location]);
	[[[parentObject session] entries] removeObject: se];	
	
//	NSLog(@"\tcurrent selected index: %i",[parentObject currentSelectedIndex]);
	
	if ([[parentObject session] currentlySelectedEntry] >= 0)
	{
		if ([[parentObject session] currentlySelectedEntry] > 0)
			[[parentObject session] setCurrentlySelectedEntry: [[parentObject session] currentlySelectedEntry] - 1];
		
		NSIndexSet *set = [[NSIndexSet alloc] initWithIndex: [[parentObject session] currentlySelectedEntry]];	
		[tableView selectRowIndexes:set byExtendingSelection:NO];	
		[set release];
	}
	
	[tableView reloadData];
}

// Datasource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [[[parentObject session] entries] count];
}

/*- (NSString *)tableView:(NSTableView *)aTableView toolTipForCell:(NSCell *)aCell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)row mouseLocation:(NSPoint)mouseLocation
{
	NSLog(@"point: %f,%f",mouseLocation.x, mouseLocation.y);
	
	return @"Deine Mutter";
}*/

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	if (rowIndex < 0)
		return nil;

	SackEntry *se = [[[parentObject session] entries] objectAtIndex: rowIndex];
	
	//KVC
	return [se valueForKey:[aTableColumn identifier]];
	
	/*
	if ([[aTableColumn identifier] isEqualToString: @"location"])
		return [se location];
	else
		return [NSNumber numberWithBool: [se visited]];*/
	
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	//NSLog(@"select did change to: %i", [tableView selectedRow]);
//	[[parentObject session] setCurrentSelectedIndex: [tableView selectedRow]];
	[[parentObject session] setCurrentlySelectedEntry: [tableView selectedRow]];

}


@end
