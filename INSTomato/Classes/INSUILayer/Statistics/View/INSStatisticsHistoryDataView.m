//
//  INSStatisticsHistoryDataView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/7.
//

#import "INSStatisticsHistoryDataView.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsHistoryDataView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation INSStatisticsHistoryDataView

- (void)configWithDataValue:(NSString *)value title:(NSString *)title {
    self.valueLabel.text = value;
    self.titleLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.valueLabel];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.valueLabel.mas_bottom);
            make.height.mas_equalTo(21);
        }];
    }
    
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = FlatWhiteDark;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:8];
    }
    
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = FlatWhite;
        _valueLabel.font = [UIFont fontWithName:@"Avenir Next" size:28];
    }
    
    return _valueLabel;
}

@end
