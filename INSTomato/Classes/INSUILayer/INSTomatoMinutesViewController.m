//
//  INSTomatoMinutesViewController.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/1.
//

#import "INSTomatoMinutesViewController.h"

#import "INSDateHelper.h"
#import "INSTaskModel.h"

@interface INSTomatoMinutesViewController ()

@property (nonatomic, strong) NSArray *tomatoMinutesArray;
@property (nonatomic, strong) NSArray *minutesTypeArray;

@end

@implementation INSTomatoMinutesViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.descriptionLabel.text = @"时长更改将从下次专注时生效";
    
    NSString *selectedMinutes = [NSString stringWithFormat:@"%@", self.taskModel.tomatoMinutes];
    NSInteger selectedIndex = [self.tomatoMinutesArray indexOfObject:selectedMinutes];
    [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
}

#pragma Mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 14;
    } else {
        return 1;
    }
}

#pragma Mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.tomatoMinutesArray[row];
    } else {
        return self.minutesTypeArray[row];
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
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        if (component == 0) {
            [pickerLabel setTextColor:FlatWhite];
            [pickerLabel setTextAlignment:NSTextAlignmentRight];
            [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:16]];
        } else {
            [pickerLabel setTextColor:FlatWhiteDark];
            [pickerLabel setTextAlignment:NSTextAlignmentLeft];
            [pickerLabel setFont: [UIFont fontWithName:@"Avenir Next" size:16]];
        }
    }
    
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - Event

- (void)clickCloseButton:(id)sender {
    NSInteger selectedIndex =[self.pickerView selectedRowInComponent:0];
    NSInteger tomatoMinutes = [self.tomatoMinutesArray[selectedIndex] integerValue];
    self.taskModel.tomatoMinutes = [NSNumber numberWithInteger:tomatoMinutes];
    
    [super clickCloseButton:sender];
}

#pragma mark - Getter and Setter

- (NSArray *)tomatoMinutesArray {
    if (!_tomatoMinutesArray) {
        _tomatoMinutesArray = [INSDateHelper tomatoMinuteArray];
    }
    
    return _tomatoMinutesArray;
}

- (NSArray *)minutesTypeArray {
    if (!_minutesTypeArray) {
        _minutesTypeArray = [INSDateHelper tomatoMinuteTypeArray];
    }
    
    return _minutesTypeArray;
}

@end
