// Erica Sadun April 2009

#import <Foundation/Foundation.h>

@interface NSMutableArray (UtilityExtensions) 
- (void) reverse;
@end

@interface NSMutableArray (StackExtensions) 
- (void) push: (id) anObject;
- (id) pop;
@end

@interface NSMutableArray (QueueExtensions)
- (id) pull;
@end

