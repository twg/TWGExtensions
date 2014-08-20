
#import "UIView+TWGNib.h"

@implementation UIView (TWGNib)

+ (instancetype)twg_loadNib
{
    return [self twg_loadNibViewFromClass:[self class]];
}

+ (id)twg_loadNibViewFromClass:(Class)class
{
    return [self twg_loadNibViewWithName:NSStringFromClass(class)];
}

+ (id)twg_loadNibViewWithName:(NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}

@end
