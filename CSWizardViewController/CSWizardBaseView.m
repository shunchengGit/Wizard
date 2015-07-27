//
//  CSWizardBaseView.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardBaseView.h"

#import "CSWizardUtils.h"

#pragma mark CSWizardStartUpObject

@implementation CSWizardStartUpObject

@end

#pragma mark CSWizardBaseViewObject

@implementation CSWizardBaseViewObject

@end

#pragma mark CSWizardBaseView

@interface CSWizardBaseView () {
    BOOL _isStartupView;
}


@property (nonatomic, strong) CSWizardBaseViewObject *baseViewObj;
@property (nonatomic, weak) UIButton *startupButton;

@end

@implementation CSWizardBaseView

- (instancetype)initWithObject:(CSWizardBaseViewObject *)viewObj {
    if (self = [super init]) {
        self.baseViewObj = viewObj;
    }
    return self;
}

- (BOOL)isStartupView {
    return _isStartupView;
}

- (void)layout {
    UIImage *image = [UIImage imageNamed:self.baseViewObj.backgroundImageName];
    UIImageView *ivBkg = [[UIImageView alloc] initWithImage:image];
    ivBkg.frame = self.bounds;
    [self insertSubview:ivBkg atIndex:0];

    [self setBackgroundColor:[UIColor clearColor]];
    [self p_buildElementView];
    [self p_buildStartupButton];
}

- (void)p_buildElementView {
    if (!_elementView) {
        UIView *view = [[UIView alloc] init];
        self.elementView = view;
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.origin.y = [CSWizardUtils isScreen35] ? -60 : 0;
        _elementView.frame = frame;
        _elementView.backgroundColor = [UIColor clearColor];
        [self addSubview:_elementView];
        //更新view的高度，让启动按钮在点击区域之内
        CGFloat newHight = _elementView.frame.size.height - frame.origin.y;
        CGRect newRect = _elementView.frame;
        newRect.size.height = newHight;
        _elementView.frame = newRect;
    }
}

- (void)p_buildStartupButton {
    if (!_startupButton && self.baseViewObj.startUpObject) {
        UIButton *btn;

        CGRect btnRect = self.baseViewObj.startUpObject.buttonFrame;
        btn = [[UIButton alloc] initWithFrame:btnRect];

        self.startupButton = btn;
        [_startupButton setBackgroundImage:self.baseViewObj.startUpObject.startUpBtnNormalImage
                                  forState:UIControlStateNormal];
        [_startupButton setBackgroundImage:self.baseViewObj.startUpObject.startUpBtnHighlightImage
                                  forState:UIControlStateHighlighted];

        [_startupButton addTarget:self
                           action:@selector(p_onStartupButtonClicked:)
                 forControlEvents:UIControlEventTouchUpInside];

        [_elementView addSubview:_startupButton];
    }
}

- (void)showAppearAnimation {
    [self p_showExtraAppearAnimation];
}

- (void)p_showExtraAppearAnimation {
}

- (void)showResetAnimation {
    [self p_showExtraResetAnimation];
}

- (void)p_showExtraResetAnimation {
}

#pragma mark Callback

- (void)p_onStartupButtonClicked:(id)sender {
    if (_enterAppBlk) {
        _enterAppBlk();
    }
}

@end
