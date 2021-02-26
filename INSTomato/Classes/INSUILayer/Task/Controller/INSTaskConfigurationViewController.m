//
//  INSTaskConfigurationViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSTaskConfigurationViewController.h"

#import "INSTaskNameViewController.h"
#import "INSColorPickerViewController.h"
#import "INSTomatoMinutesViewController.h"
#import "INSRestOptionsViewController.h"
#import "INSMusicViewController.h"
#import "INSAlertOptionsViewController.h"

#import "INSTaskConfigurationDefaultCell.h"
#import "INSTaskConfigurationSwitchCell.h"

#import "INSTaskModel.h"

#import "INSNotificationConstants.h"

#import "INSTaskTableManager.h"

#import "INSTomatoBundle.h"

#import <ChameleonFramework/Chameleon.h>

@interface INSTaskConfigurationViewController ()

@property (strong, nonatomic) INSTaskModel *taskModelCopy;
@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;

@property (strong, nonatomic) INSTaskConfigurationDefaultCell *nameCell;
@property (strong, nonatomic) INSTaskConfigurationDefaultCell *colorCell;
@property (strong, nonatomic) INSTaskConfigurationDefaultCell *tomatoMinutesCell;
@property (strong, nonatomic) INSTaskConfigurationDefaultCell *restOptionsCell;
@property (strong, nonatomic) INSTaskConfigurationSwitchCell *focusModeCell;
@property (strong, nonatomic) INSTaskConfigurationDefaultCell *musicCell;
@property (strong, nonatomic) INSTaskConfigurationSwitchCell *musicEnableCell;
@property (strong, nonatomic) INSTaskConfigurationDefaultCell *alertOptionsCell;

@end

@implementation INSTaskConfigurationViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.configurationType) {
            // 添加任务，左侧按钮变为关闭，右侧按钮为添加
        case INSTaskConfigurationTypeAdd:
            self.navigationItem.title = @"添加任务";
            [self.backBarButtonItem setImage:[INSTomatoBundle imageNamed:@"global_close_icon_28x28_"]];
            self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
            break;
            
            // 修改并允许删除任务，左侧按钮保持为返回，右侧按钮为删除
        case INSTaskConfigurationTypeModifyAndDelete:
            self.navigationItem.title = @"任务设置";
            self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
            break;
            
            // 仅允许修改任务，左侧按钮保持为返回，无右侧按钮
        case INSTaskConfigurationTypeModifyOnly:
            self.navigationItem.title = @"任务设置";
            break;
    }
    
    self.taskModelCopy = [self.taskModel copy];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updataDataAndTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 3;
    } else if (section == 2){
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.nameCell.detailTextLabel.text = self.taskModel.name;
            return self.nameCell;
        } else {
            self.colorCell.detailTextLabel.text = self.taskModel.color;
            return self.colorCell;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSNumber *tomatoMinutes = self.taskModel.tomatoMinutes;
            self.tomatoMinutesCell.detailTextLabel.text = [NSString stringWithFormat:@"%ld分钟", (long)[tomatoMinutes integerValue]];
            return self.tomatoMinutesCell;
        } else if (indexPath.row == 1) {
            return self.restOptionsCell;
        } else {
            [self.focusModeCell.configurationSwitch setOn:self.taskModel.isFocusModeEnabled];
            return self.focusModeCell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.musicCell.detailTextLabel.text = self.taskModel.music;
            return self.musicCell;
        } else {
            [self.musicEnableCell.configurationSwitch setOn:self.taskModel.isMusicModeEnabled];
            return self.musicEnableCell;
        }
    } else {
        return self.alertOptionsCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            INSTaskNameViewController *taskNameVC = [[INSTaskNameViewController alloc] initWithTaskModel:self.taskModel];
            taskNameVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:taskNameVC animated:YES completion:nil];
        } else {
            INSColorPickerViewController *colorPickerVC = [[INSColorPickerViewController alloc] initWithTaskModel:self.taskModel];
            colorPickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:colorPickerVC animated:YES completion:nil];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            INSTomatoMinutesViewController *tomatoMinutesVC = [[INSTomatoMinutesViewController alloc] initWithTaskModel:self.taskModel];
            tomatoMinutesVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:tomatoMinutesVC animated:YES completion:nil];
        } else if (indexPath.row == 1) {
            INSRestOptionsViewController *restOptionVC = [[INSRestOptionsViewController alloc] initWithTaskModel:self.taskModel];
            restOptionVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.navigationController pushViewController:restOptionVC animated:YES];
        } else {
            // do nothing
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            INSMusicViewController *musicVC = [[INSMusicViewController alloc] initWithTaskModel:self.taskModel];
            musicVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:musicVC animated:YES completion:nil];
        } else {
            // do nothing
        }
    } else {
        INSAlertOptionsViewController *alertOptionVC = [[INSAlertOptionsViewController alloc] initWithTaskModel:self.taskModel];
        alertOptionVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController pushViewController:alertOptionVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(12, 2, self.view.frame.size.width - 24, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, self.view.frame.size.width - 24, 21)];
    headerLabel.font = [UIFont fontWithName:@"Avenir Next" size:14];
    if (section == 0) {
        headerLabel.text = @"任务设置";
    } else if (section == 1) {
        headerLabel.text = @"专注设置";
    } else if (section == 2) {
        headerLabel.text = @"白噪音设置";
    } else {
        headerLabel.text = @"高级设置";
    }
    
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

