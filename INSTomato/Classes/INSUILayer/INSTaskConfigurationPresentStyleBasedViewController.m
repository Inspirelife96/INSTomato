//
//  INSTaskConfigurationPresentStyleBasedViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSTaskConfigurationPresentStyleBasedViewController.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSTaskConfigurationPresentStyleBasedViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIButton *closeButton;


@end

@implementation INSTaskConfigurationPresentStyleBasedViewController

#pragma mark - Life Cycle

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel {
    if (self = [super init]) {
        _taskModel = taskModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-76.0f);
        make.height.mas_equalTo(216.0f);
    }];
    
    [self.view addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.pickerView.mas_top).with.offset(-60.0f);
        make.height.mas_equalTo(21.0f);
    }];
    
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).with.offset(-21);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-21);
        }
        
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(28);
    }];
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter and Setter

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    
    return _pickerView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = FlatWhiteDark;
        _descriptionLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    return _descriptionLabel;
}

@end
