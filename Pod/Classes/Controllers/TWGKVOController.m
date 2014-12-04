#import "TWGKVOController.h"

@interface TWGKVOController ()
@property (nonatomic, weak) id object;
@property (nonatomic, copy) NSArray *keypaths;
@property (nonatomic, copy) TWGKVONotificationBlock block;
@end

@implementation TWGKVOController

- (void)dealloc
{
    for (NSString *keyPath in self.keypaths) {
        [self.object removeObserver:self forKeyPath:keyPath];
    }
}

- (void)observe:(id)object keyPaths:(NSArray *)keypaths block:(TWGKVONotificationBlock)block
{
    if ([self canObserveObject:object]) {
        self.keypaths = keypaths;
        self.object = object;
        self.block = block;
        
        for (NSString *keyPath in keypaths) {
            [object addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
        }
    }
}

- (BOOL)canObserveObject:(id)object
{
    return self.object == nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.object && [self.keypaths containsObject:keyPath]) {
        if (self.block) {
            self.block(object, change);
        }
    }
}

@end
