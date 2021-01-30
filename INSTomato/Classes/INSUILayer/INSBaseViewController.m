//
//  INSBaseViewController.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSBaseViewController.h"

#import "INSBackgroundImageManager.h"

@interface INSBaseViewController ()

@property(strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation INSBaseViewController

#pragma mark - Life Cycle

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self.view addSubview:self.backgroundImageView];
//    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//}
//
//#pragma mark - Getter and Setter
//
//- (UIImageView *)backgroundImageView {
//    if (!_backgroundImageView) {
//        _backgroundImageView = [[UIImageView alloc] init];
//        _backgroundImageView.image = [ILDScreenshotImageManager sharedInstance].screenshotImage;
//    }
//    
//    return _backgroundImageView;
//}

@end
