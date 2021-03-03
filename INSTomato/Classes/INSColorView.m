//
//  INSColorView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSColorView.h"

#import "UIImage+INS_ContentWithColor.h"

#import "INSTomatoBundle.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSColorView()

@property (nonatomic, strong) UILabel *colorNameLabel;
@property (nonatomic, strong) UIImageView *colorImageView;

@property (nonatomic, copy) NSString *colorName;
@property (nonatomic, strong) UIColor *color;

@end

@implementation INSColorView

- (instancetype)initWithColorName:(NSString *)colorName andColor:(UIColor *)color; {
    if (self = [super init]) {
        _colorName = colorName;
        _color = color;
        [self addSubview:self.colorImageView];
        [self.colorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).with.offset(-32);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
        }];

        [self addSubview:self.colorNameLabel];
        [self.colorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.colorImageView.mas_right).with.offset(16.0f);
            make.right.equalTo(self);
            make.top.equalTo(self.colorImageView);
            make.height.mas_equalTo(21);
        }];
    }
    
    return self;
}

#pragma mark - Getter and Setter

- (UILabel *)colorNameLabel {
    if (!_colorNameLabel) {
        _colorNameLabel = [[UILabel alloc] init];
        _colorNameLabel.textAlignment = NSTextAlignmentLeft;
        _colorNameLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        _colorNameLabel.textColor = FlatWhite;
        _colorNameLabel.text = self.colorName;
    }
    
    return _colorNameLabel;
}

- (UIImageView *)colorImageView {
    if (!_colorImageView) {
        _colorImageView = [[UIImageView alloc] init];
        UIImage *iconImage = [INSTomatoBundle imageNamed:@"ins_task_color"];
        _colorImageView.image = [iconImage ins_contentWithColor:self.color];
    }
    
    return _colorImageView;
}

@end
