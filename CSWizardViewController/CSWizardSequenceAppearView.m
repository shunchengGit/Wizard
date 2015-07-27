//
//  CSWizardSequenceAppearView.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardSequenceAppearView.h"

#import "CSWizardAnimationMethod.h"

#pragma mark CSWizardSequenceAppearItemInfo

@implementation CSWizardSequenceAppearItemInfo

@end

#pragma mark CSWizardSequenceAppearViewObject

@implementation CSWizardSequenceAppearViewObject

@end

#pragma mark CSWizardSequenceAppearView

@interface CSWizardSequenceAppearView ()

@property (nonatomic, strong) CSWizardSequenceAppearViewObject *viewObj;
@property (nonatomic, strong) NSMutableArray* animationImgViews;

@end

@implementation CSWizardSequenceAppearView

- (instancetype)initWithObject:(CSWizardSequenceAppearViewObject *)viewObj {
    if (self = [super initWithObject:viewObj]) {
        self.viewObj = viewObj;
    }
    return self;
}

- (void)layout {
    [super layout];
    
    if (!_animationImgViews) {
        self.animationImgViews = [[NSMutableArray alloc] initWithCapacity:3];
    }
    [_animationImgViews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];

    for (CSWizardSequenceAppearItemInfo *info in _viewObj.sequenceAppearItemInfos) {
        UIImage *bigImg = [UIImage imageNamed:info.imgName];
        UIImageView *view = [[UIImageView alloc] initWithImage:bigImg];
        view.frame = info.imgLocationInScreen;
        view.backgroundColor = [UIColor clearColor];
        [_animationImgViews addObject:view];
        [self.elementView addSubview:view];
    }
}

- (void)p_showExtraAppearAnimation {
    CSWizardSequenceAppearView *__weak weakSelf = self;

    [_animationImgViews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger ix, BOOL *stop) {
        CSWizardSequenceAppearItemInfo *info = (weakSelf.viewObj.sequenceAppearItemInfos)[ix];

        if (info.sequenceAppearAnimationType == CSOpacity) {
            [CSWizardAnimationMethod showOpaqueAnimationWithView:obj
                                                       beginTime:info.animationBeginTime
                                                       fromValue:info.fromValue
                                                         toValue:info.toValue
                                                      inDuration:info.animationDuration
                                                         keyName:@"appear"];
        } else if (info.sequenceAppearAnimationType == CSYPosChange) {
            [CSWizardAnimationMethod showYPosChangeAnimationWithView:obj
                                                           beginTime:info.animationBeginTime
                                                           fromValue:info.fromValue
                                                             toValue:info.toValue
                                                          inDuration:info.animationDuration
                                                             keyName:@"appear"];
        } else if (info.sequenceAppearAnimationType == CSXPosChange) {
            [CSWizardAnimationMethod showXPosChangeAnimationWithView:obj
                                                           beginTime:info.animationBeginTime
                                                           fromValue:info.fromValue
                                                             toValue:info.toValue
                                                          inDuration:info.animationDuration
                                                             keyName:@"appear"];
        } else if (info.sequenceAppearAnimationType == CSRotation) {
            [CSWizardAnimationMethod showRotationAnimationWithView:obj
                                                         beginTime:info.animationBeginTime
                                                         fromValue:info.fromValue
                                                           toValue:info.toValue
                                                        inDuration:info.animationDuration
                                                           keyName:@"appear"];
        }
    }];
}

- (void)p_showExtraResetAnimation {
    CSWizardSequenceAppearView *__weak weakSelf = self;

    [_animationImgViews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger ix, BOOL *stop) {
        CSWizardSequenceAppearItemInfo *info = (weakSelf.viewObj.sequenceAppearItemInfos)[ix];

        if (info.sequenceAppearAnimationType == CSOpacity) {
            [CSWizardAnimationMethod showOpaqueAnimationWithView:obj
                                                       beginTime:0
                                                       fromValue:info.toValue
                                                         toValue:info.fromValue
                                                      inDuration:0.1
                                                         keyName:@"reset"];
        } else if (info.sequenceAppearAnimationType == CSYPosChange) {
            [CSWizardAnimationMethod showYPosChangeAnimationWithView:obj
                                                           beginTime:0
                                                           fromValue:info.toValue
                                                             toValue:info.fromValue
                                                          inDuration:0.1
                                                             keyName:@"reset"];
        } else if (info.sequenceAppearAnimationType == CSXPosChange) {
            [CSWizardAnimationMethod showXPosChangeAnimationWithView:obj
                                                           beginTime:0
                                                           fromValue:info.toValue
                                                             toValue:info.fromValue
                                                          inDuration:0.1
                                                             keyName:@"reset"];
        } else if (info.sequenceAppearAnimationType == CSRotation) {
            [CSWizardAnimationMethod showRotationAnimationWithView:obj
                                                         beginTime:0
                                                         fromValue:info.toValue
                                                           toValue:info.fromValue
                                                        inDuration:0.1
                                                           keyName:@"reset"];
        }
    }];
}

@end
