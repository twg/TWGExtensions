
@import UIKit;
@interface UIView (TWGNib)

+ (instancetype)twg_loadNib;
+ (id)twg_loadNibViewFromClass:(Class)class;
+ (id)twg_loadNibViewWithName:(NSString *)name;

@end
