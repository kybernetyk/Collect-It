//
//  CollectWindowController.h
//  CollectIt
//
//  Created by Jaroslaw Szpilewski on 11.08.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class AppDelegate; //ficken 

@interface CollectWindowController : NSWindowController {
	//NSMutableArray *locationsArray;
	AppDelegate *parentObject;
	IBOutlet NSTableView *tableView;

}

//@property (readwrite,retain) NSMutableArray *locationsArray;
@property (readwrite,retain) AppDelegate *parentObject;

- (IBAction) visitLocation: (id) sender;
- (IBAction) removeLocationFromList: (id) sender;
- (IBAction) clearLocationList: (id) sender;

- (IBAction) saveList: (id) sender;
- (IBAction) loadList: (id) sender;


@end
