//
//  INSBaseViewController.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSBaseViewController.h"

#import "INSBackgroundImageManager.h"

#import "INSBookmarkTableManager.h"
#import "INSBookmarkModel.h"

#import "UIImageEffects.h"

#import <Masonry/Masonry.h>

@interface INSBaseViewController ()

@property(strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation INSBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Getter and Setter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        
        INSBookmarkModel *bookmarkModel = [[INSBookmarkTableManager sharedInstance] prepareBookmarkModel];
        _backgroundImageView.image = [UIImageEffects imageByApplyingDarkEffectToImage:bookmarkModel.image];
    }
    
    return _backgroundImageView;
}

@end
