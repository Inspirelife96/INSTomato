//
//  INSStatisticsHistoryDataGroupView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/7.
//

#import "INSStatisticsHistoryDataGroupView.h"

#import "INSStatisticsHistoryDataView.h"

#import "INSStatisticsHistoryViewModel.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsHistoryDataGroupView()

@property (nonatomic, strong) INSStatisticsHistoryViewModel *statisticsHistoryVM;
@property (nonatomic, strong) INSStatisticsHistoryDataView *tomatoTimesView;
@property (nonatomic, strong) INSStatisticsHistoryDataView *tomatoMinutesView;
@property (nonatomic, strong) INSStatisticsHistoryDataView *tomatoDaysView;

@end

@implementation INSStatisticsHistoryDataGroupView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tomatoTimesView];
        [self.tomatoTimesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.mas_equalTo(self).dividedBy(3);
            make.height.mas_equalTo(self);
        }];
        
        
        [self addSubview:self.tomatoMinutesView];
        [self.tomatoMinutesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tomatoTimesView.mas_right);
            make.top.equalTo(self);
            make.width.mas_equalTo(self).dividedBy(3);
            make.height.mas_equalTo(self);
        }];
        
        [self addSubview:self.tomatoDaysView];
        [self.tomatoDaysView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tomatoMinutesView.mas_right);
            make.top.equalTo(self);
            make.width.mas_equalTo(self).dividedBy(3);
            make.height.mas_equalTo(self);
        }];
    }
    
    return self;
}

- (void)configWithStatisticsHistoryViewModel:(INSStatisticsHistoryViewModel *)statisticsHistoryVM {
    _statisticsHistoryVM = statisticsHistoryVM;
    [self.tomatoTimesView configWithDataValue:statisticsHistoryVM.tomatoTimes title:statisticsHistoryVM.tomatoTimesTitle];
    [self.tomatoMinutesView configWithDataValue:statisticsHistoryVM.tomatoMinutes title:statisticsHistoryVM.tomatoMinutesTitle];
    [self.tomatoDaysView configWithDataValue:statisticsHistoryVM.tomatoDays title:statisticsHistoryVM.tomatoDaysTitle];
}


- (INSStatisticsHistoryDataView *)tomatoTimesView {
    if (!_tomatoTimesView) {
        _tomatoTimesView = [[INSStatisticsHistoryDataView alloc] init];
    }
    
    return _tomatoTimesView;
}

- (INSStatisticsHistoryDataView *)tomatoMinutesView {
    if (!_tomatoMinutesView) {
        _tomatoMinutesView = [[INSStatisticsHistoryDataView alloc] init];
    }
    
    return _tomatoMinutesView;
}

- (INSStatisticsHistoryDataView *)tomatoDaysView {
    if (!_tomatoDaysView) {
        _tomatoDaysView = [[INSStatisticsHistoryDataView alloc] init];
    }
    
    return _tomatoDaysView;
}

@end
