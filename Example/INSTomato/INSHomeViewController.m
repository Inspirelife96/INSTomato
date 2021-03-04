//
//  INSHomeViewController.m
//  INSTomato_Example
//
//  Created by XueFeng Chen on 2021/3/3.
//  Copyright © 2021 inspirelife@hotmail.com. All rights reserved.
//

#import "INSHomeViewController.h"

#import "INSTomatoViewController.h"

#import <Masonry/Masonry.h>

@interface INSHomeViewController ()

@property (nonatomic, strong) UIButton *tomatoButton;

@end

@implementation INSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tomatoButton];
    
    [self.tomatoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(64.0f);
        make.height.mas_equalTo(64.0f);
    }];
}

- (void)clickTomatoButton:(id)sender {
    // 生成番茄视图
    INSTomatoViewController *tomatoVC = [[INSTomatoViewController alloc] init];
    tomatoVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:tomatoVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIButton *)tomatoButton {
    if (!_tomatoButton) {
        _tomatoButton = [[UIButton alloc] init];
        [_tomatoButton setTitle:@"番茄时钟" forState:UIControlStateNormal];
        [_tomatoButton addTarget:self action:@selector(clickTomatoButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _tomatoButton;
}

@end
