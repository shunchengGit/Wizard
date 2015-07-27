//
//  CSWizardBaseView.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSWizardCommon.h"

@interface CSWizardStartUpObject : NSObject

@property (nonatomic, strong) UIImage *startUpBtnNormalImage;
@property (nonatomic, strong) UIImage *startUpBtnHighlightImage;
@property (nonatomic, assign) CGRect buttonFrame;

@end

@interface CSWizardBaseViewObject : NSObject

@property (nonatomic, copy) NSString *backgroundImageName;
@property (nonatomic, assign) CSWizardViewType viewType;
@property (nonatomic, strong) CSWizardStartUpObject *startUpObject;

@end

@interface CSWizardBaseView : UIView

- (instancetype)initWithObject:(CSWizardBaseViewObject *)viewObj;

//元素所在的view，为了做多屏幕适配
@property (nonatomic, weak) UIView *elementView;
@property (nonatomic, readonly, assign) BOOL isStartupView;
@property (nonatomic, copy) void (^enterAppBlk)();

- (void)layout;

- (void)showAppearAnimation;
- (void)showResetAnimation;

@end
