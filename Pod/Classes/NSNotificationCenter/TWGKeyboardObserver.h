@import Foundation;
@import UIKit;

@class TWGKeyboardObserver;
@protocol TWGKeyboardObserverDelegate<NSObject>

@optional
- (void)keyboardObserver:(TWGKeyboardObserver *)observer
willShowKeyboardWithFrame:(CGRect)frame
                duration:(CGFloat)duration;

- (void)keyboardObserver:(TWGKeyboardObserver *)observer
willHideKeyboardFromFrame:(CGRect)frame
                duration:(CGFloat)duration;

@end

@interface TWGKeyboardObserver : NSObject

@property (nonatomic, strong, readonly) NSNotificationCenter *notificationCenter;
@property (nonatomic, weak) id <TWGKeyboardObserverDelegate> delegate;

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter;


@end