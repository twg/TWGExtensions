
@import UIKit;

@interface UIView (TWGNib)

+ (instancetype)twg_loadNib;
+ (id)twg_loadNibViewFromClass:(Class) class;
+ (id)twg_loadNibViewWithName:(NSString *)name;

/**
 * Use when loading views from a nib inside another nib
 * Make sure you set the tag to '999' of the view in the nib
 * Put the following in the subviews class:
 - (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
 {
 return [self replacePlaceholderWithAutolayout:YES coder:aDecoder];
 }
 */
- (UIView *)twg_replacePlaceholderWithAutolayout:(BOOL)autolayout coder:(NSCoder *)aDecoder;

@end
