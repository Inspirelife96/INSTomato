//
//  INSTomatoViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import "INSTomatoViewController.h"

#import "INSTaskPageViewController.h"

#import "INSBookmarkViewController.h"

#import "INSTomatoConfiguration.h"

#import "INSCopyScreenManager.h"

#import "INSNotificationConstants.h"

#import "INSTomatoTimer.h"

#import "INSTaskModel.h"

#import "INSTaskTableManager.h"

#import "INSTomatoClockView.h"

#import "INSTomatoConfigurationTableManager.h"


#import "INSTaskListViewController.h"
#import "INSStatisticsTodayViewController.h"

#import "INSBookmarkTableManager.h"
#import "INSBookmarkModel.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

#import "INSTomatoBundle.h"

@interface INSTomatoViewController () <UIScrollViewDelegate, AVAudioPlayerDelegate>

// 背景图片视图，用来展示必应每日图片
@property(nonatomic, strong) UIImageView *backgroundImageView;

// 滚动视图，用来不同的任务
@property(nonatomic, strong) UIScrollView *taskPageView;
@property(nonatomic, strong) UIPageControl *pageControl;

// 四周的按钮
@property(nonatomic, strong) UIButton *taskButton;
@property(nonatomic, strong) UIButton *statisticsButton;
@property(nonatomic, strong) UIButton *bookmarkButton;
//@property(nonatomic, strong) UIButton *settingButton;
@property(nonatomic, strong) UIButton *closeButton;

//
@property(nonatomic, strong) UIButton *topLeftButton;
@property(nonatomic, strong) UIButton *topRightButton;
@property(nonatomic, strong) UIButton *bottomLeftButton;
@property(nonatomic, strong) UIButton *bottomRightButton;

// 番茄闹钟控制按钮
@property(nonatomic, strong) UIButton *startButton;
@property(nonatomic, strong) UIButton *pauseButton;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIButton *resumeButton;
@property(nonatomic, strong) UIButton *skipButton; // 休息模式可以跳过

// pageViewController的子控制器
@property(nonatomic, strong) NSMutableArray *taskPageViewControllers;

// 任务一览
@property(nonatomic, strong) NSArray *taskIds;

// 当前任务
@property(nonatomic, strong) INSTaskModel *currentTaskModel;

//@property (nonatomic, strong) INSTomatoConfiguration *tomatoConfiguration;

@end

@implementation INSTomatoViewController

#pragma mark - Life Cycle

//- (instancetype)initWithTomatoConfiguration:(INSTomatoConfiguration *)tomatoConfiguration {
//    if (self = [super init]) {
//        _tomatoConfiguration = tomatoConfiguration;
//    }
//
//    return self;
//}

- (UIButton *)fetchPluginButtonByPluginType:(INSSupportedPluginType)pluginType {
    switch (pluginType) {
        case INSSupportedPluginTypeClose:
            return self.closeButton;
            
        case INSSupportedPluginTypeTask:
            return self.taskButton;

        case INSSupportedPluginTypeStatistics:
            return self.statisticsButton;

//        case INSSupportedPluginTypeSetting:
//            return self.settingButton;

        case INSSupportedPluginTypeBookmark:
            return self.bookmarkButton;
            
        case INSSupportedPluginTypeNone:
            return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildUI];
    
    [self updateButtonsUI];
    
    [self updateTaskPageViewControllers];
    
    [self registerNotifications];
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerStart) name:kNotificationTomatoTimerStart object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerCancel) name:kNotificationTomatoTimerCancel object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerResume) name:kNotificationTomatoTimerResume object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerPause) name:kNotificationTomatoTimerPause object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerSkip) name:kNotificationTomatoTimerSkip object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerUpdate) name:kNotificationTomatoTimerUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tomatoTimerComplete) name:kNotificationTomatoTimerComplete object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskTableChanged) name:kNotificationTaskTableSaved object:nil];
}

