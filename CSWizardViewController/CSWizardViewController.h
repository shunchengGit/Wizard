//
//  CSWizardViewController.h
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSWizardViewController : UIViewController

@property (nonatomic, copy) void (^enterAppBlock)();

@end