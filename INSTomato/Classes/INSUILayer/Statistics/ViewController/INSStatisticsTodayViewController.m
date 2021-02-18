//
//  INSStatisticsTodayViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import "INSStatisticsTodayViewController.h"

#import "INSStatisticsHistoryViewController.h"

#import "INSStatisticsTodayDataView.h"

#import "INSStatisticsTodayModel.h"
#import "INSStatisticsTodayViewModel.h"

#import "INSPieChartDataModel.h"
#import "INSPieChartDataViewModel.h"

#import "INSTomatoTableManager.h"

#import "INSTomatoBundle.h"

#import "INSDateHelper.h"

#import <Charts/Charts-umbrella.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsTodayViewController () <ChartViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *historyBarButtonItem;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) INSStatisticsTodayDataView *tomatoTimesView;
@property (nonatomic, strong) INSStatisticsTodayDataView *tomatoMinutesView;
@property (nonatomic, strong) INSStatisticsTodayDataView *tomatoQualityView;
@property (nonatomic, strong) PieChartView *pieChartView;

@property (nonatomic, strong) INSStatisticsTodayViewModel *statisticsTodayVM;

@end

@implementation INSStatisticsTodayViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.closeBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.historyBarButtonItem;
    self.navigationItem.title = @"今日统计";
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat pieChartYPos = 64;
    CGFloat pieChartHeight = (screenHeight - 64 - 64)/2;
    if (pieChartHeight > screenWidth) {
        pieChartHeight = screenWidth;
    }
    
    CGFloat descriptionLabelYPos = 64 + pieChartHeight + pieChartHeight/4 - 4 - 21;
    CGFloat statisticsViewYPos = 64 + pieChartHeight + pieChartHeight/2 + pieChartHeight/4 - 40;

    [self.view addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(pieChartYPos);
        } else {
            make.top.mas_equalTo(self.view.mas_top).with.offset(pieChartYPos);
        }
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(pieChartHeight);
        make.height.mas_equalTo(pieChartHeight);
    }];

    [self.view addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(descriptionLabelYPos);
        } else {
            make.top.mas_equalTo(self.view.mas_top).with.offset(descriptionLabelYPos);
        }
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(screenWidth - 16.0f);
        make.height.mas_equalTo(21);
    }];
    
    [self.view addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(8);
        make.width.mas_equalTo(screenWidth - 16.0f);
        make.height.mas_equalTo(21);
    }];
    
    [self.view addSubview:self.tomatoTimesView];
    [self.tomatoTimesView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(statisticsViewYPos);
        } else {
            make.top.mas_equalTo(self.view.mas_top).with.offset(statisticsViewYPos);
        }
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(screenWidth/3);
        make.height.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.tomatoMinutesView];
    [self.tomatoMinutesView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(statisticsViewYPos);
        } else {
            make.top.mas_equalTo(self.view.mas_top).with.offset(statisticsViewYPos);
        }
        make.left.mas_equalTo(screenWidth/3);
        make.width.mas_equalTo(screenWidth/3);
        make.height.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.tomatoQualityView];
    [self.tomatoQualityView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(statisticsViewYPos);
        } else {
            make.top.mas_equalTo(self.view.mas_top).with.offset(statisticsViewYPos);
        }
        make.left.mas_equalTo(2*screenWidth/3);
        make.width.mas_equalTo(screenWidth/3);
        make.height.mas_equalTo(80);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configPieChartData];
}


