
#import "UIViewController+TWGDebug.h"
#import <objc/runtime.h>

@implementation UIViewController (TWGDebug)

- (void)enableDebugMode:(void (^)(void))block
{
    [self setDebugBlock:block];
    [self addDebugGesture];
}

- (void)addDebugGesture
{
    UIRotationGestureRecognizer *gesture =
        [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(didRotateForDebug:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)didRotateForDebug:(UIRotationGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
        [self setPreviousRotation:recognizer.rotation];
        break;
    }
    case UIGestureRecognizerStateEnded: {
        [self resetDebugState];
        break;
    }
    case UIGestureRecognizerStateChanged: {
        [self updateRotationDelta:recognizer.rotation];
        [self setPreviousRotation:recognizer.rotation];

        if (fabs([self rotationDelta]) >= 3) {
            [self notifyDebugCompletion];
            [self resetDebugState];
        }

        break;
    }
    default:
        break;
    }
}

- (void)updateRotationDelta:(CGFloat)newDelta
{
    CGFloat delta = [self rotationDelta];
    delta += newDelta - self.previousRotation;
    [self setRotationDelta:delta];
}

- (void)notifyDebugCompletion
{
    void (^block)(void) = [self debugBlock];
    if (block) {
        block();
    }
}

- (void)resetDebugState
{
    [self setPreviousRotation:0];
    [self setRotationDelta:0];
}

#pragma mark - Associated Objects

- (void)setPreviousRotation:(CGFloat)previousRotation
{
    objc_setAssociatedObject(self, @selector(previousRotation), @(previousRotation),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)previousRotation
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setRotationDelta:(CGFloat)rotationDelta
{
    objc_setAssociatedObject(self, @selector(rotationDelta), @(rotationDelta), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)rotationDelta
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setDebugBlock:(void (^)(void))block
{
    objc_setAssociatedObject(self, @selector(debugBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))debugBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
