//
//  INSStatisticsHistoryViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import "INSStatisticsHistoryViewController.h"

#import "INSStatisticsHistoryBarChartView.h"
#import "INSStatisticsHistoryPieChartView.h"

#import "INSStatisticsHistoryViewModel.h"

#import "INSTomatoTableManager.h"

#import "INSTomatoBundle.h"

#import <Charts/Charts-umbrella.h>
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger, INSChartMode) {
    INSChartModeBar,
    INSChartModePie
};

@interface INSStatisticsHistoryViewController () <ChartViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *chartModeButtonItem;
@property (nonatomic, strong) INSStatisticsHistoryBarChartView *historyBarChartView;
@property (nonatomic, strong) INSStatisticsHistoryPieChartView *historyPieChartView;

@property (nonatomic, strong) INSStatisticsHistoryViewModel *statisticsHistoryVM;
@property (nonatomic, assign) INSChartMode chartMode;

@end

@implementation INSStatisticsHistoryViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.historyBarChartView];
    [self.view addSubview:self.historyPieChartView];
    
    [self.historyBarChartView setHidden:NO];
    [self.historyPieChartView setHidden:YES];
    
    [self.historyBarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.historyPieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.chartModeButtonItem;
    self.navigationItem.title = @"历史数据";
}

#pragma mark - Event

- (void)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickChartModeButton:(id)sender {
    [UIView beginAnimations:@"doflip" context:nil];
    //设置时常
    [UIView setAnimationDuration:2];
    //设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置翻转方向
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:self.view cache:YES];
    [self.historyBarChartView setHidden:![self.historyBarChartView isHidden]];
    [self.historyPieChartView setHidden:![self.historyPieChartView isHidden]];
    //动画结束
    [UIView commitAnimations];
    
    if (self.chartMode == INSChartModeBar) {
        self.chartMode = INSChartModePie;
        [self.chartModeButtonItem setImage:[INSTomatoBundle imageNamed:@"global_barchart_icon_28x28_"]];
    } else {
        self.chartMode = INSChartModePie;
        [self.chartModeButtonItem setImage:[INSTomatoBundle imageNamed:@"global_piechart_icon_28x28_"]];
    }
}

#pragma mark - Getter and Setter

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[INSTomatoBundle imageNamed:@"menu_back_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButton:)];
    }
    
    return _backBarButtonItem;
}

- (UIBarButtonItem *)chartModeButtonItem {
    if (!_chartModeButtonItem) {
        _chartModeButtonItem = [[UIBarButtonItem alloc] initWithImage:[INSTomatoBundle imageNamed:@"global_piechart_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickChartModeButton:)];
        _chartMode = INSChartModeBar;
    }
    
    return _chartModeButtonItem;
}

- (INSStatisticsHistoryBarChartView *)historyBarChartView {
    if (!_historyBarChartView) {
        _historyBarChartView = [[INSStatisticsHistoryBarChartView alloc] init];
        [_historyBarChartView configWithStatisticsHistoryViewModel:self.statisticsHistoryVM];
    }
    
    return _historyBarChartView;
}

- (INSStatisticsHistoryPieChartView *)historyPieChartView {
    if (!_historyPieChartView) {
        _historyPieChartView = [[INSStatisticsHistoryPieChartView alloc] init];
        [_historyPieChartView configWithStatisticsHistoryViewModel:self.statisticsHistoryVM];
    }
    
    return _historyPieChartView;
}


- (INSStatisticsHistoryViewModel *)statisticsHistoryVM {
    if (!_statisticsHistoryVM) {
        INSStatisticsHistoryModel *statisticsHistoryModel = [[INSTomatoTableManager sharedInstance] fetchStatisticsHistoryModel];
        _statisticsHistoryVM = [[INSStatisticsHistoryViewModel alloc] initWithStatisticsHistoryModel:statisticsHistoryModel];
    }
    
    return _statisticsHistoryVM;
}

@end
