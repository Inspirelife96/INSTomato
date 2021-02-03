//
//  INSTaskPageViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import "INSTaskPageViewController.h"

#import "INSTaskModel.h"

#import "INSTomatoClockView.h"

#import "INSTaskTableManager.h"

#import "INSColorHelper.h"

@interface INSTaskPageViewController ()

@property(nonatomic, strong) UIView *backgroundView;

@property(nonatomic, copy) NSString *taskId;
@property(nonatomic, strong) INSTaskModel *taskModel;

@end

@implementation INSTaskPageViewController

#pragma mark - Life Cycle

- (instancetype)initWithTaskId:(NSString *)taskId {
    if (self = [super init]) {
        _taskId = taskId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.view addSubview:self.tomatoClockView];
    [self.tomatoClockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, -[UIScreen mainScreen].bounds.size.height/6));
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width * 3 / 5);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width * 3 / 5);
    }];
    
}

#pragma mark - Getter and Setter

- (INSTomatoClockView *)tomatoClockView {
    if (!_tomatoClockView) {
        _tomatoClockView = [[INSTomatoClockView alloc] initWithTaskName:self.taskModel.name];
    }
    
    return _tomatoClockView;
}

- (INSTaskModel *)taskModel {
    if (!_taskModel) {
        _taskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:self.taskId];
    }
    
    return _taskModel;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [INSColorHelper colorByName:self.taskModel.color];
        _backgroundView.alpha = 0.5;
    }
    
    return _backgroundView;
}

@end
