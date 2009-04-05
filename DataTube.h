// Erica Sadun April 2009

@interface DataTube : NSObject
{
	NSUInteger size;
	BOOL reversed;
	NSMutableArray *array;
}

@property (nonatomic) NSUInteger	size;
@property (nonatomic) BOOL reversed;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, readonly) NSUInteger count;

- (id) push: (id) anObject;
- (id) objectAtIndex: (NSUInteger) anIndex;
- (void) clear;
@end
