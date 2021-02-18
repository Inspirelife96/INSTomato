//
//  INSBookmarkView.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/11.
//

#import "INSBookmarkView.h"

#import "INSBookmarkModel.h"

#import "INSDateHelper.h"

#import "INSTomatoBundle.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSBookmarkView()

@property (nonatomic, strong) UIImageView *bookMarkImageView;
@property (nonatomic, strong) UIImageView *sharedLinkImageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *wordsLabel;

@property (nonatomic, strong) INSBookmarkModel *bookMarkModel;

@end

@implementation INSBookmarkView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bookMarkImageView];
        [self.bookMarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self addSubview:self.sharedLinkImageView];
        [self.sharedLinkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom).with.offset(-8);
            } else {
                make.bottom.mas_equalTo(self.mas_bottom).with.offset(-8);
            }
            make.width.mas_equalTo(76);
            make.height.mas_equalTo(76);
        }];
        
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sharedLinkImageView.mas_right).with.offset(12.0f);
            make.right.equalTo(self).with.offset(-12.0f);
            make.bottom.equalTo(self.sharedLinkImageView);
            make.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel);
            make.right.equalTo(self.dateLabel);
            make.top.equalTo(self.sharedLinkImageView);
            make.height.mas_lessThanOrEqualTo(42.0f);
        }];
        
        [self addSubview:self.wordsLabel];
        [self.wordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(12.0f);
            make.right.equalTo(self).with.offset(-12.0f);
            make.bottom.equalTo(self.sharedLinkImageView.mas_top).with.offset(-12.0f);
            make.height.mas_greaterThanOrEqualTo(21.0f);
        }];
    }
    
    return self;
}

- (void)configWithBookMarkModel:(INSBookmarkModel *)bookMarkModel {
    _bookMarkModel = bookMarkModel;
    self.bookMarkImageView.image = bookMarkModel.image;
    self.titleLabel.text = bookMarkModel.title;
    self.wordsLabel.text = bookMarkModel.words;
}


- (UIImageView *)bookMarkImageView {
    if (!_bookMarkImageView) {
        _bookMarkImageView = [[UIImageView alloc] init];
        _bookMarkImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _bookMarkImageView;
}

- (UIImageView *)sharedLinkImageView {
    if (!_sharedLinkImageView) {
        _sharedLinkImageView = [[UIImageView alloc] init ];
        _sharedLinkImageView.image = [INSTomatoBundle imageNamed:@"daycard_qrcode_50x50_"];
    }
    
    return _sharedLinkImageView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        NSString *todaysString = [INSDateHelper stringOfDayWithWeekDay:[NSDate date]] ;

        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = FlatWhite;
        _dateLabel.font = [UIFont fontWithName:@"-" size:24];
        _dateLabel.text = todaysString;

    }
    
    return _dateLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = -1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = FlatWhite;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }

    return _titleLabel;
}

- (UILabel *)wordsLabel {
    if (!_wordsLabel) {
        _wordsLabel = [[UILabel alloc] init];
        _wordsLabel.numberOfLines = -1;
        _wordsLabel.textAlignment = NSTextAlignmentLeft;
        _wordsLabel.textColor = FlatWhite;
        _wordsLabel.font = [UIFont fontWithName:@"Avenir Next" size:18];
    }

    return _wordsLabel;
}

@end