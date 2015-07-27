//
//  CSWizardViewFactory.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardViewFactory.h"

#import "CSWizardCommon.h"
#import "CSWizardBaseView.h"
#import "CSWizardSequenceAppearView.h"
#import "CSWizardUtils.h"

#pragma mark CSWizardMulScreenAdapter

@interface CSWizardMulScreenAdapter : NSObject

+ (CSWizardMulScreenAdapter *)sharedInstance;

- (void)adaptWizardStartUpObject:(CSWizardStartUpObject *)obj;
- (void)adaptWizardSequenceAppearItemInfo:(CSWizardSequenceAppearItemInfo *)item;

@end

@interface CSWizardMulScreenAdapter ()

@property (nonatomic, assign) CGFloat widthRatioToIp5;
@property (nonatomic, assign) CGFloat heightRatioToIp5;

@end

@implementation CSWizardMulScreenAdapter

+ (CSWizardMulScreenAdapter *)sharedInstance {
    static CSWizardMulScreenAdapter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSWizardMulScreenAdapter alloc] init];
    });
    return instance;
}

- (id)init {
    const float kIphone5Width = 320;
    const float kIphone5Height = 568;

    if (self = [super init]) {
        self.widthRatioToIp5 = [CSWizardUtils screenWidth] / kIphone5Width;
        self.heightRatioToIp5 = [CSWizardUtils screenHeight] / kIphone5Height;
    }
    return self;
}

- (void)adaptWizardStartUpObject:(CSWizardStartUpObject *)obj {
    if ([CSWizardUtils isScreen35]) {
        return;
    }

    obj.buttonFrame = [self p_adaptRect:obj.buttonFrame];
}

- (void)adaptWizardSequenceAppearItemInfo:(CSWizardSequenceAppearItemInfo *)item {
    if ([CSWizardUtils isScreen35]) {
        return;
    }

    item.imgLocationInScreen = [self p_adaptRect:item.imgLocationInScreen];
    if (item.sequenceAppearAnimationType == CSXPosChange) {
        item.fromValue *= self.widthRatioToIp5;
        item.toValue *= self.widthRatioToIp5;
    } else if (item.sequenceAppearAnimationType == CSYPosChange) {
        item.fromValue *= self.heightRatioToIp5;
        item.toValue *= self.heightRatioToIp5;
    }
}

#pragma mark Private Method

- (CGRect)p_adaptRect:(CGRect)rect {
    rect.origin = [self p_adaptPoint:rect.origin];
    rect.size = [self p_adaptSize:rect.size];
    return rect;
}

- (CGPoint)p_adaptPoint:(CGPoint)point {
    point.x *= _widthRatioToIp5;
    point.y *= _heightRatioToIp5;
    return point;
}

- (CGSize)p_adaptSize:(CGSize)size {
    size.width *= _widthRatioToIp5;
    size.height *= _heightRatioToIp5;
    return size;
}

@end

#pragma mark CSWizardViewInfoParser

@interface CSWizardViewObjectParser : NSObject

+ (CSWizardViewObjectParser *)sharedInstance;

- (CSWizardBaseViewObject *)parseWithInfoDic:(NSDictionary *)dic;

@end

@implementation CSWizardViewObjectParser

+ (CSWizardViewObjectParser *)sharedInstance {
    static CSWizardViewObjectParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSWizardViewObjectParser alloc] init];
    });
    return instance;
}

- (CSWizardBaseViewObject *)parseWithInfoDic:(NSDictionary *)dic {
    CSWizardViewType type = [self p_wizardViewTypeByInfoDic:dic];

    CSWizardBaseViewObject *baseObj;

    switch (type) {
        case CSWizardViewTypeSequence: {
            CSWizardSequenceAppearViewObject *obj = [[CSWizardSequenceAppearViewObject alloc] init];
            obj.sequenceAppearItemInfos = [self p_sequenceAppearItemInfosByInfoDic:dic];
            baseObj = obj;
            break;
        }
        case CSWizardViewTypeStatic:
        default: {
            CSWizardBaseViewObject *obj = [[CSWizardBaseViewObject alloc] init];
            baseObj = obj;
            break;
        }
    }

    baseObj.backgroundImageName = [self p_backgroundImageNameByInfoDic:dic];
    baseObj.viewType = type;
    baseObj.startUpObject = [self p_wizardStartUpObjectByInfoDic:dic];

    return baseObj;
}

#pragma mark Private Method