- (void)buildUI {
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:FlatWhite];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self.view addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, -20, 0, -20));
    }];
    
    [self.view addSubview:self.taskPageView];
    [self.taskPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        [self.taskPageView setContentSize:CGSizeMake(CGRectGetWidth(self.taskPageView.frame) * self.taskIds.count, CGRectGetHeight(self.taskPageView.frame))];
    }];
    
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(12);
        } else {
            make.top.equalTo(self.view.mas_top).with.offset(12);
        }
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(screenWidth - 42 * 2);
    }];
    
    _topLeftButton = [self fetchPluginButtonByPluginType:[[INSTomatoConfigurationTableManager sharedInstance] topLeftPluginType]];
    _topRightButton = [self fetchPluginButtonByPluginType:[[INSTomatoConfigurationTableManager sharedInstance] topRightPluginType]];
    _bottomLeftButton = [self fetchPluginButtonByPluginType:[[INSTomatoConfigurationTableManager sharedInstance] bottomLeftPluginType]];
    _bottomRightButton = [self fetchPluginButtonByPluginType:[[INSTomatoConfigurationTableManager sharedInstance] bottomRightPluginType]];

    if (self.topLeftButton) {
        [self.view addSubview:self.topLeftButton];
        [self.topLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(12);
            } else {
                make.top.equalTo(self.view.mas_top).with.offset(12);
            }
            make.left.equalTo(self.view.mas_left).with.offset(12);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(28);
        }];
    }
    
    if (self.topRightButton) {
        [self.view addSubview:self.topRightButton];
        [self.topRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(12);
            } else {
                make.top.equalTo(self.view.mas_top).with.offset(12);
            }
            make.right.equalTo(self.view.mas_right).with.offset(-12);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(28);
        }];
    }
    

    if (self.bottomLeftButton) {
        [self.view addSubview:self.bottomLeftButton];
        [self.bottomLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).with.offset(-12);
            } else {
                make.bottom.equalTo(self.view.mas_bottom).with.offset(-12);
            }
            make.left.equalTo(self.view.mas_left).with.offset(12);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(28);
        }];
    }
    
    if (self.bottomRightButton) {
        [self.view addSubview:self.bottomRightButton];
        [self.bottomRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).with.offset(-12);
            } else {
                make.bottom.equalTo(self.view.mas_bottom).with.offset(-12);
            }
            make.right.equalTo(self.view.mas_right).with.offset(-12);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(28);
        }];
    }
    
    [self.view addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, screenHeight/5));
        make.width.mas_equalTo(2*screenWidth/5);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.pauseButton];
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, screenHeight/5));
        make.width.mas_equalTo(screenWidth/4);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(screenWidth/10 + 5, screenHeight/5));
        make.width.mas_equalTo(screenWidth/5);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.resumeButton];
    [self.resumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(-screenWidth/10 - 5, screenHeight/5));
        make.width.mas_equalTo(screenWidth/5);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.skipButton];
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.startButton.mas_bottom).with.offset(10);
        make.width.mas_equalTo(2*screenWidth/5);
        make.height.mas_equalTo(40);
    }];
}

- (void)updateProgress {
    INSTomatoClockView *clockView = [self currentClockView];
    [clockView updateProgress];
}

- (void)startHalo {
    INSTomatoClockView *clockView = [self currentClockView];
    [clockView startHalo];
}

- (void)endHalo {
    INSTomatoClockView *clockView = [self currentClockView];
    [clockView endHalo];
}

- (INSTomatoClockView *)currentClockView {
    NSInteger page = self.pageControl.currentPage;
    INSTaskPageViewController *taskPageVC = [self.taskPageViewControllers objectAtIndex:page];
    
    return taskPageVC.tomatoClockView;
}

- (void)tomatoTimerStart {
    [self updateButtonsUI];
    [self updatePluginButtonUI];
    [self updateProgress];
    [self disablePageable];
    [self startHalo];
}

- (void)tomatoTimerPause {
    [self updateButtonsUI];
    [self updateProgress];
    [self endHalo];
}

- (void)tomatoTimerResume {
    [self updateButtonsUI];
    [self updateProgress];
    [self startHalo];
}

- (void)tomatoTimerCancel {
    [self updateButtonsUI];
    [self updatePluginButtonUI];
    [self updateProgress];
    [self enablePageable];
}

- (void)tomatoTimerSkip {
    [self updateButtonsUI];
    [self updatePluginButtonUI];
    [self updateProgress];
    [self endHalo];
    [self enablePageable];
}

- (void)tomatoTimerUpdate {
    //[self updateButtonsUI];
    [self updateProgress];
}

- (void)tomatoTimerComplete {
    [self updateButtonsUI];
    [self updatePluginButtonUI];
    [self updateProgress];
    [self endHalo];
    
    if ([INSTomatoTimer sharedInstance].tomatoTimerMode == INSTomatoTimerModeWork) {
        [self enablePageable];
    }
}

- (void)taskTableChanged {
    [self updateTaskPageViewControllers];
}

