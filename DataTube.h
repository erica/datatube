// Erica Sadun April 2009

@interface DataTube : NSObject
{
	@private
	NSUInteger size;
	BOOL reversed;
	NSMutableArray *array;
}

@property BOOL reversed;
@property (readonly) NSUInteger count;
@property (readonly) NSUInteger size;

- (id) initWithSize: (NSUInteger) aSize;
- (id) push: (id) anObject;
- (id) objectAtIndex: (NSUInteger) anIndex;
- (void) clear;

@end
