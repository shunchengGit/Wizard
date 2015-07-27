//
//  CSWizardUtils.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CSWizardUtils : NSObject

// device
+ (BOOL)isScreen35;
+ (BOOL)isScreen47;
+ (BOOL)isScreen55;

+ (NSInteger)screenHeight;
+ (NSInteger)screenWidth;
+ (BOOL)isAboveIOS7;

+ (CGRect)rectFromString:(NSString *)str;
+ (CGFloat)angleToRadian:(CGFloat)angleDegrees;

@end
