#import "TWGLoadingIndicator.h"

@interface TWGLoadingIndicator ()

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat strokeThickness;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) CAShapeLayer *animatedArcLayer;

@end

@implementation TWGLoadingIndicator

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults
{
    _radius = 18.0f;
    _strokeThickness = 4.0f;
    _strokeColor = [UIColor blackColor];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(36.0f, 36.0f);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview != nil) {
        [self layoutAnimatedLayer];
    }
    else {
        [_animatedArcLayer removeFromSuperlayer];
        _animatedArcLayer = nil;
    }
}

- (void)layoutAnimatedLayer
{
    CALayer *layer = self.animatedArcLayer;
    [self.layer addSublayer:layer];
    layer.position = CGPointMake(self.radius,
                                 self.radius);
}

- (CALayer *)animatedArcLayer
{
    if (!_animatedArcLayer) {
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
        CGRect rect = CGRectMake(0, 0, arcCenter.x*2, arcCenter.y*2);
        
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                    radius:self.radius
                                                                startAngle:((CGFloat)M_PI)*3/2
                                                                  endAngle:((CGFloat)M_PI)/2+((CGFloat)M_PI)*5
                                                                 clockwise:YES];
        
        _animatedArcLayer = [CAShapeLayer layer];
        _animatedArcLayer.contentsScale = [[UIScreen mainScreen] scale];
        _animatedArcLayer.frame = rect;
        _animatedArcLayer.fillColor = [UIColor clearColor].CGColor;
        _animatedArcLayer.strokeColor = self.strokeColor.CGColor;
        _animatedArcLayer.lineWidth = self.strokeThickness;
        _animatedArcLayer.lineCap = kCALineCapRound;
        _animatedArcLayer.lineJoin = kCALineJoinBevel;
        _animatedArcLayer.path = smoothedPath.CGPath;
        
        CALayer *maskLayer = [CALayer layer];
        maskLayer.contents = (id)[[UIImage imageNamed:@"angle-mask@2x.png"] CGImage];
        maskLayer.frame = _animatedArcLayer.bounds;
        _animatedArcLayer.mask = maskLayer;
        
        NSTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = 0;
        animation.toValue = [NSNumber numberWithDouble:M_PI*2.0f];
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_animatedArcLayer.mask addAnimation:animation forKey:@"rotate"];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.removedOnCompletion = NO;
        animationGroup.timingFunction = linearCurve;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @0.015;
        strokeStartAnimation.toValue = @0.515;
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0.485;
        strokeEndAnimation.toValue = @0.985;
        
        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        [_animatedArcLayer addAnimation:animationGroup forKey:@"progress"];
    }
    
    return _animatedArcLayer;
}

@end