- (void)disablePageable {
    [self.pageControl setHidden:YES];
    [self.taskPageView setScrollEnabled:NO];
}

- (void)enablePageable {
    [self.pageControl setHidden:NO];
    [self.taskPageView setScrollEnabled:YES];
}

- (void)updatePluginButtonUI {
    INSTomatoTimerStatus timerStatus = [INSTomatoTimer sharedInstance].tomatoTimerStatus;
    
    if (timerStatus == INSTomatoTimerStatusStop) {
        [self.taskButton setHidden:NO];
        [self.statisticsButton setHidden:NO];
        [self.bookmarkButton setHidden:NO];
    } else {
        [self.taskButton setHidden:YES];
        [self.statisticsButton setHidden:YES];
        [self.bookmarkButton setHidden:YES];
    }
}

- (void)updateButtonsUI {
    INSTomatoTimerStatus timerStatus = [INSTomatoTimer sharedInstance].tomatoTimerStatus;
    INSTomatoTimerMode timerMode = [INSTomatoTimer sharedInstance].tomatoTimerMode;
    
    switch (timerStatus) {
        case INSTomatoTimerStatusStop:
            [self.startButton setHidden:NO];
            [self.pauseButton setHidden:YES];
            [self.cancelButton setHidden:YES];
            [self.resumeButton setHidden:YES];
            [self.skipButton setHidden:YES];

            break;

        case INSTomatoTimerStatusRunning:
            [self.startButton setHidden:YES];
            [self.cancelButton setHidden:YES];
            [self.resumeButton setHidden:YES];
            
            if (timerMode == INSTomatoTimerModeWork) {
                [self.pauseButton setHidden:NO];
                [self.skipButton setHidden:YES];
            } else {
                [self.pauseButton setHidden:YES];
                [self.skipButton setHidden:NO];
            }
            
            break;
            
        case INSTomatoTimerStatusPause:
            [self.startButton setHidden:YES];
            [self.pauseButton setHidden:YES];
            [self.cancelButton setHidden:NO];
            [self.resumeButton setHidden:NO];
            [self.skipButton setHidden:YES];
            break;
        default:
            break;
    }
    
    if (timerMode == INSTomatoTimerModeWork) {
        [_startButton setBackgroundColor:FlatRed];
    } else {
        [_startButton setBackgroundColor:FlatGreen];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [[ILDStoryDataCenter sharedInstance] addObserver:self forKeyPath:@"storyDataDictionary" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [[ILDStoryDataCenter sharedInstance] removeObserver:self forKeyPath:@"storyDataDictionary"];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerStart object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerCancel object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerResume object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerPause object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerSkip object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerUpdate object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTomatoTimerComplete object:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)loadScrollViewWithPage:(NSUInteger)page {
    if (page >= self.taskIds.count) {
        return;
    }
    
    // replace the placeholder if necessary
    INSTaskPageViewController *taskPageVC = [self.taskPageViewControllers objectAtIndex:page];
    if ((NSNull *)taskPageVC == [NSNull null]) {
        taskPageVC = [[INSTaskPageViewController alloc] initWithTaskId:self.taskIds[page]];
        [self.taskPageViewControllers replaceObjectAtIndex:page withObject:taskPageVC];
    }
    
    // add the controller's view to the scroll view
    if (taskPageVC.view.superview == nil) {
        CGRect frame = self.taskPageView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        taskPageVC.view.frame = frame;
        
        [self addChildViewController:taskPageVC];
        [self.taskPageView addSubview:taskPageVC.view];
        [taskPageVC didMoveToParentViewController:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(self.taskPageView.frame);
    NSUInteger page = floor((self.taskPageView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    INSTaskModel *taskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:self.taskIds[page]];
    
    [[INSTomatoTimer sharedInstance] updateTomatoTimerWithTaskModel:taskModel];
}

- (void)gotoPage:(BOOL)animated {
    NSInteger page = self.pageControl.currentPage;
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    CGRect bounds = self.taskPageView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.taskPageView scrollRectToVisible:bounds animated:animated];
    
    INSTaskModel *taskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:self.taskIds[page]];
    
    [[INSTomatoTimer sharedInstance] updateTomatoTimerWithTaskModel:taskModel];
}

#pragma mark - Custom Delegate


#pragma mark - Notifications / KVOs

- (void)applicationWillEnterBackground:(NSNotification *)notification {
    if (self.currentTaskModel.isFocusModeEnabled) {
        [[INSTomatoTimer sharedInstance] cancelTimer];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    ILDStoryModel *storyModel = [[ILDStoryDataCenter sharedInstance] prepareStoryModel];
//    self.backgroundImageView.image = [UIImage imageWithData:storyModel.imageData];
}

#pragma mark - Event

- (void)clickTaskButton:(id)sender {
    [[INSCopyScreenManager sharedInstance] copyScreen:self.view];
    
    INSTaskListViewController *taskListVC = [[INSTaskListViewController alloc] init];
    //taskListVC.isAddTaskEnabled = [[INSTaskTableManager sharedInstance] isAddTaskEnabled];
    UINavigationController *taskListNC = [[UINavigationController alloc] initWithRootViewController:taskListVC];
    taskListNC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:taskListNC animated:YES completion:nil];
}

- (void)clickStatisticsButton:(id)sender {
    [[INSCopyScreenManager sharedInstance] copyScreen:self.view];
    
    INSStatisticsTodayViewController *statisticsTodayVC = [[INSStatisticsTodayViewController alloc] init];
    UINavigationController *statisticsTodayNC = [[UINavigationController alloc] initWithRootViewController:statisticsTodayVC];
    statisticsTodayNC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:statisticsTodayNC animated:YES completion:nil];
}

- (void)clickBookmarkButton:(id)sender {
    INSBookmarkViewController *bookmarkVC = [[INSBookmarkViewController alloc] init];
    bookmarkVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:bookmarkVC animated:YES completion:nil];
}

- (void)clickSettingButton:(id)sender {
    [[INSCopyScreenManager sharedInstance] copyScreen:self.view];

//
//    ILDSettingViewController *settingVC = [[ILDSettingViewController alloc] init];
//    UINavigationController *settingNC = [[UINavigationController alloc] initWithRootViewController:settingVC];
//    settingNC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:settingNC animated:YES completion:nil];
}

- (void)clickCloseButton:(id)sender {
    //如果当前就是rootVC，那这个按钮就没有什么用了，发出警告。
    if (self == [UIApplication sharedApplication].keyWindow.rootViewController) {
        NSLog(@"当前就是跟RootVC，不应该添加关闭按钮");
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:nil];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setTintColor:nil];
}

