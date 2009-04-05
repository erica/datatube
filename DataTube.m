// Erica Sadun April 2009

#import "DataTube.h"

@implementation DataTube
@synthesize size;
@synthesize array;
@synthesize reversed;

- (void) clear
{
	if (self.array) [self.array release];
	self.array = [[NSMutableArray alloc] init];
	[self.array release];
}


- (id) init
{
	if (!(self = [super init])) return self;
	self.size = 0;
	self.reversed = NO;
	[self clear];
	return self;
}

- (NSUInteger) count
{
	return self.array.count;
}

- (id) objectAtIndex: (NSUInteger) anIndex
{
	// out of bounds
	if (anIndex >= self.size) return nil;
	
	// not yet filled
	if (anIndex >= self.array.count) return nil;
	
	if (!self.reversed) return [self.array objectAtIndex:anIndex];
	return [self.array objectAtIndex:(self.array.count - (1 + anIndex))];
}

- (id) push: (id) anObject
{
	if (self.size == 0) return anObject;
	
	if ([self.array count] < self.size)
	{
		[self.array addObject: anObject];
		return nil;
	}
	
	[self.array addObject:anObject];
	id firstObject = [[[self.array objectAtIndex:0] retain] autorelease];
	[self.array removeObjectAtIndex:0];
	return firstObject;
}

- (void) dealloc
{
	[super dealloc];
	[self.array release];
}
@end
