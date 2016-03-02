
#import "TWGEmptyView.h"

@interface TWGEmptyView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation TWGEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectInset(self.bounds, 20, 20);
}

- (void)setLabelText:(NSString *)text
{
    self.label.text = text;
}

- (UILabel *)label
{
    if (!_label) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.numberOfLines = 0;
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
