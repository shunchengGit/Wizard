//
//  CSWizardViewFactory.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSWizardBaseView;

@interface CSWizardViewFactory : NSObject

+ (CSWizardViewFactory *)sharedInstance;

+ (CSWizardBaseView *)createWizardViewWithInfoDic:(NSDictionary *)dic;

@end