- (NSString *)p_backgroundImageNameByInfoDic:(NSDictionary *)infoDic {
    return infoDic[@"backgroundImageName"];
}

- (CSWizardViewType)p_wizardViewTypeByInfoDic:(NSDictionary *)infoDic {
    return (CSWizardViewType)[infoDic[@"viewType"] integerValue];
}

- (NSArray *)p_sequenceAppearItemInfosByInfoDic:(NSDictionary *)infoDic {
    NSDictionary *animationInfo = infoDic[@"animationInfo"];
    if (!animationInfo) {
        return nil;
    }

    NSArray *items = animationInfo[@"sequenceItem"];
    NSMutableArray *rtn = [[NSMutableArray alloc] initWithCapacity:[items count]];
    NSMutableArray *__weak weakRtn = rtn;

    [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        CSWizardSequenceAppearItemInfo *info = [[CSWizardSequenceAppearItemInfo alloc] init];

        info.imgName = [self p_imageNameOfPictureFromConfigName:obj[@"imgName"]];

        NSString *rectInBigPictureKey = @"imgRectInBigPictureForScreen4";
        info.imgRectInBigPicture = [CSWizardUtils rectFromString:(obj[rectInBigPictureKey])];

        NSString *locationInScreenKey = @"imgLocationInScreen4";
        info.imgLocationInScreen = [CSWizardUtils rectFromString:(obj[locationInScreenKey])];

        info.animationBeginTime = [obj[@"animationBeginTime"] floatValue];
        info.sequenceAppearAnimationType = [obj[@"sequenceAppearAnimationType"] intValue];
        info.animationDuration = [obj[@"animationDuration"] floatValue];
        info.fromValue = [obj[@"fromValue"] floatValue];
        info.toValue = [obj[@"toValue"] floatValue];

        [[CSWizardMulScreenAdapter sharedInstance] adaptWizardSequenceAppearItemInfo:info];

        [weakRtn addObject:info];
    }];

    return rtn;
}

- (CSWizardStartUpObject *)p_wizardStartUpObjectByInfoDic:(NSDictionary *)infoDic {
    NSString *key = @"startUpBtnNormalImageName";
    NSString *startUpBtnNormalImageName = [self p_imageNameOfPictureFromConfigName:infoDic[key]];
    if (!startUpBtnNormalImageName) {
        return nil;
    }

    key = @"startUpBtnHighlightImageName";
    NSString *startUpBtnHighlightImageName = [self p_imageNameOfPictureFromConfigName:infoDic[key]];
    if (!startUpBtnHighlightImageName) {
        return nil;
    }

    key = @"buttonFrame";
    NSString *buttonFrameString = infoDic[key];
    if (!buttonFrameString) {
        return nil;
    }

    CSWizardStartUpObject *obj = [[CSWizardStartUpObject alloc] init];
    obj.startUpBtnNormalImage = [UIImage imageNamed:startUpBtnNormalImageName];
    obj.startUpBtnHighlightImage = [UIImage imageNamed:startUpBtnHighlightImageName];
    obj.buttonFrame = [CSWizardUtils rectFromString:buttonFrameString];
    [[CSWizardMulScreenAdapter sharedInstance] adaptWizardStartUpObject:obj];

    return obj;
}

- (NSString *)p_imageNameOfPictureFromConfigName:(NSString *)configName {
    return configName;
}

@end

#pragma mark CSWizardViewFactory

@implementation CSWizardViewFactory

+ (CSWizardViewFactory *)sharedInstance {
    static CSWizardViewFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSWizardViewFactory alloc] init];
    });
    return instance;
}

+ (CSWizardBaseView *)createWizardViewWithInfoDic:(NSDictionary *)dic {
    CSWizardBaseViewObject *obj = [[CSWizardViewObjectParser sharedInstance] parseWithInfoDic:dic];
    CSWizardBaseView *view;
    switch (obj.viewType) {
        case CSWizardViewTypeSequence: {
            CSWizardSequenceAppearViewObject *sobj = (CSWizardSequenceAppearViewObject *)obj;
            view = [[CSWizardSequenceAppearView alloc] initWithObject:sobj];
            break;
        }

        case CSWizardViewTypeStatic:
        default: {
            view = [[CSWizardBaseView alloc] initWithObject:obj];
            break;
        }
    }

    view.bounds = CGRectMake(0, 0, [CSWizardUtils screenWidth], [CSWizardUtils screenHeight]);
    [view layout];
    return view;
}

@end