- (void)clickStartButton:(id)sender {
    [[INSTomatoTimer sharedInstance] startTimer];
}

- (void)clickPauseButton:(id)sender {
    [[INSTomatoTimer sharedInstance] pauseTimer];
}

- (void)clickCancelButton:(id)sender {
    [[INSTomatoTimer sharedInstance] cancelTimer];
}

- (void)clickResumeButton:(id)sender {
    [[INSTomatoTimer sharedInstance] resumeTimer];
}

- (void)clickSkipButton:(id)sender {
    [[INSTomatoTimer sharedInstance] skipTimer];
}

- (void)pageValueChanged:(id)sender {
    [self gotoPage:YES];
}

#pragma mark - Private Method

- (void)updateTaskPageViewControllers {
    NSInteger page = self.pageControl.currentPage;
    
    self.taskIds = [[INSTaskTableManager sharedInstance] taskIds];
    self.pageControl.numberOfPages = self.taskIds.count;
    self.pageControl.currentPage = (page < self.taskIds.count) ? page : self.taskIds.count;
    
    self.taskPageView.contentSize = CGSizeMake(CGRectGetWidth(self.taskPageView.frame) * self.taskIds.count, CGRectGetHeight(self.taskPageView.frame));
    
    for (UIView *subView in self.taskPageView.subviews) {
        [subView removeFromSuperview];
    }
    
    [self.taskPageViewControllers removeAllObjects];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < self.taskIds.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    
    self.taskPageViewControllers = controllers;
    [self gotoPage:YES];
}


#pragma mark - Getter and Setter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        INSBookmarkModel *bookmarkModel = [[INSBookmarkTableManager sharedInstance] prepareBookmarkModel];
        _backgroundImageView.image = bookmarkModel.image;
    }
    
    return _backgroundImageView;
}

- (UIScrollView *)taskPageView {
    if (!_taskPageView) {
        _taskPageView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _taskPageView.pagingEnabled = YES;
        _taskPageView.contentSize = CGSizeMake(CGRectGetWidth(_taskPageView.frame) * self.taskIds.count, CGRectGetHeight(_taskPageView.frame));
        _taskPageView.showsHorizontalScrollIndicator = NO;
        _taskPageView.showsVerticalScrollIndicator = NO;
        _taskPageView.scrollsToTop = NO;
        _taskPageView.delegate = self;
    }
    
    return _taskPageView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = self.taskIds.count;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    
    return _pageControl;
}

