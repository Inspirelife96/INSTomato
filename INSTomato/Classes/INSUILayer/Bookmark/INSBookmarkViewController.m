//
//  INSBookmarkViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/10.
//

#import "INSBookmarkViewController.h"

#import "INSBookmarkView.h"

#import "INSBookmarkModel.h"

#import "INSTomatoBundle.h"

#import "INSBookmarkTableManager.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSBookmarkViewController ()

@property(nonatomic, strong) UIButton *closeButton;
@property(nonatomic, strong) UIButton *shareButton;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) INSBookmarkView *bookmarkView;

@property(nonatomic, strong) INSBookmarkModel *bookmarkModel;

@end

#pragma mark - Life Cycle

@implementation INSBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bookmarkView];
    [self.bookmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.bookmarkView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:3 animations: ^{
        self.bookmarkView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finish) {
        [UIView animateWithDuration:3 animations: ^{
            self.bookmarkView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finish) {
            //
        }];
    }];
    
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(8);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).with.offset(12);
        } else {
            make.top.equalTo(self.view.mas_top).with.offset(8);
            make.left.equalTo(self.view.mas_left).with.offset(12);
        }
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.view addSubview:self.shareButton];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(8);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).with.offset(-12);
        } else {
            make.top.equalTo(self.view.mas_top).with.offset(8);
            make.right.equalTo(self.view.mas_right).with.offset(-12);
        }

        make.height.mas_equalTo(28);
        make.width.mas_equalTo(28);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).with.offset(8);
        } else {
            make.top.equalTo(self.view.mas_top).with.offset(8);
        }

        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickShareButton:(id)sender {
//    UIImage *sharedImage = [self.sharedView il_viewToImage];
//    [ILDShareSDKHelper shareMessage:self.storyModel.todaysTitle image:sharedImage onView:self.sharingButton];
}

#pragma mark - Getter and Setter

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[INSTomatoBundle imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setBackgroundImage:[INSTomatoBundle imageNamed:@"menu_share_26x26_"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shareButton;
}

- (INSBookmarkView *)bookmarkView {
    if (!_bookmarkView) {
        _bookmarkView = [[INSBookmarkView alloc] init];
        [_bookmarkView configWithBookMarkModel:self.bookmarkModel];
    }
    
    return _bookmarkView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = FlatWhite;
        _titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
        _titleLabel.text = @"今日书签";
    }
    
    return _titleLabel;
}

- (INSBookmarkModel *)bookmarkModel {
    if (!_bookmarkModel) {
        _bookmarkModel = [[INSBookmarkTableManager sharedInstance] prepareBookmarkModel];
    }
    
    return _bookmarkModel;
}

@end
