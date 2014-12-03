#import "TWGKeyboardObserver.h"

@interface TWGKeyboardObserver ()
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;
@end

@implementation TWGKeyboardObserver

- (id)init
{
    self = [super init];
    if (self) {
        [self subscribeToKeyboardNotifications];
    }
    return self;
}

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
{
    self = [super init];
    if (self) {
        _notificationCenter = notificationCenter;
        [self subscribeToKeyboardNotifications];
    }
    return self;
}

- (void)dealloc{
    [self unsubscribeFromKeyboardNotifications];
}

- (NSNotificationCenter *)notificationCenter
{
    if (!_notificationCenter) {
        self.notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return _notificationCenter;
}

- (void)subscribeToKeyboardNotifications
{
    [self.notificationCenter addObserver:self
                                selector:@selector(willShowKeyboard:)
                                    name:UIKeyboardWillShowNotification
                                  object:nil];
    [self.notificationCenter addObserver:self
                                selector:@selector(willHideKeyboard:)
                                    name:UIKeyboardWillHideNotification
                                  object:nil];
}
- (void)unsubscribeFromKeyboardNotifications
{
    [self.notificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [self.notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)willShowKeyboard:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(keyboardObserver:willShowKeyboardWithFrame:duration:)]){
        CGRect frame = [self frameFromKeyboardNotification:notification forKey:UIKeyboardFrameEndUserInfoKey];
        CGFloat duration = [self durationFromKeyboardNotification:notification];
        [self.delegate keyboardObserver:self willShowKeyboardWithFrame:frame duration:duration];
    }
}

- (void)willHideKeyboard:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(keyboardObserver:willHideKeyboardFromFrame:duration:)]) {
        CGRect frame = [self frameFromKeyboardNotification:notification forKey:UIKeyboardFrameBeginUserInfoKey];
        CGFloat duration = [self durationFromKeyboardNotification:notification];
        [self.delegate keyboardObserver:self willHideKeyboardFromFrame:frame duration:duration];
    }
}

- (CGRect)frameFromKeyboardNotification:(NSNotification *)notification forKey:(NSString *)key
{
    return [notification.userInfo[key] CGRectValue];
}

- (CGFloat)durationFromKeyboardNotification:(NSNotification *)notification
{
    return [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
}

@end
