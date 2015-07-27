//
//  CSWizardViewController.m
//  Wizard
//
//  Created by shun.cheng on 15/7/27.
//  Copyright (c) 2015年 shun.cheng. All rights reserved.
//

#import "CSWizardViewController.h"

#import "CSWizardBaseView.h"
#import "CSWizardSequenceAppearView.h"
#import "CSWizardViewFactory.h"
#import "CSWizardUIDataManager.h"
#import "CSWizardUtils.h"

#define WIZARD_VIEW_HIGHT ([UIScreen mainScreen].bounds.size.height)
#define WIZARD_VIEW_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface CSWizardViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *wizardViews;

@end

@implementation CSWizardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    [self p_buildUIElement];

    [_wizardViews enumerateObjectsUsingBlock:^(CSWizardBaseView *view, NSUInteger idx, BOOL *stop) {
        [view showResetAnimation];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CSWizardBaseView *firstView = [_wizardViews firstObject];
    [firstView showAppearAnimation];
}

#pragma mark Builde UI Element

- (void)p_buildUIElement {
    [self p_buildScrollView];
    [self p_buildPageControl];
    [self p_buildWizardViews];
}

- (void)p_buildScrollView {
    UIScrollView *strongScrollView =
        [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIZARD_VIEW_WIDTH, WIZARD_VIEW_HIGHT)];
    self.scrollView = strongScrollView;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.contentSize = CGSizeMake(
        WIZARD_VIEW_WIDTH * [[[CSWizardUIDataManager sharedInstance] wizardPageCount] integerValue], WIZARD_VIEW_HIGHT);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_scrollView];
}

- (void)p_buildPageControl {
    int yPos = WIZARD_VIEW_HIGHT - ([CSWizardUtils isAboveIOS7] ? 30 : 50);
    int xPos = [CSWizardUtils isScreen55] ? 165 : [CSWizardUtils isScreen47] ? 145 : 115;

    UIPageControl *strongPageControl;
    strongPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(xPos, yPos, 85, 15)];

    self.pageControl = strongPageControl;
    _pageControl.numberOfPages = [[[CSWizardUIDataManager sharedInstance] wizardPageCount] integerValue];
    _pageControl.enabled = NO;
    _pageControl.isAccessibilityElement = NO;
    _pageControl.currentPage = 0;
    _pageControl.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5];
    _pageControl.layer.cornerRadius = 6.0f;
    _pageControl.layer.masksToBounds = YES;
    [self.view addSubview:_pageControl];
}

- (void)p_buildWizardViews {
    NSInteger pageCnt = [[[CSWizardUIDataManager sharedInstance] wizardPageCount] integerValue];

    self.wizardViews = [[NSMutableArray alloc] initWithCapacity:pageCnt];

    for (int i = 0; i != pageCnt; ++i) {
        NSDictionary *dic = [[CSWizardUIDataManager sharedInstance] wizardInfoDicAtPageIndex:i];
        CSWizardBaseView *wizardView = [CSWizardViewFactory createWizardViewWithInfoDic:dic];
        // add view to scrollview
        wizardView.frame = CGRectMake(WIZARD_VIEW_WIDTH * i, 0, WIZARD_VIEW_WIDTH, WIZARD_VIEW_HIGHT);
        [_scrollView addSubview:wizardView];

        // add view to array
        [self.wizardViews addObject:wizardView];

        if (wizardView.isStartupView) {
            __weak __typeof(&*self) weakSelf = self;
            wizardView.enterAppBlk = ^{
                if (weakSelf.enterAppBlock) {
                    weakSelf.enterAppBlock();
                }
            };
        }
    }
}

- (NSInteger)p_calcCurrentPage {
    CGFloat pageWidth = WIZARD_VIEW_WIDTH;
    NSInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    return page;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger prevPage = self.pageControl.currentPage;
    NSInteger curPage = [self p_calcCurrentPage];

    _pageControl.currentPage = curPage;
    if (prevPage == curPage) {
        return;
    }

    NSInteger pageCnt = [[[CSWizardUIDataManager sharedInstance] wizardPageCount] integerValue];

    if ([CSWizardUtils isScreen35]) {
        _pageControl.hidden = curPage == pageCnt - 1;
    }

    [_wizardViews[curPage] showAppearAnimation];
    [_wizardViews[prevPage] showResetAnimation];
}

@end
