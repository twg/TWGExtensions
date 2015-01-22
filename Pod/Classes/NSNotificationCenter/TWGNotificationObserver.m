#import "TWGNotificationObserver.h"

@interface TWGNotificationObserver ()

@property (nonatomic, strong) NSArray *notificationNames;
@property (nonatomic, copy) void(^fireBlock)();
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

@end

@implementation TWGNotificationObserver

- (instancetype)initWithNotificationName:(NSString *)notificationName
                               fireBlock:(void(^)(NSNotification *notification))fireBlock
{
    return [self initWithNotificationName:notificationName
                                   object:nil
                                fireBlock:fireBlock];
}

- (instancetype)initWithNotificationName:(NSString *)notificationName
                                  object:(id)object
                               fireBlock:(void(^)(NSNotification *notification))fireBlock
{
    return [self initWithNotificationNames:@[notificationName]
                        notificationCenter:nil
                                    object:object
                                 fireBlock:fireBlock];
}

- (instancetype)initWithNotificationNames:(NSArray *)notificationNames
                                fireBlock:(void(^)(NSNotification *notification))fireBlock
{
    return [self initWithNotificationNames:notificationNames
                        notificationCenter:nil
                                 fireBlock:fireBlock];
}

- (instancetype)initWithNotificationNames:(NSArray *)notificationNames
                       notificationCenter:(NSNotificationCenter *)notificationCenter
                                fireBlock:(void(^)(NSNotification *notification))fireBlock
{
    
    return [self initWithNotificationNames:notificationNames
                        notificationCenter:notificationCenter
                                    object:nil
                                 fireBlock:fireBlock];
}

- (instancetype)initWithNotificationNames:(NSArray *)notificationNames
                       notificationCenter:(NSNotificationCenter *)notificationCenter
                                   object:(id)object
                                fireBlock:(void(^)(NSNotification *notification))fireBlock
{
    if (self = [super init]) {
        self.notificationCenter = notificationCenter ? notificationCenter : [NSNotificationCenter defaultCenter];
        self.notificationNames = notificationNames;
        self.fireBlock = fireBlock;
        [self registerObserversForObject:object];
    }
    
    return self;
}

- (void)registerObserversForObject:(id)object
{
    for (NSString *name in self.notificationNames) {
        [self.notificationCenter addObserver:self
                                    selector:@selector(triggerFireBlockWithNotification:)
                                        name:name
                                      object:object];
    }
}

- (void)deregisterObservers
{
    for (NSString *name in self.notificationNames) {
        [self.notificationCenter removeObserver:self name:name object:nil];
    }
}

- (void)dealloc
{
    [self deregisterObservers];
}

- (void)triggerFireBlockWithNotification:(NSNotification *)notification
{
    if (self.fireBlock) {
        self.fireBlock(notification);
    }
}

@end
