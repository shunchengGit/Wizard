//
//  CSWizardUIDataManager.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardUIDataManager.h"

#pragma mark CSWizardUIDataManager

static NSString *kDefaultPlistPath;

@interface CSWizardUIDataManager ()

@property (nonatomic, copy) NSString *plistPath;
@property (nonatomic, assign) BOOL hasParesedData;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation CSWizardUIDataManager

+ (void)initialize {
    kDefaultPlistPath = [[NSBundle mainBundle] pathForResource:@"WizardConfig" ofType:@"plist"];
}

+ (CSWizardUIDataManager *)sharedInstance {
    static CSWizardUIDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSWizardUIDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.plistPath = kDefaultPlistPath;
    }
    return self;
}

- (void)setPlistFilePath:(NSString *)filePath {
    if (![_plistPath isEqualToString:filePath]) {
        self.plistPath = filePath;
        self.hasParesedData = NO;
    }
}

- (NSNumber *)wizardPageCount {
    [self p_ensureDataHasParsed];

    return @([_dataAry count]);
}

- (NSDictionary *)wizardInfoDicAtPageIndex:(NSInteger)index {
    [self p_ensureDataHasParsed];

    return _dataAry[index];
}

#pragma mark Private Mehtod

- (void)p_ensureDataHasParsed {
    if (!_hasParesedData) {
        NSString *plistPath = _plistPath ?: kDefaultPlistPath;
        self.dataAry = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        self.hasParesedData = YES;
    }
}

@end
