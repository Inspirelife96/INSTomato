//
//  INSRestOptionsViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSRestOptionsViewController.h"

#import "INSTaskConfigurationDefaultCell.h"
#import "INSTaskConfigurationSwitchCell.h"
#import "INSRestMinutesViewController.h"

#import "INSTaskModel.h"

@interface INSRestOptionsViewController()

@property (nonatomic, strong) INSTaskConfigurationSwitchCell *restModeEnableCell;
@property (nonatomic, strong) INSTaskConfigurationDefaultCell *restMinutesCell;

@end

@implementation INSRestOptionsViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"休息";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updataDataAndTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.restModeEnableCell.configurationSwitch setOn:self.taskModel.isRestModeEnabled];
        return self.restModeEnableCell;
    } else {
        self.restMinutesCell.detailTextLabel.text = [NSString stringWithFormat:@"%@分钟", self.taskModel.restMinutes];
        return self.restMinutesCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //
    } else {
        INSRestMinutesViewController *restMinutesVC = [[INSRestMinutesViewController alloc] initWithTaskModel:self.taskModel];
        [self presentViewController:restMinutesVC animated:YES completion:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(12, 2, self.view.frame.size.width - 24, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, self.view.frame.size.width - 24, 21)];
    headerLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    headerLabel.text = @"休息设置";

    headerLabel.textColor = FlatGray;

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 43.5, self.view.frame.size.width - 24, 0.5)];
    lineView.backgroundColor = FlatWhiteDark;

    [headerView addSubview:lineView];
    [headerView addSubview:headerLabel];

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - Event

- (void)enableRestMode:(id)sender {
    self.taskModel.isRestModeEnabled = [(UISwitch *)sender isOn];
}

#pragma mark - Private Method

- (void)updataDataAndTableView {
    [self.tableView reloadData];
}

- (INSTaskConfigurationSwitchCell *)restModeEnableCell {
    if (!_restModeEnableCell) {
        _restModeEnableCell = [[INSTaskConfigurationSwitchCell alloc] init];
        _restModeEnableCell.textLabel.text = @"休息模式";
        _restModeEnableCell.detailTextLabel.text = @"每次专注完成后，会进行一次休息计时";

        [_restModeEnableCell.configurationSwitch addTarget:self action:@selector(enableRestMode:) forControlEvents:UIControlEventValueChanged];

    }
    
    return _restModeEnableCell;
}

- (INSTaskConfigurationDefaultCell *)restMinutesCell {
    if (!_restMinutesCell) {
        _restMinutesCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _restMinutesCell.textLabel.text = @"休息时长";
    }
    
    return _restMinutesCell;
}

@end
