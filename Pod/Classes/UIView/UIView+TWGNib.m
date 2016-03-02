
#import "UIView+TWGNib.h"

const NSInteger TWGNibLoadingReferenceTag = 999;

@implementation UIView (TWGNib)

+ (instancetype)twg_loadNib
{
    return [self twg_loadNibViewFromClass:[self class]];
}

+ (id)twg_loadNibViewFromClass:(Class) class
{
    return [self twg_loadNibViewWithName:NSStringFromClass(class)];
}

    + (id)twg_loadNibViewWithName : (NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}

- (UIView *)twg_replacePlaceholderWithAutolayout:(BOOL)autolayout coder:(NSCoder *)aDecoder
{
    if (self.tag == TWGNibLoadingReferenceTag) {
        UIView *realView = [[self class] twg_loadNib];
        realView.frame = self.frame;
        realView.alpha = self.alpha;
        realView.autoresizingMask = self.autoresizingMask;
        realView.autoresizesSubviews = self.autoresizesSubviews;

        if (autolayout) {
            realView.translatesAutoresizingMaskIntoConstraints = NO;
            [realView addConstraints:self.constraints];
        }

        for (UIView *view in self.subviews) {
            [realView addSubview:view];
        }
        return realView;
    }
    return [super awakeAfterUsingCoder:aDecoder];
}

@end
