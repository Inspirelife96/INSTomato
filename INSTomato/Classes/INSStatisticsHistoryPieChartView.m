//
//  INSStatisticsHistoryPieChartView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/8.
//

#import "INSStatisticsHistoryPieChartView.h"

#import "INSStatisticsHistoryDataGroupView.h"
#import "INSPieChartDataViewModel.h"

#import "INSStatisticsHistoryModel.h"
#import "INSStatisticsHistoryViewModel.h"

#import "INSTomatoConfigurationTableManager.h"

#import <Charts/Charts-umbrella.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsHistoryPieChartView()

@property (nonatomic, strong) INSStatisticsHistoryDataGroupView *dataGroupView;
@property (nonatomic, strong) PieChartView *pieChartView;
@property (nonatomic, strong) UILabel *bestTaskLabel;
@property (nonatomic, strong) UILabel *bestTaskNameLabel;

@property (nonatomic, strong) INSStatisticsHistoryViewModel *statisticsHistoryVM;

@property (nonatomic, strong) NSString *specialFontName;

@end

@implementation INSStatisticsHistoryPieChartView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];

        [self addSubview:self.dataGroupView];
        [self addSubview:self.pieChartView];
        [self addSubview:self.bestTaskLabel];
        [self addSubview:self.bestTaskNameLabel];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        [self.dataGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(64 + (screenHeight - 128)/6 - 30);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(3*screenWidth/5);
            make.height.mas_equalTo(61);
        }];
        
        CGFloat pieChartHeight = (screenHeight - 64 - 64)/2;
        if (pieChartHeight > screenWidth) {
            pieChartHeight = screenWidth;
        }
        
        [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(pieChartHeight);
            make.height.mas_equalTo(pieChartHeight);
        }];
        
        [self.bestTaskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.pieChartView.mas_bottom).with.offset(64);
            make.width.mas_equalTo(screenWidth - 16.0f);
            make.height.mas_equalTo(30);
        }];
        
        [self.bestTaskNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.bestTaskLabel.mas_bottom).with.offset(20);
            make.width.mas_equalTo(screenWidth - 16.0f);
            make.height.mas_equalTo(50);
        }];
    }
    
    return self;
}

- (void)configWithStatisticsHistoryViewModel:(INSStatisticsHistoryViewModel *)statisticsHistoryVM {
    _statisticsHistoryVM = statisticsHistoryVM;
    
    [self.dataGroupView configWithStatisticsHistoryViewModel:self.statisticsHistoryVM];
    [self configPieChartData];
    self.bestTaskNameLabel.text = self.statisticsHistoryVM.bestTask;
}

#pragma mark - Private Method

- (void)configPieChartData {
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    INSStatisticsHistoryModel *statisticsHistoryModel = self.statisticsHistoryVM.statisticsHistoryModel;
    
    NSString *title = [[INSTomatoConfigurationTableManager sharedInstance] title];
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:title];
    
    if ([statisticsHistoryModel.pieChartDataModelArray count] > 0) {
        for (int i = 0; i < [statisticsHistoryModel.pieChartDataModelArray count]; i++) {
            INSPieChartDataModel *pieChartDataModel = statisticsHistoryModel.pieChartDataModelArray[i];
            INSPieChartDataViewModel *pieChartVM = [[INSPieChartDataViewModel alloc] initWithPieChartDataModel:pieChartDataModel];
            
            [values addObject:[[PieChartDataEntry alloc] initWithValue:pieChartVM.tomatoMinutes
                                                                 label:pieChartVM.taskName]];
            [colors addObject:pieChartVM.taskColor];
        }
    } else {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:10 label:@""]];
        [colors addObject:FlatSand];
        centerText = [[NSMutableAttributedString alloc] initWithString:@"无数据"];
    }
    
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:self.specialFontName size:16.f],
                                NSForegroundColorAttributeName: FlatBlueDark
                                } range:NSMakeRange(0, centerText.length)];
    self.pieChartView.centerAttributedText = centerText;
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@"Election Results"];
    dataSet.sliceSpace = 2.0;
    dataSet.colors = colors;
    if ([statisticsHistoryModel.pieChartDataModelArray count] > 0) {
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

- (PieChartView *)pieChartView {
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.legend.enabled = NO;
        _pieChartView.drawCenterTextEnabled = YES;
        _pieChartView.chartDescription.enabled = NO;
        [_pieChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    }
    
    return _pieChartView;
}

- (UILabel *)bestTaskLabel {
    if (!_bestTaskLabel) {
        _bestTaskLabel = [[UILabel alloc] init];
        _bestTaskLabel.text = @"最佳任务";
        _bestTaskLabel.textAlignment = NSTextAlignmentCenter;
        _bestTaskLabel.textColor = FlatWhite;
        _bestTaskLabel.font = [UIFont fontWithName:self.specialFontName size:24];
    }
    
    return _bestTaskLabel;
}

- (UILabel *)bestTaskNameLabel {
    if (!_bestTaskNameLabel) {
        _bestTaskNameLabel = [[UILabel alloc] init];
        _bestTaskNameLabel.textAlignment = NSTextAlignmentCenter;
        _bestTaskNameLabel.textColor = FlatWhiteDark;
        _bestTaskNameLabel.font = [UIFont fontWithName:self.specialFontName size:32];
    }
    
    return _bestTaskNameLabel;
}

- (INSStatisticsHistoryDataGroupView *)dataGroupView {
    if (!_dataGroupView) {
        _dataGroupView = [[INSStatisticsHistoryDataGroupView alloc] init];
        [_dataGroupView configWithStatisticsHistoryViewModel:self.statisticsHistoryVM];
    }
    
    return _dataGroupView;
}

- (NSString *)specialFontName {
    if (!_specialFontName) {
        _specialFontName = @"Avenir Next";
        if ([[INSTomatoConfigurationTableManager sharedInstance] isSpecialFontOptionEnabled]) {
            _specialFontName = [[INSTomatoConfigurationTableManager sharedInstance] specialFontName];
        }
    }
    
    return _specialFontName;
}

@end
