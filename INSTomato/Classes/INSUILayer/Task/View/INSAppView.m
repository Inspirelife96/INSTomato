//
//  INSAppView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSAppView.h"

#import "INSTomatoConfigurationTableManager.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSAppView()

@property (nonatomic, strong) UIImageView *appIconImageView;
@property (nonatomic, strong) UILabel *appTitleLabel;
@property (nonatomic, strong) UILabel *appSubtitleLabel;

@property (nonatomic, strong) INSLogoConfiguration *logoConfiguration;

@end

@implementation INSAppView

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

    [self addSubview:self.appTitleLabel];
    [self.appTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.appIconImageView.mas_bottom).with.offset(12);
        make.height.mas_equalTo(21);
    }];

    [self addSubview:self.appSubtitleLabel];
    [self.appSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.appTitleLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(42);
    }];
}

#pragma mark - Getter and Setter

- (UIImageView *)appIconImageView {
    if (!_appIconImageView) {
        _appIconImageView = [[UIImageView alloc] init];
        _appIconImageView.layer.masksToBounds = YES;
        _appIconImageView.layer.cornerRadius = 20;
        _appIconImageView.image = [[INSTomatoConfigurationTableManager sharedInstance] icon];
    }
    
    return _appIconImageView;
}

- (UILabel *)appTitleLabel {
    if (!_appTitleLabel) {
        _appTitleLabel = [[UILabel alloc] init];
        _appTitleLabel.text = [[INSTomatoConfigurationTableManager sharedInstance] title];
        _appTitleLabel.textAlignment = NSTextAlignmentCenter;
        _appTitleLabel.textColor = FlatWhite;
        _appTitleLabel.font = [UIFont fontWithName:@"-" size:20];
    }
    
    return _appTitleLabel;
}

- (UILabel *)appSubtitleLabel {
    if (!_appSubtitleLabel) {
        _appSubtitleLabel = [[UILabel alloc] init];
        _appSubtitleLabel.text = [[INSTomatoConfigurationTableManager sharedInstance] subTitle];
        _appSubtitleLabel.textAlignment = NSTextAlignmentCenter;
        _appSubtitleLabel.textColor = FlatWhiteDark;
        _appSubtitleLabel.font = [UIFont fontWithName:@"-" size:18];
        _appSubtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _appSubtitleLabel.numberOfLines = 0;
    }
    
    return _appSubtitleLabel;
}

@end
