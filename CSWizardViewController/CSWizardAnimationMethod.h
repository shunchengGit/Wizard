//
//  CSWizardAnimationMethod.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CSWizardAnimationMethod : NSObject

+ (void)showResetAnimation:(UIView *)view;

// Avatar式弹出
+ (void)showPopupAnimation:(UIView *)view beginTime:(double)beginTime;

//透明渐变
+ (void)showOpaqueAnimationWithView:(UIView *)view
                          beginTime:(float)beginTime
                          fromValue:(float)fromVal
                            toValue:(float)toVal
                         inDuration:(float)duration
                            keyName:(NSString *)keyName;

// X位置变化
+ (void)showXPosChangeAnimationWithView:(UIView *)view
                              beginTime:(float)beginTime
                              fromValue:(float)fromVal
                                toValue:(float)toVal
                             inDuration:(float)duration
                                keyName:(NSString *)keyName;

// Y位置变化
+ (void)showYPosChangeAnimationWithView:(UIView *)view
                              beginTime:(float)beginTime
                              fromValue:(float)fromVal
                                toValue:(float)toVal
                             inDuration:(float)duration
                                keyName:(NSString *)keyName;

// 旋转
+ (void)showRotationAnimationWithView:(UIView *)view
                            beginTime:(float)beginTime
                            fromValue:(float)fromVal
                              toValue:(float)toVal
                           inDuration:(float)duration
                              keyName:(NSString *)keyName;

@end
