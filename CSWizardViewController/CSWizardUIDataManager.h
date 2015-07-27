//
//  CSWizardUIDataManager.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CSWizardCommon.h"

@interface CSWizardUIDataManager : NSObject

+ (CSWizardUIDataManager *)sharedInstance;

- (void)setPlistFilePath:(NSString *)filePath;

- (NSNumber *)wizardPageCount;
- (NSDictionary *)wizardInfoDicAtPageIndex:(NSInteger)index;

@end
