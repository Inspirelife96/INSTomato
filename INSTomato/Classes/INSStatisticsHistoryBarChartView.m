//
//  INSStatisticsHistoryBarChartView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/7.
//

#import "INSStatisticsHistoryBarChartView.h"

#import "INSStatisticsHistoryDataGroupView.h"
#import "INSStatisticsHistoryBarChartGroupView.h"
#import "INSStatisticsHistoryBestTomatoGroupView.h"

#import "INSStatisticsHistoryModel.h"
#import "INSStatisticsHistoryViewModel.h"


#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsHistoryBarChartView()

@property (nonatomic, strong) INSStatisticsHistoryDataGroupView *dataGroupView;
@property (nonatomic, strong) INSStatisticsHistoryBarChartGroupView *barChartGroupView;
@property (nonatomic, strong) INSStatisticsHistoryBestTomatoGroupView *bestTomatoGroupView;

@property (nonatomic, strong) INSStatisticsHistoryViewModel *statisticsHistoryVM;

@end

@implementation INSStatisticsHistoryBarChartView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dataGroupView];
        [self addSubview:self.barChartGroupView];
        [self addSubview:self.bestTomatoGroupView];
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        [self.dataGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(64 + (screenHeight - 128)/6 - 30);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(3*screenWidth/5);
            make.height.mas_equalTo(61);
        }];
        
        [self.barChartGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(64 + (screenHeight - 128)/3);
            make.left.equalTo(self.mas_left).with.offset(12);
            make.width.mas_equalTo(screenWidth - 24);
            make.height.mas_equalTo((screenHeight - 128)/3);
        }];
        
        [self.bestTomatoGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(64 + 2*(screenHeight - 128)/3 + 20);
            make.left.equalTo(self.mas_left).with.offset(12);
            make.width.mas_equalTo(screenWidth - 24);
            make.height.mas_equalTo((screenHeight - 128)/3);
        }];
    }
    
    return self;
}

- (void)configWithStatisticsHistoryViewModel:(INSStatisticsHistoryViewModel *)statisticsHistoryVM {
    _statisticsHistoryVM = statisticsHistoryVM;
    [self.dataGroupView configWithStatisticsHistoryViewModel:self.statisticsHistoryVM];
    [self.barChartGroupView configWithBarChartData:self.statisticsHistoryVM.barChartDataModelArray];
    [self.bestTomatoGroupView configWithStatisticsHistoryViewModel:self.statisticsHistoryVM];
}

- (INSStatisticsHistoryDataGroupView *)dataGroupView {
    if (!_dataGroupView) {
        _dataGroupView = [[INSStatisticsHistoryDataGroupView alloc] init];

    }
    
    return _dataGroupView;
}

- (INSStatisticsHistoryBarChartGroupView *)barChartGroupView {
    if (!_barChartGroupView) {
        _barChartGroupView = [[INSStatisticsHistoryBarChartGroupView alloc] init];

    }
    
    return _barChartGroupView;
}

- (INSStatisticsHistoryBestTomatoGroupView *)bestTomatoGroupView {
    if (!_bestTomatoGroupView) {
        _bestTomatoGroupView = [[INSStatisticsHistoryBestTomatoGroupView alloc] init];

    }
    
    return _bestTomatoGroupView;
}

@end
