@import Foundation;

typedef void (^TWGKVONotificationBlock)(id object, NSDictionary *change);

@interface TWGKVOController : NSObject

- (void)observe:(id)object keyPaths:(NSArray *)keypaths block:(TWGKVONotificationBlock)block;

@end
