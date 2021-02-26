//
//  INSTaskListViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSTaskListViewController.h"
#import "INSTaskConfigurationViewController.h"

#import "INSAppView.h"
#import "INSTaskListCell.h"

#import "INSTaskModel.h"

#import "INSTaskListCellViewModel.h"

#import "INSTaskTableManager.h"
#import "INSTomatoConfigurationTableManager.h"

#import "INSTomatoBundle.h"

#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface INSTaskListViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) INSAppView *appView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem *addBarButtonItem;

@property(nonatomic, strong) NSArray<INSTaskListCellViewModel *> *taskListCellVMArray;

@end

@implementation INSTaskListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"任务一览";
    
    self.navigationItem.rightBarButtonItem = self.closeBarButtonItem;
    
    // 若番茄配置中，允许添加任务，则添加左上角的添加按钮
    if ([[INSTomatoConfigurationTableManager sharedInstance] isAddTaskEnabled]) {
        self.navigationItem.leftBarButtonItem = self.addBarButtonItem;
    }

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateDataAndTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.taskListCellVMArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    INSTaskListCellViewModel *taskListCellVM = self.taskListCellVMArray[indexPath.row];

    INSTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([INSTaskListCell class]) forIndexPath:indexPath];
    [cell configWithTaskListCellViewModel:taskListCellVM];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    INSTaskListCellViewModel *taskListCellVM = self.taskListCellVMArray[indexPath.row];
    
    INSTaskConfigurationViewController *taskConfigurationVC = [[INSTaskConfigurationViewController alloc] initWithTaskModel:taskListCellVM.taskModel];
    
    // 默认只允许修改
    taskConfigurationVC.configurationType = INSTaskConfigurationTypeModifyOnly;
    
    // 如果可以添加任务，那么修改为可以删除任务
    if ([[INSTomatoConfigurationTableManager sharedInstance] isAddTaskEnabled]) {
        taskConfigurationVC.configurationType = INSTaskConfigurationTypeModifyAndDelete;
    }

    [self.navigationController pushViewController:taskConfigurationVC animated:YES];
}

#pragma mark - Event

- (void)clickAddButton:(id)sender {
    INSTaskModel *taskModel = [[INSTaskModel alloc] initWithTaskName:@"请修改"];
    
    INSTaskConfigurationViewController *taskConfigurationVC = [[INSTaskConfigurationViewController alloc] initWithTaskModel:taskModel];
    taskConfigurationVC.configurationType = INSTaskConfigurationTypeAdd;
    UINavigationController *taskConfigurationNC = [[UINavigationController alloc] initWithRootViewController:taskConfigurationVC];
    taskConfigurationNC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:taskConfigurationNC animated:YES completion:nil];
}

- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)updateDataAndTableView {
    [self refreshTaskListCellVMArray];
    [self.tableView reloadData];
}

#pragma mark - Getter and Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);

        _tableView.tableHeaderView = [[INSAppView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 225.0f)];
        
        [_tableView setBackgroundColor:ClearColor];

        [_tableView registerClass:[INSTaskListCell class] forCellReuseIdentifier:NSStringFromClass([INSTaskListCell class])];
    }
    
    return _tableView;
}

- (NSArray<INSTaskListCellViewModel *> *)taskListCellVMArray {
    if (!_taskListCellVMArray) {
        [self refreshTaskListCellVMArray];
    }
    
    return _taskListCellVMArray;
}

- (void)refreshTaskListCellVMArray {
    NSMutableArray *tempMutalbeArray = [[NSMutableArray alloc] init];

    NSArray *taskIdArray = [[INSTaskTableManager sharedInstance] taskIds];
    
    [taskIdArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull taskId, NSUInteger idx, BOOL * _Nonnull stop) {
        INSTaskModel *taskModel = [[INSTaskTableManager sharedInstance] taskModelByTaskId:taskId];
        INSTaskListCellViewModel *taskListCellVM = [[INSTaskListCellViewModel alloc] initWithTaskModel:taskModel];
        [tempMutalbeArray addObject:taskListCellVM];
    }];
    
    _taskListCellVMArray = [tempMutalbeArray copy];
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[INSTomatoBundle imageNamed:@"global_close_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton:)];
    }
    
    return _closeBarButtonItem;
}

- (UIBarButtonItem *)addBarButtonItem {
    if (!_addBarButtonItem) {
        _addBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickAddButton:)];
    }
    
    return _addBarButtonItem;
}

@end
