//
//  INSStatisticsHistoryBestTomatoGroupView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/8.
//

#import "INSStatisticsHistoryBestTomatoGroupView.h"

#import "INSStatisticsHistoryModel.h"
#import "INSStatisticsHistoryViewModel.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsHistoryBestTomatoGroupView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *everageMinutesLabel;
@property (nonatomic, strong) UILabel *bestTaskLabel;
@property (nonatomic, strong) UILabel *bestWeekdayLabel;
@property (nonatomic, strong) UILabel *bestWeekdayPlusLabel;
@property (nonatomic, strong) UILabel *bestHourLabel;
@property (nonatomic, strong) UILabel *bestHourPlusLabel;

@property (nonatomic, strong) INSStatisticsHistoryViewModel *statisticsHistoryVM;

@end

@implementation INSStatisticsHistoryBestTomatoGroupView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.everageMinutesLabel];
        [self addSubview:self.bestTaskLabel];
        [self addSubview:self.bestWeekdayLabel];
        [self addSubview:self.bestWeekdayPlusLabel];
        [self addSubview:self.bestHourLabel];
        [self addSubview:self.bestHourPlusLabel];
        
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(12);
            make.top.equalTo(self.mas_top).with.offset(12);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(20);
        }];
        
        [self.everageMinutesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(12);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(20);
        }];
        
        [self.bestWeekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_right).dividedBy(2).with.offset(24.0f);
            make.right.equalTo(self);
            make.centerY.equalTo(self).with.offset(-30.0f);
            make.height.mas_equalTo(20);
        }];

        [self.bestWeekdayPlusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bestWeekdayLabel);
            make.right.equalTo(self.bestWeekdayLabel);
            make.top.equalTo(self.bestWeekdayLabel.mas_bottom);
            make.height.mas_equalTo(20);
        }];

        [self.bestHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bestWeekdayLabel);
            make.right.equalTo(self.bestWeekdayLabel);
            make.top.equalTo(self.bestWeekdayPlusLabel.mas_bottom).with.offset(20);
            make.height.mas_equalTo(20);
        }];

        [self.bestHourPlusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bestWeekdayLabel);
            make.right.equalTo(self.bestWeekdayLabel);
            make.top.equalTo(self.bestHourLabel.mas_bottom);
            make.height.mas_equalTo(20);
        }];
        
        [self.bestTaskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self).dividedBy(2);
            make.centerY.equalTo(self).with.offset(20.0f);
            make.height.mas_equalTo(72);
        }];
    }
    
    return self;
}

- (void)configWithStatisticsHistoryViewModel:(INSStatisticsHistoryViewModel *)statisticsHistoryVM {
    _statisticsHistoryVM = statisticsHistoryVM;
    self.everageMinutesLabel.text = _statisticsHistoryVM.everageMinutes;
    self.bestTaskLabel.text = _statisticsHistoryVM.bestTask;
    self.bestWeekdayLabel.text = _statisticsHistoryVM.bestWeekday;
    self.bestWeekdayPlusLabel.text = _statisticsHistoryVM.bestWeekdayPlus;
    self.bestHourLabel.text = _statisticsHistoryVM.bestHour;
    self.bestHourPlusLabel.text = _statisticsHistoryVM.bestHourPlus;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        [_backgroundView setBackgroundColor:FlatWhite];
        [_backgroundView setAlpha:0.1];
        _backgroundView.layer.cornerRadius = 20;
        _backgroundView.layer.masksToBounds = YES;
    }
    
    return _backgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"最佳专注";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = FlatWhite;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _titleLabel;
}

- (UILabel *)everageMinutesLabel {
    if (!_everageMinutesLabel) {
        _everageMinutesLabel = [[UILabel alloc] init];
        _everageMinutesLabel.textAlignment = NSTextAlignmentLeft;
        _everageMinutesLabel.textColor = FlatWhiteDark;
        _everageMinutesLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
        
    }
    
    return _everageMinutesLabel;
}

- (UILabel *)bestTaskLabel {
    if (!_bestTaskLabel) {
        _bestTaskLabel = [[UILabel alloc] init];
        _bestTaskLabel.textAlignment = NSTextAlignmentCenter;
        _bestTaskLabel.textColor = FlatWhiteDark;
        _bestTaskLabel.font = [UIFont fontWithName:@"-" size:48];
    }
    
    return _bestTaskLabel;
}

- (UILabel *)bestWeekdayLabel {
    if (!_bestWeekdayLabel) {
        _bestWeekdayLabel = [[UILabel alloc] init];
        _bestWeekdayLabel.textAlignment = NSTextAlignmentLeft;
        _bestWeekdayLabel.textColor = FlatWhite;
        _bestWeekdayLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _bestWeekdayLabel;
}

- (UILabel *)bestWeekdayPlusLabel {
    if (!_bestWeekdayPlusLabel) {
        _bestWeekdayPlusLabel = [[UILabel alloc] init];
        _bestWeekdayPlusLabel.textAlignment = NSTextAlignmentLeft;
        _bestWeekdayPlusLabel.textColor = FlatWhiteDark;
        _bestWeekdayPlusLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    }
    
    return _bestWeekdayPlusLabel;
}

- (UILabel *)bestHourLabel {
    if (!_bestHourLabel) {
        _bestHourLabel = [[UILabel alloc] init];
        _bestHourLabel.textAlignment = NSTextAlignmentLeft;
        _bestHourLabel.textColor = FlatWhite;
        _bestHourLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _bestHourLabel;
}

- (UILabel *)bestHourPlusLabel {
    if (!_bestHourPlusLabel) {
        _bestHourPlusLabel = [[UILabel alloc] init];
        _bestHourPlusLabel.textAlignment = NSTextAlignmentLeft;
        _bestHourPlusLabel.textColor = FlatWhiteDark;
        _bestHourPlusLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    }
    
    return _bestHourPlusLabel;
}

@end
