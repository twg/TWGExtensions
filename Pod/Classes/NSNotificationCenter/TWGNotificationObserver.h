#import <Foundation/Foundation.h>

@interface TWGNotificationObserver : NSObject

@property (nonatomic, strong, readonly) NSArray *notificationNames;
@property (nonatomic, copy, readonly) void(^fireBlock)();
@property (nonatomic, strong, readonly) NSNotificationCenter *notificationCenter;

- (instancetype)initWithNotificationName:(NSString *)notificationName
                               fireBlock:(void(^)(NSNotification *notification))fireBlock;

- (instancetype)initWithNotificationName:(NSString *)notificationName
                                  object:(id)object
                               fireBlock:(void(^)(NSNotification *notification))fireBlock;

- (instancetype)initWithNotificationNames:(NSArray *)notificationNames
                                fireBlock:(void(^)(NSNotification *notification))fireBlock;

- (instancetype)initWithNotificationNames:(NSArray *)notificationNames
                       notificationCenter:(NSNotificationCenter *)notificationCenter
                                fireBlock:(void(^)(NSNotification *notification))fireBlock;

- (instancetype)initWithNotificationNames:(NSArray *)notificationNames
                       notificationCenter:(NSNotificationCenter *)notificationCenter
                                   object:(id)object
                                fireBlock:(void(^)(NSNotification *notification))fireBlock;

@end
