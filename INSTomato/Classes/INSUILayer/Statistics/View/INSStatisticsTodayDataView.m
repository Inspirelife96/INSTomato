//
//  INSStatisticsTodayDataView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import "INSStatisticsTodayDataView.h"

#import "INSStatisticsTodayViewModel.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSStatisticsTodayDataView()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) INSStatisticsTodayDataViewModel *statisticsTodayVM;

@end

@implementation INSStatisticsTodayDataView

- (void)configWithDataValue:(NSString *)value title:(NSString *)title image:(UIImage *)image {
    self.valueLabel.text = value;
    self.titleLabel.text = title;
    self.iconImageView.image = image;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.valueLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.iconImageView.mas_bottom);
            make.height.mas_equalTo(21);
        }];
        
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(21);
        }];
    }
    
    return self;
}


- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    
    return _iconImageView;
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
        _valueLabel.textColor = FlatWhiteDark;
        _valueLabel.font = [UIFont fontWithName:@"Avenir Next" size:24];
    }
    
    return _valueLabel;
}

@end
