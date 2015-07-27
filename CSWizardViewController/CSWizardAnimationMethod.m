//
//  CSWizardAnimationMethod.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardAnimationMethod.h"

#import "CSWizardUtils.h"

@implementation CSWizardAnimationMethod

+ (void)showResetAnimation:(UIView *)view {
    CABasicAnimation *scaleInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleInAnimation setBeginTime:0];
    [scaleInAnimation setFromValue:[NSNumber numberWithDouble:1.0]];
    [scaleInAnimation setToValue:[NSNumber numberWithDouble:0.0]];
    [scaleInAnimation setDuration:0.1];
    [scaleInAnimation setFillMode:kCAFillModeForwards];
    scaleInAnimation.removedOnCompletion = NO;
    scaleInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:scaleInAnimation forKey:@"test"];
}

// Avatar式弹出
+ (void)showPopupAnimation:(UIView *)view beginTime:(double)beginTime {
    CABasicAnimation *scaleInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleInAnimation setBeginTime:beginTime];
    [scaleInAnimation setFromValue:[NSNumber numberWithDouble:0.0]];
    [scaleInAnimation setToValue:[NSNumber numberWithDouble:1.0]];
    [scaleInAnimation setDuration:0.3];
    [scaleInAnimation setFillMode:kCAFillModeForwards];
    scaleInAnimation.removedOnCompletion = NO;
    scaleInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    CABasicAnimation *scaleInAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleInAnimation2 setBeginTime:beginTime + 0.3];
    [scaleInAnimation2 setFromValue:[NSNumber numberWithDouble:1.0]];
    [scaleInAnimation2 setToValue:[NSNumber numberWithDouble:0.9]];
    [scaleInAnimation2 setDuration:0.3];
    [scaleInAnimation2 setFillMode:kCAFillModeForwards];
    scaleInAnimation2.removedOnCompletion = NO;
    scaleInAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    CABasicAnimation *scaleInAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleInAnimation3 setBeginTime:beginTime + 0.3 + 0.3];
    [scaleInAnimation3 setFromValue:[NSNumber numberWithDouble:0.9]];
    [scaleInAnimation3 setToValue:[NSNumber numberWithDouble:1.0]];
    [scaleInAnimation3 setDuration:0.3];
    [scaleInAnimation3 setFillMode:kCAFillModeForwards];
    scaleInAnimation3.removedOnCompletion = NO;
    scaleInAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    theGroup.animations = [NSArray arrayWithObjects:scaleInAnimation, scaleInAnimation2, scaleInAnimation3, nil];
    theGroup.duration = 2;
    theGroup.delegate = self;
    theGroup.fillMode = kCAFillModeForwards;
    theGroup.removedOnCompletion = NO;

    [view.layer addAnimation:theGroup forKey:nil];
}

//透明渐变
+ (void)showOpaqueAnimationWithView:(UIView *)view
                          beginTime:(float)beginTime
                          fromValue:(float)fromVal
                            toValue:(float)toVal
                         inDuration:(float)duration
                            keyName:(NSString *)keyName {
    [self p_showAnimationWithKeyPath:@"opacity"
                                view:view
                           beginTime:beginTime
                           fromValue:fromVal
                             toValue:toVal
                          inDuration:duration
                             keyName:keyName];
}

// X位置变化
+ (void)showXPosChangeAnimationWithView:(UIView *)view
                              beginTime:(float)beginTime
                              fromValue:(float)fromVal
                                toValue:(float)toVal
                             inDuration:(float)duration
                                keyName:(NSString *)keyName {
    [self p_showAnimationWithKeyPath:@"position.x"
                                view:view
                           beginTime:beginTime
                           fromValue:fromVal
                             toValue:toVal
                          inDuration:duration
                             keyName:keyName];
}

// Y位置变化
+ (void)showYPosChangeAnimationWithView:(UIView *)view
                              beginTime:(float)beginTime
                              fromValue:(float)fromVal
                                toValue:(float)toVal
                             inDuration:(float)duration
                                keyName:(NSString *)keyName {
    [self p_showAnimationWithKeyPath:@"position.y"
                                view:view
                           beginTime:beginTime
                           fromValue:fromVal
                             toValue:toVal
                          inDuration:duration
                             keyName:keyName];
}

// 旋转
+ (void)showRotationAnimationWithView:(UIView *)view
                            beginTime:(float)beginTime
                            fromValue:(float)fromVal
                              toValue:(float)toVal
                           inDuration:(float)duration
                              keyName:(NSString *)keyName {
    [self p_showAnimationWithKeyPath:@"transform.rotation.z"
                                view:view
                           beginTime:beginTime
                           fromValue:[CSWizardUtils angleToRadian:fromVal]
                             toValue:[CSWizardUtils angleToRadian:toVal]
                          inDuration:duration
                             keyName:keyName];
}

#pragma mark Private Method

+ (void)p_showAnimationWithKeyPath:(NSString *)keyPath
                              view:(UIView *)view
                         beginTime:(float)beginTime
                         fromValue:(float)fromVal
                           toValue:(float)toVal
                        inDuration:(float)duration
                           keyName:(NSString *)keyName {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:keyPath];
    [opacityAnimation setBeginTime:CACurrentMediaTime() + beginTime];
    [opacityAnimation setFromValue:[NSNumber numberWithDouble:fromVal]];
    [opacityAnimation setToValue:[NSNumber numberWithDouble:toVal]];
    [opacityAnimation setDuration:duration];
    [opacityAnimation setFillMode:kCAFillModeForwards];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:opacityAnimation forKey:keyName];
}

@end
