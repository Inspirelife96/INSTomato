//
//  INSTaskNameViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/31.
//

#import "INSTaskNameViewController.h"

#import "INSTaskModel.h"

#import "INSTomatoBundle.h"

#import "INSTaskTableManager.h"

#import "UIViewController+INS_AlertView.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSTaskNameViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *taskNameTextField;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UITapGestureRecognizer *singleTap;

@end

@implementation INSTaskNameViewController

#pragma mark - Life Cycle

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel {
    if (self = [super init]) {
        _taskModel = taskModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-100.0f);
        make.height.mas_equalTo(21);
    }];

    [self.view addSubview:self.taskNameTextField];
    [self.taskNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.descriptionLabel.mas_bottom).with.offset(44);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(12.0f);
        make.right.equalTo(self.view).with.offset(-12.0f);
        make.top.equalTo(self.taskNameTextField.mas_bottom).with.offset(5);
        make.height.mas_equalTo(0.5);
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
    
    [self.view addGestureRecognizer:self.singleTap];

    [self.taskNameTextField becomeFirstResponder];
    
    self.view.userInteractionEnabled = YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Event

-(void)singleTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

- (void)clickCloseButton:(id)sender {
    if ([[INSTaskTableManager sharedInstance] isTaskNameAlreadyExist:self.taskNameTextField.text identifier:self.taskModel.identifier]) {
        [self alertInfoWithTitle:@"通知" subTitle:@"任务名称已经存在，请重新取名！"];
    } else if ([self.taskNameTextField.text isEqualToString:@""]) {
        [self alertInfoWithTitle:@"通知" subTitle:@"任务名称不能为空"];
    } else {
        self.taskModel.name = self.taskNameTextField.text;
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

#pragma mark - Getter and Setter

- (UITextField *)taskNameTextField {
    if (!_taskNameTextField) {
        _taskNameTextField = [[UITextField alloc] init];
        _taskNameTextField.delegate = self;
        _taskNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _taskNameTextField.textAlignment = NSTextAlignmentCenter;
        _taskNameTextField.font = [UIFont fontWithName:@"Avenir Next" size:16];
        _taskNameTextField.textColor = FlatWhite;
        _taskNameTextField.text = self.taskModel.name;
        _taskNameTextField.returnKeyType = UIReturnKeyDone;
        
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入任务名字" attributes:@{NSForegroundColorAttributeName : FlatGray}];
        _taskNameTextField.attributedPlaceholder = placeholderString;
    }
    
    return _taskNameTextField;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setBackgroundImage:[INSTomatoBundle imageNamed:@"global_close_icon_28x28_"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = @"任务名字，请尽量简短";
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.textColor = FlatWhiteDark;
        _descriptionLabel.font = [UIFont fontWithName:@"Avenir Next" size:16];
    }
    
    return _descriptionLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = FlatWhiteDark;
        _lineView.alpha = 0.5;
    }
    
    return _lineView;
}

- (UITapGestureRecognizer *)singleTap {
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    }
    
    return _singleTap;
}

@end
