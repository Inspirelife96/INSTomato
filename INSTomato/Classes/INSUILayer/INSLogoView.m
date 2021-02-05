//
//  INSLogoView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSLogoView.h"

#import "INSLogoConfiguration.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSLogoView()

@property (nonatomic, strong) UIImageView *appIconImageView;
@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UILabel *appDescriptionLabel;

@property (nonatomic, strong) INSLogoConfiguration *logoConfiguration;

@end

@implementation INSLogoView

- (instancetype)initWithFrame:(CGRect)frame andLogoConfiguration:(INSLogoConfiguration *)logoConfiguration {
    if (self = [super initWithFrame:frame]) {
        _logoConfiguration = logoConfiguration;
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    [self addSubview:self.appIconImageView];
    [self.appIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];

    [self addSubview:self.appNameLabel];
    [self.appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.appIconImageView.mas_bottom).with.offset(12);
        make.height.mas_equalTo(21);
    }];

    [self addSubview:self.appDescriptionLabel];
    [self.appDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.appNameLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(42);
    }];
}

#pragma mark - Getter and Setter

- (UIImageView *)appIconImageView {
    if (!_appIconImageView) {
        _appIconImageView = [[UIImageView alloc] init];
        _appIconImageView.layer.masksToBounds = YES;
        _appIconImageView.layer.cornerRadius = 20;
        _appIconImageView.image = self.logoConfiguration.logoImage;
    }
    
    return _appIconImageView;
}

- (UILabel *)appNameLabel {
    if (!_appNameLabel) {
        _appNameLabel = [[UILabel alloc] init];
        _appNameLabel.text = self.logoConfiguration.logoName;
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
        _appNameLabel.textColor = FlatWhite;
        _appNameLabel.font = [UIFont fontWithName:@"-" size:20];
    }
    
    return _appNameLabel;
}

- (UILabel *)appDescriptionLabel {
    if (!_appDescriptionLabel) {
        _appDescriptionLabel = [[UILabel alloc] init];
        _appDescriptionLabel.text = self.logoConfiguration.logoDescription;
        _appDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        _appDescriptionLabel.textColor = FlatWhiteDark;
        _appDescriptionLabel.font = [UIFont fontWithName:@"-" size:18];
        _appDescriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _appDescriptionLabel.numberOfLines = 0;
    }
    
    return _appDescriptionLabel;
}

@end
