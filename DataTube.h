// Erica Sadun April 2009

@interface DataTube : NSObject
{
	NSUInteger size;
	BOOL reversed;
	NSMutableArray *array;
}

@property (nonatomic) BOOL reversed;
@property (nonatomic, readonly) NSUInteger count;
- (id) initWithSize: (NSUInteger) aSize;
- (id) push: (id) anObject;
- (id) objectAtIndex: (NSUInteger) anIndex;
- (void) clear;
@end
