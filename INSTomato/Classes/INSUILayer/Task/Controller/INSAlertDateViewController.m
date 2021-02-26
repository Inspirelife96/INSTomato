//
//  INSAlertDateViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSAlertDateViewController.h"

#import "INSTaskModel.h"

#import "INSDateHelper.h"

#import <ChameleonFramework/Chameleon.h>

@interface INSAlertDateViewController ()

@property (nonatomic, strong) NSArray *alertHourArray;
@property (nonatomic, strong) NSArray *AlertMinuteArray;

@end

@implementation INSAlertDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDate *date = self.taskModel.alertDate;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    NSString *hour = [NSString stringWithFormat:@"%02ld", (long)[components hour]];
    NSString *minute = [NSString stringWithFormat:@"%02ld", (long)[components minute]];
    NSInteger hourIndex = [self.alertHourArray indexOfObject:hour];
    NSInteger minuteIndex = [self.AlertMinuteArray indexOfObject:minute];
    
    [self.pickerView selectRow:hourIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:minuteIndex inComponent:1 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 24;
    } else {
        return 12;
    }
}

#pragma Mark -- UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 40;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.alertHourArray[row];
    } else {
        return self.AlertMinuteArray[row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    for(UIView *singleLine in pickerView.subviews) {
        if (singleLine.frame.size.height < 1) {
            CGFloat y = singleLine.frame.origin.y;
            CGFloat height = singleLine.frame.size.height;
            [singleLine setFrame:CGRectMake(12, y, self.view.frame.size.width - 24, height)];
            singleLine.backgroundColor = FlatWhiteDark;
            singleLine.alpha = 0.3;
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        if (component == 0) {
            [pickerLabel setTextColor:FlatWhite];
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
            [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:24]];
        } else {
            [pickerLabel setTextColor:FlatWhiteDark];
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
            [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:24]];
        }
    }

    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    NSInteger hourIndex =[self.pickerView selectedRowInComponent:0];
    NSInteger minuteIndex = [self.pickerView selectedRowInComponent:1];
    NSString *dateString = [NSString stringWithFormat:@"2016-7-16 %@:%@:00", self.alertHourArray[hourIndex], self.AlertMinuteArray[minuteIndex]];

    self.taskModel.alertDate = [INSDateHelper stringToDate:dateString withForamt:@"yyyy-MM-dd HH:mm:ss"];
    [super clickCloseButton:sender];
}

#pragma mark - Getter and Setter

- (NSArray *)alertHourArray {
    if (!_alertHourArray) {
        _alertHourArray = [INSDateHelper alertHourArray];
    }
    
    return _alertHourArray;
}

- (NSArray *)AlertMinuteArray {
    if (!_AlertMinuteArray) {
        _AlertMinuteArray = [INSDateHelper alertMinuteArray];
    }
    
    return _AlertMinuteArray;
}

@end
