//
//  GGCircleTransition.m
//  自定义转场动画
//
//  Created by zachary spark on 2019/7/8.
//  Copyright © 2019 Struggle3g. All rights reserved.
//

#import "GGCircleTransition.h"
#import "ViewController.h"
#import "TwoVC.h"

#define GGScreenwidth [UIScreen mainScreen].bounds.size.width
#define GGScreenheight [UIScreen mainScreen].bounds.size.height

@interface GGCircleTransition()<CAAnimationDelegate>
{
    CGPoint         _AnimationCenter;
    CGRect          _AnimationFrame;
    UIBezierPath    *SmallPath;
    UIBezierPath    *BigPath;
    CAShapeLayer    *maskLayer;
}
@property(nonatomic,strong)id <UIViewControllerContextTransitioning> context;
@end

@implementation GGCircleTransition

- (instancetype)initWithTransitionType:(GGCircleTransitionType)type View:(UIView *)CircleView;{
    
    self = [super init];
    if (self) {
        self.Type = type;
        _AnimationFrame     = CircleView.frame;
        _AnimationCenter    = CircleView.center;
    }
    return self;
}


- (void)attribute{
    
    SmallPath        = [UIBezierPath bezierPathWithOvalInRect:_AnimationFrame];
    CGFloat x        = MAX(_AnimationCenter.x, GGScreenwidth - _AnimationCenter.x);
    CGFloat y        = MAX(_AnimationCenter.y, GGScreenheight - _AnimationCenter.y);
    CGFloat radius   = sqrtf(pow(x, 2) + pow(y, 2));
    BigPath          = [UIBezierPath bezierPathWithArcCenter:_AnimationCenter radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    maskLayer        = [CAShapeLayer layer];
    
}



#pragma mark -- UIViewControllerAnimatedTransitioning
//动画持续时间，单位是秒
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

//动画效果
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _context = transitionContext;
    
    [self attribute];
    
    [self CircleTransitionAnimation];
    
}



- (void)CircleTransitionAnimation{
    
    switch (_Type) {
        case GGCircleTransitionTypePresentation:
        {
            [self CreatePresentationAnimation:_context];
        }
            break;
        case GGCircleTransitionTypeDissmiss:
        {
            [self CreateDismissAnimation:_context];
        }
            break;
        case GGCircleTransitionTypePush:
        {
            [self CreatePushAnimation:_context];
        }
            break;
        case GGCircleTransitionTypePop:
        {
            [self CreatePopAnimation:_context];
        }
            break;
            
        default:
            break;
    }
}

#pragma  mark func

//dissmiss
- (void)CreateDismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIView* containerView   = [transitionContext containerView];
    TwoVC * fromVC          = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
     [containerView addSubview:fromVC.view];
    
    maskLayer.path              = SmallPath.CGPath;
    fromVC.view.layer.mask      = maskLayer;

    CABasicAnimation *anim      = [CABasicAnimation animation];
    anim.keyPath                = @"path";
    anim.fromValue              = (__bridge id _Nullable)(BigPath.CGPath);
    anim.toValue                = (__bridge id _Nullable)(SmallPath.CGPath);
    anim.duration               = [self transitionDuration:_context];
    anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate               = self;
    [maskLayer addAnimation:anim forKey:nil];
    
    
    
}

//Presentation
- (void)CreatePresentationAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame             = CGRectMake(0, 0, GGScreenwidth, GGScreenheight);
    UIView *containerView       = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    maskLayer.path              = BigPath.CGPath;
    toVC.view.layer.mask        = maskLayer;

    CABasicAnimation *anim      = [CABasicAnimation animation];
    anim.keyPath                = @"path";
    anim.fromValue              = (__bridge id _Nullable)(SmallPath.CGPath);
    anim.toValue                = (__bridge id _Nullable)(BigPath.CGPath);
    anim.duration               = [self transitionDuration:_context];
    anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate               = self;
    [maskLayer addAnimation:anim forKey:nil];
}

//Pop
- (void)CreatePopAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * fromVC   = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView       = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];

    maskLayer.path              = SmallPath.CGPath;
    fromVC.view.layer.mask      = maskLayer;
    
    CABasicAnimation *anim      = [CABasicAnimation animation];
    anim.keyPath                = @"path";
    anim.fromValue              = (__bridge id _Nullable)(BigPath.CGPath);
    anim.toValue                = (__bridge id)(SmallPath.CGPath);
    anim.duration               = [self transitionDuration:_context];
    anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate               = self;
    [maskLayer addAnimation:anim forKey:nil];
    
}

//push
- (void)CreatePushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC      = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView       = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    maskLayer.path              = BigPath.CGPath;
    toVC.view.layer.mask        = maskLayer;
    
    CABasicAnimation *anim      = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.fromValue              = (__bridge id)(SmallPath.CGPath);
    anim.toValue                = (__bridge id)((BigPath.CGPath));
    anim.duration               = [self transitionDuration:_context];
    anim.timingFunction         = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate               = self;
    [maskLayer addAnimation:anim forKey:nil];
}

#pragma  mark -- CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [_context completeTransition:YES];
    
    if(_Type == GGCircleTransitionTypePresentation || _Type == GGCircleTransitionTypePush){
        
        TwoVC *toVC                 = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.layer.mask        = nil;
        
    }else if(_Type == GGCircleTransitionTypeDissmiss || _Type == GGCircleTransitionTypePop){
        
        UIViewController *FromVC    = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        FromVC.view.layer.mask      = nil;
        
    }
}

@end
