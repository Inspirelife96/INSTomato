//
//  INSTaskConfigurationNavigationStyleBasedViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import "INSTaskConfigurationNavigationStyleBasedViewController.h"

@interface INSTaskConfigurationNavigationStyleBasedViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation INSTaskConfigurationNavigationStyleBasedViewController

#pragma mark - Life Cycle

- (instancetype)initWithTaskModel:(INSTaskModel *)taskModel {
    if (self = [super init]) {
        _taskModel = taskModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.backBarButtonItem;

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Event

- (void)clickBackBarButtonItem:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter and Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ClearColor;
    }
    
    return _tableView;
}

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_back_icon_28x28_"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBarButtonItem:)];
    }
    
    return _backBarButtonItem;
}

@end
