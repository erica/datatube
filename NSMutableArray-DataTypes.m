// Erica Sadun April 2009

#import "NSMutableArray-DataTypes.h"


@implementation NSMutableArray (UtilityExtensions)
- (void)reverse
{
	for (int i=0; i<(floor([self count]/2.0)); i++) 
		[self exchangeObjectAtIndex:i withObjectAtIndex:([self count]-(i+1))];
}
@end


@implementation NSMutableArray (StackExtensions)
- (id)pop
{
    id lastObject = [[[self lastObject] retain] autorelease];
    [self removeLastObject];
    return lastObject;
}

- (void)push:(id)object
{
    [self addObject:object];
}
@end

@implementation NSMutableArray (QueueExtensions)
- (id) pull
{
	id firstObject = [[[self objectAtIndex:0] retain] autorelease];
	[self removeObjectAtIndex:0];
	return firstObject;
}
@end

