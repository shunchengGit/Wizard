//
//  CSWizardUtils.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardUtils.h"

#import <UIKit/UIKit.h>

@implementation CSWizardUtils

+ (BOOL)isScreen35 {
    return 320 == [self screenWidth] && 480 == [self screenHeight];
}

+ (BOOL)isScreen47 {
    return 375 == [self screenWidth] && 667 == [self screenHeight];
}

+ (BOOL)isScreen55 {
    return 414 == [self screenWidth] && 736 == [self screenHeight];
}

+ (NSInteger)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (NSInteger)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (BOOL)isAboveIOS7 {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

+ (CGRect)rectFromString:(NSString *)str {
    NSArray *ptAry = [str componentsSeparatedByString:@" "];

    CGRect rect;
    rect.origin.x = [ptAry[0] floatValue];
    rect.origin.y = [ptAry[1] floatValue];
    rect.size.width = [ptAry[2] floatValue];
    rect.size.height = [ptAry[3] floatValue];

    return rect;
}

+ (CGFloat)angleToRadian:(CGFloat)angleDegrees {
    return angleDegrees * M_PI / 180.0;
}

@end
