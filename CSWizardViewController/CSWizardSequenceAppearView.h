//
//  CSWizardSequenceAppearView.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CSWizardBaseView.h"

typedef enum {
    CSOpacity = 1,
    CSXPosChange = 2,
    CSYPosChange = 3,
    CSRotation = 4,
} CSSequenceAppearAnimationType;

@interface CSWizardSequenceAppearItemInfo : NSObject

// image
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, assign) CGRect imgRectInBigPicture;
@property (nonatomic, assign) CGRect imgLocationInScreen;
// animation
@property (nonatomic, assign) CGFloat animationBeginTime;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CSSequenceAppearAnimationType sequenceAppearAnimationType;
@property (nonatomic, assign) CGFloat fromValue;
@property (nonatomic, assign) CGFloat toValue;

@end

@interface CSWizardSequenceAppearViewObject : CSWizardBaseViewObject

@property (nonatomic, strong) NSArray *sequenceAppearItemInfos;

@end

@interface CSWizardSequenceAppearView : CSWizardBaseView

- (instancetype)initWithObject:(CSWizardSequenceAppearViewObject *)viewObj;

@end
