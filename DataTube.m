// Erica Sadun April 2009

#import "DataTube.h"

@implementation DataTube
@synthesize reversed;

- (void) clear
{
	array = [[NSMutableArray array] retain];
}


- (id) initWithSize: (NSUInteger) aSize
{
	if (!(self = [super init])) return self;
	size = aSize;
	self.reversed = NO;
	[self clear];
	return self;
}

- (NSUInteger) count
{
	return array.count;
}

- (id) objectAtIndex: (NSUInteger) anIndex
{
	// out of bounds
	if (anIndex >= size) return nil;
	
	// not yet filled
	if (anIndex >= array.count) return nil;
	
	if (!self.reversed) return [array objectAtIndex:anIndex];
	return [array objectAtIndex:(array.count - (1 + anIndex))];
}

- (id) push: (id) anObject
{
	if (size == 0) return anObject;
	
	if ([array count] < size)
	{
		[array addObject: anObject];
		return nil;
	}
	
	[array addObject:anObject];
	id firstObject = [[[array objectAtIndex:0] retain] autorelease];
	[array removeObjectAtIndex:0];
	return firstObject;
}

- (void) dealloc
{
	array = nil;
	[super dealloc];
}
@end
