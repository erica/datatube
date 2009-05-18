/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
#import "DataTube.h"

#define COOKBOOK_PURPLE_COLOR	[UIColor colorWithRed:0.20392f green:0.19607f blue:0.61176f alpha:1.0f]
#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

@interface TestBedViewController : UITableViewController
{
	DataTube *tube;
}
@end

@implementation TestBedViewController

#pragma mark UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return tube.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"generic"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"generic"] autorelease];
	cell.textLabel.text = [tube objectAtIndex:[indexPath row]];
	return cell;
}

- (void) tick: (NSTimer *) timer
{
	// Simulate receiving new data by adding a new item to the tube
	[tube push:[[NSDate date] description]];
	[self.tableView reloadData];
}

#pragma mark Button Actions
- (void) performClear
{
	[tube clear];
	[self.tableView reloadData];
}

- (void) performReverse
{
	tube.reversed = !tube.reversed;
	[self.tableView reloadData];
}

#pragma mark Initialization and Cleanup
- (void) viewDidLoad
{
	self.title = @"DataTube Demo";
	self.navigationController.navigationBar.tintColor = COOKBOOK_PURPLE_COLOR;
	self.navigationItem.rightBarButtonItem = BARBUTTON(@"Clear", @selector(performClear));
	self.navigationItem.leftBarButtonItem = BARBUTTON(@"Reverse", @selector(performReverse));
	
	tube = [[DataTube alloc] initWithSize:8];
	tube.reversed = NO;
	
	// Timer simulates receiving new data via polling
	[NSTimer scheduledTimerWithTimeInterval: 1.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];	
}

- (void) dealloc
{
	[tube release];
	[super dealloc];
}
@end

@interface TestBedAppDelegate : NSObject <UIApplicationDelegate>
@end

@implementation TestBedAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[TestBedViewController alloc] init]];
	[window addSubview:nav.view];
	[window makeKeyAndVisible];
}
@end

int main(int argc, char *argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"TestBedAppDelegate");
	[pool release];
	return retVal;
}
