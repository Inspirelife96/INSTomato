//
//  INSAlertOptionsViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSAlertOptionsViewController.h"

#import "INSTaskConfigurationSwitchCell.h"
#import "INSTaskConfigurationDefaultCell.h"
#import "INSAlertDateViewController.h"

#import "INSTaskModel.h"

#import <ChameleonFramework/Chameleon.h>

@interface INSAlertOptionsViewController ()

@property (nonatomic, strong) INSTaskConfigurationSwitchCell *alertModeEnableCell;
@property (nonatomic, strong) INSTaskConfigurationDefaultCell *alertDateCell;

@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;

@end

#pragma mark - Life Cycle

@implementation INSAlertOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"专注提醒";
    _hour = @"";
    _minute = @"";
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
        [self.alertModeEnableCell.configurationSwitch setOn:self.taskModel.isAlertModeEnabled];
        return self.alertModeEnableCell;
    } else {
        self.alertDateCell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@", self.hour, self.minute];
        return self.alertDateCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
    } else  {
        INSAlertDateViewController *alertDateVC = [[INSAlertDateViewController alloc] initWithTaskModel:self.taskModel];
        [self presentViewController:alertDateVC animated:YES completion:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(12, 2, self.view.frame.size.width - 24, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, self.view.frame.size.width - 24, 21)];
    headerLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    headerLabel.text = @"专注提醒";
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

- (void)enableAlert:(id)sender {
    self.taskModel.isAlertModeEnabled = [(UISwitch *)sender isOn];
}

- (void)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Method

- (void)updataDataAndTableView {
    NSDate *date = self.taskModel.alertDate;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    _hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    _minute = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
    
    [self.tableView reloadData];
}

//- (void)setTaskModel:(INSTaskModel *)taskModel {
//    _ = taskConfiguration;
//    
//    NSDate *date = _taskConfiguration.alertTime;
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    NSDateComponents *components = [cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
//    _hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
//    _minute = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
//}

- (INSTaskConfigurationSwitchCell *)alertModeEnableCell {
    if (!_alertModeEnableCell) {
        _alertModeEnableCell = [[INSTaskConfigurationSwitchCell alloc] init];
        _alertModeEnableCell.textLabel.text = @"专注提醒";
        _alertModeEnableCell.detailTextLabel.text = @"在你设定的时间提醒你进行专注";
        
        [_alertModeEnableCell.configurationSwitch addTarget:self action:@selector(enableAlert:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _alertModeEnableCell;
}

- (INSTaskConfigurationDefaultCell *)alertDateCell {
    if (!_alertDateCell) {
        _alertDateCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _alertDateCell.textLabel.text = @"提醒时间";
    }
    
    return _alertDateCell;
}

@end