- (void)enableFocusMode:(id)sender {
    self.taskModel.isFocusModeEnabled = [(UISwitch *)sender isOn];
}

- (void)enableMusicMode:(id)sender {
    self.taskModel.isMusicModeEnabled = [(UISwitch *)sender isOn];
}

- (void)clickBackBarButtonItem:(id)sender {
    if (self.configurationType == INSTaskConfigurationTypeAdd) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if ([self.taskModel.name isEqualToString:@""]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"任务名称不能为空，请设置" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //
            }];
            
            [alertVC addAction:cancelAction];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        } else {
            if (![self.taskModelCopy isEqualToTaskModel:self.taskModel]) {
                [[INSTaskTableManager sharedInstance] updateTask:self.taskModel.identifier taskModel:self.taskModel];
            }
            
            [super clickBackBarButtonItem:sender];
        }
    }
}

- (void)saveTask:(id)sender {
    [[INSTaskTableManager sharedInstance] addTask:self.taskModel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteTask:(id)sender {
    if ([[[INSTaskTableManager sharedInstance] taskIds] count] <= 1) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"通知" message:@"这是最后一个任务，无法被删除" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        
        [alertVC addAction:cancelAction];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"该操作会删除当前任务以及所有的和任务相关的统计记录，确认删除吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[INSTaskTableManager sharedInstance] removeTask:self.taskModel.identifier];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        
        [alertVC addAction:cancelAction];
        [alertVC addAction:okAction];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - Private Method

- (void)updataDataAndTableView {
    [self.tableView reloadData];
    
    if (self.configurationType == INSTaskConfigurationTypeAdd) {
        if ([self.taskModel.name isEqualToString:@""]) {
            [self.rightBarButtonItem setEnabled:NO];
        } else {
            [self.rightBarButtonItem setEnabled:YES];
        }
    }
}

#pragma mark - Getter and Setter

- (UIBarButtonItem *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        if (self.configurationType == INSTaskConfigurationTypeAdd) {
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveTask:)];
        } else if (self.configurationType == INSTaskConfigurationTypeModifyAndDelete){
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteTask:)];
            _rightBarButtonItem.tintColor = FlatRed;
        }
    }
    
    return _rightBarButtonItem;
}

- (INSTaskConfigurationDefaultCell *)nameCell {
    if (!_nameCell) {
        _nameCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _nameCell.textLabel.text = @"任务名字";
        _nameCell.detailTextLabel.text = self.taskModel.name;
    }
    
    return _nameCell;
}

- (INSTaskConfigurationDefaultCell *)colorCell {
    if (!_colorCell) {
        _colorCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _colorCell.textLabel.text = @"任务配色";
        _colorCell.detailTextLabel.text = self.taskModel.color;
    }
    
    return _colorCell;
}

- (INSTaskConfigurationDefaultCell *)tomatoMinutesCell {
    if (!_tomatoMinutesCell) {
        _tomatoMinutesCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _tomatoMinutesCell.textLabel.text = @"专注时长";
        _tomatoMinutesCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.taskModel.tomatoMinutes];
    }
    
    return _tomatoMinutesCell;
}

- (INSTaskConfigurationDefaultCell *)restOptionsCell {
    if (!_restOptionsCell) {
        _restOptionsCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _restOptionsCell.textLabel.text = @"休息";
    }
    
    return _restOptionsCell;
}

- (INSTaskConfigurationSwitchCell *)focusModeCell {
    if (!_focusModeCell) {
        _focusModeCell = [[INSTaskConfigurationSwitchCell alloc] init];
        _focusModeCell.textLabel.text = @"沉浸模式";
        _focusModeCell.detailTextLabel.text = @"退出应用会导致专注失败且不允许暂停";
        [_focusModeCell.configurationSwitch addTarget:self action:@selector(enableFocusMode:) forControlEvents:UIControlEventValueChanged];
        [_focusModeCell.configurationSwitch setOn:self.taskModel.isFocusModeEnabled];
    }
    
    return _focusModeCell;
}

- (INSTaskConfigurationDefaultCell *)musicCell {
    if (!_musicCell) {
        _musicCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _musicCell.textLabel.text = @"背景音乐";
        _musicCell.detailTextLabel.text = self.taskModel.music;
    }
    
    return _musicCell;
}

- (INSTaskConfigurationSwitchCell *)musicEnableCell {
    if (!_musicEnableCell) {
        _musicEnableCell = [[INSTaskConfigurationSwitchCell alloc] init];
        _musicEnableCell.textLabel.text = @"白噪音";
        [_musicEnableCell.configurationSwitch addTarget:self action:@selector(enableMusicMode:) forControlEvents:UIControlEventValueChanged];
        [_musicEnableCell.configurationSwitch setOn:self.taskModel.isMusicModeEnabled];

    }
    
    return _musicEnableCell;
}

- (INSTaskConfigurationDefaultCell *)alertOptionsCell {
    if (!_alertOptionsCell) {
        _alertOptionsCell = [[INSTaskConfigurationDefaultCell alloc] init];
        _alertOptionsCell.textLabel.text = @"专注提醒";
    }
    
    return _alertOptionsCell;
}

@end