- (UIButton *)taskButton {
    if (!_taskButton) {
        _taskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_taskButton setImage:[INSTomatoBundle imageNamed:@"menu_task_28x28_"] forState:UIControlStateNormal];
        [_taskButton addTarget:self action:@selector(clickTaskButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _taskButton;
}

- (UIButton *)statisticsButton {
    if (!_statisticsButton) {
        _statisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statisticsButton setImage:[INSTomatoBundle imageNamed:@"menu_statistics_28x28_"] forState:UIControlStateNormal];
        [_statisticsButton addTarget:self action:@selector(clickStatisticsButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _statisticsButton;
}

- (UIButton *)bookmarkButton {
    if (!_bookmarkButton) {
        _bookmarkButton = [[UIButton alloc] init];
        [_bookmarkButton setBackgroundImage:[INSTomatoBundle imageNamed:@"bookmark_icon_28x28_"] forState:UIControlStateNormal];
        [_bookmarkButton addTarget:self action:@selector(clickBookmarkButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bookmarkButton;
}

//- (UIButton *)settingButton {
//    if (!_settingButton) {
//        _settingButton = [[UIButton alloc] init];
//        [_settingButton setBackgroundImage:[INSTomatoBundle imageNamed:@"menu_settings_26x26_"] forState:UIControlStateNormal];
//        [_settingButton addTarget:self action:@selector(clickSettingButton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    return _settingButton;
//}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton addTarget:self action:@selector(clickStartButton:) forControlEvents:UIControlEventTouchUpInside];
        [_startButton setBackgroundColor:FlatRed];
        [_startButton.layer setMasksToBounds:YES];
        [_startButton.layer setCornerRadius:20];
        [_startButton setTitle:@"勤·开始" forState:UIControlStateNormal];
        [_startButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_startButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    }
    
    return _startButton;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton addTarget:self action:@selector(clickPauseButton:) forControlEvents:UIControlEventTouchUpInside];
        [_pauseButton.layer setMasksToBounds:YES];
        [_pauseButton.layer setCornerRadius:15];
        [_pauseButton.layer setBorderWidth:2.0f];
        [_pauseButton.layer setBorderColor:FlatWhiteDark.CGColor];
        [_pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
        [_pauseButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_pauseButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
    }
    
    return _pauseButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setMasksToBounds:YES];
        [_cancelButton.layer setCornerRadius:15];
        [_cancelButton.layer setBorderWidth:2.0f];
        [_cancelButton.layer setBorderColor:FlatWhiteDark.CGColor];
        [_cancelButton setTitle:@"放弃" forState:UIControlStateNormal];
        [_cancelButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_cancelButton setTitleColor:FlatWhiteDark forState:UIControlStateNormal];
    }
    
    return _cancelButton;
}

- (UIButton *)resumeButton {
    if (!_resumeButton) {
        _resumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resumeButton addTarget:self action:@selector(clickResumeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_resumeButton setBackgroundColor:FlatGreen];
        [_resumeButton.layer setMasksToBounds:YES];
        [_resumeButton.layer setCornerRadius:15];
        [_resumeButton setTitle:@"继续" forState:UIControlStateNormal];
        [_resumeButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_resumeButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    }
    
    return _resumeButton;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton addTarget:self action:@selector(clickSkipButton:) forControlEvents:UIControlEventTouchUpInside];
        [_skipButton setBackgroundColor:ClearColor];
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipButton.titleLabel setFont:[UIFont fontWithName:@"-" size:24]];
        [_skipButton setTitleColor:FlatWhite forState:UIControlStateNormal];
    }
    
    return _skipButton;
}

- (NSMutableArray *)taskPageViewControllers {
    if (!_taskPageViewControllers) {
        _taskPageViewControllers = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < self.taskIds.count; i++) {
            [_taskPageViewControllers addObject:[NSNull null]];
        }
    }
    
    return _taskPageViewControllers;
}

- (NSArray *)taskIds {
    if (!_taskIds) {
        _taskIds = [[INSTaskTableManager sharedInstance] taskIds];
    }
    
    return _taskIds;
}

- (INSTaskModel *)currentTaskModel {
    NSInteger page = self.pageControl.currentPage;
    NSString *taskId = self.taskIds[page];
    _currentTaskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:taskId];
    return _currentTaskModel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[INSTomatoBundle imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

@end