#pragma mark - Event
- (void)clickHistoryButton:(id)sender {
    INSStatisticsHistoryViewController *statisticsHistoryVC = [[INSStatisticsHistoryViewController alloc] init];
    [self.navigationController pushViewController:statisticsHistoryVC animated:YES];
}

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)configPieChartData {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"勤之时"];
    
    INSStatisticsTodayModel *statisticsTodayModel = self.statisticsTodayVM.statisticsTodayModel;
    
    
    if ([statisticsTodayModel.pieChartDataModelArray count] > 0) {
        for (int i = 0; i < [statisticsTodayModel.pieChartDataModelArray count]; i++) {
            INSPieChartDataModel *pieChartDataModel = statisticsTodayModel.pieChartDataModelArray[i];
            
            INSPieChartDataViewModel *pieChartDataVM = [[INSPieChartDataViewModel alloc] initWithPieChartDataModel:pieChartDataModel];
            
            [values addObject:[[PieChartDataEntry alloc] initWithValue:pieChartDataVM.tomatoMinutes
                                                                 label:pieChartDataVM.taskName]];
            [colors addObject:pieChartDataVM.taskColor];
        }
    } else {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:10 label:@""]];
        [colors addObject:FlatSand];
        centerText = [[NSMutableAttributedString alloc] initWithString:@"无数据"];
    }
    
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"-" size:16.f],
                                NSForegroundColorAttributeName: FlatBlueDark
                                } range:NSMakeRange(0, centerText.length)];
    self.pieChartView.centerAttributedText = centerText;
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@"Election Results"];
    dataSet.sliceSpace = 2.0;
    dataSet.colors = colors;
    if ([statisticsTodayModel.pieChartDataModelArray count] > 0) {
        dataSet.drawValuesEnabled = YES;
    } else {
        dataSet.drawValuesEnabled = NO;
    }
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" 分钟";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    self.pieChartView.data = data;
    [self.pieChartView highlightValues:nil];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight {
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView {
    NSLog(@"chartValueNothingSelected");
}

#pragma mark - Getter and Setter

- (UIBarButtonItem *)historyBarButtonItem {
    if (!_historyBarButtonItem) {
        _historyBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[INSTomatoBundle imageNamed:@"global_barchart_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickHistoryButton:)];
    }
    
    return _historyBarButtonItem;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[INSTomatoBundle imageNamed:@"global_close_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton:)];
    }
    
    return _closeBarButtonItem;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = @"今日专注";
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = FlatWhite;
        _descriptionLabel.font = [UIFont fontWithName:@"-" size:18];
        
    }
    
    return _descriptionLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = [INSDateHelper stringOfDay:[NSDate date]];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = FlatWhiteDark;
        _dateLabel.font = [UIFont fontWithName:@"-" size:14];
        
    }
    
    return _dateLabel;
}

- (INSStatisticsTodayDataView *)tomatoTimesView {
    if (!_tomatoTimesView) {
        _tomatoTimesView = [[INSStatisticsTodayDataView alloc] init];
        [_tomatoTimesView configWithDataValue:self.statisticsTodayVM.tomatoTimes title:self.statisticsTodayVM.tomatoTimesTitle image:self.statisticsTodayVM.tomatoTimesImage];
    }
    
    return _tomatoTimesView;
}

- (INSStatisticsTodayDataView *)tomatoMinutesView {
    if (!_tomatoMinutesView) {
        _tomatoMinutesView = [[INSStatisticsTodayDataView alloc] init];
        [_tomatoMinutesView configWithDataValue:self.statisticsTodayVM.tomatoMinutes title:self.statisticsTodayVM.tomatoMinutesTitle image:self.statisticsTodayVM.tomatoMinutesImage];
    }
    
    return _tomatoMinutesView;
}

- (INSStatisticsTodayDataView *)tomatoQualityView {
    if (!_tomatoQualityView) {
        _tomatoQualityView = [[INSStatisticsTodayDataView alloc] init];
        [_tomatoQualityView configWithDataValue:self.statisticsTodayVM.tomatoQuality title:self.statisticsTodayVM.tomatoQualityTitle image:self.statisticsTodayVM.tomatoQualityImage];
    }
    
    return _tomatoQualityView;
}

- (PieChartView *)pieChartView {
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.delegate = self;
        _pieChartView.legend.enabled = NO;
        _pieChartView.drawCenterTextEnabled = YES;
        _pieChartView.chartDescription.enabled = NO;
        [_pieChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    }
    
    return _pieChartView;
}

- (INSStatisticsTodayViewModel *)statisticsTodayVM {
    if (!_statisticsTodayVM) {
        INSStatisticsTodayModel *statisticsTodayModel = [[INSTomatoTableManager sharedInstance] fetchStatisticsTodayModel];
        _statisticsTodayVM = [[INSStatisticsTodayViewModel alloc] initWithStatisticsTodayModel:statisticsTodayModel];
    }
    
    return _statisticsTodayVM;
}

@end
