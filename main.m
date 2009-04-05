#import <UIKit/UIKit.h>
#import "DataTube.h"

@interface TestBedController : UITableViewController
{
	DataTube *tube;
}
@end

@implementation TestBedController

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
	cell.text = [tube objectAtIndex:[indexPath row]];
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

- (void)loadView
{
	[super loadView];
	
	self.title = @"DataTube Demo";
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithTitle:@"Clear" 
											   style:UIBarButtonItemStylePlain 
											   target:self 
											   action:@selector(performClear)] autorelease];
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
											  initWithTitle:@"Reverse" 
											  style:UIBarButtonItemStylePlain 
											  target:self 
											  action:@selector(performReverse)] autorelease];
	
	tube = [[DataTube alloc] init];
	tube.size = 8;
	tube.reversed = NO;
	
	// Timer simulates receiving new data via polling
	[NSTimer scheduledTimerWithTimeInterval: 1.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];	
}

- (void) dealloc
{
	[super dealloc];
	[tube release];
}
@end

#pragma mark Generic Application Material

@interface TestBedAppDelegate : NSObject <UIApplicationDelegate>
@end

@implementation TestBedAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[TestBedController alloc] init]];
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
